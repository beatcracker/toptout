#Requires -Version 6

$LF = "`n"

$PadRegex = [regex]'(?m)^(.)'
$PadReplace = '  $1'

$ShellHelpersMap = @{
    pwsh = @'
#Requires -Version 5

<#
.Synopsis
    Toptout shell script: Disable known telemetry channels for apps

.Parameter Env
    Set environment variables that disable telemetry

.Parameter Exec
    Execute shell commands that disable telemetry

.Parameter ShowLog
    Show operation log

.Example
    toptout_pwsh.ps1 -WhatIf

    Set environment variables and execute commands, dry run mode.

.Example
    toptout_pwsh.ps1 -ShowLog

    Set environment variables and execute commands, show log.

.Example
    toptout_pwsh.ps1 -Env -ShowLog

    Set environment variables, show log.

.Example
    toptout_pwsh.ps1 -Exec -ShowLog

    Execute commands, show log.

.Example
    toptout_pwsh.ps1

    Set environment variables and execute commands, silent.
#>

[CmdletBinding(SupportsShouldProcess = $true)]
Param(
    [switch]$Env,
    [switch]$Exec,
    [switch]$ShowLog
)

function Get-OsMoniker {
    if ($IsCoreCLR) {
        if ($IsWindows) {
            'windows'
        }
        elseif ($IsLinux) {
            'linux'
        }
        elseif ($IsMacOS) {
            'macos'
        }
    }
    else {
        'windows'
    }
}

function Invoke-ShellCommand {
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Command,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Arguments,

        [switch]$ShowLog
    )

    if (Get-Command -Name $Command -CommandType Application -ErrorAction SilentlyContinue) {
        $LoggedCommand = "$Command $Arguments"

        if ($PSCmdlet.ShouldProcess($LoggedCommand, 'Execute command')) {
            if ($ShowLog) {
                Write-Host 'Executing command: ' -ForegroundColor Green -NoNewline
                Write-Host $LoggedCommand -ForegroundColor Yellow
            }

            $ret = Start-Process -FilePath $Command -ArgumentList $Arguments -NoNewWindow -Wait

            if ($ShowLog) {
                Write-Host $ret -ForegroundColor White
            }
        }
    }
}

function Set-EnvVar {
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Value,

        [switch]$ShowLog
    )

    $EnvVar = "$Name=$Value"

    if ($PSCmdlet.ShouldProcess($EnvVar, 'Set environment variable')) {
        if ($ShowLog) {
            Write-Host 'Setting environment variable: ' -ForegroundColor Green -NoNewline
            Write-Host "$EnvVar" -ForegroundColor Yellow
        }

        [System.Environment]::SetEnvironmentVariable($Name, $Value)
    }
}

if (-not $Env -and -not $Exec) {
    $Env = $Exec = $true
}

'@
    bash = '#!/usr/bin/env bash'
}

$ShellSwitchMap = @{
    bash = @'
case "$OSTYPE" in
{0}
esac
'@
    pwsh = @'
switch (Get-OsMoniker) {{
{0}
}}
'@
}

$ShellCaseMap = @{
    bash = @{
        default = @'
*)
{0}
;;
'@
        linux   = @'
linux*)
{0}
;;
'@
        windows = @'
msys*)
{0}
;;
'@
        macos   = @'
darwin*)
{0}
;;
'@
    }
    pwsh = @{
        default = @'
default {{
{0}
}}
'@
        linux   = @'
'linux' {{
{0}
}}
'@
        windows = @'
'windows' {{
{0}
}}
'@
        macos   = @'
'macos' {{
{0}
}}
'@
    }
}

$ShellCmdMap = @{
    bash = @{
        env  = "export {0}='{1}'"
        exec = @'
if command -v '{0}' > /dev/null 2>&1 > /dev/null
then
  '{0}' {1} > /dev/null 2>&1
fi
'@
    }
    pwsh = @{
        env  = @'
if ($Env) {{
    Set-EnvVar -Name '{0}' -Value '{1}' -ShowLog:$ShowLog
}}
'@
        exec = @'
if ($Exec) {{
    Invoke-ShellCommand -Command '{0}' -Arguments '{1}' -ShowLog:$ShowLog
}}
'@
    }
}


filter Select-LowestScope {
    foreach ($scope in 'process', 'user', 'machine') {
        if ($_.scope.Keys -contains $scope) {
            $_.scope.$scope
            break
        }
    }
}

filter Select-LowestImpact {
    foreach ($target in 'env', 'exec') {
        if ($_.Keys -contains $target) {
            @{ $target = $_.$target }
            break
        }
    }
}

filter Get-ShellScriptExtension {
    @{
        bash = 'sh'
        pwsh = 'ps1'
    }.$_
}

function Get-ShellScriptHelpers {
    Param (
        [ValidateSet('bash', 'pwsh')]
        [string]$Shell
    )

    if ($ShellHelpersMap.$Shell) {
        $ShellHelpersMap.$Shell | Add-NewLine
    }
}

filter ConvertTo-ShellScript {
    # $Shell IS used, PSScriptAnalyzer is just not smart enough yet to figure it out
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '')]
    Param (
        [ValidateSet('bash', 'pwsh')]
        [string]$Shell
    )

    foreach ($telemetry in $_.telemetry) {

        $target = $telemetry.target | Select-LowestImpact

        $code = if ($target) {
            '# {0}' -f $telemetry.name
            if ($telemetry.links.main) { '# {0}' -f $telemetry.links.main }

            $target.GetEnumerator() | ForEach-Object {

                if ($_.Key -and $ShellCmdMap.$Shell.ContainsKey($_.Key)) {
                    $scope = $_.Value | Select-LowestScope

                    if ($scope.path | Test-IsDefaultOnly) {
                        $ShellCmdMap.$Shell.($_.Key) -f $scope.path.default, $scope.value.opt_out
                    }
                    else {
                        $cases = foreach ($kv in $scope.path.GetEnumerator() | Sort-Object { $_.Key }) {
                            $ShellCaseMap.$Shell.($kv.Key) -f (
                                (
                                    $ShellCmdMap.$Shell.($_.Key) -f $kv.Value, $scope.value.opt_out
                                ) -replace $PadRegex, $PadReplace
                            )
                        }

                        $ShellSwitchMap.$Shell -f (
                            ($cases -join $LF) -replace $PadRegex, $PadReplace
                        )
                    }
                    Add-Newline
                }
            }
        }

        if ($code) {
            '# {0}' -f $_.name
            '# {0}' -f $_.links.main
            Add-Newline
            $code
        }
    }
}
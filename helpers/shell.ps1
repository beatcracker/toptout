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

.Link
    https://beatcracker.github.io/toptout/

.Parameter Env
    Set environment variables that disable telemetry

.Parameter Exec
    Execute shell commands that disable telemetry

.Parameter ShowLog
    Show operation log

.Example
    toptout_pwsh.ps1 -Env -WhatIf

    Set environment variables, dry run.

.Example
    toptout_pwsh.ps1 -Exec -WhatIf

    Execute commands, dry run.

.Example
    toptout_pwsh.ps1 -Env -Exec -ShowLog

    Set environment variables and execute commands, verbose log.

.Example
    toptout_pwsh.ps1 -Env -Exec

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
                Write-Host 'Executing command           : ' -ForegroundColor DarkGreen -NoNewline
                Write-Host $LoggedCommand -ForegroundColor DarkYellow
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
            Write-Host 'Setting environment variable: ' -ForegroundColor DarkGreen -NoNewline
            Write-Host "$EnvVar" -ForegroundColor DarkYellow
        }

        [System.Environment]::SetEnvironmentVariable($Name, $Value)
    }
}

if (-not $PSBoundParameters.Count) {
    Get-Help $PSCmdlet.MyInvocation.MyCommand.Definition -Examples
    return
}

if ($ShowLog) {
@"
    ______            __              __
   /_  __/___  ____  / /_____  __  __/ /_
    / / / __ \/ __ \/ __/ __ \/ / / / __/
   / / / /_/ / /_/ / /_/ /_/ / /_/ / /_
  /_/  \____/ .___/\__/\____/\__,_/\__/
            /_/
"@ | Write-Host -ForegroundColor Magenta

@"

Easily opt-out from telemetry collection
________________________________________

 https://beatcracker.github.io/toptout/
________________________________________

Current settings:

  Set environment variables: $Env
  Execute commands         : $Exec
  Verbose                  : $ShowLog
  Dry run                  : $WhatIfPreference
________________________________________

"@ | Write-Host
}
'@
    bash = @'
#!/usr/bin/env bash

# https://beatcracker.github.io/toptout/

cleanup () {
  unset $(compgen -v | grep '^toptout_')
}

trap cleanup RETURN EXIT

toptout_name="$(basename "${BASH_SOURCE[0]}")"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  toptout_sourced='False'
else
  toptout_sourced='True'
fi

toptout_usage="
Usage:

  . './${toptout_name}' -exvdh

Arguments:

  -e : set environment variables.
       You must source script for this to work: . './${toptout_name}' -e
  -x : execute commands
  -v : verbose
  -d : dry run
  -h : this help"

toptout_warn=$'
WARNING:
  -e specified, but script is not sourced!
  Environment variables wouldn\'t be exported to your shell session.'

toptout_env='False'
toptout_exec='False'
toptout_dry='False'
toptout_verbose='False'

OPTIND=1

while getopts ":exdvh" opt
do
  case $opt in
  e)
    toptout_env='True'
    [[ "${toptout_sourced}" != 'True' ]] && >&2 echo -e "\033[31m${toptout_warn}\033[0m"
  ;;
  x)
    toptout_exec='True'
  ;;
  d)
    toptout_dry='True'
  ;;
  v)
    toptout_verbose='True'
  ;;
  h|\?)
    toptout_help='True'
    echo "${toptout_usage}"
  ;;
  esac
done

if [[ -n "${toptout_help}" ]]
then
  [[ "${toptout_sourced}" == 'True' ]] && return || exit
fi

if [[ "${toptout_env}" == 'False' && "${toptout_exec}" == 'False' ]]
then
  echo "${toptout_usage}"
  [[ "${toptout_sourced}" == 'True' ]] && return || exit
fi

run_cmd () {
  if command -v "${1}" > /dev/null 2>&1
  then
    [[ "${toptout_verbose}" == 'True' ]] && echo -e "\033[32mExecuting command           :\033[0m \033[33m${1} ${2}\033[0m"
    [[ "${toptout_dry}" == 'False' ]] && "${1}" ${2}
  fi
}

set_env () {
  [[ "${toptout_verbose}" == 'True' ]] && echo -e "\033[32mSetting environment variable:\033[0m \033[33m${1}=${2}\033[0m"
  [[ "${toptout_dry}" == 'False' ]] && export "${1}"="${2}"
}

[[ "${toptout_verbose}" == 'True' ]] && echo -e "\033[95m
    ______            __              __
   /_  __/___  ____  / /_____  __  __/ /_
    / / / __ \/ __ \/ __/ __ \/ / / / __/
   / / / /_/ / /_/ / /_/ /_/ / /_/ / /_
  /_/  \____/ .___/\__/\____/\__,_/\__/
            /_/
\033[0m
Easily opt-out from telemetry collection
________________________________________

 https://beatcracker.github.io/toptout/
________________________________________

Current settings:

  Set environment variables: ${toptout_env}
  Execute commands         : ${toptout_exec}
  Verbose                  : ${toptout_verbose}
  Dry run                  : ${toptout_dry}
________________________________________
"
'@
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
        env  = @'
[[ "${{toptout_env}}" == 'True' ]] && set_env '{0}' '{1}'
'@
        exec = @'
[[ "${{toptout_exec}}" == 'True' ]] && run_cmd '{0}' '{1}'
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
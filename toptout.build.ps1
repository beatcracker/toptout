#Requires -Version 6

[CmdletBinding()]
Param(
    [Parameter(Position = 0)]
    [ValidateNotNullOrEmpty()]
    [string[]]$Tasks
)

#region Common functions

<#
.Synopsis Run paket with args, handle exit codes
#>
function Invoke-Paket {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Arguments
    )

    End {
        if ($paket = Join-Path $PSScriptRoot '.paket/paket.exe' -Resolve) {
            try {
                & $paket $Arguments

                if ($LASTEXITCODE) {
                    Write-Error "paket exit code: $LASTEXITCODE"
                }
            }
            catch {
                throw $_
            }
        }
    }
}

<#
.Synopsis Given string 'TEST' produce centered padded string '---TEST---'
#>
function Get-PaddedString {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 0)]
        [string[]]$InputObject,

        [Parameter(Position = 1)]
        [ValidateNotNullOrEmpty()]
        [int]$Width = $(
            if ($host.UI.RawUI.WindowSize.Width) {
                $host.UI.RawUI.WindowSize.Width
            }
            else {
                79
            }
        ),

        [Parameter(Position = 2)]
        [ValidateNotNullOrEmpty()]
        [string]$PaddingChar = '-'
    )

    Process {
        foreach ($item in $InputObject) {
            $item.PadLeft(
                $item.Length + [System.Math]::Floor($Width / 2 - $item.Length / 2),
                $PaddingChar
            ).PadRight(
                $Width,
                $PaddingChar
            )
        }
    }
}

#endregion

#region Common variables

$PackageDirPath = Join-Path $PSScriptRoot 'packages'
$TasksDirPath = Join-Path $PSScriptRoot 'tasks'

#endregion

#region Bootstrap

# If direct call: ensure packages and call the local Invoke-Build
if ([System.IO.Path]::GetFileName($MyInvocation.ScriptName) -ne 'Invoke-Build.ps1') {
    $ErrorActionPreference = 'Stop'
    $ib = Join-Path $PackageDirPath 'InvokeBuild/Invoke-Build.ps1'

    # install packages
    if (-not (Test-Path -LiteralPath $ib)) {
        '{1}{0}{1}' -f ('=::[ Bootstrap ]::=' | Get-PaddedString -Width 100), [System.Environment]::NewLine

        Invoke-Paket -Arguments @(
            '--silent'
            'install'
        )

        ''
        '-' | Get-PaddedString -Width 100
        ''
    }

    # call Invoke-Build
    & $ib -Task $Tasks -File $MyInvocation.MyCommand.Path @PSBoundParameters
    return
}

#endregion

#region Build output customization

# Set custom task header
Set-BuildHeader {
    Param($Path)

    Write-Build Magenta (
        '{1}{0}{1}' -f ("=::[ $Path ]::=" | Get-PaddedString -Width 100), [System.Environment]::NewLine
    )
}

#endregion


#region Import tasks

foreach ($file in Get-ChildItem -Path "$TasksDirPath/*.tasks.ps1") {
    . $file
}

#endregion


#region Tasks

task . -Jobs @(
    'Invoke-Pester'
    'New-README'
)

task Clear-PackageCache {
    Invoke-Paket -Arguments @(
        'clear-cache'
        '--clear-local'
    )
}

task Invoke-Pester {
    $Results = Start-Job -Name Invoke-Pester -ScriptBlock {
        Param (
            [Parameter(Position = 0)]
            [ValidateNotNullOrEmpty()]
            [string]$PackageDirPath,

            [Parameter(Position = 1)]
            [ValidateNotNullOrEmpty()]
            [string]$TestDirPath
        )

        $ErrorActionPreference = 'Stop'

        $splat = @{
            Path       = $TestDirPath
            Strict     = $true
            PassThru   = $true
            Verbose    = $false
            EnableExit = $false
        }

        'Pester', 'PSScriptAnalyzer' | ForEach-Object {
            Import-Module -Name "$PackageDirPath/$_" -Force
        }

        Invoke-Pester @splat
    } -ArgumentList @(
        $PackageDirPath
        "$BuildRoot/tests"
     ) | Receive-Job -Wait -AutoRemoveJob

    assert($Results.FailedCount -eq 0) ('Failed "{0}" tests.' -f $Results.FailedCount)
}

#endregion

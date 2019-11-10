$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Describe 'PSScriptAnalyzer tests for build scripts' {
    @(
        "$here/../tasks/*.ps1"
        "$here/../*.ps1"
    ) | Get-ChildItem | ForEach-Object {
        Context $_.Name {
            It 'Should not have any PSScriptAnalyzer warnings' {
                [array]$ScriptWarnings = $_ | Invoke-ScriptAnalyzer

                if ($ScriptWarnings.Count) {
                    $ScriptWarnings | Format-List | Out-String | Write-Warning
                }

                $ScriptWarnings.Count | Should -BeExactly 0
            }
        }
    }
}

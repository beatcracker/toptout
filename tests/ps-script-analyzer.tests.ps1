$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Describe 'PSScriptAnalyzer tests for build scripts' {
    @(
        "$here/.."
        "$here/../helpers"
        "$here/../tests"
    ) | Get-ChildItem -Filter '*.ps1' -File | ForEach-Object {
        Context $_.Name {
            It 'Should not have any PSScriptAnalyzer warnings' {
                [array]$ScriptWarnings = Invoke-ScriptAnalyzer -Path $_.FullName

                if ($ScriptWarnings.Count) {
                    $ScriptWarnings | Out-String | Write-Warning
                }

                $ScriptWarnings.Count | Should -BeExactly 0
            }
        }
    }
}

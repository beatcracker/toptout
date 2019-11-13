$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Describe 'PSScriptAnalyzer tests for build scripts' {
    @(
        "$here/../tasks/*.ps1"
        "$here/../*.ps1"
    ) | Get-ChildItem | ForEach-Object {
        Context $_.Name {
            It 'Should not have any PSScriptAnalyzer warnings' {
                [array]$ScriptWarnings = Invoke-ScriptAnalyzer -Path $_.FullName

                if ($ScriptWarnings.Count) {
                    $ScriptWarnings |fl|out-string| Write-Host -ForegroundColor Cyan
                }

                $ScriptWarnings.Count | Should -BeExactly 0
            }
        }
    }
}

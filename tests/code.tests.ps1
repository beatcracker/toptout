BeforeDiscovery {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignment', '', Justification = 'This is how Pester works')]
    $ps_files = @(
        "$PSScriptRoot/.."
        "$PSScriptRoot/../helpers"
        "$PSScriptRoot/../tests"
    ) | Get-ChildItem -Filter '*.ps1' -File
}

Describe 'PSScriptAnalyzer' {
    Context '<_.Name>' -ForEach $ps_files {
        It 'Should not have any PSScriptAnalyzer warnings' {
            [array]$ScriptWarnings = Invoke-ScriptAnalyzer -Path $_.FullName -ExcludeRule 'PSUseBOMForUnicodeEncodedFile'

            if ($ScriptWarnings.Count) {
                $ScriptWarnings | Out-String | Write-Warning
            }

            $ScriptWarnings.Count | Should -BeExactly 0
        }
    }
}

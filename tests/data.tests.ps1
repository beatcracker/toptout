#Requires -Version 6

Describe 'JSON telemetry data' {
    $schema = Get-Content -Path "$PSScriptRoot/../schema/toptout.schema.json" -Raw
    [array]$json_files = Get-ChildItem -Path "$PSScriptRoot/../data" -Filter '*.json' -File | Sort-Object

    Context 'Common' {
        It 'Schema is a valid JSON' {
            $schema | Test-Json | Should -BeExactly $true
        }

        It 'Telemetry JSON files exist' {
            $json_files.Count | Should -BeGreaterThan 0
        }

        It 'Telemetry JSON filenames are unique' {
            # Handle case-sensitive FS
            # TODO: can't pass 'invariant' culture to Sort-Object, it fails.
            @($json_files.Name | Sort-Object -Unique).Count | Should -BeExactly $json_files.Count
        }
    }

    $json_files | ForEach-Object {
        Context $_.Name {
            $content =  $_ | Get-Content -Raw
            $object = $content | ConvertFrom-Json -Depth 100

            It 'Conforms to the schema' {
                $content | Test-Json -Schema $schema | Should -BeExactly $true
            }

            It 'File basename matches id' {
                $object.id | Should -BeExactly $_.BaseName
            }

            It 'Telemetry opt-out definitions have unique IDs' {
                [array]$telemetry = $object.telemetry
                if ($telemetry.Count -gt 1) {
                    @($telemetry.id | Sort-Object -Unique).Count | Should -BeExactly @($telemetry.id).Count
                }
            }

            It 'Using LF, not CRLF' {
                $content -match "`r`n" | Should -BeExactly $false
            }
        }
    }
}

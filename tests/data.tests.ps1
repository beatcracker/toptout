#Requires -Version 7

BeforeDiscovery {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignment', '', Justification = 'This is how Pester works')]
    [array]$json_files = Get-ChildItem -Path "$PSScriptRoot/../data" -Filter '*.json' -File | Sort-Object -Property BaseName
}

BeforeAll {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignment', '', Justification = 'This is how Pester works')]
    $schema_file = "$PSScriptRoot/../schema/toptout.schema.json"
}

Describe 'JSON schema' {
    It 'Schema is a valid JSON' {
        Get-Content -LiteralPath $schema_file -Raw | Test-Json | Should -BeExactly $true
    }
}

Describe 'Data files' -ForEach (, $json_files) {
    It 'JSON files exist' {
        $_.Count | Should -BeGreaterThan 0
    }

    It 'JSON filenames are unique' {
        # Handle case-sensitive FS
        # TODO: can't pass 'invariant' culture to Sort-Object, it fails.
        @($_.Name | Sort-Object -Unique).Count | Should -BeExactly $_.Count
    }

}

Describe 'Telemetry data' {
    BeforeEach {
        $content = $_ | Get-Content -Raw

        [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignment', '', Justification = 'This is how Pester works')]
        $object = $content | ConvertFrom-Json -Depth 100
    }

    Context '<_.Name>' -ForEach $json_files {
        It 'Conforms to the schema' {
            # TODO: Figure out a better way to show what's exactly wrong with the file
            $ret = try {
                $content | Test-Json -SchemaFile $schema_file
            }
            catch {
                $_ | Write-Error
            }

            $ret | Should -BeExactly $true
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

        It '"display_value" in "json_file" should be valid JSON' {
            foreach ($t in $object.telemetry) {
                if ($t.target.json_file) {
                    foreach ($scope in 'process', 'user', 'machine') {
                        $ts = $t.target.json_file.scope.$scope
                        if ($ts) {
                            $ts.display_value | Test-Json | Should -BeExactly $true
                        }
                    }
                }
            }
        }

        It '"opt_in/out" in "registry" should match registry key type' {
            foreach ($t in $object.telemetry) {
                if ($t.target.registry) {
                    foreach ($scope in 'process', 'user', 'machine') {
                        foreach ($opt in 'opt_in', 'opt_out') {
                            $type = $t.target.registry.scope.$scope.type
                            $value = $t.target.registry.scope.$scope.value.$opt
                            if ($null -ne $value) {
                                switch ($type) {
                                    { $_ -eq 'REG_BINARY' } {
                                        $value.Length % 2 | Should -BeExactly 0
                                        $value -match '[^0-9A-F]' | Should -BeExactly $false
                                        break
                                    }

                                    {
                                        $_ -in @(
                                            'REG_DWORD'
                                            'REG_DWORD_BIG_ENDIAN'
                                        )
                                    } {
                                        [int32]::TryParse($value, [ref]$null) | Should -BeExactly $true
                                        break
                                    }

                                    { $_ -eq 'REG_QWORD' } {
                                        [int64]::TryParse($value, [ref]$null) | Should -BeExactly $true
                                        break
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        It 'Using LF, not CRLF' {
            $content -match '\r\n' | Should -BeExactly $false
        }
    }
}

<#
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
            $content = $_ | Get-Content -Raw
            $object = $content | ConvertFrom-Json -Depth 100

            It 'Conforms to the schema' {
                # TODO: Figure out a better way to show what's exactly wrong with file
                $ret = try {
                    $content | Test-Json -Schema $schema
                }
                catch {
                    $_ | Write-Error
                }

                $ret | Should -BeExactly $true
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

            It '"display_value" in "json_file" should be valid JSON' {
                foreach ($t in $object.telemetry) {
                    if ($t.target.json_file) {
                        foreach ($scope in 'process', 'user', 'machine') {
                            $dv = $t.target.json_file.scope.$scope.display_value
                            if ($dv) {
                                $dv | Test-Json | Should -BeExactly $true
                            }
                        }
                    }
                }
            }

            It '"opt_in/out" in "registry" should match registry key type' {
                foreach ($t in $object.telemetry) {
                    if ($t.target.registry) {
                        foreach ($scope in 'process', 'user', 'machine') {
                            foreach ($opt in 'opt_in', 'opt_out') {
                                $type = $t.target.registry.scope.$scope.type
                                $value = $t.target.registry.scope.$scope.value.$opt
                                if ($null -ne $value) {
                                    switch ($type) {
                                        { $_ -eq 'REG_BINARY' } {
                                            $value.Length % 2 | Should -BeExactly 0
                                            $value -match '[^0-9A-F]' | Should -BeExactly $false
                                            break
                                        }

                                        {
                                            $_ -in @(
                                                'REG_DWORD'
                                                'REG_DWORD_BIG_ENDIAN'
                                            )
                                        } {
                                            [int32]::TryParse($value, [ref]$null) | Should -BeExactly $true
                                            break
                                        }

                                        { $_ -eq 'REG_QWORD' } {
                                            [int64]::TryParse($value, [ref]$null) | Should -BeExactly $true
                                            break
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            It 'Using LF, not CRLF' {
                $content -match "`r`n" | Should -BeExactly $false
            }
        }
    }
}
#>
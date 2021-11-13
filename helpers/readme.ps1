#Requires -Version 7

$LF = "`n"
$CRLF = "`r`n"

filter ConvertTo-RegCommand {
    $p = '{0}\{1}' -f $_.root, $_.path | Add-Quote
    $k = $_.key | Add-Quote

    if ($null -eq $_.value.opt_out) {
        'reg delete {0} /v {1} /f' -f $p, $k
    }
    else {
        $v = $_.value.opt_out | Add-Quote
        'reg add {0} /v {1} /d {2} /t {3} /f' -f $p, $k, $v, $_.type
    }
}

filter Add-Quote {
    if ($_ -match '\s+') {
        '"{0}"' -f $_
    }
    else {
        $_
    }
}

filter ConvertTo-Anchor {
    ($_ -replace '[^\w- ]').ToLowerInvariant() -replace '\s', '-'
}

filter Format-MdString {
    Param (
        [switch]$Code
    )

    if ($_) {
        if ($Code) {
            '`{0}`' -f $_
        }
        else {
            $_ -replace '([\`\\\`\*_\{\}\[\]\(\)\#\+\-\.\!])', '\$1' # Escape markdown special chars
        }
    }
}

filter ConvertTo-OsTableObject {
    Param(
        [ValidateNotNullOrEmpty()]
        [string]$ValueName,

        [ValidateNotNullOrEmpty()]
        [string]$ValuePostfix
    )

    if ($ValuePostfix) {
        $ValuePostfix = " $ValuePostfix"
    }

    foreach ($key in ($_.Keys) | Sort-Object) {
        [ordered]@{
            OS         = @{
                linux   = 'Linux'
                macos   = 'macOS'
                windows = 'Windows'
                default = 'Other'
            }[$key]
            $ValueName = ( -join ($_.$key, $ValuePostfix) | Format-MdString -Code)
        }
    }
}

function New-MdTable {
    [CmdletBinding()]
    # Doesn't change anything
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]

    # Collects pipeline input in the implied End block
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseProcessBlockForPipelineCommand', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '')]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.IDictionary[]]$InputObject,

        [switch]$AlignLeft,
        [switch]$AlignRight,
        [switch]$AlignCenter
    )

    $Items = @($input)
    $MinLength = 3
    $ItemLenghtMap = [ordered]@{ }
    $tpl = '| {0} |'
    $joiner = ' | '

    # Get max row length
    foreach ($item in $Items) {
        foreach ($key in $item.get_Keys()) {
            $maxLength = @(
                @(
                    $key
                    @($Items.$Key)
                ).foreach( { $_.Length } ) | Sort-Object
            )[-1]

            $ItemLenghtMap.$key = ($maxLength, $MinLength)[$maxLength -lt $MinLength]
        }
    }

    # Generate table headers
    $Headers = foreach ($item in $ItemLenghtMap.GetEnumerator()) {
        $item.Key.PadRight($item.Value)
    }

    $tpl -f ($Headers -join $joiner)
    $row = (
        $Headers | ForEach-Object {
            $align = '---'.PadRight($_.Length - 2, '-')

            $align = if ($AlignLeft) {
                ':{0}-' -f $align
            }
            elseif ($AlignRight) {
                '-{0}:' -f $align
            }
            elseif ($AlignCenter) {
                ':{0}:' -f $align
            }
            else {
                '-{0}-' -f $align
            }

            $align
        }
    ) -join $joiner

    $tpl -f $row

    # Generate the rest of the table
    foreach ($item in $Items) {

        # ItemLenghtMap keeps all keys. Should work for objects with different properties
        $row = foreach ($key in $ItemLenghtMap.get_Keys()) {

            # Avoid null
            $value = if ($null -eq $item.$key) {
                [string]::Empty
            }
            else {
                $item.$key
            }

            $value.PadRight($ItemLenghtMap.$key)
        }

        $tpl -f ($row -join $joiner)
    }
}

filter ConvertTo-Readme {
    Param (
        [int]$Indent = 3
    )

    $hdr = '#'

    '{0} [{1}]({2})' -f ($hdr * $Indent), $_.name, $_.links.main | Add-Newline

    '> {0}' -f $_.description | Add-Newline

    if ($_.links.telemetry) {
        '- [Telemetry details]({0})' -f $_.links.telemetry
    }

    if ($_.links.privacy) {
        '- [Privacy policy]({0})' -f $_.links.privacy
    }
    else {
        '- Privacy policy: ❌'
    }

    if ($_.links.Keys.Count) {
        Add-Newline
    }

    if ($_.telemetry.Count -gt 0) {
        'List of known telemetry channels:' | Add-Newline
    }

    foreach ($tm in $_.telemetry) {
        $Indent++ > $null

        if ($tm.links.main) {
            '{0} [{1}]({2})' -f ($hdr * $Indent), $tm.name, $tm.links.main | Add-Newline
        }
        else {
            '{0} {1}' -f ($hdr * $Indent), $tm.name | Add-Newline
        }

        $traits = [ordered]@{
            official     = 'Official'
            usage_data   = 'Usage data'
            update_check = 'Update check'
            error_report = 'Error report'
        }

        $traits.Keys | ForEach-Object -Begin {
            [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignment', '', Justification = 'Dynamic scope')]
            $ret = [ordered]@{}
        } -Process {
            $ret.($traits.$_) = ('❌', '✔')[$tm.traits.$_]
        } -End {
            $ret
        } | New-MdTable -AlignCenter

        Add-NewLine

        if ($tm.links.telemetry) {
            '- [Telemetry details]({0})' -f $tm.links.telemetry | Add-Newline
        }

        if ($tm.links.privacy) {
            '- [Privacy policy]({0})' -f $tm.links.privacy | Add-Newline
        }

        if ($tm.description) {
            '> {0}' -f $tm.description | Add-Newline
        }

        if ($tm.target.Keys.Count -gt 0) {
            'Use methods described below to opt-out of this telemetry channel.' | Add-Newline
        }

        $Counter = 1

        foreach ($tg in ($tm.target.Keys | Sort-Object)) {

            $Indent++ > $null

            '{0} {1}. {2}' -f @(
                $hdr * $Indent
                $Counter
                @{
                    noop       = 'Visit link(s) for more details'
                    env        = 'Set environment variable'
                    exec       = 'Run command'
                    registry   = 'Set registry key'
                    ini_file   = 'Edit config file (INI)'
                    json_file  = 'Edit config file (JSON)'
                    plain_file = 'Edit config file (plaintext)'
                    toml_file  = 'Edit config file (TOML)'
                    xml_file   = 'Edit config file (XML)'
                    yaml_file  = 'Edit config file (YAML)'
                }[$tg]
            ) | Add-Newline

            $Indent++ > $null

            if ($tg -eq 'noop') {

                $noop_counter = 1

                foreach ($item in $tm.target.$tg) {

                    '{0}. [{1}]({2})' -f $noop_counter, $item.name, $item.link | Add-NewLine
                    '    > {0}' -f ($item.description -replace '(\r\n|\r|\n)', '$1    > ') | Add-Newline

                    $noop_counter++ > $null
                }
            }

            foreach ($scope in ('machine', 'user', 'process')) {

                $tgs = $tm.target.$tg.scope.$scope

                if ($tgs) {

                    '{0} Scope: {1}' -f ($hdr * $Indent), @{
                        machine = '💻 Machine'
                        user    = '👤 User'
                        process = '⧉ Process'
                    }[$scope] | Add-Newline

                    switch -Regex ($tg) {
                        '^env$' {
                            if ($tgs.path | Test-IsDefaultOnly) {

                                '```none'
                                '{0}={1}' -f $tgs.path.default, $tgs.value.opt_out
                                '```'

                                Add-Newline
                            }
                            else {
                                $tgs.path | ConvertTo-OsTableObject -ValueName 'Variable Name' | New-MdTable

                                'Value: `{0}`' -f $tgs.value.opt_out | Add-NewLine
                            }

                            break
                        }

                        '^exec$' {
                            if ($tgs.path | Test-IsDefaultOnly) {

                                '```shell'
                                @(
                                    $tgs.path.default
                                    $tgs.value.opt_out | Add-Quote
                                ) -join ' '
                                '```'
                            }
                            else {
                                $tgs.path |
                                ConvertTo-OsTableObject -ValueName 'Command' -ValuePostfix (
                                    $tgs.value.opt_out | Add-Quote
                                ) | New-MdTable
                            }

                            Add-Newline

                            break
                        }

                        '^registry$' {
                            '- Path: `{0}`' -f (
                                $tgs.root, $tgs.path, $tgs.key -join '\'
                            )

                            '- Type: `{0}`' -f $tgs.type

                            '- Value: `{0}`' -f $tgs.value.opt_out | Add-Newline

                            'Example:' | Add-Newline
                            '```shell'
                            $tgs | ConvertTo-RegCommand
                            '```'

                            break
                        }

                        '^(ini|json|plain|toml|xml|yaml)_file$' {
                            if ($tgs.path | Test-IsDefaultOnly) {

                                'Path: `{0}`' -f $tgs.path.default
                            }
                            else {
                                $tgs.path | ConvertTo-OsTableObject -ValueName 'Path' | New-MdTable
                            }

                            Add-Newline

                            '{0} Content' -f ($hdr * $Indent) | Add-Newline

                            '```{0}' -f $Matches[1].Replace('plain', 'none')
                            if ($Matches.1 -eq 'json') {
                                ($tgs.display_value | ConvertFrom-Json -Depth 100 | ConvertTo-Json) -replace $CRLF, $LF
                            }
                            else {
                                $tgs.display_value
                            }
                            '```'

                            Add-Newline

                            break
                        }

                        default {
                            throw "Unknown target: $_"
                        }
                    }
                }
            }

            $Indent-- > $null
            $Indent-- > $null

            $Counter++ > $null
        }
        $Indent-- > $null
    }
}

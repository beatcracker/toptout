#Requires -Version 6

$LF = "`n"
$CRLF = "`r`n"

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

filter ConvertTo-PathTableObject {
    foreach ($key in ($_.Keys) | Sort-Object) {
        [ordered]@{
            OS   = @{
                linux   = 'Linux'
                macos   = 'macOS'
                windows = 'Windows'
            }[$key]
            Path = ($_.$key | Format-MdString)
        }
    }
}

function New-MdTable {
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.IDictionary[]]$InputObject
    )

    $Items = @($input)
    $MinLength = 3
    $ItemLenghtMap = [ordered]@{ }
    $tpl = '|{0}|'

    # Get max row Lenght
    foreach ($item in $Items) {
        foreach ($key in $item.get_Keys()) {
            $maxLength = @(
                @(
                    $key
                    @($Items.$Key)
                ).foreach( { $_.Length }) | Sort-Object
            )[-1]

            $ItemLenghtMap.$key = ($maxLength, $MinLength)[$maxLength -lt $MinLength]
        }
    }

    # Generate table headers

    $Headers = foreach ($item in $ItemLenghtMap.GetEnumerator()) {
        # wrap in spaces + pad
        ' ' + $item.Key.PadRight($item.Value + 1)
    }

    $tpl -f ($Headers -join '|')
    $row = ($Headers | ForEach-Object {
            '---'.PadRight($_.Length, '-')
        }
    ) -join '|'

    $tpl -f ($row -join '|')


    # Generate the rest of the table

    foreach ($item in $Items) {

        # ItemLenghtMap keeps all keys. Should work for objects with different properties
        $row = foreach ($key in $ItemLenghtMap.get_Keys()) {

            # avoid null
            $value = if ($null -ne $item.$key) {
                $item.$key
            }
            else {
                [string]::Empty
            }

            # wrap in spaces + pad
            ' ' + $value.PadRight($ItemLenghtMap.$key + 1)

        }

        $tpl -f ($row -join '|')
    }
}


filter ConvertTo-Readme {
    Param (
        [int]$Indent = 2
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

    if ($_.links.Keys.Count -gt 1) {
        Add-Newline
    }

    if ($_.telemetry.Count -gt 0) {
        'List of known telemetry channels:' | Add-Newline
    }

    foreach ($tm in $_.telemetry) {
        $Indent++ > $null

        '{0} {1}' -f ($hdr * $Indent), $tm.name | Add-Newline

        if ($tm.description) {
            '> {0}' -f $tm.description | Add-Newline
        }

        if ($tm.links) {
            foreach ($l in $tm.links.GetEnumerator()) {
                '{0}: {1}' -f $l.Key, $l.Value
            }

            Add-Newline
        }

        if ($tm.target.Keys.Count -gt 0) {
            'Use methods described below to opt-out of this telemetry channel.' | Add-Newline
        }

        $Indent++ > $null

        foreach ($tg in $tm.target) {

            $Counter = 1

            $MethodHdr = {
                if ($tg.Keys.Count -gt 1) {
                    '{0} Method #{1}' -f ($hdr * $Indent), $Counter | Add-NewLine
                }
            }

            if ($tg.env) {
                . $MethodHdr

                $Indent++ > $null

                '{0} Set environment variable' -f ($hdr * $Indent) | Add-Newline

                '```none'
                '{0}={1}' -f $tg.env.path.default, $tg.env.value.opt_out
                '```'

                Add-Newline

                $Indent-- > $null
                $Counter++ > $null

            }

            if ($tg.exec) {
                . $MethodHdr

                $Indent++ > $null

                '{0} Run command' -f ($hdr * $Indent) | Add-Newline

                '```shell'
                @($tg.exec.path.default, $tg.exec.value.opt_out) -join ' '
                '```'

                Add-Newline

                $Indent-- > $null
                $Counter++ > $null

            }

            if ($tg.json_file) {
                . $MethodHdr

                $Indent++ > $null

                '{0} Edit config file (JSON)' -f ($hdr * $Indent) | Add-Newline

                $Indent++ > $null

                $tg.json_file.path | ConvertTo-PathTableObject | New-MdTable

                # '{0} Path' -f ($hdr * $Indent) | Add-Newline

                # foreach ($p in $tgi.Value.path.GetEnumerator()) {
                #     '- {0}: `{1}`' -f $p.Key, $p.Value
                # }

                Add-Newline

                '{0} Content' -f ($hdr * $Indent) | Add-Newline

                '```json'
                ($tg.json_file.display_value | ConvertFrom-Json -Depth 100 | ConvertTo-Json) -replace $CRLF, $LF
                '```'

                Add-Newline

                $Indent-- > $null
                $Indent-- > $null
                $Counter++ > $null
            }

            if ($tg.plain_file) {
                . $MethodHdr

                $Indent++ > $null

                '{0} Edit config file (plaintext)' -f ($hdr * $Indent) | Add-Newline

                $Indent++ > $null

                $tg.plain_file.path | ConvertTo-PathTableObject | New-MdTable

                # '{0} Path' -f ($hdr * $Indent) | Add-Newline

                # foreach ($p in $tgi.Value.path.GetEnumerator()) {
                #     '- {0}: `{1}`' -f $p.Key, $p.Value
                # }

                Add-Newline

                '{0} Content' -f ($hdr * $Indent) | Add-Newline

                '```none'
                $tg.plain_file.display_value
                '```'

                Add-Newline

                $Indent-- > $null
                $Indent-- > $null
                $Counter++ > $null
            }
        }

        $Indent-- > $null
        $Indent-- > $null
    }
}

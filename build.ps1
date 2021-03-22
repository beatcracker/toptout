#Requires -Version 6

# PSScriptAnalyzer doesn't handle scriptblocks well
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseUsingScopeModifierInNewRunspaces', '')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '')]

[CmdletBinding()]
Param(
    [Parameter(Position = 0)]
    [ValidateSet(
        'test',
        'readme',
        'shell',
        'api',
        'static-files',
        'openapi-bundle',
        'openapi-lint',
        'clean'
    )]
    [string[]]$Tasks
)

#region Common variables

$PackageDirPath = Join-Path $PSScriptRoot 'packages'

#endregion

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

#region Tasks

task . -Jobs @(
    'test'
    'readme'
    'shell'
    'api'
)

task api -Jobs @(
    'static-files'
    'openapi-lint'
    'openapi-bundle'
)

task clean {
    Write-Build Yellow 'Clearing local package directories'

    Remove-BuildItem @(
        "$BuildRoot/packages"
        "$BuildRoot/paket-files"
    )
}

task test {
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
            Path     = $TestDirPath
            Strict   = $true
            PassThru = $true
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

task readme {
    . "$BuildRoot/helpers/common.ps1"
    . "$BuildRoot/helpers/readme.ps1"

    $ReadmePath = "$BuildRoot/README.md"
    $DataDir = "$BuildRoot/data"

    $DataFiles = Get-ChildItem $DataDir -Filter '*.json' -File

    Write-Build White ('Processing data files: {0}' -f $DataFiles.Count)
    $DataFiles | ForEach-Object {
        Write-Build Gray ('  - {0}' -f $_.Name)
    }

    $data = $DataFiles | ForEach-Object {
        $_ | Get-Content -Raw | ConvertFrom-Json -Depth 100 -AsHashtable
    } | Group-Object -AsHashTable -AsString -Property @{ e = { $_.category_id, $_.category_name -join '|' } }

    # TODO: use category_id
    $Categories = $data.Keys | Sort-Object

    $document = $(
        @'
<p align="center">
  <img id="logo" src="https://raw.githubusercontent.com/beatcracker/toptout/master/media/toptout.png">
</p>

<p align="center">
  <a href="https://github.com/beatcracker/toptout/actions?query=workflow%3ATests"><img alt="GitHub Actions status" src="https://github.com/beatcracker/toptout/workflows/Tests/badge.svg"></a>
</p>

# Easily opt-out from telemetry collection

Telemetry in software projects is a polarized issue: on the one hand it allows developers to improve their work by collecting various metrics, on the other hand - nobody likes to be spied on.
The goal of this project is to put you in control. See what data is collected by the tools you use and decide if you want to share it. Then use methods provided here to opt-in or opt-out.

## Usage

The core of this project is a [set of JSON files](data) which describe what telemetry is collected and what can be done to enable or disable it.
What you can do with it is only limited by your imagination. Here are several examples to get you started:

### 📜 Awesome list

The page you see has an [awesome-list of telemetry channels](#telemetry-channels) in various apps.

### 🧯 Scripts

[Scripts](/examples/) to disable all known telemetry channels in your shell session.

### 🚧 API

Get telemetry configuration data via API! See [openapi.yaml](https://github.com/beatcracker/toptout/blob/master/docs/swagger/openapi.yaml) definition and try it online using [Swagger-UI](https://beatcracker.github.io/toptout/swagger).

Or try it in your shell! ⬇️

```shell
curl -X GET 'https://beatcracker.github.io/toptout/api/telemetry/id/powershell-core/' -H 'accept: application/json'
```

### 🤔 Future plans

- Automated tool that can ingest the data from the API. You could run it on your machine to detect and configure telemetry in all suported products.
  - 🚧 [nikvoronin/toptout-cli](https://github.com/nikvoronin/toptout-cli)
- ???

## Details

### JSON data format

JSON telemetry data format decscription: [data/README](/data/)

### Contributing

If the tool you're using is not here you can easily add it by creating a new JSON file describing its telemetry data channels. Pull requests are welcome!

See [CONTRIBUTING](/.github/CONTRIBUTING.md) for details on adding new telemetry data and running tests.

## Related projects

- [Console Do Not Track (DNT)](https://consoledonottrack.com)

  A proposed unified standard for opting out of telemetry for TUI/console apps: `export DO_NOT_TRACK=1`

  Git: [git.eeqj.de/sneak/consoledonottrack.com](https://git.eeqj.de/sneak/consoledonottrack.com)

- [privacy.sexy](https://privacy.sexy/)

  Web tool to enforce privacy & security best-practices on Windows, because privacy is sexy 🍑🍆

  GitHub: [undergroundwires/privacy.sexy](https://github.com/undergroundwires/privacy.sexy)

'@
        '## Telemetry channels' | Add-Newline

        'Below is automatically generated list of known telemetry channels for various applications.' | Add-Newline

        $Categories | ForEach-Object {
            $cid, $cname = $_.Split('|')

            '- [{0}](#{1})' -f $cname, $cid

            $data.$_ | ForEach-Object {
                '  - [{0}](#{1})' -f $_.name, $_.id
            }
        }

        Add-Newline

        $Categories | ForEach-Object {
            $cid, $cname = $_.Split('|')

            '## {0}' -f $cname | Add-Newline

            $data.$_ | Sort-Object -Property id | ForEach-Object {
                $_ | ConvertTo-Readme
            }
        }
    )

    Write-Build White 'Generating MARKDOWN:'
    Write-Build Gray ('  - {0}: {1}' -f 'README.md', $ReadmePath)
    ($document -join $LF).Trim() + $LF | Out-File -LiteralPath $ReadmePath -Encoding utf8NoBOM -NoNewline -Force
}

task shell {
    . "$BuildRoot/helpers/common.ps1"
    . "$BuildRoot/helpers/shell.ps1"

    $DataDir = "$BuildRoot/data"
    $ShellScriptDir = "$BuildRoot/examples"

    $DataFiles = Get-ChildItem $DataDir -Filter '*.json' -File

    Write-Build White ('Processing data files: {0}' -f $DataFiles.Count)
    $DataFiles | ForEach-Object {
        Write-Build Gray ('  - {0}' -f $_.Name)
    }

    $data = $DataFiles | ForEach-Object {
        $_ | Get-Content -Raw | ConvertFrom-Json -Depth 100 -AsHashtable
    } | Group-Object -Property category_name -AsHashTable -AsString

    $Categories = $data.Keys | Sort-Object

    $ShellList = @(
        'bash'
        'pwsh'
    )

    Write-Build White ('Generating SHELL SCRIPT(s): {0}' -f $ShellList.Count)

    foreach ($Shell in $ShellList) {
        $ShellScript = $Categories | Sort-Object | ForEach-Object -Begin {
            Get-ShellScriptHelpers -Shell $Shell
        } -Process {
            $data.$_ | Sort-Object -Property id | ConvertTo-ShellScript -Shell $Shell
        }

        $ShellScriptName = 'toptout_{0}.{1}' -f $Shell, ($Shell | Get-ShellScriptExtension)

        Write-Build Gray ('  - {0}: {1}' -f $Shell, "$ShellScriptDir/$ShellScriptName")
        ($ShellScript -join $LF).Trim() + $LF | Out-File -LiteralPath "$ShellScriptDir/$ShellScriptName" -Encoding utf8NoBOM -NoNewline -Force
    }
}

task static-files {
    . "$BuildRoot/helpers/common.ps1"

    $DataDir = "$BuildRoot/data"
    $ApiDir = "$BuildRoot/docs/api"

    Remove-BuildItem $ApiDir

    $DataFiles = Get-ChildItem $DataDir -Filter '*.json' -File

    Write-Build White ('Processing data files: {0}' -f $DataFiles.Count)
    $DataFiles | ForEach-Object {
        Write-Build Gray ('  - {0}' -f $_.Name)
    }

    $data = $DataFiles | ForEach-Object {
        $_ | Get-Content -Raw | ConvertFrom-Json -Depth 100
    }

    Write-Build White 'Generating API'

    Write-Build White '  category/'
    New-Item -Path "$ApiDir/category" -ItemType Directory > $null
    $data.category_id | Sort-Object -Unique | ConvertTo-Json -Depth 100 -Compress |
    Out-File -LiteralPath "$ApiDir/category/index.json" -Encoding utf8NoBOM -NoNewline -Force

    Write-Build White '  id/'
    New-Item -Path "$ApiDir/id" -ItemType Directory > $null
    @($data.id) | ConvertTo-Json -Depth 100 -Compress |
    Out-File -LiteralPath "$ApiDir/id/index.json" -Encoding utf8NoBOM -NoNewline -Force

    Write-Build White '  telemetry/'
    New-Item -Path "$ApiDir/telemetry" -ItemType Directory > $null
    ConvertTo-Json -InputObject @($data) -Depth 100 -Compress |
    Out-File -LiteralPath "$ApiDir/telemetry/index.json" -Encoding utf8NoBOM -NoNewline -Force

    Write-Build White '  telemetry/id/'
    $data | ForEach-Object {
        $id = $_.id

        Write-Build White "    $id/"
        New-Item -Path "$ApiDir/telemetry/id/$id" -ItemType Directory > $null

        $_ | ConvertTo-Json -Depth 100 -Compress |
        Out-File -LiteralPath "$ApiDir/telemetry/id/$id/index.json" -Encoding utf8NoBOM -NoNewline -Force
    }

    Write-Build White '  telemetry/category/'
    $data_by_category_id = $data | Group-Object -Property category_id
    $data_by_category_id | ForEach-Object {
        $category_id = $_.Name

        Write-Build White "    $category_id/"
        New-Item -Path "$ApiDir/telemetry/category/$category_id" -ItemType Directory > $null

        ConvertTo-Json -InputObject @($_.Group) -Depth 100 -Compress |
        Out-File -LiteralPath "$ApiDir/telemetry/category/$category_id/index.json" -Encoding utf8NoBOM -NoNewline -Force
    }
}

task openapi-lint {
    Write-Build White 'Linting OpenAPI schema'

    exec {
        & 'npx' @(
            '@redocly/openapi-cli'
            'lint'
            "$BuildRoot/schema/openapi.yaml"
            "--config=$BuildRoot/schema/.redocly.lint-ignore.yaml"
        )
    }
}

task openapi-bundle {
    Write-Build White 'Bundling OpenAPI schema'

    exec {
        & 'npx' @(
            '@redocly/openapi-cli'
            'bundle'
            "$BuildRoot/schema/openapi.yaml"
            '--output'
            "$BuildRoot/docs/swagger/openapi.yaml"
            "--config=$BuildRoot/schema/.redocly.lint-ignore.yaml"
        )
    }
}

#endregion

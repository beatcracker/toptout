#Requires -Version 5

<#
.Synopsis
    Toptout shell script: Disable known telemetry channels for apps

.Link
    https://toptout.me

.Parameter Env
    Set environment variables that disable telemetry

.Parameter Exec
    Execute shell commands that disable telemetry

.Parameter ShowLog
    Show operation log

.Example
    toptout_pwsh.ps1 -Env -WhatIf

    Set environment variables, dry run.

.Example
    toptout_pwsh.ps1 -Exec -WhatIf

    Execute commands, dry run.

.Example
    toptout_pwsh.ps1 -Env -Exec -ShowLog

    Set environment variables and execute commands, verbose log.

.Example
    toptout_pwsh.ps1 -Env -Exec

    Set environment variables and execute commands, silent.
#>

[CmdletBinding(SupportsShouldProcess = $true)]
Param(
    [switch]$Env,
    [switch]$Exec,
    [switch]$ShowLog
)

function Get-OsMoniker {
    if ($IsCoreCLR) {
        if ($IsWindows) {
            'windows'
        }
        elseif ($IsLinux) {
            'linux'
        }
        elseif ($IsMacOS) {
            'macos'
        }
    }
    else {
        'windows'
    }
}

function Test-InPath {
    Param(
        [switch]$ShowLog
    )

    foreach ($item in $args) {
        if ($ShowLog) { Write-Host "  Cheking if '$item' is in PATH: " -ForegroundColor Gray -NoNewLine}
        if (Get-Command -Name $item -CommandType Application -ErrorAction SilentlyContinue) {
            if ($ShowLog) { Write-Host $true -ForegroundColor DarkGreen}
            return $true
        }
        if ($ShowLog) { Write-Host $false -ForegroundColor DarkYellow}
    }
    return $false
}

function Invoke-ShellCommand {
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Command,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Arguments,

        [switch]$ShowLog
    )

    $LoggedCommand = "$Command $Arguments"

    if ($PSCmdlet.ShouldProcess($LoggedCommand, 'Execute command')) {
        if ($ShowLog) {
            Write-Host 'Executing command           : ' -ForegroundColor DarkGreen -NoNewline
            Write-Host $LoggedCommand -ForegroundColor DarkYellow
        }

        $ret = Start-Process -FilePath $Command -ArgumentList $Arguments -NoNewWindow -Wait

        if ($ShowLog) {
            Write-Host $ret -ForegroundColor White
        }
    }
}

function Set-EnvVar {
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Value,

        [switch]$ShowLog
    )

    $EnvVar = "$Name=$Value"

    if ($PSCmdlet.ShouldProcess($EnvVar, 'Set environment variable')) {
        if ($ShowLog) {
            Write-Host 'Setting environment variable: ' -ForegroundColor DarkGreen -NoNewline
            Write-Host "$EnvVar" -ForegroundColor DarkYellow
        }

        [System.Environment]::SetEnvironmentVariable($Name, $Value)
    }
}

if (-not $PSBoundParameters.Count) {
    Get-Help $PSCmdlet.MyInvocation.MyCommand.Definition -Examples
    return
}

if ($ShowLog) {
@"
    ______            __              __
   /_  __/___  ____  / /_____  __  __/ /_
    / / / __ \/ __ \/ __/ __ \/ / / / __/
   / / / /_/ / /_/ / /_/ /_/ / /_/ / /_
  /_/  \____/ .___/\__/\____/\__,_/\__/
            /_/
"@ | Write-Host -ForegroundColor Magenta

@"

Easily opt-out from telemetry collection
________________________________________

           https://toptout.me
________________________________________

Current settings:

  Set environment variables: $Env
  Execute commands         : $Exec
  Verbose                  : $ShowLog
  Dry run                  : $WhatIfPreference
________________________________________

"@ | Write-Host
}

# Canvas LMS
# https://github.com/instructure/canvas-lms

# Usage data | Official
# https://github.com/instructure/canvas-lms/blob/dc0e7b50e838fcca6f111082293b8faf415aff28/lib/tasks/db_load_data.rake#L154
if ($Env) {
    Set-EnvVar -Name 'CANVAS_LMS_STATS_COLLECTION' -Value 'opt_out' -ShowLog:$ShowLog
}

# Canvas LMS
# https://github.com/instructure/canvas-lms

# Usage data | Unofficial
# https://github.com/instructure/canvas-lms/blob/dc0e7b50e838fcca6f111082293b8faf415aff28/lib/tasks/db_load_data.rake#L16
if ($Env) {
    Set-EnvVar -Name 'TELEMETRY_OPT_IN' -Value '' -ShowLog:$ShowLog
}

# Eternal Terminal
# https://github.com/MisterTea/EternalTerminal

# Crash data
if ($Env) {
    Set-EnvVar -Name 'ET_NO_TELEMETRY' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# Firefox
# https://www.mozilla.org/firefox/

# Enable policies (macOS)
# https://github.com/mozilla/policy-templates/tree/master/mac
switch (Get-OsMoniker) {
    'macos' {
        if ($Exec) {
            if (Test-InPath 'firefox' -ShowLog:$ShowLog) {
                if (Test-InPath 'defaults' -ShowLog:$ShowLog) {
                    Invoke-ShellCommand -Command 'defaults' -Arguments 'System.Object[]' -ShowLog:$ShowLog
                }
            }
        }
    }
}

# Firefox
# https://www.mozilla.org/firefox/

# Usage data
# https://github.com/mozilla/policy-templates/blob/master/README.md
switch (Get-OsMoniker) {
    'macos' {
        if ($Exec) {
            if (Test-InPath 'firefox' -ShowLog:$ShowLog) {
                if (Test-InPath 'defaults' -ShowLog:$ShowLog) {
                    Invoke-ShellCommand -Command 'defaults' -Arguments 'System.Object[]' -ShowLog:$ShowLog
                }
            }
        }
    }
}

# Homebrew
# https://brew.sh

# Usage data
if ($Env) {
    Set-EnvVar -Name 'HOMEBREW_NO_ANALYTICS' -Value '1' -ShowLog:$ShowLog
}

# LYNX VFX
# https://github.com/LucaScheller/VFX-LYNX

# Usage data
if ($Env) {
    Set-EnvVar -Name 'LYNX_ANALYTICS' -Value '0' -ShowLog:$ShowLog
}

# Microsoft 365 | Enterprise
# https://www.microsoft.com/en-us/microsoft-365/enterprise

# Diagnostic data
# https://docs.microsoft.com/en-us/deployoffice/privacy/overview-privacy-controls#diagnostic-data-sent-from-microsoft-365-apps-for-enterprise-to-microsoftd
switch (Get-OsMoniker) {
    'macos' {
        if ($Exec) {
            if (Test-InPath 'winword' -ShowLog:$ShowLog) {
                if (Test-InPath 'defaults' -ShowLog:$ShowLog) {
                    Invoke-ShellCommand -Command 'defaults' -Arguments 'System.Object[]' -ShowLog:$ShowLog
                }
            }
        }
    }
}

# Quickwit
# https://quickwit.io/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'DISABLE_QUICKWIT_TELEMETRY' -Value '1' -ShowLog:$ShowLog
}

# Automagica
# https://automagica.com/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'AUTOMAGICA_NO_TELEMETRY' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# AWS SAM CLI
# https://aws.amazon.com/serverless/sam/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'SAM_CLI_TELEMETRY' -Value '0' -ShowLog:$ShowLog
}

# Azure CLI
# https://docs.microsoft.com/en-us/cli/azure

# Usage data
if ($Env) {
    Set-EnvVar -Name 'AZURE_CORE_COLLECT_TELEMETRY' -Value '0' -ShowLog:$ShowLog
}

# Google Cloud SDK
# https://cloud.google.com/sdk

# Usage data
if ($Env) {
    Set-EnvVar -Name 'CLOUDSDK_CORE_DISABLE_USAGE_REPORTING' -Value 'true' -ShowLog:$ShowLog
}

# Hoockdeck CLI
# https://hookdeck.com/

# Usage data
# https://github.com/hookdeck/hookdeck-cli/blob/8c2e18bfd5d413e1d2418c5a73d56791b3bfb513/pkg/hookdeck/client.go#L56-L61
if ($Env) {
    Set-EnvVar -Name 'HOOKDECK_CLI_TELEMETRY_OPTOUT' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# Netdata
# https://www.netdata.cloud

# Usage data
if ($Env) {
    Set-EnvVar -Name 'DO_NOT_TRACK' -Value '1' -ShowLog:$ShowLog
}

# Netlify CLI
# https://netlify.com

# Usage data
if ($Exec) {
    if (Test-InPath 'netlify' -ShowLog:$ShowLog) {
        Invoke-ShellCommand -Command 'netlify' -Arguments 'System.Object[]' -ShowLog:$ShowLog
    }
}

# Scaleway CLI (v2)
# https://www.scaleway.com/en/cli/

# Usage data
if ($Exec) {
    if (Test-InPath 'scw' -ShowLog:$ShowLog) {
        Invoke-ShellCommand -Command 'scw' -Arguments 'System.Object[]' -ShowLog:$ShowLog
    }
}

# Stripe CLI
# https://stripe.com/docs/stripe-cli

# Usage data
if ($Env) {
    Set-EnvVar -Name 'STRIPE_CLI_TELEMETRY_OPTOUT' -Value '1' -ShowLog:$ShowLog
}

# Tilt
# https://tilt.dev

# Usage data
if ($Env) {
    Set-EnvVar -Name 'DO_NOT_TRACK' -Value '1' -ShowLog:$ShowLog
}

# Mattermost Server
# https://mattermost.com/

# Diagnostic data
# https://docs.mattermost.com/manage/telemetry.html#error-and-diagnostics-reporting-feature
if ($Env) {
    Set-EnvVar -Name 'MM_LOGSETTINGS_ENABLEDIAGNOSTICS' -Value 'false' -ShowLog:$ShowLog
}

# Mattermost Server
# https://mattermost.com/

# Security Update Check
# https://docs.mattermost.com/manage/telemetry.html#security-update-check-feature
if ($Env) {
    Set-EnvVar -Name 'MM_SERVICESETTINGS_ENABLESECURITYFIXALERT' -Value 'false' -ShowLog:$ShowLog
}

# Aerospike
# https://aerospike.com/

# Usage data
if ($Exec) {
    if (Test-InPath '/opt/aerospike/telemetry/telemetry.py' -ShowLog:$ShowLog) {
        Invoke-ShellCommand -Command '/opt/aerospike/telemetry/telemetry.py' -Arguments 'System.Object[]' -ShowLog:$ShowLog
    }
}

# Feast
# https://feast.dev/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'FEAST_TELEMETRY' -Value 'False' -ShowLog:$ShowLog
}

# InfluxDB
# https://www.influxdata.com/

# Usage data
# https://docs.influxdata.com/influxdb/v2.0/reference/config-options/
if ($Env) {
    Set-EnvVar -Name 'INFLUXD_REPORTING_DISABLED' -Value 'true' -ShowLog:$ShowLog
}

# Meltano
# https://www.meltano.com/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'MELTANO_DISABLE_TRACKING' -Value 'True' -ShowLog:$ShowLog
}

# Quilt
# https://quiltdata.com/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'QUILT_DISABLE_USAGE_METRICS' -Value 'True' -ShowLog:$ShowLog
}

# TimescaleDB
# https://www.timescale.com/

# Usage data
if ($Exec) {
    if (Test-InPath 'psql' -ShowLog:$ShowLog) {
        Invoke-ShellCommand -Command 'psql' -Arguments 'System.Object[]' -ShowLog:$ShowLog
    }
}

# aliBuild
# https://github.com/alisw/alibuild

# Usage data
if ($Env) {
    Set-EnvVar -Name 'ALIBUILD_NO_ANALYTICS' -Value '1' -ShowLog:$ShowLog
}

# Angular
# https://angular.io

# Usage data
# https://angular.io/analytics
if ($Env) {
    Set-EnvVar -Name 'NG_CLI_ANALYTICS' -Value 'false' -ShowLog:$ShowLog
}

# Angular
# https://angular.io

# Usage data (custom)
# https://angular.io/cli/usage-analytics-gathering
if ($Env) {
    Set-EnvVar -Name 'NG_CLI_ANALYTICS_SHARE' -Value 'false' -ShowLog:$ShowLog
}

# Appc Daemon
# https://github.com/appcelerator/appc-daemon

# Usage data
if ($Env) {
    Set-EnvVar -Name 'APPCD_TELEMETRY' -Value '0' -ShowLog:$ShowLog
}

# App Center CLI
# https://github.com/microsoft/appcenter-cli/

# Usage data (command)
if ($Exec) {
    if (Test-InPath 'appcenter' -ShowLog:$ShowLog) {
        Invoke-ShellCommand -Command 'appcenter' -Arguments 'System.Object[]' -ShowLog:$ShowLog
    }
}

# App Center CLI
# https://github.com/microsoft/appcenter-cli/

# Usage data (env. var)
# https://github.com/microsoft/appcenter-cli/blob/master/src/util/profile/telemetry.ts
if ($Env) {
    Set-EnvVar -Name 'MOBILE_CENTER_TELEMETRY' -Value 'off' -ShowLog:$ShowLog
}

# Arduino CLI
# https://arduino.github.io/arduino-cli/latest/

# Internal metrics
if ($Env) {
    Set-EnvVar -Name 'ARDUINO_METRICS_ENABLED' -Value 'false' -ShowLog:$ShowLog
}

# Bot Framework CLI
# https://github.com/microsoft/botframework-cli

# Usage data
# https://github.com/microsoft/botframework-cli/tree/main/packages/cli#bf-configsettelemetry
if ($Env) {
    Set-EnvVar -Name 'BF_CLI_TELEMETRY' -Value 'false' -ShowLog:$ShowLog
}

# Carbon Design System
# https://www.carbondesignsystem.com/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'CARBON_TELEMETRY_DISABLED' -Value '1' -ShowLog:$ShowLog
}

# choosenim
# https://github.com/dom96/choosenim

# Usage data
if ($Env) {
    Set-EnvVar -Name 'CHOOSENIM_NO_ANALYTICS' -Value '1' -ShowLog:$ShowLog
}

# CocoaPods
# https://cocoapods.org/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'COCOAPODS_DISABLE_STATS' -Value 'true' -ShowLog:$ShowLog
}

# Apache Cordova CLI
# https://cordova.apache.org

# Usage data
if ($Env) {
    Set-EnvVar -Name 'CI' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# Cube.js
# https://cube.dev/

# Usage data
# https://cube.dev/docs/reference/environment-variables#general
if ($Env) {
    Set-EnvVar -Name 'CUBEJS_TELEMETRY' -Value 'false' -ShowLog:$ShowLog
}

# Dagster
# https://dagster.io/

# Usage data (environment variable)
# https://github.com/dagster-io/dagster/blob/master/python_modules/dagit/dagit/telemetry.py
if ($Env) {
    Set-EnvVar -Name 'DAGSTER_DISABLE_TELEMETRY' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# .NET Interactive
# https://github.com/dotnet/interactive

# Usage data
if ($Env) {
    Set-EnvVar -Name 'DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT' -Value '1' -ShowLog:$ShowLog
}

# dotnet-svcutil
# https://docs.microsoft.com/en-us/dotnet/core/additional-tools/dotnet-svcutil-guide

# Usage data
if ($Env) {
    Set-EnvVar -Name 'DOTNET_SVCUTIL_TELEMETRY_OPTOUT' -Value '1' -ShowLog:$ShowLog
}

# DVC
# https://dvc.org/

# Usage Analytics
if ($Exec) {
    if (Test-InPath 'dvc' -ShowLog:$ShowLog) {
        Invoke-ShellCommand -Command 'dvc' -Arguments 'System.Object[]' -ShowLog:$ShowLog
    }
}

# Fastlane
# https://fastlane.tools/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'FASTLANE_OPT_OUT_USAGE' -Value 'YES' -ShowLog:$ShowLog
}

# Flagsmith API
# https://flagsmith.com/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'TELEMETRY_DISABLED' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# Flutter
# https://flutter.dev/

# Crash reporting
if ($Exec) {
    if (Test-InPath 'flutter' -ShowLog:$ShowLog) {
        Invoke-ShellCommand -Command 'flutter' -Arguments 'System.Object[]' -ShowLog:$ShowLog
    }
}

# Gatsby
# https://www.gatsbyjs.org

# Usage data
if ($Env) {
    Set-EnvVar -Name 'GATSBY_TELEMETRY_DISABLED' -Value '1' -ShowLog:$ShowLog
}

# Hasura GraphQL engine
# https://hasura.io

# Usage data (CLI and Console)
if ($Env) {
    Set-EnvVar -Name 'HASURA_GRAPHQL_ENABLE_TELEMETRY' -Value 'false' -ShowLog:$ShowLog
}

# Humbug
# https://github.com/bugout-dev/humbug

# Usage data
# https://github.com/bugout-dev/humbug/issues/13
if ($Env) {
    Set-EnvVar -Name 'BUGGER_OFF' -Value '1' -ShowLog:$ShowLog
}

# ImageGear
# https://www.accusoft.com/products/imagegear-collection/imagegear/

# Usage data
# https://help.accusoft.com/ImageGear/v18.8/Linux/Installation.html
switch (Get-OsMoniker) {
    'linux' {
        if ($Env) {
            Set-EnvVar -Name 'IG_PRO_OPT_OUT' -Value 'YES' -ShowLog:$ShowLog
        }
    }
}

# Ionic CLI
# https://ionicframework.com/

# Usage data
if ($Exec) {
    if (Test-InPath 'ionic' -ShowLog:$ShowLog) {
        Invoke-ShellCommand -Command 'ionic' -Arguments 'System.Object[]' -ShowLog:$ShowLog
    }
}

# MeiliSearch
# https://github.com/meilisearch/MeiliSearch

# Usage data and crash reports
if ($Env) {
    Set-EnvVar -Name 'MEILI_NO_ANALYTICS' -Value 'true' -ShowLog:$ShowLog
}

# ML.NET CLI
# https://docs.microsoft.com/en-us/dotnet/machine-learning/automate-training-with-cli

# Usage data
if ($Env) {
    Set-EnvVar -Name 'MLDOTNET_CLI_TELEMETRY_OPTOUT' -Value 'True' -ShowLog:$ShowLog
}

# mssql-cli
# https://github.com/dbcli/mssql-cli

# Usage data
if ($Env) {
    Set-EnvVar -Name 'MSSQL_CLI_TELEMETRY_OPTOUT' -Value 'True' -ShowLog:$ShowLog
}

# .NET Core SDK
# https://docs.microsoft.com/en-us/dotnet/core/tools/index

# Usage data
if ($Env) {
    Set-EnvVar -Name 'DOTNET_CLI_TELEMETRY_OPTOUT' -Value 'true' -ShowLog:$ShowLog
}

# Next.js
# https://nextjs.org

# Usage data
if ($Env) {
    Set-EnvVar -Name 'NEXT_TELEMETRY_DISABLED' -Value '1' -ShowLog:$ShowLog
}

# NocoDB
# https://www.nocodb.com/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'NC_DISABLE_TELE' -Value '1' -ShowLog:$ShowLog
}

# Nuxt.js
# https://nuxtjs.org/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'NUXT_TELEMETRY_DISABLED' -Value '1' -ShowLog:$ShowLog
}

# One Codex API - Python Client Library and CLI
# https://www.onecodex.com/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'ONE_CODEX_NO_TELEMETRY' -Value 'True' -ShowLog:$ShowLog
}

# Ory
# https://www.ory.sh/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'SQA_OPT_OUT' -Value 'true' -ShowLog:$ShowLog
}

# Oryx
# https://github.com/microsoft/Oryx

# Usage data
if ($Env) {
    Set-EnvVar -Name 'ORYX_DISABLE_TELEMETRY' -Value 'true' -ShowLog:$ShowLog
}

# otel-launcher-node
# https://github.com/lightstep/otel-launcher-node/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'LS_METRICS_HOST_ENABLED' -Value '0' -ShowLog:$ShowLog
}

# Pants
# https://www.pantsbuild.org/

# Usage data
# https://www.pantsbuild.org/docs/reference-anonymous-telemetry
if ($Env) {
    Set-EnvVar -Name 'PANTS_ANONYMOUS_TELEMETRY_ENABLED' -Value 'false' -ShowLog:$ShowLog
}

# Microsoft Power Platform CLI
# https://docs.microsoft.com/en-us/powerapps/developer/data-platform/powerapps-cli

# Usage data
if ($Exec) {
    if (Test-InPath 'pac' -ShowLog:$ShowLog) {
        Invoke-ShellCommand -Command 'pac' -Arguments 'System.Object[]' -ShowLog:$ShowLog
    }
}

# Prisma
# https://www.prisma.io/

# Usage data
# https://www.prisma.io/docs/concepts/more/telemetry#usage-data
if ($Env) {
    Set-EnvVar -Name 'CHECKPOINT_DISABLE' -Value '1' -ShowLog:$ShowLog
}

# projector-cli
# https://github.com/projector-cli/projector-cli

# Usage data
if ($Env) {
    Set-EnvVar -Name 'TELEMETRY_ENABLED' -Value '0' -ShowLog:$ShowLog
}

# PROSE Code Accelerator SDK
# https://www.microsoft.com/en-us/research/group/prose/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'PROSE_TELEMETRY_OPTOUT' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# Rasa
# https://rasa.com/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'RASA_TELEMETRY_ENABLED' -Value 'false' -ShowLog:$ShowLog
}

# ReportPortal (JS client)
# https://github.com/reportportal/client-javascript

# Usage data
if ($Env) {
    Set-EnvVar -Name 'REPORTPORTAL_CLIENT_JS_NO_ANALYTICS' -Value 'true' -ShowLog:$ShowLog
}

# ReportPortal (Pytest plugin)
# https://github.com/reportportal/agent-python-pytest

# Usage data
if ($Env) {
    Set-EnvVar -Name 'AGENT_NO_ANALYTICS' -Value '1' -ShowLog:$ShowLog
}

# RESTler
# https://github.com/microsoft/restler-fuzzer

# Usage data
# https://github.com/microsoft/restler-fuzzer/blob/main/docs/user-guide/Telemetry.md
if ($Env) {
    Set-EnvVar -Name 'RESTLER_TELEMETRY_OPTOUT' -Value '1' -ShowLog:$ShowLog
}

# Rockset CLI
# https://rockset.com/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'ROCKSET_CLI_TELEMETRY_OPTOUT' -Value '1' -ShowLog:$ShowLog
}

# Testim Root Cause
# https://github.com/testimio/root-cause

# Usage data
if ($Env) {
    Set-EnvVar -Name 'SUGGESTIONS_OPT_OUT' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# Rover CLI
# https://www.apollographql.com/docs/rover/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'APOLLO_TELEMETRY_DISABLED' -Value '1' -ShowLog:$ShowLog
}

# Salto CLI
# https://www.salto.io/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'SALTO_TELEMETRY_DISABLE' -Value '1' -ShowLog:$ShowLog
}

# Serverless Framework
# https://www.serverless.com/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'SLS_TELEMETRY_DISABLED' -Value '1' -ShowLog:$ShowLog
}

# Salesforce CLI
# https://developer.salesforce.com/tools/sfdxcli

# Usage data
if ($Env) {
    Set-EnvVar -Name 'SFDX_DISABLE_TELEMETRY' -Value 'true' -ShowLog:$ShowLog
}

# SKU
# https://github.com/seek-oss/sku

# Usage data
if ($Env) {
    Set-EnvVar -Name 'SKU_TELEMETRY' -Value 'false' -ShowLog:$ShowLog
}

# Strapi
# https://strapi.io/

# Usage data
# https://strapi.io/documentation/developer-docs/latest/setup-deployment-guides/configurations.html#environment
if ($Env) {
    Set-EnvVar -Name 'STRAPI_TELEMETRY_DISABLED' -Value 'true' -ShowLog:$ShowLog
}

# Strapi
# https://strapi.io/

# Update check
# https://strapi.io/documentation/developer-docs/latest/setup-deployment-guides/configurations.html#environment
if ($Env) {
    Set-EnvVar -Name 'STRAPI_DISABLE_UPDATE_NOTIFICATION' -Value 'true' -ShowLog:$ShowLog
}

# Tuist
# https://tuist.io/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'TUIST_STATS_OPT_OUT' -Value '1' -ShowLog:$ShowLog
}

# TYPO3
# https://github.com/instructure/canvas-lms

# Update check
# https://docs.typo3.org/m/typo3/guide-installation/master/en-us/Legacy/Index.html#disabling-the-core-updater
if ($Env) {
    Set-EnvVar -Name 'TYPO3_DISABLE_CORE_UPDATER' -Value '1' -ShowLog:$ShowLog
}

# TYPO3
# https://github.com/instructure/canvas-lms

# Update check (Apache compatibility)
# https://forge.typo3.org/issues/53188
if ($Env) {
    Set-EnvVar -Name 'REDIRECT_TYPO3_DISABLE_CORE_UPDATER' -Value '1' -ShowLog:$ShowLog
}

# vstest
# https://github.com/microsoft/vstest/

# Usage data
# https://github.com/microsoft/vstest/blob/main/src/vstest.console/TestPlatformHelpers/TestRequestManager.cs#L1047
if ($Env) {
    Set-EnvVar -Name 'VSTEST_TELEMETRY_OPTEDIN' -Value '0' -ShowLog:$ShowLog
}

# VueDX
# https://github.com/znck/vue-developer-experience

# Usage data
if ($Env) {
    Set-EnvVar -Name 'VUEDX_TELEMETRY' -Value 'off' -ShowLog:$ShowLog
}

# WAPM CLI
# https://wasmer.io/

# Usage data
if ($Exec) {
    if (Test-InPath 'wapm' -ShowLog:$ShowLog) {
        Invoke-ShellCommand -Command 'wapm' -Arguments 'System.Object[]' -ShowLog:$ShowLog
    }
}

# webhint
# https://webhint.io/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'HINT_TELEMETRY' -Value 'off' -ShowLog:$ShowLog
}

# Webiny
# https://www.webiny.com/

# Usage data (env. var)
# https://github.com/webiny/webiny-js/blob/0240c2000d1743160c601ae4ce40dd2f949d4d07/packages/telemetry/react.js#L9
if ($Env) {
    Set-EnvVar -Name 'REACT_APP_WEBINY_TELEMETRY' -Value 'false' -ShowLog:$ShowLog
}

# Webiny
# https://www.webiny.com/

# Usage data (command)
# https://www.webiny.com/docs/key-topics/webiny-cli/#yarn-webiny-disable-tracking
if ($Exec) {
    if (Test-InPath 'webiny' -ShowLog:$ShowLog) {
        if (Test-InPath 'yarn' -ShowLog:$ShowLog) {
            Invoke-ShellCommand -Command 'yarn' -Arguments 'System.Object[]' -ShowLog:$ShowLog
        }
    }
}

# Yarn 2
# https://yarnpkg.com/

# Usage data
# https://yarnpkg.com/advanced/telemetry
if ($Env) {
    Set-EnvVar -Name 'YARN_ENABLE_TELEMETRY' -Value '0' -ShowLog:$ShowLog
}

# AutomatedLab
# https://github.com/AutomatedLab/AutomatedLab

# Usage data
if ($Env) {
    Set-EnvVar -Name 'AUTOMATEDLAB_TELEMETRY_OPTIN' -Value '0' -ShowLog:$ShowLog
}

# AutomatedLab
# https://github.com/AutomatedLab/AutomatedLab

# Usage data (legacy env. var.)
if ($Env) {
    Set-EnvVar -Name 'AUTOMATEDLAB_TELEMETRY_OPTOUT' -Value '1' -ShowLog:$ShowLog
}

# AutoSPInstaller Online
# https://github.com/IvanJosipovic/AutoSPInstallerOnline

# Usage data
# https://github.com/IvanJosipovic/AutoSPInstallerOnline/blob/3b4d0e3a7220632a00e36194ce540b8b34e9ed18/AutoSPInstaller.Core/Startup.cs#L36
if ($Env) {
    Set-EnvVar -Name 'DisableTelemetry' -Value 'True' -ShowLog:$ShowLog
}

# Batect
# https://batect.dev/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'BATECT_ENABLE_TELEMETRY' -Value 'false' -ShowLog:$ShowLog
}

# Chef Workstation
# https://docs.chef.io/workstation/

# Usage data
# https://docs.chef.io/workstation/privacy/#opting-out
if ($Env) {
    Set-EnvVar -Name 'CHEF_TELEMETRY_OPT_OUT' -Value '1' -ShowLog:$ShowLog
}

# Consul
# https://www.consul.io/

# Update check
# https://www.consul.io/docs/agent/options#disable_update_check
if ($Env) {
    Set-EnvVar -Name 'CHECKPOINT_DISABLE' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# decK
# https://github.com/Kong/deck

# Usage data
if ($Env) {
    Set-EnvVar -Name 'DECK_ANALYTICS' -Value 'off' -ShowLog:$ShowLog
}

# F5 BIG-IP Terraform provider
# https://registry.terraform.io/providers/F5Networks/bigip/latest/docs

# Usage data
if ($Env) {
    Set-EnvVar -Name 'TEEM_DISABLE' -Value 'true' -ShowLog:$ShowLog
}

# F5 CLI
# https://clouddocs.f5.com/sdk/f5-cli/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'F5_ALLOW_TELEMETRY' -Value 'false' -ShowLog:$ShowLog
}

# Infracost
# https://www.infracost.io/

# Usage data
# https://www.infracost.io/docs/integrations/environment_variables/#infracost_self_hosted_telemetry
if ($Env) {
    Set-EnvVar -Name 'INFRACOST_SELF_HOSTED_TELEMETRY' -Value 'false' -ShowLog:$ShowLog
}

# Infracost
# https://www.infracost.io/

# Update check
# https://www.infracost.io/docs/integrations/environment_variables/#infracost_skip_update_check
if ($Env) {
    Set-EnvVar -Name 'INFRACOST_SKIP_UPDATE_CHECK' -Value 'true' -ShowLog:$ShowLog
}

# Kics
# https://kics.io/

# Usage data (current)
# https://github.com/Checkmarx/kics/issues/3876
if ($Env) {
    Set-EnvVar -Name 'DISABLE_CRASH_REPORT' -Value '1' -ShowLog:$ShowLog
}

# Kics
# https://kics.io/

# Usage data (legacy)
# https://github.com/Checkmarx/kics/issues/3876
if ($Env) {
    Set-EnvVar -Name 'KICS_COLLECT_TELEMETRY' -Value '0' -ShowLog:$ShowLog
}

# kPow
# https://kpow.io/

# Usage data
# https://docs.kpow.io/about/data-collection#how-do-i-opt-out
if ($Env) {
    Set-EnvVar -Name 'ALLOW_UI_ANALYTICS' -Value 'false' -ShowLog:$ShowLog
}

# kubeapt
# https://github.com/twosson/kubeapt

# Usage data
if ($Env) {
    Set-EnvVar -Name 'DASH_DISABLE_TELEMETRY' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# MSLab
# https://github.com/microsoft/MSLab

# Usage data
if ($Env) {
    Set-EnvVar -Name 'MSLAB_TELEMETRY_LEVEL' -Value 'None' -ShowLog:$ShowLog
}

# Nuke
# https://nuke.build/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'NUKE_TELEMETRY_OPTOUT' -Value '1' -ShowLog:$ShowLog
}

# Packer
# https://www.packer.io/

# Update check
if ($Env) {
    Set-EnvVar -Name 'CHECKPOINT_DISABLE' -Value '1' -ShowLog:$ShowLog
}

# PnP PowerShell
# https://pnp.github.io/powershell/

# Usage data (env. var)
# https://pnp.github.io/powershell/articles/configuration.html#disable-or-enable-telemetry
if ($Env) {
    Set-EnvVar -Name 'PNPPOWERSHELL_DISABLETELEMETRY' -Value 'true' -ShowLog:$ShowLog
}

# PnP PowerShell
# https://pnp.github.io/powershell/

# Update check
# https://pnp.github.io/powershell/articles/updatenotifications.html
if ($Env) {
    Set-EnvVar -Name 'PNPPOWERSHELL_UPDATECHECK' -Value 'false' -ShowLog:$ShowLog
}

# Azure Service Fabric CLI
# https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-sfctl

# Usage data
if ($Exec) {
    if (Test-InPath 'sfctl' -ShowLog:$ShowLog) {
        Invoke-ShellCommand -Command 'sfctl' -Arguments 'System.Object[]' -ShowLog:$ShowLog
    }
}

# Skaffold
# https://skaffold.dev/

# Usage data
if ($Exec) {
    if (Test-InPath 'skaffold' -ShowLog:$ShowLog) {
        Invoke-ShellCommand -Command 'skaffold' -Arguments 'System.Object[]' -ShowLog:$ShowLog
    }
}

# Telepresence
# https://www.telepresence.io/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'SCOUT_DISABLE' -Value '1' -ShowLog:$ShowLog
}

# Terraform
# https://www.terraform.io/

# Update check
# https://www.terraform.io/docs/commands/index.html#disable_checkpoint
if ($Env) {
    Set-EnvVar -Name 'CHECKPOINT_DISABLE' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# Terraform Provider for Azure
# https://registry.terraform.io/providers/hashicorp/azurerm/latest

# Usage data
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#disable_terraform_partner_id
if ($Env) {
    Set-EnvVar -Name 'ARM_DISABLE_TERRAFORM_PARTNER_ID' -Value 'true' -ShowLog:$ShowLog
}

# Cloud Development Kit for Terraform
# https://github.com/hashicorp/terraform-cdk

# Usage data
if ($Env) {
    Set-EnvVar -Name 'CHECKPOINT_DISABLE' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# Vagrant
# https://www.vagrantup.com/

# Vagrant update check
# https://www.vagrantup.com/docs/other/environmental-variables#vagrant_checkpoint_disable
if ($Env) {
    Set-EnvVar -Name 'VAGRANT_CHECKPOINT_DISABLE' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# Vagrant
# https://www.vagrantup.com/

# Vagrant box update check
# https://www.vagrantup.com/docs/other/environmental-variables#vagrant_box_update_check_disable
if ($Env) {
    Set-EnvVar -Name 'VAGRANT_BOX_UPDATE_CHECK_DISABLE' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# Weave Net
# https://www.weave.works/

# Update check
if ($Env) {
    Set-EnvVar -Name 'CHECKPOINT_DISABLE' -Value '1' -ShowLog:$ShowLog
}

# WKSctl
# https://www.weave.works/oss/wksctl/

# Update check
if ($Env) {
    Set-EnvVar -Name 'CHECKPOINT_DISABLE' -Value '1' -ShowLog:$ShowLog
}

# AccessMap
# https://www.accessmap.io/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'ANALYTICS' -Value 'no' -ShowLog:$ShowLog
}

# Oh My Zsh
# https://ohmyz.sh/

# Update check
if ($Env) {
    Set-EnvVar -Name 'DISABLE_AUTO_UPDATE' -Value 'true' -ShowLog:$ShowLog
}

# PowerShell Core
# https://github.com/powershell/powershell

# Usage data
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_telemetry
if ($Env) {
    Set-EnvVar -Name 'POWERSHELL_TELEMETRY_OPTOUT' -Value '1' -ShowLog:$ShowLog
}

# PowerShell Core
# https://github.com/powershell/powershell

# Update check
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_update_notification
if ($Env) {
    Set-EnvVar -Name 'POWERSHELL_UPDATECHECK' -Value 'Off' -ShowLog:$ShowLog
}

# Azure Application Insights (VSCode)
# https://marketplace.visualstudio.com/items?itemName=VisualStudioOnlineApplicationInsights.application-insights

# Usage data
if ($Env) {
    Set-EnvVar -Name 'AITOOLSVSCODE_DISABLETELEMETRY' -Value 'ANY_VALUE' -ShowLog:$ShowLog
}

# JavaScript debugger (VSCode)
# https://marketplace.visualstudio.com/items?itemName=ms-vscode.js-debug

# Usage data
# https://github.com/microsoft/vscode-js-debug/blob/12ec6df97f45b25b168e1eac8a17b802af73806f/src/ioc.ts#L168
if ($Env) {
    Set-EnvVar -Name 'DA_TEST_DISABLE_TELEMETRY' -Value '1' -ShowLog:$ShowLog
}

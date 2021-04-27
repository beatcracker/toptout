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

    if (Get-Command -Name $Command -CommandType Application -ErrorAction SilentlyContinue) {
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

# Firefox
# https://www.mozilla.org/firefox/

# Enable policies (macOS)
# https://github.com/mozilla/policy-templates/tree/master/mac
switch (Get-OsMoniker) {
  'macos' {
    if ($Exec) {
        Invoke-ShellCommand -Command 'defaults' -Arguments 'write /Library/Preferences/org.mozilla.firefox EnterprisePoliciesEnabled -bool TRUE' -ShowLog:$ShowLog
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
        Invoke-ShellCommand -Command 'defaults' -Arguments 'write /Library/Preferences/org.mozilla.firefox DisableTelemetry -bool TRUE' -ShowLog:$ShowLog
    }
  }
}

# Homebrew
# https://brew.sh

# Usage data
if ($Env) {
    Set-EnvVar -Name 'HOMEBREW_NO_ANALYTICS' -Value '1' -ShowLog:$ShowLog
}

# Microsoft 365 | Enterprise
# https://www.microsoft.com/en-us/microsoft-365/enterprise

# Diagnostic data
# https://docs.microsoft.com/en-us/deployoffice/privacy/overview-privacy-controls#diagnostic-data-sent-from-microsoft-365-apps-for-enterprise-to-microsoftd
switch (Get-OsMoniker) {
  'macos' {
    if ($Exec) {
        Invoke-ShellCommand -Command 'defaults' -Arguments 'write com.microsoft.office DiagnosticDataTypePreference -string ZeroDiagnosticData' -ShowLog:$ShowLog
    }
  }
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
if ($Exec) {
    Invoke-ShellCommand -Command 'gcloud' -Arguments 'config set disable_usage_reporting true' -ShowLog:$ShowLog
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
    Invoke-ShellCommand -Command 'netlify' -Arguments '--telemetry-disable' -ShowLog:$ShowLog
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
# https://docs.mattermost.com/administration/telemetry.html#error-and-diagnostics-reporting-feature
if ($Env) {
    Set-EnvVar -Name 'MM_LOGSETTINGS_ENABLEDIAGNOSTICS' -Value 'false' -ShowLog:$ShowLog
}

# Mattermost Server
# https://mattermost.com/

# Security Update Check
# https://docs.mattermost.com/administration/telemetry.html#security-update-check-feature
if ($Env) {
    Set-EnvVar -Name 'MM_SERVICESETTINGS_ENABLESECURITYFIXALERT' -Value 'false' -ShowLog:$ShowLog
}

# Feast
# https://feast.dev/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'FEAST_TELEMETRY' -Value 'False' -ShowLog:$ShowLog
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
    Invoke-ShellCommand -Command 'psql' -Arguments '-c "ALTER SYSTEM SET timescaledb.telemetry_level=off"' -ShowLog:$ShowLog
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

# Arduino CLI
# https://arduino.github.io/arduino-cli/latest/

# Internal metrics
if ($Env) {
    Set-EnvVar -Name 'ARDUINO_METRICS_ENABLED' -Value 'false' -ShowLog:$ShowLog
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
    Invoke-ShellCommand -Command 'dvc' -Arguments 'config core.analytics false --global' -ShowLog:$ShowLog
}

# Flutter
# https://flutter.dev/

# Crash reporting
if ($Exec) {
    Invoke-ShellCommand -Command 'flutter' -Arguments 'config --no-analytics' -ShowLog:$ShowLog
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

# Ionic CLI
# https://ionicframework.com/

# Usage data
if ($Exec) {
    Invoke-ShellCommand -Command 'ionic' -Arguments 'config set --global telemetry false' -ShowLog:$ShowLog
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

# Nuxt.js
# https://nuxtjs.org/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'NUXT_TELEMETRY_DISABLED' -Value '1' -ShowLog:$ShowLog
}

# Prisma
# https://www.prisma.io/

# Usage data
# https://www.prisma.io/docs/concepts/more/telemetry#usage-data
if ($Env) {
    Set-EnvVar -Name 'CHECKPOINT_DISABLE' -Value '1' -ShowLog:$ShowLog
}

# Rasa
# https://rasa.com/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'RASA_TELEMETRY_ENABLED' -Value 'false' -ShowLog:$ShowLog
}

# Salto CLI
# https://www.salto.io/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'SALTO_TELEMETRY_DISABLE ' -Value '1' -ShowLog:$ShowLog
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

# webhint
# https://webhint.io/

# Usage data
if ($Env) {
    Set-EnvVar -Name 'HINT_TELEMETRY' -Value 'off' -ShowLog:$ShowLog
}

# Yarn 2
# https://yarnpkg.com/

# Usage data
# https://yarnpkg.com/advanced/telemetry
if ($Exec) {
    Invoke-ShellCommand -Command 'yarn' -Arguments 'config set --home enableTelemetry 0' -ShowLog:$ShowLog
}

# AutomatedLab
# https://github.com/AutomatedLab/AutomatedLab

# Usage data
if ($Env) {
    Set-EnvVar -Name 'AUTOMATEDLAB_TELEMETRY_OPTOUT' -Value '1' -ShowLog:$ShowLog
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

# Packer
# https://www.packer.io/

# Update check
if ($Env) {
    Set-EnvVar -Name 'CHECKPOINT_DISABLE' -Value '1' -ShowLog:$ShowLog
}

# Skaffold
# https://skaffold.dev/

# Usage data
if ($Exec) {
    Invoke-ShellCommand -Command 'skaffold' -Arguments 'config set --global collect-metrics false' -ShowLog:$ShowLog
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

# PowerShell Core
# https://github.com/powershell/powershell

# Usage data
if ($Env) {
    Set-EnvVar -Name 'POWERSHELL_TELEMETRY_OPTOUT' -Value '1' -ShowLog:$ShowLog
}

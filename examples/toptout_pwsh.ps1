#Requires -Version 5

function Get-OsMoniker {
    if ($IsCoreCLR) {
        if ($IsWindows) {
            'windows'
        } elseif ($IsLinux) {
            'linux'
        } elseif ($IsMacOS) {
            'macos'
        }
    } else {
        'windows'
    }
}

# Firefox
# https://www.mozilla.org/firefox/

# Enable policies (macOS)
# https://github.com/mozilla/policy-templates/tree/master/mac
switch (Get-OsMoniker) {
  'macos' {
    . {
      "& (Get-Command -Name 'defaults' -CommandType Application -ErrorAction Stop)[0].Path --% write /Library/Preferences/org.mozilla.firefox EnterprisePoliciesEnabled -bool TRUE"
    } *>&1 > $null
  }
}

# Firefox
# https://www.mozilla.org/firefox/

# Usage data
# https://github.com/mozilla/policy-templates/blob/master/README.md
switch (Get-OsMoniker) {
  'macos' {
    . {
      "& (Get-Command -Name 'defaults' -CommandType Application -ErrorAction Stop)[0].Path --% write /Library/Preferences/org.mozilla.firefox DisableTelemetry -bool TRUE"
    } *>&1 > $null
  }
}

# Homebrew
# https://brew.sh

# Usage data
${env:HOMEBREW_NO_ANALYTICS} = '1'

# Microsoft 365 | Enterprise
# https://www.microsoft.com/en-us/microsoft-365/enterprise

# Diagnostic data
# https://docs.microsoft.com/en-us/deployoffice/privacy/overview-privacy-controls#diagnostic-data-sent-from-microsoft-365-apps-for-enterprise-to-microsoftd
switch (Get-OsMoniker) {
  'macos' {
    . {
      "& (Get-Command -Name 'defaults' -CommandType Application -ErrorAction Stop)[0].Path --% write /Library/Preferences/com.microsoft.office DiagnosticDataTypePreference -string ZeroDiagnosticData"
    } *>&1 > $null
  }
}

# AWS SAM CLI
# https://aws.amazon.com/serverless/sam/

# Usage data
${env:SAM_CLI_TELEMETRY} = '0'

# Azure CLI
# https://docs.microsoft.com/en-us/cli/azure

# Usage data
${env:AZURE_CORE_COLLECT_TELEMETRY} = '0'

# Google Cloud SDK
# https://cloud.google.com/sdk

# Usage data
. {
  "& (Get-Command -Name 'gcloud' -CommandType Application -ErrorAction Stop)[0].Path --% config set disable_usage_reporting true"
} *>&1 > $null

# Netdata
# https://www.netdata.cloud

# Usage data
${env:DO_NOT_TRACK} = '1'

# Netlify CLI
# https://netlify.com

# Usage data
. {
  "& (Get-Command -Name 'netlify' -CommandType Application -ErrorAction Stop)[0].Path --% --telemetry-disable"
} *>&1 > $null

# Stripe CLI
# https://stripe.com/docs/stripe-cli

# Usage data
${env:STRIPE_CLI_TELEMETRY_OPTOUT} = '1'

# Tilt
# https://tilt.dev

# Usage data
${env:DO_NOT_TRACK} = '1'

# Apache Cordova CLI
# https://cordova.apache.org

# Usage data
${env:CI} = 'ANY_VALUE'

# Gatsby
# https://www.gatsbyjs.org

# Usage data
${env:GATSBY_TELEMETRY_DISABLED} = '1'

# Hasura GraphQL engine
# https://hasura.io

# Usage data (CLI and Console)
${env:HASURA_GRAPHQL_ENABLE_TELEMETRY} = 'false'

# .NET Core SDK
# https://docs.microsoft.com/en-us/dotnet/core/tools/index

# Usage data
${env:DOTNET_CLI_TELEMETRY_OPTOUT} = 'true'

# Next.js
# https://nextjs.org

# Usage data
${env:NEXT_TELEMETRY_DISABLED} = '1'

# AutomatedLab
# https://github.com/AutomatedLab/AutomatedLab

# Usage data
${env:AUTOMATEDLAB_TELEMETRY_OPTOUT} = '1'

# PowerShell Core
# https://github.com/powershell/powershell

# Usage data
${env:POWERSHELL_TELEMETRY_OPTOUT} = '1'

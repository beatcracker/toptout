#!/usr/bin/env bash

# Firefox
# https://www.mozilla.org/firefox/

# Enable policies (macOS)
# https://github.com/mozilla/policy-templates/tree/master/mac
case "$OSTYPE" in
  darwin*)
    if command -v 'defaults' >/dev/null 2>&1 >/dev/null
    then
      'defaults' write /Library/Preferences/org.mozilla.firefox EnterprisePoliciesEnabled -bool TRUE >/dev/null 2>&1
    fi
  ;;
esac

# Firefox
# https://www.mozilla.org/firefox/

# Usage data
# https://github.com/mozilla/policy-templates/blob/master/README.md
case "$OSTYPE" in
  darwin*)
    if command -v 'defaults' >/dev/null 2>&1 >/dev/null
    then
      'defaults' write /Library/Preferences/org.mozilla.firefox DisableTelemetry -bool TRUE >/dev/null 2>&1
    fi
  ;;
esac

# Homebrew
# https://brew.sh

# Usage data
export HOMEBREW_NO_ANALYTICS='1'

# Microsoft 365 | Enterprise
# https://www.microsoft.com/en-us/microsoft-365/enterprise

# Diagnostic data
# https://docs.microsoft.com/en-us/deployoffice/privacy/overview-privacy-controls#diagnostic-data-sent-from-microsoft-365-apps-for-enterprise-to-microsoftd
case "$OSTYPE" in
  darwin*)
    if command -v 'defaults' >/dev/null 2>&1 >/dev/null
    then
      'defaults' write com.microsoft.office DiagnosticDataTypePreference -string ZeroDiagnosticData >/dev/null 2>&1
    fi
  ;;
esac

# AWS SAM CLI
# https://aws.amazon.com/serverless/sam/

# Usage data
export SAM_CLI_TELEMETRY='0'

# Azure CLI
# https://docs.microsoft.com/en-us/cli/azure

# Usage data
export AZURE_CORE_COLLECT_TELEMETRY='0'

# Google Cloud SDK
# https://cloud.google.com/sdk

# Usage data
if command -v 'gcloud' >/dev/null 2>&1 >/dev/null
then
  'gcloud' config set disable_usage_reporting true >/dev/null 2>&1
fi

# Netdata
# https://www.netdata.cloud

# Usage data
export DO_NOT_TRACK='1'

# Netlify CLI
# https://netlify.com

# Usage data
if command -v 'netlify' >/dev/null 2>&1 >/dev/null
then
  'netlify' --telemetry-disable >/dev/null 2>&1
fi

# Stripe CLI
# https://stripe.com/docs/stripe-cli

# Usage data
export STRIPE_CLI_TELEMETRY_OPTOUT='1'

# Tilt
# https://tilt.dev

# Usage data
export DO_NOT_TRACK='1'

# Apache Cordova CLI
# https://cordova.apache.org

# Usage data
export CI='ANY_VALUE'

# Gatsby
# https://www.gatsbyjs.org

# Usage data
export GATSBY_TELEMETRY_DISABLED='1'

# Hasura GraphQL engine
# https://hasura.io

# Usage data (CLI and Console)
export HASURA_GRAPHQL_ENABLE_TELEMETRY='false'

# .NET Core SDK
# https://docs.microsoft.com/en-us/dotnet/core/tools/index

# Usage data
export DOTNET_CLI_TELEMETRY_OPTOUT='true'

# Next.js
# https://nextjs.org

# Usage data
export NEXT_TELEMETRY_DISABLED='1'

# AutomatedLab
# https://github.com/AutomatedLab/AutomatedLab

# Usage data
export AUTOMATEDLAB_TELEMETRY_OPTOUT='1'

# PowerShell Core
# https://github.com/powershell/powershell

# Usage data
export POWERSHELL_TELEMETRY_OPTOUT='1'

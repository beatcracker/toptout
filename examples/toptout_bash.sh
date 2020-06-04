# Homebrew
# https://brew.sh
export HOMEBREW_NO_ANALYTICS='1'

# AWS SAM CLI
# https://aws.amazon.com/serverless/sam/
export SAM_CLI_TELEMETRY='0'

# Azure CLI
# https://docs.microsoft.com/en-us/cli/azure
export AZURE_CORE_COLLECT_TELEMETRY='0'

# Google Cloud SDK
# https://cloud.google.com/sdk
if command -v 'gcloud' >/dev/null 2>&1 >/dev/null
then
  'gcloud' config set disable_usage_reporting true >/dev/null 2>&1
fi

# Netdata
# https://www.netdata.cloud
export DO_NOT_TRACK='1'

# Netlify CLI
# https://netlify.com
if command -v 'netlify' >/dev/null 2>&1 >/dev/null
then
  'netlify' --telemetry-disable >/dev/null 2>&1
fi

# Stripe CLI
# https://stripe.com/docs/stripe-cli
export STRIPE_CLI_TELEMETRY_OPTOUT='1'

# Tilt
# https://tilt.dev
export DO_NOT_TRACK='1'

# Apache Cordova CLI
# https://cordova.apache.org
export CI='ANY_VALUE'

# Gatsby
# https://www.gatsbyjs.org
export GATSBY_TELEMETRY_DISABLED='1'

# Hasura GraphQL engine
# https://hasura.io
export HASURA_GRAPHQL_ENABLE_TELEMETRY='false'

# .NET Core SDK
# https://docs.microsoft.com/en-us/dotnet/core/tools/index
export DOTNET_CLI_TELEMETRY_OPTOUT='true'

# Next.js
# https://nextjs.org
export NEXT_TELEMETRY_DISABLED='1'

# AutomatedLab
# https://github.com/AutomatedLab/AutomatedLab
export AUTOMATEDLAB_TELEMETRY_OPTOUT='1'

# PowerShell Core
# https://github.com/powershell/powershell
export POWERSHELL_TELEMETRY_OPTOUT='1'

# Homebrew
# https://brew.sh
${env:HOMEBREW_NO_ANALYTICS} = '1'

# AWS SAM CLI
# https://aws.amazon.com/serverless/sam/
${env:SAM_CLI_TELEMETRY} = '0'

# Azure CLI
# https://docs.microsoft.com/en-us/cli/azure
${env:AZURE_CORE_COLLECT_TELEMETRY} = '0'

# Google Cloud SDK
# https://cloud.google.com/sdk
. {
  & (Get-Command -Name 'gcloud' -CommandType Application -ErrorAction Stop)[0].Path --% config set disable_usage_reporting true
} *>&1 > $null

# Netdata
# https://www.netdata.cloud
${env:DO_NOT_TRACK} = '1'

# Netlify CLI
# https://netlify.com
. {
  & (Get-Command -Name 'netlify' -CommandType Application -ErrorAction Stop)[0].Path --% --telemetry-disable
} *>&1 > $null

# Stripe CLI
# https://stripe.com/docs/stripe-cli
${env:STRIPE_CLI_TELEMETRY_OPTOUT} = '1'

# Tilt
# https://tilt.dev
${env:DO_NOT_TRACK} = '1'

# Apache Cordova CLI
# https://cordova.apache.org
${env:CI} = 'ANY_VALUE'

# Gatsby
# https://www.gatsbyjs.org
${env:GATSBY_TELEMETRY_DISABLED} = '1'

# Hasura GraphQL engine
# https://hasura.io
${env:HASURA_GRAPHQL_ENABLE_TELEMETRY} = 'false'

# .NET Core SDK
# https://docs.microsoft.com/en-us/dotnet/core/tools/index
${env:DOTNET_CLI_TELEMETRY_OPTOUT} = 'true'

# Next.js
# https://nextjs.org
${env:NEXT_TELEMETRY_DISABLED} = '1'

# AutomatedLab
# https://github.com/AutomatedLab/AutomatedLab
${env:AUTOMATEDLAB_TELEMETRY_OPTOUT} = '1'

# PowerShell Core
# https://github.com/powershell/powershell
${env:POWERSHELL_TELEMETRY_OPTOUT} = '1'

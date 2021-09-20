#!/usr/bin/env bash

# https://toptout.me

cleanup () {
  # We're sourced, so cleanup is needed
  unset $(compgen -v | grep '^toptout_')
}

trap cleanup RETURN EXIT

toptout_name="$(basename "${BASH_SOURCE[0]}")"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  toptout_sourced='False'
else
  toptout_sourced='True'
fi

toptout_usage="
Usage:

  . './${toptout_name}' -exvdh

Arguments:

  -e : set environment variables.
       You must source script for this to work: . './${toptout_name}' -e
  -x : execute commands
  -v : verbose
  -d : dry run
  -h : this help"

toptout_warn=$'
WARNING:
  -e specified, but script is not sourced!
  Environment variables wouldn\'t be exported to your shell session.'

toptout_env='False'
toptout_exec='False'
toptout_dry='False'
toptout_verbose='False'

OPTIND=1

while getopts ":exdvh" opt
do
  case $opt in
  e)
    toptout_env='True'
    [[ "${toptout_sourced}" != 'True' ]] && >&2 echo -e "\033[31m${toptout_warn}\033[0m"
  ;;
  x)
    toptout_exec='True'
  ;;
  d)
    toptout_dry='True'
  ;;
  v)
    toptout_verbose='True'
  ;;
  h|\?)
    toptout_help='True'
    echo "${toptout_usage}"
  ;;
  esac
done

if [[ -n "${toptout_help}" ]]
then
  [[ "${toptout_sourced}" == 'True' ]] && return || exit
fi

if [[ "${toptout_env}" == 'False' && "${toptout_exec}" == 'False' ]]
then
  echo "${toptout_usage}"
  [[ "${toptout_sourced}" == 'True' ]] && return || exit
fi

in_path () {
  for item in "$@"
  do
    [[ "${toptout_verbose}" == 'True' ]] && echo -en "  Cheking if \033[32m${item}\033[0m is in PATH: "
    if command -v "${item}" > /dev/null 2>&1
    then
      [[ "${toptout_verbose}" == 'True' ]] && echo -e "\033[32mTrue\033[0m"
      return 0
    else
      [[ "${toptout_verbose}" == 'True' ]] && echo -e "\033[33mFalse\033[0m"
    fi
  done
  return 1
}

run_cmd () {
  [[ "${toptout_verbose}" == 'True' ]] && echo -e "\033[32mExecuting command           :\033[0m \033[33m${1} ${2}\033[0m"
  [[ "${toptout_dry}" == 'False' ]] && "${1}" ${2}
}

set_env () {
  [[ "${toptout_verbose}" == 'True' ]] && echo -e "\033[32mSetting environment variable:\033[0m \033[33m${1}=${2}\033[0m"
  [[ "${toptout_dry}" == 'False' ]] && export "${1}"="${2}"
}

[[ "${toptout_verbose}" == 'True' ]] && echo -e "\033[95m
    ______            __              __
   /_  __/___  ____  / /_____  __  __/ /_
    / / / __ \/ __ \/ __/ __ \/ / / / __/
   / / / /_/ / /_/ / /_/ /_/ / /_/ / /_
  /_/  \____/ .___/\__/\____/\__,_/\__/
            /_/
\033[0m
Easily opt-out from telemetry collection
________________________________________

           https://toptout.me
________________________________________

Current settings:

  Set environment variables: ${toptout_env}
  Execute commands         : ${toptout_exec}
  Verbose                  : ${toptout_verbose}
  Dry run                  : ${toptout_dry}
________________________________________
"

# Eternal Terminal
# https://github.com/MisterTea/EternalTerminal

# Crash data
[[ "${toptout_env}" == 'True' ]] && set_env 'ET_NO_TELEMETRY' 'ANY_VALUE'

# Firefox
# https://www.mozilla.org/firefox/

# Enable policies (macOS)
# https://github.com/mozilla/policy-templates/tree/master/mac
case "$OSTYPE" in
  darwin*)
    if [[ "${toptout_exec}" == 'True' ]]
    then
      if in_path 'firefox'
      then
        if in_path 'defaults'
        then
          run_cmd 'defaults' 'write /Library/Preferences/org.mozilla.firefox EnterprisePoliciesEnabled -bool TRUE'
        fi
      fi
    fi
  ;;
esac

# Firefox
# https://www.mozilla.org/firefox/

# Usage data
# https://github.com/mozilla/policy-templates/blob/master/README.md
case "$OSTYPE" in
  darwin*)
    if [[ "${toptout_exec}" == 'True' ]]
    then
      if in_path 'firefox'
      then
        if in_path 'defaults'
        then
          run_cmd 'defaults' 'write /Library/Preferences/org.mozilla.firefox DisableTelemetry -bool TRUE'
        fi
      fi
    fi
  ;;
esac

# Homebrew
# https://brew.sh

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'HOMEBREW_NO_ANALYTICS' '1'

# LYNX VFX
# https://github.com/LucaScheller/VFX-LYNX

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'LYNX_ANALYTICS' '0'

# Microsoft 365 | Enterprise
# https://www.microsoft.com/en-us/microsoft-365/enterprise

# Diagnostic data
# https://docs.microsoft.com/en-us/deployoffice/privacy/overview-privacy-controls#diagnostic-data-sent-from-microsoft-365-apps-for-enterprise-to-microsoftd
case "$OSTYPE" in
  darwin*)
    if [[ "${toptout_exec}" == 'True' ]]
    then
      if in_path 'winword'
      then
        if in_path 'defaults'
        then
          run_cmd 'defaults' 'write com.microsoft.office DiagnosticDataTypePreference -string ZeroDiagnosticData'
        fi
      fi
    fi
  ;;
esac

# Quickwit
# https://quickwit.io/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'DISABLE_QUICKWIT_TELEMETRY' '1'

# Automagica
# https://automagica.com/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'AUTOMAGICA_NO_TELEMETRY' 'ANY_VALUE'

# AWS SAM CLI
# https://aws.amazon.com/serverless/sam/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'SAM_CLI_TELEMETRY' '0'

# Azure CLI
# https://docs.microsoft.com/en-us/cli/azure

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'AZURE_CORE_COLLECT_TELEMETRY' '0'

# Google Cloud SDK
# https://cloud.google.com/sdk

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'CLOUDSDK_CORE_DISABLE_USAGE_REPORTING' 'true'

# Hoockdeck CLI
# https://hookdeck.com/

# Usage data
# https://github.com/hookdeck/hookdeck-cli/blob/8c2e18bfd5d413e1d2418c5a73d56791b3bfb513/pkg/hookdeck/client.go#L56-L61
[[ "${toptout_env}" == 'True' ]] && set_env 'HOOKDECK_CLI_TELEMETRY_OPTOUT' 'ANY_VALUE'

# Netdata
# https://www.netdata.cloud

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'DO_NOT_TRACK' '1'

# Netlify CLI
# https://netlify.com

# Usage data
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path 'netlify'
  then
    run_cmd 'netlify' '--telemetry-disable'
  fi
fi

# Scaleway CLI (v2)
# https://www.scaleway.com/en/cli/

# Usage data
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path 'scw'
  then
    run_cmd 'scw' 'config set send-telemetry=false'
  fi
fi

# Stripe CLI
# https://stripe.com/docs/stripe-cli

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'STRIPE_CLI_TELEMETRY_OPTOUT' '1'

# Tilt
# https://tilt.dev

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'DO_NOT_TRACK' '1'

# Mattermost Server
# https://mattermost.com/

# Diagnostic data
# https://docs.mattermost.com/administration/telemetry.html#error-and-diagnostics-reporting-feature
[[ "${toptout_env}" == 'True' ]] && set_env 'MM_LOGSETTINGS_ENABLEDIAGNOSTICS' 'false'

# Mattermost Server
# https://mattermost.com/

# Security Update Check
# https://docs.mattermost.com/administration/telemetry.html#security-update-check-feature
[[ "${toptout_env}" == 'True' ]] && set_env 'MM_SERVICESETTINGS_ENABLESECURITYFIXALERT' 'false'

# Aerospike
# https://aerospike.com/

# Usage data
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path '/opt/aerospike/telemetry/telemetry.py'
  then
    run_cmd '/opt/aerospike/telemetry/telemetry.py' '/etc/aerospike/telemetry.conf --disable'
  fi
fi

# Feast
# https://feast.dev/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'FEAST_TELEMETRY' 'False'

# InfluxDB
# https://www.influxdata.com/

# Usage data
# https://docs.influxdata.com/influxdb/v2.0/reference/config-options/
[[ "${toptout_env}" == 'True' ]] && set_env 'INFLUXD_REPORTING_DISABLED' 'true'

# Meltano
# https://www.meltano.com/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'MELTANO_DISABLE_TRACKING' 'True'

# Quilt
# https://quiltdata.com/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'QUILT_DISABLE_USAGE_METRICS' 'True'

# TimescaleDB
# https://www.timescale.com/

# Usage data
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path 'psql'
  then
    run_cmd 'psql' '-c "ALTER SYSTEM SET timescaledb.telemetry_level=off"'
  fi
fi

# aliBuild
# https://github.com/alisw/alibuild

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'ALIBUILD_NO_ANALYTICS' '1'

# Angular
# https://angular.io

# Usage data
# https://angular.io/analytics
[[ "${toptout_env}" == 'True' ]] && set_env 'NG_CLI_ANALYTICS' 'false'

# Angular
# https://angular.io

# Usage data (custom)
# https://angular.io/cli/usage-analytics-gathering
[[ "${toptout_env}" == 'True' ]] && set_env 'NG_CLI_ANALYTICS_SHARE' 'false'

# Appc Daemon
# https://github.com/appcelerator/appc-daemon

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'APPCD_TELEMETRY' '0'

# App Center CLI
# https://github.com/microsoft/appcenter-cli/

# Usage data (command)
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path 'appcenter'
  then
    run_cmd 'appcenter' 'telemetry off'
  fi
fi

# App Center CLI
# https://github.com/microsoft/appcenter-cli/

# Usage data (env. var)
# https://github.com/microsoft/appcenter-cli/blob/master/src/util/profile/telemetry.ts
[[ "${toptout_env}" == 'True' ]] && set_env 'MOBILE_CENTER_TELEMETRY' 'off'

# Arduino CLI
# https://arduino.github.io/arduino-cli/latest/

# Internal metrics
[[ "${toptout_env}" == 'True' ]] && set_env 'ARDUINO_METRICS_ENABLED' 'false'

# Bot Framework CLI
# https://github.com/microsoft/botframework-cli

# Usage data
# https://github.com/microsoft/botframework-cli/tree/main/packages/cli#bf-configsettelemetry
[[ "${toptout_env}" == 'True' ]] && set_env 'BF_CLI_TELEMETRY' 'false'

# Carbon Design System
# https://www.carbondesignsystem.com/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'CARBON_TELEMETRY_DISABLED' '1'

# choosenim
# https://github.com/dom96/choosenim

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'CHOOSENIM_NO_ANALYTICS' '1'

# CocoaPods
# https://cocoapods.org/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'COCOAPODS_DISABLE_STATS' 'true'

# Apache Cordova CLI
# https://cordova.apache.org

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'CI' 'ANY_VALUE'

# Cube.js
# https://cube.dev/

# Usage data
# https://cube.dev/docs/reference/environment-variables#general
[[ "${toptout_env}" == 'True' ]] && set_env 'CUBEJS_TELEMETRY' 'false'

# Dagster
# https://dagster.io/

# Usage data (environment variable)
# https://github.com/dagster-io/dagster/blob/master/python_modules/dagit/dagit/telemetry.py
[[ "${toptout_env}" == 'True' ]] && set_env 'DAGSTER_DISABLE_TELEMETRY' 'ANY_VALUE'

# .NET Interactive
# https://github.com/dotnet/interactive

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT' '1'

# dotnet-svcutil
# https://docs.microsoft.com/en-us/dotnet/core/additional-tools/dotnet-svcutil-guide

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'DOTNET_SVCUTIL_TELEMETRY_OPTOUT' '1'

# DVC
# https://dvc.org/

# Usage Analytics
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path 'dvc'
  then
    run_cmd 'dvc' 'config core.analytics false --global'
  fi
fi

# Fastlane
# https://fastlane.tools/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'FASTLANE_OPT_OUT_USAGE' 'YES'

# Flagsmith API
# https://flagsmith.com/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'TELEMETRY_DISABLED' 'ANY_VALUE'

# Flutter
# https://flutter.dev/

# Crash reporting
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path 'flutter'
  then
    run_cmd 'flutter' 'config --no-analytics'
  fi
fi

# Gatsby
# https://www.gatsbyjs.org

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'GATSBY_TELEMETRY_DISABLED' '1'

# Hasura GraphQL engine
# https://hasura.io

# Usage data (CLI and Console)
[[ "${toptout_env}" == 'True' ]] && set_env 'HASURA_GRAPHQL_ENABLE_TELEMETRY' 'false'

# Humbug
# https://github.com/bugout-dev/humbug

# Usage data
# https://github.com/bugout-dev/humbug/issues/13
[[ "${toptout_env}" == 'True' ]] && set_env 'BUGGER_OFF' '1'

# ImageGear
# https://www.accusoft.com/products/imagegear-collection/imagegear/

# Usage data
# https://help.accusoft.com/ImageGear/v18.8/Linux/Installation.html
case "$OSTYPE" in
  linux*)
    [[ "${toptout_env}" == 'True' ]] && set_env 'IG_PRO_OPT_OUT' 'YES'
  ;;
esac

# Ionic CLI
# https://ionicframework.com/

# Usage data
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path 'ionic'
  then
    run_cmd 'ionic' 'config set --global telemetry false'
  fi
fi

# MeiliSearch
# https://github.com/meilisearch/MeiliSearch

# Usage data and crash reports
[[ "${toptout_env}" == 'True' ]] && set_env 'MEILI_NO_ANALYTICS' 'true'

# ML.NET CLI
# https://docs.microsoft.com/en-us/dotnet/machine-learning/automate-training-with-cli

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'MLDOTNET_CLI_TELEMETRY_OPTOUT' 'True'

# mssql-cli
# https://github.com/dbcli/mssql-cli

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'MSSQL_CLI_TELEMETRY_OPTOUT' 'True'

# .NET Core SDK
# https://docs.microsoft.com/en-us/dotnet/core/tools/index

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'DOTNET_CLI_TELEMETRY_OPTOUT' 'true'

# Next.js
# https://nextjs.org

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'NEXT_TELEMETRY_DISABLED' '1'

# NocoDB
# https://www.nocodb.com/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'NC_DISABLE_TELE' '1'

# Nuxt.js
# https://nuxtjs.org/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'NUXT_TELEMETRY_DISABLED' '1'

# One Codex API - Python Client Library and CLI
# https://www.onecodex.com/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'ONE_CODEX_NO_TELEMETRY' 'True'

# Ory
# https://www.ory.sh/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'SQA_OPT_OUT' 'true'

# Oryx
# https://github.com/microsoft/Oryx

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'ORYX_DISABLE_TELEMETRY' 'true'

# otel-launcher-node
# https://github.com/lightstep/otel-launcher-node/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'LS_METRICS_HOST_ENABLED' '0'

# Pants
# https://www.pantsbuild.org/

# Usage data
# https://www.pantsbuild.org/docs/reference-anonymous-telemetry
[[ "${toptout_env}" == 'True' ]] && set_env 'PANTS_ANONYMOUS_TELEMETRY_ENABLED' 'false'

# Microsoft Power Platform CLI
# https://docs.microsoft.com/en-us/powerapps/developer/data-platform/powerapps-cli

# Usage data
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path 'pac'
  then
    run_cmd 'pac' 'telemetry disable'
  fi
fi

# Prisma
# https://www.prisma.io/

# Usage data
# https://www.prisma.io/docs/concepts/more/telemetry#usage-data
[[ "${toptout_env}" == 'True' ]] && set_env 'CHECKPOINT_DISABLE' '1'

# projector-cli
# https://github.com/projector-cli/projector-cli

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'TELEMETRY_ENABLED' '0'

# PROSE Code Accelerator SDK
# https://www.microsoft.com/en-us/research/group/prose/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'PROSE_TELEMETRY_OPTOUT' 'ANY_VALUE'

# Rasa
# https://rasa.com/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'RASA_TELEMETRY_ENABLED' 'false'

# ReportPortal (JS client)
# https://github.com/reportportal/client-javascript

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'REPORTPORTAL_CLIENT_JS_NO_ANALYTICS' 'true'

# ReportPortal (Pytest plugin)
# https://github.com/reportportal/agent-python-pytest

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'AGENT_NO_ANALYTICS' '1'

# RESTler
# https://github.com/microsoft/restler-fuzzer

# Usage data
# https://github.com/microsoft/restler-fuzzer/blob/main/docs/user-guide/Telemetry.md
[[ "${toptout_env}" == 'True' ]] && set_env 'RESTLER_TELEMETRY_OPTOUT' '1'

# Rockset CLI
# https://rockset.com/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'ROCKSET_CLI_TELEMETRY_OPTOUT' '1'

# Testim Root Cause
# https://github.com/testimio/root-cause

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'SUGGESTIONS_OPT_OUT' 'ANY_VALUE'

# Rover CLI
# https://www.apollographql.com/docs/rover/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'APOLLO_TELEMETRY_DISABLED' '1'

# Salto CLI
# https://www.salto.io/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'SALTO_TELEMETRY_DISABLE' '1'

# Serverless Framework
# https://www.serverless.com/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'SLS_TELEMETRY_DISABLED' '1'

# Salesforce CLI
# https://developer.salesforce.com/tools/sfdxcli

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'SFDX_DISABLE_TELEMETRY' 'true'

# SKU
# https://github.com/seek-oss/sku

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'SKU_TELEMETRY' 'false'

# Strapi
# https://strapi.io/

# Usage data
# https://strapi.io/documentation/developer-docs/latest/setup-deployment-guides/configurations.html#environment
[[ "${toptout_env}" == 'True' ]] && set_env 'STRAPI_TELEMETRY_DISABLED' 'true'

# Strapi
# https://strapi.io/

# Update check
# https://strapi.io/documentation/developer-docs/latest/setup-deployment-guides/configurations.html#environment
[[ "${toptout_env}" == 'True' ]] && set_env 'STRAPI_DISABLE_UPDATE_NOTIFICATION' 'true'

# Tuist
# https://tuist.io/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'TUIST_STATS_OPT_OUT' '1'

# vstest
# https://github.com/microsoft/vstest/

# Usage data
# https://github.com/microsoft/vstest/blob/main/src/vstest.console/TestPlatformHelpers/TestRequestManager.cs#L1047
[[ "${toptout_env}" == 'True' ]] && set_env 'VSTEST_TELEMETRY_OPTEDIN' '0'

# VueDX
# https://github.com/znck/vue-developer-experience

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'VUEDX_TELEMETRY' 'off'

# WAPM CLI
# https://wasmer.io/

# Usage data
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path 'wapm'
  then
    run_cmd 'wapm' 'config set telemetry.enabled false'
  fi
fi

# webhint
# https://webhint.io/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'HINT_TELEMETRY' 'off'

# Webiny
# https://www.webiny.com/

# Usage data (env. var)
# https://github.com/webiny/webiny-js/blob/0240c2000d1743160c601ae4ce40dd2f949d4d07/packages/telemetry/react.js#L9
[[ "${toptout_env}" == 'True' ]] && set_env 'REACT_APP_WEBINY_TELEMETRY' 'false'

# Webiny
# https://www.webiny.com/

# Usage data (command)
# https://www.webiny.com/docs/key-topics/webiny-cli/#yarn-webiny-disable-tracking
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path 'webiny'
  then
    if in_path 'yarn'
    then
      run_cmd 'yarn' 'webiny disable-tracking'
    fi
  fi
fi

# Yarn 2
# https://yarnpkg.com/

# Usage data
# https://yarnpkg.com/advanced/telemetry
[[ "${toptout_env}" == 'True' ]] && set_env 'YARN_ENABLE_TELEMETRY' '0'

# AutomatedLab
# https://github.com/AutomatedLab/AutomatedLab

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'AUTOMATEDLAB_TELEMETRY_OPTIN' '0'

# AutomatedLab
# https://github.com/AutomatedLab/AutomatedLab

# Usage data (legacy env. var.)
[[ "${toptout_env}" == 'True' ]] && set_env 'AUTOMATEDLAB_TELEMETRY_OPTOUT' '1'

# Batect
# https://batect.dev/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'BATECT_ENABLE_TELEMETRY' 'false'

# Chef Workstation
# https://docs.chef.io/workstation/

# Usage data
# https://docs.chef.io/workstation/privacy/#opting-out
[[ "${toptout_env}" == 'True' ]] && set_env 'CHEF_TELEMETRY_OPT_OUT' '1'

# Consul
# https://www.consul.io/

# Update check
# https://www.consul.io/docs/agent/options#disable_update_check
[[ "${toptout_env}" == 'True' ]] && set_env 'CHECKPOINT_DISABLE' 'ANY_VALUE'

# decK
# https://github.com/Kong/deck

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'DECK_ANALYTICS' 'off'

# F5 BIG-IP Terraform provider
# https://registry.terraform.io/providers/F5Networks/bigip/latest/docs

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'TEEM_DISABLE' 'true'

# F5 CLI
# https://clouddocs.f5.com/sdk/f5-cli/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'F5_ALLOW_TELEMETRY' 'false'

# Infracost
# https://www.infracost.io/

# Usage data
# https://www.infracost.io/docs/integrations/environment_variables/#infracost_self_hosted_telemetry
[[ "${toptout_env}" == 'True' ]] && set_env 'INFRACOST_SELF_HOSTED_TELEMETRY' 'false'

# Infracost
# https://www.infracost.io/

# Update check
# https://www.infracost.io/docs/integrations/environment_variables/#infracost_skip_update_check
[[ "${toptout_env}" == 'True' ]] && set_env 'INFRACOST_SKIP_UPDATE_CHECK' 'true'

# Kics
# https://kics.io/

# Usage data (current)
# https://github.com/Checkmarx/kics/issues/3876
[[ "${toptout_env}" == 'True' ]] && set_env 'DISABLE_CRASH_REPORT' '1'

# Kics
# https://kics.io/

# Usage data (legacy)
# https://github.com/Checkmarx/kics/issues/3876
[[ "${toptout_env}" == 'True' ]] && set_env 'KICS_COLLECT_TELEMETRY' '0'

# kPow
# https://kpow.io/

# Usage data
# https://docs.kpow.io/about/data-collection#how-do-i-opt-out
[[ "${toptout_env}" == 'True' ]] && set_env 'ALLOW_UI_ANALYTICS' 'false'

# kubeapt
# https://github.com/twosson/kubeapt

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'DASH_DISABLE_TELEMETRY' 'ANY_VALUE'

# MSLab
# https://github.com/microsoft/MSLab

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'MSLAB_TELEMETRY_LEVEL' 'None'

# Nuke
# https://nuke.build/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'NUKE_TELEMETRY_OPTOUT' '1'

# Packer
# https://www.packer.io/

# Update check
[[ "${toptout_env}" == 'True' ]] && set_env 'CHECKPOINT_DISABLE' '1'

# PnP PowerShell
# https://pnp.github.io/powershell/

# Usage data (env. var)
# https://pnp.github.io/powershell/articles/configuration.html#disable-or-enable-telemetry
[[ "${toptout_env}" == 'True' ]] && set_env 'PNPPOWERSHELL_DISABLETELEMETRY' 'true'

# PnP PowerShell
# https://pnp.github.io/powershell/

# Update check
# https://pnp.github.io/powershell/articles/updatenotifications.html
[[ "${toptout_env}" == 'True' ]] && set_env 'PNPPOWERSHELL_UPDATECHECK' 'false'

# Azure Service Fabric CLI
# https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-sfctl

# Usage data
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path 'sfctl'
  then
    run_cmd 'sfctl' 'settings telemetry set_telemetry --off'
  fi
fi

# Skaffold
# https://skaffold.dev/

# Usage data
if [[ "${toptout_exec}" == 'True' ]]
then
  if in_path 'skaffold'
  then
    run_cmd 'skaffold' 'config set --global collect-metrics false'
  fi
fi

# Telepresence
# https://www.telepresence.io/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'SCOUT_DISABLE' '1'

# Terraform
# https://www.terraform.io/

# Update check
# https://www.terraform.io/docs/commands/index.html#disable_checkpoint
[[ "${toptout_env}" == 'True' ]] && set_env 'CHECKPOINT_DISABLE' 'ANY_VALUE'

# Cloud Development Kit for Terraform
# https://github.com/hashicorp/terraform-cdk

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'CHECKPOINT_DISABLE' 'ANY_VALUE'

# Vagrant
# https://www.vagrantup.com/

# Vagrant update check
# https://www.vagrantup.com/docs/other/environmental-variables#vagrant_checkpoint_disable
[[ "${toptout_env}" == 'True' ]] && set_env 'VAGRANT_CHECKPOINT_DISABLE' 'ANY_VALUE'

# Vagrant
# https://www.vagrantup.com/

# Vagrant box update check
# https://www.vagrantup.com/docs/other/environmental-variables#vagrant_box_update_check_disable
[[ "${toptout_env}" == 'True' ]] && set_env 'VAGRANT_BOX_UPDATE_CHECK_DISABLE' 'ANY_VALUE'

# Weave Net
# https://www.weave.works/

# Update check
[[ "${toptout_env}" == 'True' ]] && set_env 'CHECKPOINT_DISABLE' '1'

# WKSctl
# https://www.weave.works/oss/wksctl/

# Update check
[[ "${toptout_env}" == 'True' ]] && set_env 'CHECKPOINT_DISABLE' '1'

# AccessMap
# https://www.accessmap.io/

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'ANALYTICS' 'no'

# Oh My Zsh
# https://ohmyz.sh/

# Update check
[[ "${toptout_env}" == 'True' ]] && set_env 'DISABLE_AUTO_UPDATE' 'true'

# PowerShell Core
# https://github.com/powershell/powershell

# Usage data
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_telemetry
[[ "${toptout_env}" == 'True' ]] && set_env 'POWERSHELL_TELEMETRY_OPTOUT' '1'

# PowerShell Core
# https://github.com/powershell/powershell

# Update check
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_update_notification
[[ "${toptout_env}" == 'True' ]] && set_env 'POWERSHELL_UPDATECHECK' 'Off'

# Azure Application Insights (VSCode)
# https://marketplace.visualstudio.com/items?itemName=VisualStudioOnlineApplicationInsights.application-insights

# Usage data
[[ "${toptout_env}" == 'True' ]] && set_env 'AITOOLSVSCODE_DISABLETELEMETRY' 'ANY_VALUE'

# JavaScript debugger (VSCode)
# https://marketplace.visualstudio.com/items?itemName=ms-vscode.js-debug

# Usage data
# https://github.com/microsoft/vscode-js-debug/blob/12ec6df97f45b25b168e1eac8a17b802af73806f/src/ioc.ts#L168
[[ "${toptout_env}" == 'True' ]] && set_env 'DA_TEST_DISABLE_TELEMETRY' '1'

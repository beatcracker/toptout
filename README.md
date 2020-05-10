<p align="center">
  <img src="/media/toptout.png">
</p>

<p align="center">
  <a href="https://github.com/beatcracker/toptout/actions?query=workflow%3ATests"><img alt="GitHub Actions status" src="https://github.com/beatcracker/toptout/workflows/Tests/badge.svg"></a>
</p>

# Toptout: easily opt-out from telemetry collection [![Tweet](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=Toptout%3A%20easily%20opt-out%20from%20telemetry%20collection%21%20https%3A%2F%2Fgithub.com%2Fbeatcracker%2Ftoptout&hashtags=opensource,powershell,telemetry,privacy,infosec)

Telemetry in software projects is a polarized issue: on the one hand it allows developers to improve their work by collecting various metrics, on the other hand - nobody likes to be spied on.
The goal of this project is to put you in control. See what data is collected by the tools you use and decide if you want to share it. Then use methods provided here to opt-in or opt-out.

## Details

The core of this project is a set of JSON files which describe what telemetry is collected and what can be done to enable or disable it. The README you see is automatically generated from those files.

## Contributing

If the tool you're using is not here you can easily add it by creating a new JSON file describing its telemetry data channels.

See [CONTRIBUTING](/docs/CONTRIBUTING.md) and [data/README](/data/README.md) for details.

## Future plans

- API to serve this data online.
- Automated tool that can ingest the data from the API. You could run it on your machine to detect and configure telemetry in all suported products.
- ???

## Related projects

[Console Do Not Track (DNT)](https://consoledonottrack.com)

A proposed unified standard for opting out of telemetry for TUI/console apps: `export DO_NOT_TRACK=1`

## Table of Contents

- [Applications](#applications)
  - [Atom](#atom)
  - [Homebrew](#homebrew)
  - [Microsoft calculator](#microsoft-calculator)
  - [VSCode](#vscode)
- [Cloud](#cloud)
  - [AWS SAM CLI](#aws-sam-cli)
  - [Azure CLI](#azure-cli)
  - [Google Cloud SDK](#google-cloud-sdk)
  - [Netdata](#netdata)
  - [Netlify CLI](#netlify-cli)
  - [Stripe CLI](#stripe-cli)
  - [Tilt](#tilt)
- [Development](#development)
  - [Apache Cordova CLI](#apache-cordova-cli)
  - [Gatsby](#gatsby)
  - [Hasura GraphQL engine](#hasura-graphql-engine)
  - [.NET Core SDK](#net-core-sdk)
  - [Next.js](#nextjs)
- [DevOps](#devops)
  - [AutomatedLab](#automatedlab)
- [Shells](#shells)
  - [PowerShell Core](#powershell-core)

## Applications

## [Atom](https://atom.io)

> Help improve Atom by sending usage statistics, exceptions and deprecations to the team.

- [Telemetry details](https://github.com/atom/metrics)
- [Privacy policy](https://help.github.com/articles/github-privacy-policy/)

List of known telemetry channels:

### Usage data

> The user's decision is stored at core.telemetryConsent. The three possible values are undecided, no and limited. The intent is that consent is given if and only if limited is chosen.

Use methods described below to opt-out of this telemetry channel.

##### Edit config file (plaintext)

| OS      | Path                                |
|---------|-------------------------------------|
| Linux   | $HOME/\.atom/init\.coffee           |
| macOS   | $HOME/\.atom/init\.coffee           |
| Windows | %USERPROFILE%\\\.atom\\init\.coffee |

###### Content

```none
atom.config.set('core.telemetryConsent', 'no')
```

## [Homebrew](https://brew.sh)

> Homebrew has begun gathering anonymous aggregate user behaviour analytics and reporting these to Google Analytics.

- [Telemetry details](https://docs.brew.sh/Analytics)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

#### Method #1

##### Set environment variable

```none
HOMEBREW_NO_ANALYTICS=1
```

#### Method #2

##### Run command

```shell
brew analytics off
```

## [Microsoft calculator](https://github.com/Microsoft/calculator)

> This project collects usage data and sends it to Microsoft to help improve our products and services.

- [Telemetry details](https://github.com/microsoft/calculator#diagnostic-data)
- [Privacy policy](https://go.microsoft.com/fwlink/?LinkId=521839)

List of known telemetry channels:

### Diagnostic data

> Diagnostic data is disabled in development builds by default, and can be enabled with the SEND_DIAGNOSTICS build flag.

## [VSCode](https://code.visualstudio.com/)

> Visual Studio Code collects telemetry data, which is used to help understand how to improve the product.

- [Telemetry details](https://code.visualstudio.com/docs/getstarted/telemetry)
- [Privacy policy](https://go.microsoft.com/fwlink/?LinkID=528096)

List of known telemetry channels:

### Usage data

> VS Code collects usage data that helps to debug issues, such as slow start-up times, and to prioritize new features.

Use methods described below to opt-out of this telemetry channel.

##### Edit config file (JSON)

| OS      | Path                                                       |
|---------|------------------------------------------------------------|
| Linux   | $HOME/\.config/Code/User/settings\.json                    |
| macOS   | $HOME/Library/Application Support/Code/User/settings\.json |
| Windows | %APPDATA%\\Code\\User\\settings\.json                      |

###### Content

```json
{
  "telemetry.enableTelemetry": false
}
```

### Crash data

> VS Code collects data about any crashes that occur and sends it to Microsoft to help improve our products and services.

Use methods described below to opt-out of this telemetry channel.

##### Edit config file (JSON)

| OS      | Path                                                       |
|---------|------------------------------------------------------------|
| Linux   | $HOME/\.config/Code/User/settings\.json                    |
| macOS   | $HOME/Library/Application Support/Code/User/settings\.json |
| Windows | %APPDATA%\\Code\\User\\settings\.json                      |

###### Content

```json
{
  "telemetry.enableCrashReporter": false
}
```

## Cloud

## [AWS SAM CLI](https://aws.amazon.com/serverless/sam/)

> At AWS, we develop and launch services based on what we learn from interactions with customers. We use customer feedback to iterate on our product. Telemetry is additional information that helps us to better understand our customers’ needs, diagnose issues, and deliver features that improve the customer experience. The AWS SAM CLI collects telemetry, such as generic usage metrics, system and environment information, and errors.

- [Telemetry details](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-telemetry.html)
- [Privacy policy](https://aws.amazon.com/compliance/data-privacy-faq/)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

##### Set environment variable

```none
SAM_CLI_TELEMETRY=0
```

## [Azure CLI](https://docs.microsoft.com/en-us/cli/azure)

> Allow Microsoft to collect anonymous data on the usage of the CLI.

- [Telemetry details](https://docs.microsoft.com/en-us/cli/azure/azure-cli-configuration)
- [Privacy policy](https://aka.ms/AzureCliLegal)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

#### Method #1

##### Set environment variable

```none
AZURE_CORE_COLLECT_TELEMETRY=0
```

#### Method #2

##### Run command

```shell
az configure -d collect_telemetry=0
```

## [Google Cloud SDK](https://cloud.google.com/sdk)

> Unless you opt-in during Google Cloud SDK installation, Cloud SDK software does not collect usage statistics. You can help Google to prioritize Google Cloud SDK features and improvements by permitting Cloud SDK to send command-line command usage statistics to Google.

- [Telemetry details](https://cloud.google.com/sdk/usage-statistics)
- [Privacy policy](https://policies.google.com/privacy)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

##### Run command

```shell
gcloud config set disable_usage_reporting true
```

## [Netdata](https://www.netdata.cloud)

> By default, Netlify collects data on usage of Netlify CLI commands. We do this to improve the reliability and performance of Netlify CLI, and to help drive new features and improvements.

- [Telemetry details](https://learn.netdata.cloud/docs/agent/anonymous-statistic/)
- [Privacy policy](https://learn.netdata.cloud/docs/agent/privacy-policy/)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

##### Set environment variable

```none
DO_NOT_TRACK=1
```

## [Netlify CLI](https://netlify.com)

> By default, Netlify collects data on usage of Netlify CLI commands. We do this to improve the reliability and performance of Netlify CLI, and to help drive new features and improvements.

- [Telemetry details](https://docs.netlify.com/cli/get-started/#usage-data-collection)
- [Privacy policy](https://www.netlify.com/privacy/)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

#### Method #1

##### Run command

```shell
netlify --telemetry-disable
```

#### Method #2

##### Edit config file (JSON)

| OS      | Path                                   |
|---------|----------------------------------------|
| Linux   | $HOME/\.netlify/config\.json           |
| macOS   | $HOME/\.netlify/config\.json           |
| Windows | %USERPROFILE%\\\.netlify\\config\.json |

###### Content

```json
{
  "telemetryDisabled": true
}
```

## [Stripe CLI](https://stripe.com/docs/stripe-cli)

> The Stripe CLI includes a telemetry feature that collects some usage data. This feature is enabled by default.

- [Telemetry details](https://github.com/stripe/stripe-cli/wiki/telemetry)
- [Privacy policy](https://stripe.com/privacy)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

##### Set environment variable

```none
STRIPE_CLI_TELEMETRY_OPTOUT=1
```

## [Tilt](https://tilt.dev)

> Tilt sends anonymized data about how you use it.

- [Telemetry details](https://docs.tilt.dev/telemetry_faq.html)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

##### Set environment variable

```none
DO_NOT_TRACK=1
```

## Development

## [Apache Cordova CLI](https://cordova.apache.org)

> We use the gathered information to help us make our tool more useful and to better understand how it is used. We do not track or collect personally identifiable information or associate gathered data with any personally identifying information from other sources.

- [Telemetry details](https://cordova.apache.org/docs/en/latest/reference/cordova-cli/#global-command-list)
- [Privacy policy](https://cordova.apache.org/privacy/)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

#### Method #1

##### Set environment variable

```none
CI=ANY_VALUE
```

#### Method #2

##### Run command

```shell
cordova telemetry off
```

## [Gatsby](https://www.gatsbyjs.org)

> Gatsby contains a telemetry feature that collects anonymous usage information that is used to help improve Gatsby for all users. The Gatsby user base is growing very rapidly. It’s important that our small team and the greater community will better understand the usage patterns, so we can best decide how to design future features and prioritize current work.

- [Telemetry details](https://www.gatsbyjs.org/docs/telemetry/)
- [Privacy policy](https://www.gatsbyjs.com/privacy-policy/)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

#### Method #1

##### Set environment variable

```none
GATSBY_TELEMETRY_DISABLED=1
```

#### Method #2

##### Run command

```shell
gatsby telemetry --disable
```

## [Hasura GraphQL engine](https://hasura.io)

> The Hasura GraphQL engine collects anonymous telemetry data that helps the Hasura team in understanding how the product is being used and in deciding what to focus on next.

- [Telemetry details](https://docs.hasura.io/1.0/graphql/manual/guides/telemetry.html)
- [Privacy policy](https://hasura.io/legal/hasura-privacy-policy)

List of known telemetry channels:

### Usage data (CLI and Console)

> The CLI collects each execution event, along with a randomly generated UUID. The execution event contains the command name, timestamp and whether the execution resulted in an error or not. Error messages, arguments and flags are not recorded. The CLI also collects the server version and UUID that it is talking to. The operating system platform and architecture is also noted along with the CLI version.

Use methods described below to opt-out of this telemetry channel.

#### Method #1

##### Set environment variable

```none
HASURA_GRAPHQL_ENABLE_TELEMETRY=false
```

#### Method #2

##### Edit config file (JSON)

| OS      | Path                                  |
|---------|---------------------------------------|
| Linux   | $HOME/\.hasura/config\.json           |
| macOS   | $HOME/\.hasura/config\.json           |
| Windows | %USERPROFILE%\\\.hasura\\config\.json |

###### Content

```json
{
  "enable_telemetry": false
}
```

## [.NET Core SDK](https://docs.microsoft.com/en-us/dotnet/core/tools/index)

> The NET Core SDK includes a telemetry feature that collects usage data and exception information when the .NET Core CLI crashes. The .NET Core CLI comes with the .NET Core SDK and is the set of verbs that enable you to build, test, and publish your .NET Core apps. It's important that the .NET team understands how the tools are used so they can be improved. Information on failures helps the team resolve problems and fix bugs.

- [Telemetry details](https://docs.microsoft.com/en-us/dotnet/core/tools/telemetry)
- [Privacy policy](https://go.microsoft.com/fwlink/?LinkID=528096)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

##### Set environment variable

```none
DOTNET_CLI_TELEMETRY_OPTOUT=true
```

## [Next.js](https://nextjs.org)

> Next.js collects completely anonymous telemetry data about general usage. Participation in this anonymous program is optional, and you may opt-out if you'd not like to share any information.

- [Telemetry details](https://nextjs.org/telemetry)
- [Privacy policy](https://zeit.co/security#policy)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

#### Method #1

##### Set environment variable

```none
NEXT_TELEMETRY_DISABLED=1
```

#### Method #2

##### Run command

```shell
npx next telemetry disable
```

## DevOps

## [AutomatedLab](https://github.com/AutomatedLab/AutomatedLab)

> AutomatedLab will start to collect telemetry starting with version 5.0. This is an opt-out collection and you will be asked once to specify whether or not you want to send us telemetry data.

- [Telemetry details](https://github.com/AutomatedLab/AutomatedLab/wiki/Lab-Telemetry)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

#### Method #1

##### Set environment variable

```none
AUTOMATEDLAB_TELEMETRY_OPTOUT=1
```

#### Method #2

##### Run command

```shell
pwsh -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "Import-Module AutomatedLab -ErrorAction Stop ; Disable-LabTelemetry -ErrorAction Stop"
```

## Shells

## [PowerShell Core](https://github.com/powershell/powershell)

> PowerShell Core sends basic telemetry data to Microsoft when it is launched. The data includes the OS name, OS version, and PowerShell version. This data allows us to better understand the environments where PowerShell is used and enables us to prioritize new features and fixes.

- [Telemetry details](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_telemetry)
- [Privacy policy](https://privacy.microsoft.com/privacystatement)

List of known telemetry channels:

### Usage data

Use methods described below to opt-out of this telemetry channel.

##### Set environment variable

```none
POWERSHELL_TELEMETRY_OPTOUT=1
```

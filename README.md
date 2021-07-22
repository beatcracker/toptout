<p align="center">
  <img id="logo" src="https://raw.githubusercontent.com/beatcracker/toptout/master/media/toptout.png">
</p>

<p align="center">
  <a href="https://github.com/beatcracker/toptout/actions?query=workflow%3ATests"><img alt="GitHub Actions status" src="https://github.com/beatcracker/toptout/workflows/Tests/badge.svg"></a>
  <a href="https://twitter.com/toptout_me"><img alt="Twitter Follow" src="https://img.shields.io/twitter/follow/toptout_me?style=social"></a>
</p>

# Easily opt-out from telemetry collection

Telemetry in software projects is a polarized issue: on the one hand it allows developers to improve their work by collecting various metrics, on the other hand - nobody likes to be spied on.
The goal of this project is to put you in control. See what data is collected by the tools you use and decide if you want to share it. Then use methods provided here to opt-in or opt-out.

## Usage

This project collects data about telemetry in applications in [machine-readable format](/data/) and makes it easy to create derivative works such as awesome-lists, configuration scripts, APIs, etc.
What you can do with it is only limited by your imagination. Here are several examples to get you started:

### 📜 Awesome list

The page you see has an [awesome-list of telemetry channels](#telemetry-channels) in various apps.

### 🧯 Scripts

[Scripts](/examples/) to disable all known telemetry channels in your shell session.

<p align="center">
  <img id="script" src="https://raw.githubusercontent.com/beatcracker/toptout/master/media/script.png">
</p>

### 🚧 API

Get telemetry configuration data via API! See [openapi.yaml](https://github.com/beatcracker/toptout/blob/master/docs/swagger/openapi.yaml) definition and try it online using [Swagger-UI](https://toptout.me/swagger).

Or try it in your shell! ⬇️

```shell
curl -X GET 'https://toptout.me/api/telemetry/id/powershell-core/' -H 'accept: application/json'
```

### 🤔 Future plans

- Automated tool that can ingest the data from the API. You could run it on your machine to detect and configure telemetry in all supported products.
  - 🚧 [nikvoronin/toptout-cli](https://github.com/nikvoronin/toptout-cli)
- ???

## Details

### JSON data format

JSON telemetry data format description: [data/README](/data/)

### Contributing

If the tool you're using is not here you can easily add it by creating a new JSON file describing its telemetry data channels. Pull requests are welcome!

See [CONTRIBUTING](/.github/CONTRIBUTING.md) for details on adding new telemetry data and running tests.

## Contributors

- Emanuel Bronshtein ([emanuelb](https://github.com/emanuelb), [e3amn2l](https://twitter.com/e3amn2l))

  [Telemetry definitions](https://github.com/beatcracker/toptout/issues/created_by/emanuelb)

- Lars Wirzenius (https://liw.fi, [liw](https://toot.liw.fi/@liw))

  [Readme review](https://liw.fi/readme-review/)

## Related projects

- [Console Do Not Track (DNT)](https://consoledonottrack.com)

  A proposed unified standard for opting out of telemetry for TUI/console apps: `export DO_NOT_TRACK=1`

  Git: [git.eeqj.de/sneak/consoledonottrack.com](https://git.eeqj.de/sneak/consoledonottrack.com)

- [privacy.sexy](https://privacy.sexy/)

  Web tool to enforce privacy & security best-practices on Windows, because privacy is sexy 🍑🍆

  GitHub: [undergroundwires/privacy.sexy](https://github.com/undergroundwires/privacy.sexy)

- [Distro Telemetry Watch](https://www.summertime.tech/dtw.EN.html)

  List of Linux distributions, ranked by included telemetry.

- [rljacobson/OptOutEnv](https://github.com/rljacobson/OptOutEnv)

  A lot of software enables telemetry by default unless an environment variable is set. This repository collects telemetry opt-out environment variables from across the web.

- [herrbischoff/telemetry](https://github.com/herrbischoff/telemetry)

  How to disable most data collection happening in your software and on your devices.

- [rfletcher/cli-privacy](https://github.com/rfletcher/cli-privacy)

  CLI Privacy: Opt-out of third-party tracking in your terminal.

## Telemetry channels

Below is automatically generated list of known telemetry channels for various applications.

Total count: **132**

- [Applications](#applications)
  - [Atom](#atom)
  - [Eternal Terminal](#eternal-terminal)
  - [Firefox](#firefox)
  - [Homebrew](#homebrew)
  - [Lens](#lens)
  - [LYNX VFX](#lynx-vfx)
  - [Microsoft 365 | Enterprise](#microsoft-365--enterprise)
  - [Microsoft calculator](#microsoft-calculator)
  - [Quickwit](#quickwit)
  - [VSCode](#vscode)
  - [Windows Terminal](#windows-terminal)
  - [winget](#winget)
- [Cloud](#cloud)
  - [Automagica](#automagica)
  - [AWS SAM CLI](#aws-sam-cli)
  - [Azure CLI](#azure-cli)
  - [Google Cloud SDK](#google-cloud-sdk)
  - [Hoockdeck CLI](#hoockdeck-cli)
  - [Netdata](#netdata)
  - [Netlify CLI](#netlify-cli)
  - [Stripe CLI](#stripe-cli)
  - [Tilt](#tilt)
- [Communications](#communications)
  - [Mattermost Server](#mattermost-server)
- [Database](#database)
  - [Aerospike](#aerospike)
  - [Feast](#feast)
  - [InfluxDB](#influxdb)
  - [Materialize](#materialize)
  - [Meltano](#meltano)
  - [Quilt](#quilt)
  - [TimescaleDB](#timescaledb)
- [Development](#development)
  - [aliBuild](#alibuild)
  - [Angular](#angular)
  - [Appc Daemon](#appc-daemon)
  - [App Center CLI](#app-center-cli)
  - [Arduino CLI](#arduino-cli)
  - [Bot Framework CLI](#bot-framework-cli)
  - [BuildBuddy](#buildbuddy)
  - [Carbon Design System](#carbon-design-system)
  - [choosenim](#choosenim)
  - [CocoaPods](#cocoapods)
  - [code-server](#code-server)
  - [Apache Cordova CLI](#apache-cordova-cli)
  - [Cube.js](#cubejs)
  - [Dagster](#dagster)
  - [Docker Desktop](#docker-desktop)
  - [.NET Interactive](#net-interactive)
  - [dotnet-svcutil](#dotnet-svcutil)
  - [DVC](#dvc)
  - [Ember CLI](#ember-cli)
  - [Fastlane](#fastlane)
  - [Flagsmith API](#flagsmith-api)
  - [Flutter](#flutter)
  - [Gatsby](#gatsby)
  - [Hasura GraphQL engine](#hasura-graphql-engine)
  - [Humbug](#humbug)
  - [ImageGear](#imagegear)
  - [Ionic CLI](#ionic-cli)
  - [MeiliSearch](#meilisearch)
  - [ML.NET CLI](#mlnet-cli)
  - [mssql-cli](#mssql-cli)
  - [.NET Core SDK](#net-core-sdk)
  - [Next.js](#nextjs)
  - [NocoDB](#nocodb)
  - [Nuxt.js](#nuxtjs)
  - [One Codex API - Python Client Library and CLI](#one-codex-api---python-client-library-and-cli)
  - [Ory](#ory)
  - [Oryx](#oryx)
  - [otel-launcher-node](#otel-launcher-node)
  - [Pants](#pants)
  - [Prisma](#prisma)
  - [projector-cli](#projector-cli)
  - [PROSE Code Accelerator SDK](#prose-code-accelerator-sdk)
  - [REST API Fuzz Testing (RAFT)](#rest-api-fuzz-testing-raft)
  - [Rasa](#rasa)
  - [React Native for Windows + macOS](#react-native-for-windows--macos)
  - [ReportPortal (JS client)](#reportportal-js-client)
  - [ReportPortal (Pytest plugin)](#reportportal-pytest-plugin)
  - [RESTler](#restler)
  - [Rockset CLI](#rockset-cli)
  - [Testim Root Cause](#testim-root-cause)
  - [Rover CLI](#rover-cli)
  - [Salto CLI](#salto-cli)
  - [Serverless Framework](#serverless-framework)
  - [Salesforce CLI](#salesforce-cli)
  - [SKU](#sku)
  - [Strapi](#strapi)
  - [Tuist](#tuist)
  - [vstest](#vstest)
  - [VueDX](#vuedx)
  - [WAPM CLI](#wapm-cli)
  - [webhint](#webhint)
  - [Webiny](#webiny)
  - [Yarn 2](#yarn-2)
- [DevOps](#devops)
  - [AutomatedLab](#automatedlab)
  - [Batect](#batect)
  - [Chef Automate](#chef-automate)
  - [Chef Workstation](#chef-workstation)
  - [Consul](#consul)
  - [decK](#deck)
  - [F5 BIG-IP Terraform provider](#f5-big-ip-terraform-provider)
  - [F5 CLI](#f5-cli)
  - [Infracost](#infracost)
  - [k0s](#k0s)
  - [Kics](#kics)
  - [kPow](#kpow)
  - [kubeapt](#kubeapt)
  - [MSLab](#mslab)
  - [Nuke](#nuke)
  - [OpenVZ](#openvz)
  - [Packer](#packer)
  - [PnP PowerShell](#pnp-powershell)
  - [Azure Service Fabric CLI](#azure-service-fabric-cli)
  - [Skaffold](#skaffold)
  - [Telepresence](#telepresence)
  - [Terraform](#terraform)
  - [Cloud Development Kit for Terraform](#cloud-development-kit-for-terraform)
  - [Vagrant](#vagrant)
  - [Weave Net](#weave-net)
  - [WKSctl](#wksctl)
- [Drivers](#drivers)
  - [Nvidia drivers](#nvidia-drivers)
- [Operating systems](#operating-systems)
  - [Windows 10](#windows-10)
- [Other](#other)
  - [AccessMap](#accessmap)
- [Shells](#shells)
  - [Oh My Zsh](#oh-my-zsh)
  - [PowerShell Core](#powershell-core)
- [VSCode extension](#vscode-extension)
  - [Azure Application Insights (VSCode)](#azure-application-insights-vscode)
  - [docs-yaml (VSCode)](#docs-yaml-vscode)
  - [ESP-IDF (VSCode)](#esp-idf-vscode)
  - [JavaScript debugger (VSCode)](#javascript-debugger-vscode)
  - [Julia (VSCode)](#julia-vscode)
  - [PrintCode (VSCode)](#printcode-vscode)
  - [REST Client (VSCode)](#rest-client-vscode)
  - [Serverless IDE (VSCode)](#serverless-ide-vscode)
  - [Terminal (VSCode)](#terminal-vscode)

## Applications

### [Atom](https://atom.io)

> Help improve Atom by sending usage statistics, exceptions and deprecations to the team.

- [Telemetry details](https://github.com/atom/metrics)
- [Privacy policy](https://help.github.com/articles/github-privacy-policy/)

List of known telemetry channels:

#### Usage data

Official: ✔

> The user's decision is stored at core.telemetryConsent. The three possible values are undecided, no and limited. The intent is that consent is given if and only if limited is chosen.

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (plaintext)

###### Scope: 👤 User

| OS      | Path                              |
|---------|-----------------------------------|
| Linux   | `$HOME/.atom/init.coffee`         |
| macOS   | `$HOME/.atom/init.coffee`         |
| Windows | `%USERPROFILE%\.atom\init.coffee` |

###### Content

```none
atom.config.set('core.telemetryConsent', 'no')
```

### [Eternal Terminal](https://github.com/MisterTea/EternalTerminal)

> Eternal Terminal collects crashes and errors in order to help us improve your experience. The data collected is anonymous.

- [Telemetry details](https://github.com/MisterTea/EternalTerminal/blob/55aafce51b7199908423efb4d4e69a4f61b22069/src/terminal/TelemetryService.cpp#L117-L120)
- Privacy policy: ❌

List of known telemetry channels:

#### Crash data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
ET_NO_TELEMETRY=ANY_VALUE
```

### [Firefox](https://www.mozilla.org/firefox/)

> Telemetry collects information about your Firefox browsing experience to improve Firefox features, browser performance and stability.

- [Telemetry details](https://wiki.allizom.org/Telemetry/FAQ)
- [Privacy policy](https://www.mozilla.org/privacy/firefox/)

List of known telemetry channels:

#### [Enable policies (macOS)](https://github.com/mozilla/policy-templates/tree/master/mac)

Official: ✔

> Enable Firefox policies so the telemetry can be configured.

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 💻 Machine

| OS    | Command                                                                                        |
|-------|------------------------------------------------------------------------------------------------|
| macOS | `defaults write /Library/Preferences/org.mozilla.firefox EnterprisePoliciesEnabled -bool TRUE` |

#### [Usage data](https://github.com/mozilla/policy-templates/blob/master/README.md)

Official: ✔

> Examples of the kind of data Telemetry sends to Mozilla includes start-up time, time between cycle collector runs, memory heap used, whether hardware graphics acceleration or Java is enabled, and more.
Telemetry does not collect any bookmarks or passwords. It may collect anonymized site visit information in some circumstances, such as when a secure browsing connection fails to connect, or for some experiments.

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 💻 Machine

| OS    | Command                                                                               |
|-------|---------------------------------------------------------------------------------------|
| macOS | `defaults write /Library/Preferences/org.mozilla.firefox DisableTelemetry -bool TRUE` |

##### 2. Edit config file (JSON)

###### Scope: 💻 Machine

| OS      | Path                                                                      |
|---------|---------------------------------------------------------------------------|
| Linux   | `distribution/policies.json`                                              |
| macOS   | `/Applications/Firefox.app/Contents/Resources/distribution/policies.json` |
| Windows | `distribution\policies.json`                                              |

###### Content

```json
{
  "policies": {
    "DisableTelemetry": true
  }
}
```

##### 3. Set registry key

###### Scope: 💻 Machine

- Path: `HKEY_LOCAL_MACHINE\Software\Policies\Mozilla\Firefox\DisableTelemetry`
- Type: `REG_DWORD`
- Value: `1`

###### Scope: 👤 User

- Path: `HKEY_CURRENT_USER\Software\Policies\Mozilla\Firefox\DisableTelemetry`
- Type: `REG_DWORD`
- Value: `1`

### [Homebrew](https://brew.sh)

> Homebrew has begun gathering anonymous aggregate user behaviour analytics and reporting these to Google Analytics.

- [Telemetry details](https://docs.brew.sh/Analytics)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
HOMEBREW_NO_ANALYTICS=1
```

##### 2. Run command

###### Scope: 👤 User

```shell
brew analytics off
```

### [Lens](https://k8slens.dev/)

> Lens collects telemetry data, which is used to help us understand how to improve the product. For example, this usage data helps us to debug issues and to prioritize new features.

- [Telemetry details](https://docs.k8slens.dev/getting-started/preferences)
- [Privacy policy](https://www.mirantis.com/company/privacy-policy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Disable usage data reporting](https://docs.k8slens.dev/v4.1.2/getting-started/preferences/#disable-telemetry-reporting)

    > If you don't wish to send usage data to Mirantis, you can disable the "Telemetry & Usage Tracking" in the Lens preferences.

### [LYNX VFX](https://github.com/LucaScheller/VFX-LYNX)

> When using LYNX, non personal data can be optionally collected via Google Analytics. This helps us get feedback and prioritize the development to give you the best possible version of our product in future releases.

- [Telemetry details](https://github.com/LucaScheller/VFX-LYNX#analytics)
- [Privacy policy](https://www.lucascheller.de/imprint-privacypolicy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
LYNX_ANALYTICS=0
```

##### 2. Edit config file (JSON)

###### Scope: 👤 User

| OS    | Path               |
|-------|--------------------|
| Linux | `/etc/LYNX.config` |

###### Content

```json
{
  "ANALYTICS": {
    "enabled": 0
  }
}
```

### [Microsoft 365 | Enterprise](https://www.microsoft.com/en-us/microsoft-365/enterprise)

> Microsoft is committed to providing you with the information and controls you need to make choices about how your data is collected and used when you’re using Microsoft 365 Apps for enterprise (previously named Office 365 ProPlus).

- [Telemetry details](https://docs.microsoft.com/en-us/deployoffice/privacy/manage-privacy-controls)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### [Diagnostic data](https://docs.microsoft.com/en-us/deployoffice/privacy/overview-privacy-controls#diagnostic-data-sent-from-microsoft-365-apps-for-enterprise-to-microsoftd)

Official: ✔

> Configure the level of client software diagnostic data sent by Office to Microsoft.

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 💻 Machine

| OS    | Command                                                                                       |
|-------|-----------------------------------------------------------------------------------------------|
| macOS | `defaults write com.microsoft.office DiagnosticDataTypePreference -string ZeroDiagnosticData` |

##### 2. Set registry key

###### Scope: 👤 User

- Path: `HKEY_CURRENT_USER\Software\Policies\Microsoft\office\16.0\common\privacy\SendTelemetry`
- Type: `REG_DWORD`
- Value: `3`

### [Microsoft calculator](https://github.com/Microsoft/calculator)

> This project collects usage data and sends it to Microsoft to help improve our products and services.

- [Telemetry details](https://github.com/microsoft/calculator#diagnostic-data)
- [Privacy policy](https://go.microsoft.com/fwlink/?LinkId=521839)

List of known telemetry channels:

#### Diagnostic data

Official: ✔

> Diagnostic data is disabled in development builds by default, and can be enabled with the SEND_DIAGNOSTICS build flag.

### [Quickwit](https://quickwit.io/)

> Quickwit Inc. collects anonymous data regarding general usage to help us drive our development.

- [Telemetry details](https://quickwit.io/docs/reference/telemetry)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DISABLE_QUICKWIT_TELEMETRY=1
```

### [VSCode](https://code.visualstudio.com/)

> Visual Studio Code collects telemetry data, which is used to help understand how to improve the product.

- [Telemetry details](https://code.visualstudio.com/docs/getstarted/telemetry)
- [Privacy policy](https://go.microsoft.com/fwlink/?LinkID=528096)

List of known telemetry channels:

#### Usage data

Official: ✔

> VS Code collects usage data that helps to debug issues, such as slow start-up times, and to prioritize new features.

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                                        |
|---------|-------------------------------------------------------------|
| Linux   | `$HOME/.config/Code/User/settings.json`                     |
| macOS   | `$HOME/Library/Application Support/Code/User/settings.json` |
| Windows | `%APPDATA%\Code\User\settings.json`                         |

###### Content

```json
{
  "telemetry.enableTelemetry": false
}
```

#### Crash data

Official: ✔

> VS Code collects data about any crashes that occur and sends it to Microsoft to help improve our products and services.

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                                        |
|---------|-------------------------------------------------------------|
| Linux   | `$HOME/.config/Code/User/settings.json`                     |
| macOS   | `$HOME/Library/Application Support/Code/User/settings.json` |
| Windows | `%APPDATA%\Code\User\settings.json`                         |

###### Content

```json
{
  "telemetry.enableCrashReporter": false
}
```

### [Windows Terminal](https://github.com/microsoft/terminal)

> The Windows Terminal client is instrumented to collect usage and diagnostic (error) data and sends it to Microsoft to help improve the product.

- [Telemetry details](https://github.com/microsoft/terminal/issues/5331)
- Privacy policy: ❌

List of known telemetry channels:

#### [Usage and Diagnostic data](https://support.microsoft.com/en-us/help/4468236/diagnostics-feedback-and-privacy-in-windows-10-microsoft-privacy)

Official: ✔

> The Windows Terminal client respects machine wide privacy settings and users can opt-out on their device, as documented in the Microsoft Windows privacy statement.

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [support.microsoft.com | Diagnostics, feedback, and privacy in Windows 10](https://support.microsoft.com/en-us/windows/diagnostics-feedback-and-privacy-in-windows-10-28808a2b-a31b-dd73-dcd3-4559a5199319)

    > To opt-out, go to 'Start', then select 'Settings' > 'Privacy' > 'Diagnostics & feedback', and select 'Basic'.

##### 2. Set registry key

###### Scope: 💻 Machine

- Path: `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DataCollection\AllowTelemetry`
- Type: `REG_DWORD`
- Value: `1`

### [winget](https://github.com/microsoft/winget-cli)

> The winget.exe client is instrumented to collect usage and diagnostic (error) data and sends it to Microsoft to help improve the product.

- [Telemetry details](https://github.com/microsoft/winget-cli#datatelemetry)
- [Privacy policy](https://github.com/microsoft/winget-cli/blob/master/privacy.md)

List of known telemetry channels:

#### [Usage and Diagnostic data](https://support.microsoft.com/en-us/help/4468236/diagnostics-feedback-and-privacy-in-windows-10-microsoft-privacy)

Official: ✔

> The winget.exe client respects machine wide privacy settings and users can opt-out on their device, as documented in the Microsoft Windows privacy statement.

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [support.microsoft.com | Diagnostics, feedback, and privacy in Windows 10](https://support.microsoft.com/en-us/windows/diagnostics-feedback-and-privacy-in-windows-10-28808a2b-a31b-dd73-dcd3-4559a5199319)

    > To opt-out, go to 'Start', then select 'Settings' > 'Privacy' > 'Diagnostics & feedback', and select 'Basic'.

##### 2. Set registry key

###### Scope: 💻 Machine

- Path: `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DataCollection\AllowTelemetry`
- Type: `REG_DWORD`
- Value: `1`

## Cloud

### [Automagica](https://automagica.com/)

> This allows us to collect information on the usage of certain Automagica functionalities in order for us to keep improving the software.

- [Telemetry details](https://telemetry.automagica.com/)
- [Privacy policy](https://automagica.com/privacy-policy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
AUTOMAGICA_NO_TELEMETRY=ANY_VALUE
```

### [AWS SAM CLI](https://aws.amazon.com/serverless/sam/)

> At AWS, we develop and launch services based on what we learn from interactions with customers. We use customer feedback to iterate on our product. Telemetry is additional information that helps us to better understand our customers’ needs, diagnose issues, and deliver features that improve the customer experience. The AWS SAM CLI collects telemetry, such as generic usage metrics, system and environment information, and errors.

- [Telemetry details](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-telemetry.html)
- [Privacy policy](https://aws.amazon.com/compliance/data-privacy-faq/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
SAM_CLI_TELEMETRY=0
```

### [Azure CLI](https://docs.microsoft.com/en-us/cli/azure)

> Allow Microsoft to collect anonymous data on the usage of the CLI.

- [Telemetry details](https://docs.microsoft.com/en-us/cli/azure/azure-cli-configuration)
- [Privacy policy](https://aka.ms/AzureCliLegal)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
AZURE_CORE_COLLECT_TELEMETRY=0
```

##### 2. Run command

###### Scope: 👤 User

```shell
az configure -d collect_telemetry=0
```

### [Google Cloud SDK](https://cloud.google.com/sdk)

> Unless you opt-in during Google Cloud SDK installation, Cloud SDK software does not collect usage statistics. You can help Google to prioritize Google Cloud SDK features and improvements by permitting Cloud SDK to send command-line command usage statistics to Google.

- [Telemetry details](https://cloud.google.com/sdk/usage-statistics)
- [Privacy policy](https://policies.google.com/privacy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CLOUDSDK_CORE_DISABLE_USAGE_REPORTING=true
```

##### 2. Run command

###### Scope: 👤 User

```shell
gcloud config set disable_usage_reporting true
```

### [Hoockdeck CLI](https://hookdeck.com/)

> Telemetry data is sent to Hookdeck.

- [Privacy policy](https://hookdeck.com/terms)

List of known telemetry channels:

#### [Usage data](https://github.com/hookdeck/hookdeck-cli/blob/8c2e18bfd5d413e1d2418c5a73d56791b3bfb513/pkg/hookdeck/client.go#L56-L61)

Official: ❌

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
HOOKDECK_CLI_TELEMETRY_OPTOUT=ANY_VALUE
```

### [Netdata](https://www.netdata.cloud)

> Starting with v1.12, Netdata collects anonymous usage information by default and sends it to Google Analytics.

- [Telemetry details](https://learn.netdata.cloud/docs/agent/anonymous-statistics)
- [Privacy policy](https://learn.netdata.cloud/docs/agent/privacy-policy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DO_NOT_TRACK=1
```

### [Netlify CLI](https://netlify.com)

> By default, Netlify collects data on usage of Netlify CLI commands. We do this to improve the reliability and performance of Netlify CLI, and to help drive new features and improvements.

- [Telemetry details](https://docs.netlify.com/cli/get-started/#usage-data-collection)
- [Privacy policy](https://www.netlify.com/privacy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 👤 User

```shell
netlify --telemetry-disable
```

##### 2. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                 |
|---------|--------------------------------------|
| Linux   | `$HOME/.netlify/config.json`         |
| macOS   | `$HOME/.netlify/config.json`         |
| Windows | `%USERPROFILE%\.netlify\config.json` |

###### Content

```json
{
  "telemetryDisabled": true
}
```

### [Stripe CLI](https://stripe.com/docs/stripe-cli)

> The Stripe CLI includes a telemetry feature that collects some usage data. This feature is enabled by default.

- [Telemetry details](https://github.com/stripe/stripe-cli/wiki/telemetry)
- [Privacy policy](https://stripe.com/privacy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
STRIPE_CLI_TELEMETRY_OPTOUT=1
```

### [Tilt](https://tilt.dev)

> Tilt sends anonymized data about how you use it.

- [Telemetry details](https://docs.tilt.dev/telemetry_faq.html)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DO_NOT_TRACK=1
```

## Communications

### [Mattermost Server](https://mattermost.com/)

> As described in the privacy policy in each Mattermost server, telemetry data optionally shared from your Mattermost servers is used to identify security and reliability issues, to analyze and fix software problems, to help improve the quality of Mattermost software and related services, and to make design decisions for future releases.

- [Telemetry details](https://docs.mattermost.com/administration/telemetry.html)
- [Privacy policy](https://about.mattermost.com/default-privacy-policy/)

List of known telemetry channels:

#### [Diagnostic data](https://docs.mattermost.com/administration/telemetry.html#error-and-diagnostics-reporting-feature)

Official: ❌

- [Telemetry details](https://github.com/mattermost/mattermost-server/issues/9466)

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
MM_LOGSETTINGS_ENABLEDIAGNOSTICS=false
```

#### [Security Update Check](https://docs.mattermost.com/administration/telemetry.html#security-update-check-feature)

Official: ❌

- [Telemetry details](https://github.com/mattermost/mattermost-server/issues/9466)

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
MM_SERVICESETTINGS_ENABLESECURITYFIXALERT=false
```

## Database

### [Aerospike](https://aerospike.com/)

> Aerospike Telemetry is a feature that allows us to collect certain use data - not the database data - on your Aerospike Community Edition server use.

- [Telemetry details](https://aerospike.com/aerospike-telemetry/)
- [Privacy policy](https://aerospike.com/forms/privacy-policy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 💻 Machine

```shell
/opt/aerospike/telemetry/telemetry.py /etc/aerospike/telemetry.conf --disable
```

##### 2. Edit config file (plaintext)

###### Scope: 💻 Machine

Path: `/etc/aerospike/telemetry.conf`

###### Content

```none
[main]
disable = true
```

### [Feast](https://feast.dev/)

> The Feast maintainers use anonymous usage statistics to help shape the Feast roadmap.

- [Telemetry details](https://docs.feast.dev/feast-on-kubernetes/advanced-1/telemetry)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
FEAST_TELEMETRY=False
```

### [InfluxDB](https://www.influxdata.com/)

> InfluxData collects information about the usage of InfluxDB. This “phone home” capability is intended to provide us with information about the broader user community and an understanding of how the platform is being used.

- [Telemetry details](https://www.influxdata.com/telemetry/)
- [Privacy policy](https://www.influxdata.com/legal/privacy-policy/)

List of known telemetry channels:

#### [Usage data](https://docs.influxdata.com/influxdb/v2.0/reference/config-options/)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
INFLUXD_REPORTING_DISABLED=true
```

##### 2. Visit link(s) for more details

1. [Disable usage data reporting](https://docs.influxdata.com/influxdb/v2.0/get-started/#influxdb-phone-home)

    > Telemetry reporting is enabled by default. However, we’ve made it as easy as possible to ‘opt-out’ of the reporting. Simply start the InfluxDB process with the --reporting-disabled flag

##### 3. Edit config file (plaintext)

###### Scope: 👤 User

| OS      | Path                                |
|---------|-------------------------------------|
| Linux   | `$INFLUXD_CONFIG_PATH/config.yaml`  |
| macOS   | `$INFLUXD_CONFIG_PATH/config.yaml`  |
| Windows | `%INFLUXD_CONFIG_PATH%\config.yaml` |

###### Content

```none
telemetry:
  enabled: false
```

### [Materialize](https://materialize.com/)

> Unless disabled, upon startup and once an hour materialized reports some anonymous telemetry data to a central server operated by materialize.com.

- [Telemetry details](https://materialize.io/docs/cli/#telemetry)
- [Privacy policy](https://materialize.com/privacy-policy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Disable telemetry for a single invocation](https://materialize.com/docs/cli/#telemetry)

    > If you would like to disable telemetry collection or uploading for a single invocation, pass the `--disable-telemetry` flag, for example:
    > ```shell
    > materialized --disable-telemetry
    > ```

### [Meltano](https://www.meltano.com/)

> By default, Meltano shares anonymous usage data with the Meltano team using Google Analytics.

- [Telemetry details](https://www.meltano.com/docs/settings.html#send-anonymous-usage-stats)
- [Privacy policy](https://www.meltano.com/privacy.html/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
MELTANO_DISABLE_TRACKING=True
```

##### 2. Visit link(s) for more details

1. [New project](https://www.meltano.com/docs/command-line-interface.html#init)

    > When creating a new project, pass `--no_usage_stats` to meltano init

2. [Existing project](https://www.meltano.com/docs/settings.html#send-anonymous-usage-stats)

    > In an existing project, disable `send_anonymous_usage_stats` setting

### [Quilt](https://quiltdata.com/)

> Quilt collect anonymous usage statistics to find bugs and prioritize features.

- [Telemetry details](https://docs.quiltdata.com/more/faq#does-quilt3-collect-anonymous-usage-statistics)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
QUILT_DISABLE_USAGE_METRICS=True
```

##### 2. Run command

###### Scope: 👤 User

```shell
quilt3 disable-telemetry
```

### [TimescaleDB](https://www.timescale.com/)

> We enable anonymous usage sharing to help us better understand and assist TimescaleDB users, as well as provide automated version checks.

- [Telemetry details](https://docs.timescale.com/latest/using-timescaledb/telemetry)
- [Privacy policy](https://www.timescale.com/legal/privacy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 💻 Machine

```shell
psql -c "ALTER SYSTEM SET timescaledb.telemetry_level=off"
```

##### 2. Edit config file (plaintext)

###### Scope: 👤 User

| OS      | Path                                                                       |
|---------|----------------------------------------------------------------------------|
| Linux   | `/usr/local/var/postgres/postgresql.conf`                                  |
| macOS   | `./Library/PostgreSQL/{postgres_version}/share/postgresql/postgresql.conf` |
| Windows | `%ProgramFiles%\PostgreSQL\{postgres_version}\postgresql.conf`             |

###### Content

```none
timescaledb.telemetry_level=off
```

## Development

### [aliBuild](https://github.com/alisw/alibuild)

> aliBuild has begun gathering anonymous aggregate user behaviour analytics.

- [Telemetry details](https://github.com/alisw/alibuild/blob/master/ANALYTICS.md)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
ALIBUILD_NO_ANALYTICS=1
```

##### 2. Run command

###### Scope: 👤 User

```shell
aliBuild analytics off
```

### [Angular](https://angular.io)

> When installing the Angular CLI or upgrading an existing version, you are prompted to allow global collection of usage statistics. If you say no or skip the prompt, no data is collected.

- [Telemetry details](https://angular.io/cli/analytics)
- Privacy policy: ❌

List of known telemetry channels:

#### [Usage data](https://angular.io/analytics)

Official: ✔

- [Telemetry details](https://github.com/angular/angular-cli/blob/master/docs/design/analytics.md#disabling-usage-analytics)

> Share usage data with Angular team.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
NG_CLI_ANALYTICS=false
```

##### 2. Run command

###### Scope: 👤 User

```shell
ng analytics off
```

#### [Usage data (custom)](https://angular.io/cli/usage-analytics-gathering)

Official: ✔

- [Telemetry details](https://angular.io/cli/usage-analytics-gathering)

> Gather usage data in your own Google Analytics. This configuration option is separate from and in addition to other usage analytics that your users may be sharing with Google.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
NG_CLI_ANALYTICS_SHARE=false
```

##### 2. Run command

###### Scope: 👤 User

```shell
ng config --global --remove cli.analyticsSharing
```

##### 3. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                 |
|---------|--------------------------------------|
| Linux   | `$HOME/.angular-config.json`         |
| macOS   | `$HOME/.angular-config.json`         |
| Windows | `%USERPROFILE%\.angular-config.json` |

###### Content

```json
{
  "cli": {
    "analyticsSharing": "<- REMOVE THIS KEY"
  }
}
```

### [Appc Daemon](https://github.com/appcelerator/appc-daemon)

> The telemetry system is implemented in the appcd-telemetry pacakge and provides a service for collecting time and counter-based information and sending it to the Appc cloud for processing.

- [Telemetry details](https://github.com/appcelerator/appc-daemon/blob/master/docs/Development/appcd/Architecture/Telemetry.md)
- [Privacy policy](https://www.axway.com/en/privacy-statement)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
APPCD_TELEMETRY=0
```

##### 2. Run command

###### Scope: 👤 User

```shell
appcd config set telemetry.enabled false --force
```

### [App Center CLI](https://github.com/microsoft/appcenter-cli/)

> App Center CLI would like to collect data about how users use CLI commands and some problems they encounter.

- Privacy policy: ❌

List of known telemetry channels:

#### Usage data (command)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 👤 User

```shell
appcenter telemetry off
```

#### [Usage data (env. var)](https://github.com/microsoft/appcenter-cli/blob/master/src/util/profile/telemetry.ts)

Official: ❌

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
MOBILE_CENTER_TELEMETRY=off
```

#### [Usage data (JSON file)](https://github.com/microsoft/appcenter-cli/blob/master/src/util/profile/telemetry.ts)

Official: ❌

> Empty JSON file will disable telemetry.

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (plaintext)

###### Scope: 👤 User

| OS      | Path                                                 |
|---------|------------------------------------------------------|
| Linux   | `$HOME/.appcenter-cli/telemetryEnabled.json`         |
| macOS   | `$HOME/.appcenter-cli/telemetryEnabled.json`         |
| Windows | `%USERPROFILE%\.appcenter-cli\telemetryEnabled.json` |

###### Content

```none

```

### [Arduino CLI](https://arduino.github.io/arduino-cli/latest/)

> No data is currently gathered from users of the CLI. Arduino CLI can be launched as a gRPC server via the daemon command. To provide observability for the gRPC server activities besides logs, the daemon mode activates and exposes by default a Prometheus endpoint (http://localhost:9090/metrics) that can be fetched for metrics data

- [Telemetry details](https://arduino.github.io/arduino-cli/latest/getting-started/#using-the-daemon-mode-and-the-grpc-interface)
- Privacy policy: ❌

List of known telemetry channels:

#### Internal metrics

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
ARDUINO_METRICS_ENABLED=false
```

##### 2. Visit link(s) for more details

1. [Internal metrics (config file)](https://arduino.github.io/arduino-cli/latest/getting-started/#using-the-daemon-mode-and-the-grpc-interface)

    > The metrics settings are exposed via the metrics section in the CLI configuration

### [Bot Framework CLI](https://github.com/microsoft/botframework-cli)

> Privacy is very important to us. BF CLI contains optional instrumentation that is designed to help us improve the tool based on anonymous usage patterns. It is disabled, opted-out by default.

- [Telemetry details](https://github.com/microsoft/botframework-cli#privacy)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### [Usage data](https://github.com/microsoft/botframework-cli/tree/main/packages/cli#bf-configsettelemetry)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
BF_CLI_TELEMETRY=false
```

##### 2. Run command

###### Scope: 👤 User

```shell
bf config:set:telemetry --disable
```

### [BuildBuddy](https://www.buildbuddy.io/)

> At BuildBuddy, we collect telemetry for the purpose of helping us build a better BuildBuddy.

- [Telemetry details](https://docs.buildbuddy.io/docs/config-telemetry/)
- [Privacy policy](https://www.buildbuddy.io/privacy)

List of known telemetry channels:

#### Usage data

Official: ✔

> The telemetry data we collect is reported once per day and contains only aggregate stats like invocation counts and feature usage information. Our telemetry infrastructure is also used to report when important security updates are available.

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Telemetry | Using commandline flag](https://docs.buildbuddy.io/docs/config-telemetry/)

    > Provide `---disable_telemetry=true` flag.

#### Google Analytics

Official: ✔

> We also use Google Analytics to collect pseudonymized usage data about how users are using the BuildBuddy product and how well it is performing.

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Google Analytics | Using commandline flag](https://docs.buildbuddy.io/docs/config-telemetry/)

    > Provide `--disable_ga=true` flag.

### [Carbon Design System](https://www.carbondesignsystem.com/)

> Carbon contains a telemetry feature that collects usage information for IBM and Carbon Design System properties.

- [Telemetry details](https://www.carbondesignsystem.com/help/faq/#telemetry)
- [Privacy policy](https://www.ibm.com/privacy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CARBON_TELEMETRY_DISABLED=1
```

### [choosenim](https://github.com/dom96/choosenim)

> Starting with version 0.3.0, choosenim has the ability to gather anonymous aggregate user behaviour analytics and to report them to Google Analytics.

- [Telemetry details](https://github.com/dom96/choosenim/blob/master/analytics.md)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CHOOSENIM_NO_ANALYTICS=1
```

### [CocoaPods](https://cocoapods.org/)

> First up, we don't want to know anything about your app. So in order to know unique targets we use your project's target UUID as an identifier. These are a hash of your MAC address, Xcode's process id and the time of target creation (but we only know the UUID/hash, so your MAC address is unknown to us). These UUIDs never change in a project's lifetime (contrary to, for example, the bundle identifier). We double hash it just to be super safe.

- [Telemetry details](https://blog.cocoapods.org/Stats/)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
COCOAPODS_DISABLE_STATS=true
```

### [code-server](https://github.com/cdr/code-server)

> We use the data collected only to improve code-server.

- [Telemetry details](https://github.com/cdr/code-server/blob/main/docs/FAQ.md#how-can-i-disable-telemetry)
- [Privacy policy](https://coder.com/legal/privacy-policy)

List of known telemetry channels:

#### Usage data

Official: ❌

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Using commandline flag](https://github.com/cdr/code-server/blob/main/docs/FAQ.md#how-can-i-disable-telemetry)

    > Use the `--disable-telemetry` flag to completely disable telemetry.

### [Apache Cordova CLI](https://cordova.apache.org)

> We use the gathered information to help us make our tool more useful and to better understand how it is used. We do not track or collect personally identifiable information or associate gathered data with any personally identifying information from other sources.

- [Telemetry details](https://cordova.apache.org/docs/en/latest/reference/cordova-cli/#global-command-list)
- [Privacy policy](https://cordova.apache.org/privacy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CI=ANY_VALUE
```

##### 2. Run command

###### Scope: 👤 User

```shell
cordova telemetry off
```

### [Cube.js](https://cube.dev/)

> Cube.js collects high-level anonymous usage statistics for servers started in development mode. It doesn't track any credentials, schema contents or queries issued. This statistics is used solely for the purpose of constant cube.js improvement.

- [Telemetry details](https://cube.dev/docs/config#options-reference-telemetry)
- [Privacy policy](https://cube.dev/privacy-policy)

List of known telemetry channels:

#### [Usage data](https://cube.dev/docs/reference/environment-variables#general)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CUBEJS_TELEMETRY=false
```

#### Usage data (per-project)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Disable per-project usage data reporting](https://cube.dev/docs/config#options-reference-telemetry)

    > You can opt out by setting telemetry option to false: `module.exports = { telemetry: false, };`

### [Dagster](https://dagster.io/)

> As an open source project, we collect usage statistics to better understand how users engage with Dagster and to inform development priorities.

- [Telemetry details](https://docs.dagster.io/getting-started/telemetry)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data (config file)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (plaintext)

###### Scope: 👤 User

| OS      | Path                          |
|---------|-------------------------------|
| Linux   | `$DAGSTER_HOME/dagster.yaml`  |
| macOS   | `$DAGSTER_HOME/dagster.yaml`  |
| Windows | `%DAGSTER_HOME%\dagster.yaml` |

###### Content

```none
telemetry:
  enabled: false
```

#### [Usage data (environment variable)](https://github.com/dagster-io/dagster/blob/master/python_modules/dagit/dagit/telemetry.py)

Official: ❌

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DAGSTER_DISABLE_TELEMETRY=ANY_VALUE
```

### [Docker Desktop](https://www.docker.com/products/docker-desktop)

> Docker Desktop tracks all app interactions, checks for updates and sends crash reports.

- [Privacy policy](https://www.docker.com/legal/privacy)

List of known telemetry channels:

#### [Usage data](https://github.com/docker/for-mac/issues/2122)

Official: ❌

> All app interactions are tracked via [segment.com](https://segment.com/)

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Block tracking](https://linuxize.com/post/how-to-edit-your-hosts-file/)

    > Add this record to your hosts file to block access to Segment
    >  ```
    > 0.0.0.0 api.segment.io
    > ```

#### [Customer experience data](https://github.com/docker/for-mac/issues/2122)

Official: ❌

> Customer experience is tracked via [www.wootric.com](https://www.wootric.com/)

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Block tracking](https://linuxize.com/post/how-to-edit-your-hosts-file/)

    > Add this record to your hosts file to block access to Wootric
    >  ```
    > 0.0.0.0 api.wootric.com
    > ```

#### [Crash data](https://github.com/docker/for-mac/issues/2122)

Official: ❌

> Crash reports are uploaded to the [www.bugsnag.com](https://www.bugsnag.com/)

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Block crash reports](https://linuxize.com/post/how-to-edit-your-hosts-file/)

    > Add this record to your hosts file to block access to Bugsnag
    > ```
    > 0.0.0.0 notify.bugsnag.com
    > 0.0.0.0 sessions.bugsnag.com
    > ```

#### [Update check](https://docs.docker.com/docker-for-windows/install/#automatic-updates)

Official: ❌

> Updates are forced, unless you upgrade to a paid plan

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Block update check](https://linuxize.com/post/how-to-edit-your-hosts-file/)

    > Add this record to your hosts file to block update checks
    > ```
    > 0.0.0.0 desktop.docker.com
    > ```

2. [github.com | RektInator/kill-docker-auto-update](https://github.com/RektInator/kill-docker-auto-update)

    > This repository contains patched binaries that disable the auto-updating process of Docker Desktop. If you rather patch the binaries yourself, the instructions can be found under [Patching Docker Manually](https://github.com/RektInator/kill-docker-auto-update#patching-docker-manually).

### [.NET Interactive](https://github.com/dotnet/interactive)

> Telemetry is collected when .NET Interactive is started. Once .NET Interactive is running, we do not collect telemetry from any further user actions.

- [Telemetry details](https://github.com/dotnet/interactive/blob/main/docs/README.md#telemetry)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=1
```

### [dotnet-svcutil](https://docs.microsoft.com/en-us/dotnet/core/additional-tools/dotnet-svcutil-guide)

> Anonymous telemetry information collection.

- [Telemetry details](https://github.com/dotnet/wcf/blob/main/release-notes/dotnet-svcutil-notes.md)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DOTNET_SVCUTIL_TELEMETRY_OPTOUT=1
```

### [DVC](https://dvc.org/)

> To help us better understand how DVC is used and improve it, DVC captures and reports anonymized usage statistics.

- [Telemetry details](https://dvc.org/doc/user-guide/analytics)
- [Privacy policy](https://dvc.org/doc/user-guide/privacy)

List of known telemetry channels:

#### Usage Analytics

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 💻 Machine

```shell
dvc config core.analytics false --system
```

###### Scope: 👤 User

```shell
dvc config core.analytics false --global
```

### [Ember CLI](https://cli.emberjs.com/)

> Ember-cli tracks (only) the following data points: ember-cli version, build/rebuild/live-reload times, how many errors occurred.

- [Telemetry details](https://github.com/ember-cli/ember-cli/blob/master/docs/analytics.md)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                       |
|---------|----------------------------|
| Linux   | `$HOME/.ember-cli`         |
| macOS   | `$HOME/.ember-cli`         |
| Windows | `%USERPROFILE%\.ember-cli` |

###### Content

```json
{
  "disableAnalytics": true
}
```

##### 2. Visit link(s) for more details

1. [Disable usage data reporting](https://github.com/ember-cli/ember-cli/pull/2923)

    > You can also disable analytics on per-command basis by adding '--disable-analytics' option

### [Fastlane](https://fastlane.tools/)

> fastlane tracks a few key metrics to understand how developers are using the tool and to help us know what areas need improvement. No personal/sensitive information is ever collected.

- [Telemetry details](https://docs.fastlane.tools/#metrics)
- [Privacy policy](https://www.google.com/policies/privacy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
FASTLANE_OPT_OUT_USAGE=YES
```

##### 2. Visit link(s) for more details

1. [Per-project (Fastfile)](http://docs.fastlane.tools/actions/opt_out_usage/#opt_out_usage)

    > Add `opt_out_usage` at the top of your Fastfile to disable metrics collection.

### [Flagsmith API](https://flagsmith.com/)

> Flagsmith collects information about self hosted installations. This helps us understand how the platform is being used. This data is never shared outside of the organisation, and is anonymous by design.

- [Telemetry details](https://flagsmith.com/privacy-policy/)
- [Privacy policy](https://docs.flagsmith.com/deployment-overview/#api-telemetry)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
TELEMETRY_DISABLED=ANY_VALUE
```

### [Flutter](https://flutter.dev/)

> If you have not opted-out of Flutter’s analytics and crash reporting, when a flutter command crashes it attempts to send a crash report to Google in order to help Google contribute improvements to Flutter over time.

- [Telemetry details](https://flutter.dev/docs/reference/crash-reporting)
- [Privacy policy](https://policies.google.com/privacy)

List of known telemetry channels:

#### Crash reporting

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 👤 User

```shell
flutter config --no-analytics
```

### [Gatsby](https://www.gatsbyjs.org)

> Gatsby contains a telemetry feature that collects anonymous usage information that is used to help improve Gatsby for all users. The Gatsby user base is growing very rapidly. It’s important that our small team and the greater community will better understand the usage patterns, so we can best decide how to design future features and prioritize current work.

- [Telemetry details](https://www.gatsbyjs.org/docs/telemetry/)
- [Privacy policy](https://www.gatsbyjs.com/privacy-policy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
GATSBY_TELEMETRY_DISABLED=1
```

##### 2. Run command

###### Scope: 👤 User

```shell
gatsby telemetry --disable
```

### [Hasura GraphQL engine](https://hasura.io)

> The Hasura GraphQL engine collects anonymous telemetry data that helps the Hasura team in understanding how the product is being used and in deciding what to focus on next.

- [Telemetry details](https://docs.hasura.io/1.0/graphql/manual/guides/telemetry.html)
- [Privacy policy](https://hasura.io/legal/hasura-privacy-policy)

List of known telemetry channels:

#### Usage data (CLI and Console)

Official: ✔

> The CLI collects each execution event, along with a randomly generated UUID. The execution event contains the command name, timestamp and whether the execution resulted in an error or not. Error messages, arguments and flags are not recorded. The CLI also collects the server version and UUID that it is talking to. The operating system platform and architecture is also noted along with the CLI version.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
HASURA_GRAPHQL_ENABLE_TELEMETRY=false
```

##### 2. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                |
|---------|-------------------------------------|
| Linux   | `$HOME/.hasura/config.json`         |
| macOS   | `$HOME/.hasura/config.json`         |
| Windows | `%USERPROFILE%\.hasura\config.json` |

###### Content

```json
{
  "enable_telemetry": false
}
```

### [Humbug](https://github.com/bugout-dev/humbug)

> Humbug lets you collect basic system information and crash reports while respecting your users' privacy.

- Privacy policy: ❌

List of known telemetry channels:

#### [Usage data](https://github.com/bugout-dev/humbug/issues/13)

Official: ✔

> For people who want to opt out of any Humbug reporting across any tool with a single setting.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
BUGGER_OFF=1
```

### [ImageGear](https://www.accusoft.com/products/imagegear-collection/imagegear/)

> By using the TOOLKIT with an Evaluation License, you hereby agree to allow ACCUSOFT to collect and monitor data about which of the TOOLKIT API calls you use and which of our sample programs you use. We use this tracking information to determine which areas of the TOOLKIT are most (and least) popular to improve our SDK capabilities and our samples in the future. The tracking information is anonymized in such a way that neither ACCUSOFT nor anybody else can associate this information with you. Please note that no usage data is collected for a licensed TOOLKIT.

- [Telemetry details](https://www.accusoft.com/company/legal/toolkit-software-license-agreement/)
- [Privacy policy](https://www.accusoft.com/company/privacy-statement/)

List of known telemetry channels:

#### [Usage data](https://help.accusoft.com/ImageGear/v18.8/Linux/Installation.html)

Official: ❌

> ImageGear for C and C++

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

| OS    | Variable Name    |
|-------|------------------|
| Linux | `IG_PRO_OPT_OUT` |
Value: `YES`

### [Ionic CLI](https://ionicframework.com/)

> The CLI sends usage data to Ionic to create a better experience.

- [Telemetry details](https://ionicframework.com/docs/cli/configuration#telemetry)
- [Privacy policy](https://ionicframework.com/privacy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 👤 User

```shell
ionic config set --global telemetry false
```

### [MeiliSearch](https://github.com/meilisearch/MeiliSearch)

> MeiliSearch collects anonymous data regarding general usage. This helps us better understand developers' usage of MeiliSearch features. We also use Sentry to make us crash and error reports.

- [Telemetry details](https://github.com/meilisearch/MeiliSearch/blob/main/README.md#telemetry)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data and crash reports

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
MEILI_NO_ANALYTICS=true
```

### [ML.NET CLI](https://docs.microsoft.com/en-us/dotnet/machine-learning/automate-training-with-cli)

> The ML.NET CLI includes a telemetry feature that collects anonymous usage data that is aggregated for use by Microsoft.

- [Telemetry details](https://docs.microsoft.com/en-us/dotnet/machine-learning/resources/ml-net-cli-telemetry)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
MLDOTNET_CLI_TELEMETRY_OPTOUT=True
```

### [mssql-cli](https://github.com/dbcli/mssql-cli)

> By default, Microsoft collects anonymous usage data in order to improve the user experience. The usage data collected allows the team to prioritize features and bug fixes.

- [Telemetry details](https://github.com/dbcli/mssql-cli/blob/master/doc/telemetry_guide.md)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
MSSQL_CLI_TELEMETRY_OPTOUT=True
```

### [.NET Core SDK](https://docs.microsoft.com/en-us/dotnet/core/tools/index)

> The NET Core SDK includes a telemetry feature that collects usage data and exception information when the .NET Core CLI crashes. The .NET Core CLI comes with the .NET Core SDK and is the set of verbs that enable you to build, test, and publish your .NET Core apps. It's important that the .NET team understands how the tools are used so they can be improved. Information on failures helps the team resolve problems and fix bugs.

- [Telemetry details](https://docs.microsoft.com/en-us/dotnet/core/tools/telemetry)
- [Privacy policy](https://go.microsoft.com/fwlink/?LinkID=528096)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DOTNET_CLI_TELEMETRY_OPTOUT=true
```

### [Next.js](https://nextjs.org)

> Next.js collects completely anonymous telemetry data about general usage. Participation in this anonymous program is optional, and you may opt-out if you'd not like to share any information.

- [Telemetry details](https://nextjs.org/telemetry)
- [Privacy policy](https://zeit.co/security#policy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
NEXT_TELEMETRY_DISABLED=1
```

##### 2. Run command

###### Scope: 👤 User

```shell
npx next telemetry disable
```

### [NocoDB](https://www.nocodb.com/)

> NocoDB collects telemetry.

- [Telemetry details](https://github.com/nocodb/nocodb/blob/master/README.md#environment-variables)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
NC_DISABLE_TELE=1
```

### [Nuxt.js](https://nuxtjs.org/)

> Nuxt Telemetry collects anonymous telemetry data about general usage. This helps us to accurately gauge feature usage and customization across all our users.

- [Telemetry details](https://nuxtjs.org/docs/2.x/configuration-glossary/configuration-telemetry)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
NUXT_TELEMETRY_DISABLED=1
```

##### 2. Run command

###### Scope: 👤 User

```shell
npx nuxt telemetry disable --global
```

### [One Codex API - Python Client Library and CLI](https://www.onecodex.com/)

> One Codex CLI logs errors to One Codex's Sentry server.

- [Telemetry details](https://github.com/onecodex/onecodex/pull/62)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ❌

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
ONE_CODEX_NO_TELEMETRY=True
```

### [Ory](https://www.ory.sh/)

> Ory's services collect summarized, anonymized data that can optionally be turned off.

- [Telemetry details](https://www.ory.sh/docs/ecosystem/sqa/)
- [Privacy policy](https://www.ory.sh/docs/ecosystem/sqa/#data-privacy)

List of known telemetry channels:

#### Usage data

Official: ❌

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
SQA_OPT_OUT=true
```

##### 2. Visit link(s) for more details

1. [Using commandline flag](https://www.ory.sh/docs/ecosystem/sqa/#opt-out)

    > Provide `--sqa-opt-out` flag to Ory product.

2. [Using config file](https://www.ory.sh/docs/ecosystem/sqa/#opt-out)

    > Set the yaml configuration key (if supported by Ory product):
    > ```yaml
    > sqa.opt_out=true
    > ```

### [Oryx](https://github.com/microsoft/Oryx)

> When utilized within Azure services, this project collects usage data and sends it to Microsoft to help improve our products and services.

- [Telemetry details](https://github.com/microsoft/Oryx#datatelemetry)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
ORYX_DISABLE_TELEMETRY=true
```

### [otel-launcher-node](https://github.com/lightstep/otel-launcher-node/)

> Launcher automatically collects and sends host metrics to Lightstep.

- [Telemetry details](https://github.com/lightstep/otel-launcher-node/blob/master/CHANGELOG.md#0130)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
LS_METRICS_HOST_ENABLED=0
```

### [Pants](https://www.pantsbuild.org/)

> Pants can optionally send anonymized telemetry to the Pants project. This data helps us develop and improve Pants by detecting bugs, analyzing usage patterns, and so on. Telemetry is sent in the background, so it doesn't slow down your Pants runs. No telemetry is sent until you opt in to this feature.

- [Telemetry details](https://www.pantsbuild.org/docs/anonymous-telemetry)
- [Privacy policy](https://www.pantsbuild.org/docs/anonymous-telemetry#data-policies)

List of known telemetry channels:

#### [Usage data](https://www.pantsbuild.org/docs/reference-anonymous-telemetry)

Official: ❌

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
PANTS_ANONYMOUS_TELEMETRY_ENABLED=false
```

##### 2. Visit link(s) for more details

1. [Using commandline flag](https://www.pantsbuild.org/docs/reference-anonymous-telemetry#section-enabled)

    > Provide `--no-anonymous-telemetry-enabled` flag.

2. [Using config file](https://www.pantsbuild.org/docs/anonymous-telemetry#opting-in-to-telemetry)

    > To explicitly opt out of telemetry and silence any logging about it add this to your `pants.toml`:
    > ```toml
    > [anonymous-telemetry]
    > enabled = false
    > ```

### [Prisma](https://www.prisma.io/)

> Telemetry helps us better understand how many users are using our products and how often they are using our products.

- [Telemetry details](https://www.prisma.io/docs/concepts/more/telemetry)
- [Privacy policy](https://pris.ly/privacy)

List of known telemetry channels:

#### [Usage data](https://www.prisma.io/docs/concepts/more/telemetry#usage-data)

Official: ✔

> Invocations of the prisma CLI and general usage of Studio results in data being sent to the telemetry server at https://checkpoint.prisma.io.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CHECKPOINT_DISABLE=1
```

#### [Error reporting](https://www.prisma.io/docs/concepts/more/telemetry#error-reporting)

Official: ✔

> Before an error report is submitted, there will always be a prompt asking you to confirm or deny the submission of the error report!

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Disable error reporting](https://www.prisma.io/docs/concepts/more/telemetry#error-reporting-1)

    > You can opt-out of data collection by responding to the interactive prompt with no.

### [projector-cli](https://github.com/projector-cli/projector-cli)

> Projector uses Application Insights to better understand and fix errors that come up in the CLI.

- [Telemetry details](https://github.com/projector-cli/projector-cli/blob/main/README.md#application-telemetry)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
TELEMETRY_ENABLED=0
```

### [PROSE Code Accelerator SDK](https://www.microsoft.com/en-us/research/group/prose/)

> PROSE sends telemetry information for the purpose of improving the product. The data collected is not used to identify any person.

- [Telemetry details](https://docs.microsoft.com/en-us/python/api/overview/azure/prose/config#configuration-settings)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
PROSE_TELEMETRY_OPTOUT=ANY_VALUE
```

##### 2. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                      |
|---------|-------------------------------------------|
| Linux   | `$HOME/.config/prose/config.json`         |
| macOS   | `$HOME/.config/prose/config.json`         |
| Windows | `%USERPROFILE%\.config\prose\config.json` |

###### Content

```json
{
  "telemetry_opt_out": true
}
```

### [REST API Fuzz Testing (RAFT)](https://github.com/microsoft/rest-api-fuzz-testing)

> By default, we collect anonymous usage data from your RAFT instance, which helps us understand how users use RAFT and the problems they experience, which in turn, helps us improve the quality of the offering over time.

- [Telemetry details](https://github.com/microsoft/rest-api-fuzz-testing/blob/main/docs/how-to-deploy.md#telemetry)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### [Usage data](https://github.com/microsoft/rest-api-fuzz-testing/blob/main/docs/how-to-deploy.md#telemetry)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Disable metrics in config file](https://github.com/microsoft/rest-api-fuzz-testing/blob/main/docs/how-to-deploy.md#telemetry)

    > The first time you use this command, RAFT will create an empty 'defaults.json' file in the CLI directory on your local machine. Set the 'metricsOptIn' field in this file set to 'false'

### [Rasa](https://rasa.com/)

> Rasa uses telemetry to report anonymous usage information. This information is essential to help improve Rasa Open Source for all users.

- [Telemetry details](https://rasa.com/docs/rasa/telemetry/telemetry)
- [Privacy policy](https://rasa.com/privacy-policy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
RASA_TELEMETRY_ENABLED=false
```

##### 2. Run command

###### Scope: 👤 User

```shell
rasa telemetry disable
```

### [React Native for Windows + macOS](https://microsoft.github.io/react-native-windows/)

> Some build-time tools will send telemetry to Microsoft by default. No telemetry is collected or transmitted in the final app.

- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [react-native-windows/cli | Using commandline flag](https://github.com/microsoft/react-native-windows/blob/master/packages/@react-native-windows/cli/README.md)

    > Provide `--no-telemetry` flag.

2. [react-native-windows-init | Using commandline flag](https://github.com/microsoft/react-native-windows/blob/master/packages/react-native-windows-init/README.md)

    > Provide `--no-telemetry` flag.

### [ReportPortal (JS client)](https://github.com/reportportal/client-javascript)

> ReportPortal collects only information about agent name and version. This information is sent to Google analytics on the launch start.

- [Telemetry details](https://github.com/reportportal/client-javascript/blob/master/README.md)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
REPORTPORTAL_CLIENT_JS_NO_ANALYTICS=true
```

### [ReportPortal (Pytest plugin)](https://github.com/reportportal/agent-python-pytest)

> ReportPortal collects information about agent name and its version only. This information is sent to Google analytics on the launch start.

- [Telemetry details](https://github.com/reportportal/agent-python-pytest/blob/master/README.rst#integration-with-ga)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
AGENT_NO_ANALYTICS=1
```

### [RESTler](https://github.com/microsoft/restler-fuzzer)

> RESTler collects telemetry in order to understand usage and prioritize improvements.

- [Telemetry details](https://github.com/microsoft/restler-fuzzer/tree/main#data-collection)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### [Usage data](https://github.com/microsoft/restler-fuzzer/blob/main/docs/user-guide/Telemetry.md)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
RESTLER_TELEMETRY_OPTOUT=1
```

### [Rockset CLI](https://rockset.com/)

> The Rockset CLI includes a telemetry feature that collects some usage data. This feature is enabled by default. We never log any sensitive data, query text, or query result data.

- [Telemetry details](https://github.com/rockset/rockset-js/blob/master/packages/cli/README.md#telemetry)
- [Privacy policy](https://rockset.com/legal/privacy-policy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
ROCKSET_CLI_TELEMETRY_OPTOUT=1
```

### [Testim Root Cause](https://github.com/testimio/root-cause)

> As part of an incubating feature, we are collection some basic telemetry & usage statistics.

- [Telemetry details](https://github.com/testimio/root-cause/blob/main/docs/failure-suggestions-telemetry.md)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
SUGGESTIONS_OPT_OUT=ANY_VALUE
```

### [Rover CLI](https://www.apollographql.com/docs/rover/)

> By default, Rover collects some anonymous usage data to help us improve the tool.

- [Telemetry details](https://www.apollographql.com/docs/rover/privacy/)
- [Privacy policy](https://www.apollographql.com/Apollo-Privacy-Policy.pdf)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
APOLLO_TELEMETRY_DISABLED=1
```

### [Salto CLI](https://www.salto.io/)

> Telemetry refers to the collection of non personally identifiable data. The data is being used to improve the product's performance, as well as detect bugs and issues.

- [Telemetry details](https://github.com/salto-io/salto/blob/master/docs/telemetry.md)
- [Privacy policy](https://www.salto.io/privacy-policy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
SALTO_TELEMETRY_DISABLE =1
```

##### 2. Edit config file (plaintext)

###### Scope: 👤 User

| OS      | Path                                            |
|---------|-------------------------------------------------|
| Linux   | `$HOME/.salto/salto.config/config.nacl`         |
| macOS   | `$HOME/.salto/salto.config/config.nacl`         |
| Windows | `%USERPROFILE%\.salto\salto.config\config.nacl` |

###### Content

```none
AppConfig:
    telemetry: false
```

### [Serverless Framework](https://www.serverless.com/)

> Serverless Framework collects anonymous telemetry data in order to better understand the needs of our users and to help drive better prioritization of improvements and more informed decisions.

- [Telemetry details](https://www.serverless.com/framework/docs/telemetry/)
- [Privacy policy](https://app.serverless.com/legal/privacy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
SLS_TELEMETRY_DISABLED=1
```

##### 2. Run command

###### Scope: 👤 User

```shell
serverless slstats --disable
```

### [Salesforce CLI](https://developer.salesforce.com/tools/sfdxcli)

> Salesforce collects usage data and metrics (telemetry) to help improve Salesforce CLI. We collect anonymous information related to the use of the CLI and plug-ins, such as which commands and parameters were run, and performance and error data.

- [Telemetry details](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_dev_cli_telemetry.htm)
- [Privacy policy](https://www.salesforce.com/company/privacy.jsp)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
SFDX_DISABLE_TELEMETRY=true
```

##### 2. Run command

###### Scope: 👤 User

```shell
sfdx config:set disableTelemetry=true --global
```

### [SKU](https://github.com/seek-oss/sku)

> To help us improve sku, please install our private telemetry package that gives us insights on usage, errors and performance.

- [Telemetry details](https://github.com/seek-oss/sku/pull/495)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
SKU_TELEMETRY=false
```

### [Strapi](https://strapi.io/)

> Strapi contains a feature in which anonymous and otherwise non-sensitive data is collected. This data is collectively aggregated for all our users, which when taken together give us a better global understanding of how users are interacting and using Strapi.

- [Telemetry details](https://strapi.io/documentation/developer-docs/latest/getting-started/usage-information.html)
- [Privacy policy](https://strapi.io/privacy)

List of known telemetry channels:

#### [Usage data](https://strapi.io/documentation/developer-docs/latest/setup-deployment-guides/configurations.html#environment)

Official: ✔

> Don't send telemetry usage data to Strapi.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
STRAPI_TELEMETRY_DISABLED=true
```

#### Usage data (per-project)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Disable per-project usage data reporting](https://strapi.io/documentation/developer-docs/latest/getting-started/usage-information.html#opt-out)

    > Should you decide to opt-out, you may do so by removing the 'uuid' property in the 'package.json' file located within the root of your project. This will automatically disable this feature.

#### [Update check](https://strapi.io/documentation/developer-docs/latest/setup-deployment-guides/configurations.html#environment)

Official: ✔

> Don't show the notification message about updating strapi in the terminal.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
STRAPI_DISABLE_UPDATE_NOTIFICATION=true
```

### [Tuist](https://tuist.io/)

> Tuist sends some anonymous analytics events to track the usage of the tool.

- [Telemetry details](https://docs.tuist.io/guides/stats/)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
TUIST_STATS_OPT_OUT=1
```

### [vstest](https://github.com/microsoft/vstest/)

> Going forward vstest platform will enable collection of rich telemetry data points to helps us and any vstest consuming platform in making the right choices to improve end user experience.

- [Telemetry details](https://github.com/Microsoft/vstest-docs/blob/main/RFCs/0015-Telemetry.md)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### [Usage data](https://github.com/microsoft/vstest/blob/main/src/vstest.console/TestPlatformHelpers/TestRequestManager.cs#L1047)

Official: ❌

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
VSTEST_TELEMETRY_OPTEDIN=0
```

### [VueDX](https://github.com/znck/vue-developer-experience)

> This package contains telemetry and submits various actions to Sentry.io.

- [Telemetry details](https://github.com/znck/vue-developer-experience)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
VUEDX_TELEMETRY=off
```

### [WAPM CLI](https://wasmer.io/)

> During the alpha, telemetry (specifically error logging to Sentry) is enabled by default in the WAPM CLI. We send and record information such as IP address, operating system name and version, and the error/panic message.

- [Telemetry details](https://docs.wasmer.io/ecosystem/wapm/cli#telemetry)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 👤 User

```shell
wapm config set telemetry.enabled false
```

### [webhint](https://webhint.io/)

> At the end of the second run webhint we will ask if you want to send limited usage information to help us to build a better product.

- [Telemetry details](https://webhint.io/docs/user-guide/telemetry/summary/)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
HINT_TELEMETRY=off
```

##### 2. Run command

###### Scope: 👤 User

```shell
hint --telemetry=off
```

### [Webiny](https://www.webiny.com/)

> By default, Webiny collects anonymous usage information, which is exclusively used for improving the product and understanding usage patterns.

- [Telemetry details](https://www.webiny.com/telemetry/)
- [Privacy policy](https://www.webiny.com/privacy-policy)

List of known telemetry channels:

#### [Usage data (env. var)](https://github.com/webiny/webiny-js/blob/0240c2000d1743160c601ae4ce40dd2f949d4d07/packages/telemetry/react.js#L9)

Official: ❌

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
REACT_APP_WEBINY_TELEMETRY=false
```

#### [Usage data (command)](https://www.webiny.com/docs/key-topics/webiny-cli/#yarn-webiny-disable-tracking)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 👤 User

```shell
yarn webiny disable-tracking
```

### [Yarn 2](https://yarnpkg.com/)

> Data are sent via batches, roughly every seven days. This prevents us from tracking your usage with a too high granularity, leaving us only the most useful information to do our job efficiently.

- [Telemetry details](https://yarnpkg.com/advanced/telemetry)
- Privacy policy: ❌

List of known telemetry channels:

#### [Usage data](https://yarnpkg.com/advanced/telemetry)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 👤 User

```shell
yarn config set --home enableTelemetry 0
```

#### [Usage data (per-project)](https://yarnpkg.com/advanced/telemetry)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Disable per-project usage data reporting](https://yarnpkg.com/advanced/telemetry#how-can-i-disable-it)

    > To disable it on a project (including for anyone who would clone it), run: yarn config set enableTelemetry 0

## DevOps

### [AutomatedLab](https://github.com/AutomatedLab/AutomatedLab)

> AutomatedLab will start to collect telemetry starting with version 5.0. This is an opt-out collection and you will be asked once to specify whether or not you want to send us telemetry data.

- [Telemetry details](https://github.com/AutomatedLab/AutomatedLab/wiki/Lab-Telemetry)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
AUTOMATEDLAB_TELEMETRY_OPTIN=0
```

##### 2. Run command

###### Scope: 👤 User

| OS      | Command                                                                                                                                                                  |
|---------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Other   | `pwsh -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "Import-Module AutomatedLab -ErrorAction Stop ; Disable-LabTelemetry -ErrorAction Stop"`       |
| Windows | `powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "Import-Module AutomatedLab -ErrorAction Stop ; Disable-LabTelemetry -ErrorAction Stop"` |

#### Usage data (legacy env. var.)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
AUTOMATEDLAB_TELEMETRY_OPTOUT=1
```

### [Batect](https://batect.dev/)

> No personally identifiable information or telemetry information is sent to the API as part of this process.

- [Telemetry details](https://batect.dev/privacy/#what-data-is-collected-and-how-it-is-used)
- [Privacy policy](https://batect.dev/privacy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
BATECT_ENABLE_TELEMETRY=false
```

##### 2. Run command

###### Scope: 👤 User

```shell
batect --permanently-enable-telemetry
```

#### Usage data (per-invocation)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Disable telemetry collection or uploading for a single invocation.](https://batect.dev/docs/reference/cli/#--no-telemetry)

    > If you would like to disable telemetry collection or uploading for a single invocation, pass the --no-telemetry flag, for example: ./batect --no-telemetry the-task

#### [Update check](https://strapi.io/documentation/developer-docs/latest/setup-deployment-guides/configurations.html#environment)

Official: ✔

> Don't show the notification message about updating strapi in the terminal.

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Disable update check](https://batect.dev/docs/reference/cli/#--no-update-notification)

    > Batect automatically checks for updates at most once every 24 hours and displays a notification if a newer version is available. Passing this flag will disable both the update check and notification: --no-update-notification.

### [Chef Automate](https://docs.chef.io/workstation/)

> Users of this Chef Automate server may elect to share user-anonymized usage data with Chef Software, Inc. Chef uses this shared data to improve Chef Automate.

- [Telemetry details](https://docs.chef.io/automate/telemetry/)
- [Privacy policy](https://www.chef.io/privacy-policy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Server-side configuration](https://docs.chef.io/automate/telemetry/)

    > Admins can opt out of telemetry for the Automate server and all of its users, by editing an existing `configuration.toml` or create a new TOML file.

2. [Individual user configuration](https://docs.chef.io/automate/telemetry/)

    > Individual users can opt out of telemetry by unchecking the telemetry box on the welcome pop-up the first time they log into Automate. To opt out of telemetry at any later point in time, navigate to the profile icon, select “About Chef Automate” from the drop-down, and uncheck the telemetry checkbox.

### [Chef Workstation](https://docs.chef.io/workstation/)

> In order to continually improve Chef Workstation, we collect information to help us identify bugs and understand how people interact with Chef Workstation.

- [Telemetry details](https://docs.chef.io/workstation/privacy/)
- [Privacy policy](https://www.chef.io/privacy-policy/)

List of known telemetry channels:

#### [Usage data](https://docs.chef.io/workstation/privacy/#opting-out)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CHEF_TELEMETRY_OPT_OUT=1
```

##### 2. Edit config file (plaintext)

###### Scope: 👤 User

| OS      | Path                                          |
|---------|-----------------------------------------------|
| Linux   | `$HOME/.chef-workstation/config.toml`         |
| macOS   | `$HOME/.chef-workstation/config.toml`         |
| Windows | `%USERPROFILE%\.chef-workstation\config.toml` |

###### Content

```none
[telemetry]
enabled=false
```

### [Consul](https://www.consul.io/)

> Consul makes use of a HashiCorp service called Checkpoint which is used to check for updates and critical security bulletins.

- [Telemetry details](https://www.consul.io/docs/troubleshoot/faq#q-what-is-checkpoint-does-consul-call-home)
- [Privacy policy](https://hashicorp.com/privacy)

List of known telemetry channels:

#### [Update check](https://www.consul.io/docs/agent/options#disable_update_check)

Official: ✔

> Disables automatic checking for security bulletins and new version releases. This is disabled in Consul Enterprise.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CHECKPOINT_DISABLE=ANY_VALUE
```

##### 2. Edit config file (JSON)

###### Scope: 👤 User

Path: `some-dir/example.json`

###### Content

```json
{
  "disable_update_check": true
}
```

#### [Update check signature](https://www.consul.io/docs/agent/options#disable_anonymous_signature)

Official: ✔

> Disables providing an anonymous signature for de-duplication with the update check

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (JSON)

###### Scope: 👤 User

Path: `some-dir/example.json`

###### Content

```json
{
  "disable_anonymous_signature": true
}
```

### [decK](https://github.com/Kong/deck)

> decK collects anonymized data to track feature adoption.

- [Telemetry details](https://docs.konghq.com/deck/commands/#analytics)
- [Privacy policy](http://konghq.com/privacy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DECK_ANALYTICS=off
```

### [F5 BIG-IP Terraform provider](https://registry.terraform.io/providers/F5Networks/bigip/latest/docs)

> The F5 BIG-IP provider gathers non-identifiable usage data for the purposes of improving the product as outlined in the end user license agreement for BIG-IP.

- [Telemetry details](https://registry.terraform.io/providers/F5Networks/bigip/latest/docs#note)
- [Privacy policy](https://www.f5.com/company/policies/privacy-policy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
TEEM_DISABLE=true
```

### [F5 CLI](https://clouddocs.f5.com/sdk/f5-cli/)

> F5 collects non-personal telemetry data to help improve the CLI.

- [Telemetry details](https://clouddocs.f5.com/sdk/f5-cli/examples/faq.html)
- [Privacy policy](https://www.f5.com/company/policies/privacy-policy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
F5_ALLOW_TELEMETRY=false
```

### [Infracost](https://www.infracost.io/)

> When using a self-hosted Cloud Pricing API, Infracost CLI will send telemetry data.

- [Privacy policy](https://www.infracost.io/docs/privacy-policy)

List of known telemetry channels:

#### [Usage data](https://www.infracost.io/docs/integrations/environment_variables/#infracost_self_hosted_telemetry)

Official: ✔

> Opt-out of telemetry when using a self-hosted Cloud Pricing API.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
INFRACOST_SELF_HOSTED_TELEMETRY=false
```

#### [Update check](https://www.infracost.io/docs/integrations/environment_variables/#infracost_skip_update_check)

Official: ✔

> Skip the Infracost update check.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
INFRACOST_SKIP_UPDATE_CHECK=true
```

### [k0s](https://k8slens.dev/)

> To build better end user experience we collect and send telemetry data from clusters.

- [Telemetry details](https://docs.k0sproject.io/v0.10.0/configuration/#telemetry)
- [Privacy policy](https://www.mirantis.com/company/privacy-policy/)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Disable usage data reporting](https://docs.k8slens.dev/v4.1.2/getting-started/preferences/#disable-telemetry-reporting)

    > It is enabled by default and can be disabled by settings corresponding option as 'false'.

### [Kics](https://kics.io/)

> Kics is using Sentry's application monitoring platform for crash reports collection: https://sentry.io/

- [Telemetry details](https://github.com/Checkmarx/kics/blob/master/docs/commands.md#disable-telemetry)
- Privacy policy: ❌

List of known telemetry channels:

#### [Usage data (current)](https://github.com/Checkmarx/kics/issues/3876)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DISABLE_CRASH_REPORT=1
```

#### [Usage data (legacy)](https://github.com/Checkmarx/kics/issues/3876)

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
KICS_COLLECT_TELEMETRY=0
```

### [kPow](https://kpow.io/)

> The kPow UI records product usage with Google Analytics. We receive the standard Google Analytics data set (page views, location, etc). We also receive a small number of custom events when you take user action (topic-create, topic-delete, sample-topic, etc).

- [Telemetry details](https://docs.kpow.io/about/data-collection)
- [Privacy policy](https://operatr.io/privacy/)

List of known telemetry channels:

#### [Usage data](https://docs.kpow.io/about/data-collection#how-do-i-opt-out)

Official: ✔

> Trial users cannot opt out of product telemetry. Licensed users can configure the following environment variable to opt out of product telemetry.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
ALLOW_UI_ANALYTICS=false
```

### [kubeapt](https://github.com/twosson/kubeapt)

> The software may collect information about you and your use of the software.

- [Telemetry details](https://github.com/twosson/kubeapt#environment-variables)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DASH_DISABLE_TELEMETRY=ANY_VALUE
```

### [MSLab](https://github.com/microsoft/MSLab)

> The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services.

- [Telemetry details](https://github.com/microsoft/MSLab/blob/master/Docs/mslab-telemetry.md)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
MSLAB_TELEMETRY_LEVEL=None
```

### [Nuke](https://nuke.build/)

> As an effort to improve NUKE and to provide you with a better and more tailored experience, we include a telemetry feature that collects anonymous usage data and enables us to make more informed decisions for the future development.

- [Telemetry details](https://nuke.build/docs/getting-started/telemetry.html)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
NUKE_TELEMETRY_OPTOUT=1
```

### [OpenVZ](https://openvz.org/)

> vzstats is a tool to gather OpenVZ usage statistics.

- [Telemetry details](https://wiki.openvz.org/Vzstats)
- [Privacy policy](https://wiki.openvz.org/Vzstats#What_about_my_privacy.3F)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [Disable usage data reporting](https://wiki.openvz.org/Vzstats#How_to_opt-out)

    > You can completely disable vzstats client on a machine by executing the following command:
    > ```shell
    > mkdir -p /etc/vz
    > touch /etc/vz/vzstats-disable```

### [Packer](https://www.packer.io/)

> When Packer is invoked it sometimes calls out to checkpoint.hashicorp.com to look for new versions of Packer.

- [Telemetry details](https://www.packer.io/docs/other/environment-variables.html#checkpoint_disable)
- [Privacy policy](https://hashicorp.com/privacy)

List of known telemetry channels:

#### Update check

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CHECKPOINT_DISABLE=1
```

### [PnP PowerShell](https://pnp.github.io/powershell/)

> By default PnP PowerShell will report its usage to the PnP Team.

- [Telemetry details](https://pnp.github.io/powershell/articles/configuration.html)
- Privacy policy: ❌

List of known telemetry channels:

#### [Usage data (env. var)](https://pnp.github.io/powershell/articles/configuration.html#disable-or-enable-telemetry)

Official: ✔

> By default PnP PowerShell will report its usage to the PnP Team. We collection information about the version of PnP PowerShell and the cmdlet executed. Notice that we will not include parameters used and we will not include any values of parameters.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
PNPPOWERSHELL_DISABLETELEMETRY=true
```

#### [Usage data (cmdlet)](https://pnp.github.io/powershell/cmdlets/Enable-PnPPowerShellTelemetry.html?q=telemetry)

Official: ✔

> In order to help to make PnP PowerShell better, we can track anonymous telemetry. We track the version of the cmdlets you are using, which cmdlet you are executing and which version of SharePoint you are connecting to.

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 👤 User

| OS      | Command                                                                                                                                                                                     |
|---------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Other   | `pwsh -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "Import-Module PnP.PowerShell -ErrorAction Stop ; Disable-PnPPowerShellTelemetry -Force -ErrorAction Stop"`       |
| Windows | `powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "Import-Module PnP.PowerShell -ErrorAction Stop ; Disable-PnPPowerShellTelemetry -Force -ErrorAction Stop"` |

#### [Update check](https://pnp.github.io/powershell/articles/updatenotifications.html)

Official: ✔

> One time per PowerShell session PnP PowerShell will check for new versions when you execute `Connect-PnPOnline`.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
PNPPOWERSHELL_UPDATECHECK=false
```

### [Azure Service Fabric CLI](https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-sfctl)

> Sfctl telemetry collects command name without parameters provided or their values, sfctl version, OS type, python version, the success or failure of the command, the error message returned.

- [Telemetry details](https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-sfctl-settings-telemetry)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 👤 User

```shell
sfctl settings telemetry set_telemetry --off
```

### [Skaffold](https://skaffold.dev/)

> To help prioritize features and work on improving Skaffold, we collect anonymized Skaffold usage data. Usage data does not include any argument values or personal information.

- [Telemetry details](https://skaffold.dev/docs/resources/telemetry/)
- [Privacy policy](https://policies.google.com/privacy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Run command

###### Scope: 👤 User

```shell
skaffold config set --global collect-metrics false
```

### [Telepresence](https://www.telepresence.io/)

> Telepresence collects some basic information about its users so it can send important client notices, such as new version availability and security bulletins. We also use the information to aggregate basic usage analytics anonymously.

- [Telemetry details](https://github.com/telepresenceio/telepresence#usage-reporting)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
SCOUT_DISABLE=1
```

### [Terraform](https://www.terraform.io/)

> The Terraform CLI commands interact with the HashiCorp service Checkpoint to check for the availability of new versions and for critical security bulletins about the current version.

- [Telemetry details](https://www.terraform.io/docs/commands/index.html#upgrade-and-security-bulletin-checks)
- [Privacy policy](https://hashicorp.com/privacy)

List of known telemetry channels:

#### [Update check](https://www.terraform.io/docs/commands/index.html#disable_checkpoint)

Official: ✔

> Disable checkpoint calls entirely.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CHECKPOINT_DISABLE=ANY_VALUE
```

##### 2. Edit config file (plaintext)

###### Scope: 👤 User

| OS      | Path                     |
|---------|--------------------------|
| Linux   | `$HOME/.terraformrc`     |
| macOS   | `$HOME/.terraformrc`     |
| Windows | `%APPDATA%\terraform.rc` |

###### Content

```none
disable_checkpoint = true
```

#### [Update check signature](https://www.terraform.io/docs/commands/index.html#disable_checkpoint_signature)

Official: ✔

> Disable the use of an anonymous signature in checkpoint requests. This allows Terraform to check for security bulletins but does not send the anonymous signature in these requests.

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (plaintext)

###### Scope: 👤 User

| OS      | Path                     |
|---------|--------------------------|
| Linux   | `$HOME/.terraformrc`     |
| macOS   | `$HOME/.terraformrc`     |
| Windows | `%APPDATA%\terraform.rc` |

###### Content

```none
disable_checkpoint_signature = true
```

### [Cloud Development Kit for Terraform](https://github.com/hashicorp/terraform-cdk)

> CDK for Terraform CLI (cdktf-cli) interacts with a HashiCorp service called Checkpoint to report project metrics such as cdktf version, project language, provider name, platform name, and other details that help guide the project maintainers with feature and roadmap decisions.

- [Telemetry details](https://github.com/hashicorp/terraform-cdk/blob/master/docs/working-with-cdk-for-terraform/telemetry.md)
- [Privacy policy](https://hashicorp.com/privacy)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CHECKPOINT_DISABLE=ANY_VALUE
```

### [Vagrant](https://www.vagrantup.com/)

> Vagrant interacts with HashiCorp services to provide update notifications.

- [Telemetry details](https://www.vagrantup.com/docs/other/environmental-variables)
- [Privacy policy](https://hashicorp.com/privacy)

List of known telemetry channels:

#### [Vagrant update check](https://www.vagrantup.com/docs/other/environmental-variables#vagrant_checkpoint_disable)

Official: ✔

> Vagrant does occasional network calls to check whether the version of Vagrant that is running locally is up to date.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
VAGRANT_CHECKPOINT_DISABLE=ANY_VALUE
```

#### [Vagrant box update check](https://www.vagrantup.com/docs/other/environmental-variables#vagrant_box_update_check_disable)

Official: ✔

> By default, Vagrant will query the metadata API server to see if a newer box version is available for download.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
VAGRANT_BOX_UPDATE_CHECK_DISABLE=ANY_VALUE
```

### [Weave Net](https://www.weave.works/)

> Weave Net periodically contacts Weaveworks servers for available versions. New versions are announced in the log and in the status summary.

- [Telemetry details](https://www.weave.works/docs/net/latest/install/installing-weave/#checkpoint)
- [Privacy policy](https://www.weave.works/weaveworks-privacy-policy/)

List of known telemetry channels:

#### Update check

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CHECKPOINT_DISABLE=1
```

### [WKSctl](https://www.weave.works/oss/wksctl/)

> wksctl contacts Weaveworks servers for available versions. When a new version is available, wksctl will print out a message along with a URL to download it.

- [Telemetry details](https://wksctl.readthedocs.io/en/latest/faq/#checkpoint-and-how-to-disable-it)
- [Privacy policy](https://www.weave.works/weaveworks-privacy-policy/)

List of known telemetry channels:

#### Update check

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
CHECKPOINT_DISABLE=1
```

## Drivers

### [Nvidia drivers](https://www.nvidia.com/en-us/geforce/geforce-experience/)

> Details on your device and network configurations, how you are using our products or services (including the software you are using), and details on how your system is performing, so we can optimize hardware and software configurations.

- [Privacy policy](https://www.nvidia.com/en-us/about-nvidia/privacy-policy/)

List of known telemetry channels:

#### [Diagnostic data](https://www.gamersnexus.net/industry/2672-geforce-experience-data-transfer-analysis)

Official: ❌

> Analyzing GeForce Experience Data Transfers with Packet Monitoring

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [NVCleanstall](https://www.techpowerup.com/nvcleanstall/)

    > Our free software lets you customize the NVIDIA GeForce Driver package by removing components that you don't need (or want).

2. [Disable Nvidia Telemetry](https://github.com/NateShoffner/Disable-Nvidia-Telemetry)

    > Disable Nvidia Telemetry is a utility that allows you to disable the telemetry services Nvidia bundles with their drivers.

## Operating systems

### [Windows 10](https://www.microsoft.com/windows/)

> Microsoft collects Windows diagnostic data to solve problems and to keep Windows up to date, secure, and operating properly.

- [Telemetry details](https://support.microsoft.com/en-us/help/4468236/diagnostics-feedback-and-privacy-in-windows-10-microsoft-privacy)
- [Privacy policy](https://privacy.microsoft.com/privacystatement)

List of known telemetry channels:

#### [Usage data | Enterprise](https://docs.microsoft.com/en-us/windows/privacy/configure-windows-diagnostic-data-in-your-organization)

Official: ✔

> Applies to: Windows 10 Enterprise/Education, Windows Server 2016 and newer

Use methods described below to opt-out of this telemetry channel.

##### 1. Set registry key

###### Scope: 💻 Machine

- Path: `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DataCollection\AllowTelemetry`
- Type: `REG_DWORD`
- Value: `0`

#### Usage data

Official: ❌

> There is no official way to disable telemetry in all other Windows editions (Home/Pro/etc...)

Use methods described below to opt-out of this telemetry channel.

##### 1. Visit link(s) for more details

1. [ghacks.net | Comparison of Windows 10 Privacy tools](https://www.ghacks.net/2015/08/14/comparison-of-windows-10-privacy-tools/)

    > We update the listing regularly. Please let us know about any updates that we may have missed, and about new programs that you found that are not on it already.

2. [github.com | Windows 10 Sophia Script](https://github.com/farag2/Windows-10-Sophia-Script)

    > A PowerShell module for Windows 10 fine-tuning and automating the routine tasks 🏆

3. [github.com | crazy-max/WindowsSpyBlocker](https://github.com/crazy-max/WindowsSpyBlocker)

    > 🛡 Block spying and tracking on Windows

4. [github.com | builtbybel/Privatezilla](https://github.com/builtbybel/privatezilla)

    > Privatezilla is the simplest way to perform a quick privacy and security check of your Windows 10 copy.

5. [github.com | builtbybel/SharpApp](https://github.com/builtbybel/sharpapp)

    > 💩⭐️🚀A #app with cutting edge technology to minimize windows-10 telemetry and maximize privacy plus many more

## Other

### [AccessMap](https://www.accessmap.io/)

> AccessMap tracks website interactions to do research on user interactions and root out bugs.

- [Telemetry details](https://github.com/AccessMap/accessmap/blob/master/README.md#analytics)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
ANALYTICS=no
```

## Shells

### [Oh My Zsh](https://ohmyz.sh/)

> By default, you will be prompted to check for upgrades every few weeks.

- [Telemetry details](https://github.com/ohmyzsh/ohmyzsh/tree/master#getting-updates)
- Privacy policy: ❌

List of known telemetry channels:

#### Update check

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DISABLE_AUTO_UPDATE=true
```

### [PowerShell Core](https://github.com/powershell/powershell)

> PowerShell Core sends basic telemetry data to Microsoft and queries an online service to determine if a newer version is available.

- [Privacy policy](https://privacy.microsoft.com/privacystatement)

List of known telemetry channels:

#### [Usage data](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_telemetry)

Official: ✔

> PowerShell sends basic telemetry data to Microsoft. This data allows us to better understand the environments where PowerShell is used and enables us to prioritize new features and fixes.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
POWERSHELL_TELEMETRY_OPTOUT=1
```

##### 2. Visit link(s) for more details

1. [Disable telemetry in PowerShell Core 6.0](https://docs.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-core-61#telemetry-can-only-be-disabled-with-an-environment-variable)

    > You can opt-out from telemetry by creating 'DELETE_ME_TO_DISABLE_CONSOLEHOST_TELEMETRY' file in the directory where 'pwsh' binary is installed.

#### [Update check](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_update_notification)

Official: ✔

> PowerShell uses update notifications to alert users to the existence of updates to PowerShell. Once per day, PowerShell queries an online service to determine if a newer version is available.

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
POWERSHELL_UPDATECHECK=Off
```

## VSCode extension

### [Azure Application Insights (VSCode)](https://marketplace.visualstudio.com/items?itemName=VisualStudioOnlineApplicationInsights.application-insights)

> The software may collect information about you and your use of the software and send it to Microsoft.

- [Telemetry details](https://github.com/microsoft/applicationinsights-vscode/blob/master/README.md#privacy-statement)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### Usage data

Official: ❌

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
AITOOLSVSCODE_DISABLETELEMETRY=ANY_VALUE
```

### [docs-yaml (VSCode)](https://marketplace.visualstudio.com/items?itemName=docsmsft.docs-yaml)

> The software may collect information about you and your use of the software and send it to Microsoft.

- [Telemetry details](https://github.com/microsoft/docs-yaml/blob/main/PRIVACY.md)
- [Privacy policy](https://privacy.microsoft.com/en-us/privacystatement)

List of known telemetry channels:

#### Usage data

Official: ❌

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                                        |
|---------|-------------------------------------------------------------|
| Linux   | `$HOME/.config/Code/User/settings.json`                     |
| macOS   | `$HOME/Library/Application Support/Code/User/settings.json` |
| Windows | `%APPDATA%\Code\User\settings.json`                         |

###### Content

```json
{
  "docsYaml.telemetry.enableTelemetry": false
}
```

##### 2. Visit link(s) for more details

1. [Usage data](https://github.com/microsoft/docs-yaml/blob/main/PRIVACY.md)

    > Follow the steps below to disable data collection:
    > 
    > 1. In Visual Studio Code: _File_ > _Preferences_ > _Settings_
    > 1. Navigate to _Extensions_ > _Docs Yaml_
    > 1. Uncheck _Enable usage data and errors to be sent to an online service._

### [ESP-IDF (VSCode)](https://marketplace.visualstudio.com/items?itemName=espressif.esp-idf-extension)

> We collect telemetry data, from vscode extension which is used to help understand how to improve the extension. For example, this usage data helps to debug issues, such as slow start-up times, and to prioritize new features.

- [Telemetry details](https://github.com/espressif/vscode-esp-idf-extension/blob/master/docs/TELEMETRY.md)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                                        |
|---------|-------------------------------------------------------------|
| Linux   | `$HOME/.config/Code/User/settings.json`                     |
| macOS   | `$HOME/Library/Application Support/Code/User/settings.json` |
| Windows | `%APPDATA%\Code\User\settings.json`                         |

###### Content

```json
{
  "idf.telemetry": false
}
```

### [JavaScript debugger (VSCode)](https://marketplace.visualstudio.com/items?itemName=ms-vscode.js-debug)

> The software may collect information about you and your use of the software.

- Privacy policy: ❌

List of known telemetry channels:

#### [Usage data](https://github.com/microsoft/vscode-js-debug/blob/12ec6df97f45b25b168e1eac8a17b802af73806f/src/ioc.ts#L168)

Official: ❌

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DA_TEST_DISABLE_TELEMETRY=1
```

### [Julia (VSCode)](https://www.julia-vscode.org/)

> You can help improve the Julia VS Code extension by sending usage statistics and exceptions to the development team. By default, telemetry and crash report data are not collected, but rather the user has to opt-in to have their data sent.

- [Telemetry details](https://www.julia-vscode.org/docs/stable/userguide/privacy/#Collecting-Data-1)
- [Privacy policy](https://www.julia-vscode.org/docs/stable/userguide/privacy/#Using-Collected-Data-1)

List of known telemetry channels:

#### Usage data

Official: ✔

> Anonymous, non-identifying usage and error data is sent to the development team.

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                                        |
|---------|-------------------------------------------------------------|
| Linux   | `$HOME/.config/Code/User/settings.json`                     |
| macOS   | `$HOME/Library/Application Support/Code/User/settings.json` |
| Windows | `%APPDATA%\Code\User\settings.json`                         |

###### Content

```json
{
  "julia.enableTelemetry": false
}
```

#### Crash data

Official: ✔

> Stack traces from errors in the extension are sent to the development team. Those stack traces can contain identifying information, for example filenames.

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                                        |
|---------|-------------------------------------------------------------|
| Linux   | `$HOME/.config/Code/User/settings.json`                     |
| macOS   | `$HOME/Library/Application Support/Code/User/settings.json` |
| Windows | `%APPDATA%\Code\User\settings.json`                         |

###### Content

```json
{
  "julia.enableCrashReporter": false
}
```

### [PrintCode (VSCode)](https://marketplace.visualstudio.com/items?itemName=nobuhito.printcode)

> PrintCode records product usage with Google Analytics.

- [Telemetry details](https://github.com/nobuhito/vscode.printcode/blob/master/README.md#configuration-options)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                                        |
|---------|-------------------------------------------------------------|
| Linux   | `$HOME/.config/Code/User/settings.json`                     |
| macOS   | `$HOME/Library/Application Support/Code/User/settings.json` |
| Windows | `%APPDATA%\Code\User\settings.json`                         |

###### Content

```json
{
  "printcode.disableTelemetry": false
}
```

### [REST Client (VSCode)](https://marketplace.visualstudio.com/items?itemName=humao.rest-client)

> REST Client sends out anonymous usage data.

- [Telemetry details](https://github.com/Huachao/vscode-restclient#settings)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                                        |
|---------|-------------------------------------------------------------|
| Linux   | `$HOME/.config/Code/User/settings.json`                     |
| macOS   | `$HOME/Library/Application Support/Code/User/settings.json` |
| Windows | `%APPDATA%\Code\User\settings.json`                         |

###### Content

```json
{
  "rest-client.enableTelemetry": false
}
```

### [Serverless IDE (VSCode)](https://marketplace.visualstudio.com/items?itemName=ThreadHeap.serverless-ide-vscode)

> ServerlessIDE collects anonymous information related to the usage of the extensions, such as which commands were run, as well as performance and error data.

- [Telemetry details](https://github.com/threadheap/serverless-ide-vscode/blob/master/packages/vscode/README.md#telemetry)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data and crash reports

Official: ✔

> We also respect the global telemetry setting [telemetry.enableTelemetry](https://toptout.me/#/?id=vscode); if that is set to false, ServerlessIDE telemetry is disabled.

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                                        |
|---------|-------------------------------------------------------------|
| Linux   | `$HOME/.config/Code/User/settings.json`                     |
| macOS   | `$HOME/Library/Application Support/Code/User/settings.json` |
| Windows | `%APPDATA%\Code\User\settings.json`                         |

###### Content

```json
{
  "serverlessIDE.telemetry.enableTelemetry": false
}
```

### [Terminal (VSCode)](https://marketplace.visualstudio.com/items?itemName=formulahendry.terminal)

> Terminal uses Application Insights to track telemetry data. By default, telemetry data collection is turned on.

- [Telemetry details](https://github.com/formulahendry/vscode-terminal/tree/master#telemetry-data)
- Privacy policy: ❌

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Edit config file (JSON)

###### Scope: 👤 User

| OS      | Path                                                        |
|---------|-------------------------------------------------------------|
| Linux   | `$HOME/.config/Code/User/settings.json`                     |
| macOS   | `$HOME/Library/Application Support/Code/User/settings.json` |
| Windows | `%APPDATA%\Code\User\settings.json`                         |

###### Content

```json
{
  "terminal.enableAppInsights": false
}
```

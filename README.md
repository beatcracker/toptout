<p align="center">
  <img id="logo" src="https://raw.githubusercontent.com/beatcracker/toptout/master/media/toptout.png">
</p>

<p align="center">
  <a href="https://github.com/beatcracker/toptout/actions?query=workflow%3ATests"><img alt="GitHub Actions status" src="https://github.com/beatcracker/toptout/workflows/Tests/badge.svg"></a>
</p>

# Easily opt-out from telemetry collection

Telemetry in software projects is a polarized issue: on the one hand it allows developers to improve their work by collecting various metrics, on the other hand - nobody likes to be spied on.
The goal of this project is to put you in control. See what data is collected by the tools you use and decide if you want to share it. Then use methods provided here to opt-in or opt-out.

## Real-world applications

The core of this project is a set of JSON files which describe what telemetry is collected and what can be done to enable or disable it.
This data can be used in various ways. Here are several examples:

### Documentation

The [page](README.md) you see is automatically generated.

### Scripts

[Scripts](/examples/) to disable all known telemetry channels in your shell session.

### API

Get telemetry confugration data via API! See [openapi.yaml](https://github.com/beatcracker/toptout/blob/api-docs/docs/swagger/openapi.yaml) definition and try it online using [Swagger-UI](https://beatcracker.github.io/toptout/swagger).

#### Example

```shell
curl -X GET 'https://beatcracker.github.io/toptout/api/telemetry/id/powershell-core/' -H 'accept: application/json'
```

## Details

### Contributing

If the tool you're using is not here you can easily add it by creating a new JSON file describing its telemetry data channels. Pull requests are welcome!

See [CONTRIBUTING](/.github/CONTRIBUTING.md) for details on adding telemetry data and running tests.

### JSON data format

JSON telemetry data format decscription: [data/README](/data/)

## Future plans

- Automated tool that can ingest the data from the API. You could run it on your machine to detect and configure telemetry in all suported products.
- ???

## Related projects

- [Console Do Not Track (DNT)](https://consoledonottrack.com)

  A proposed unified standard for opting out of telemetry for TUI/console apps: `export DO_NOT_TRACK=1`

- [privacy.sexy](https://privacy.sexy/)

  Web tool to enforce privacy & security best-practices on Windows, because privacy is sexy 🍑🍆

  GitHub: [undergroundwires/privacy.sexy](https://github.com/undergroundwires/privacy.sexy)

## Telemetry channels

Below is automatically generated list of known telemetry channels for various applications.

- [Applications](#applications)
  - [Atom](#atom)
  - [Firefox](#firefox)
  - [Homebrew](#homebrew)
  - [Lens](#lens)
  - [Microsoft 365 | Enterprise](#microsoft-365--enterprise)
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
  - [Prisma](#prisma)
- [DevOps](#devops)
  - [AutomatedLab](#automatedlab)
  - [Consul](#consul)
  - [k0s](#k0s)
  - [Packer](#packer)
  - [Terraform](#terraform)
  - [Cloud Development Kit for Terraform](#cloud-development-kit-for-terraform)
  - [Vagrant](#vagrant)
  - [Weave Net](#weave-net)
  - [WKSctl](#wksctl)
- [Drivers](#drivers)
  - [Nvidia drivers](#nvidia-drivers)
- [Operating systems](#operating-systems)
  - [Windows 10](#windows-10)
- [Shells](#shells)
  - [PowerShell Core](#powershell-core)

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

## Cloud

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

##### 1. Run command

###### Scope: 👤 User

```shell
gcloud config set disable_usage_reporting true
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

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
DO_NOT_TRACK=1
```

## Development

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

## DevOps

### [AutomatedLab](https://github.com/AutomatedLab/AutomatedLab)

> AutomatedLab will start to collect telemetry starting with version 5.0. This is an opt-out collection and you will be asked once to specify whether or not you want to send us telemetry data.

- [Telemetry details](https://github.com/AutomatedLab/AutomatedLab/wiki/Lab-Telemetry)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
AUTOMATEDLAB_TELEMETRY_OPTOUT=1
```

##### 2. Run command

###### Scope: 👤 User

| OS      | Command                                                                                                                                                                  |
|---------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Other   | `pwsh -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "Import-Module AutomatedLab -ErrorAction Stop ; Disable-LabTelemetry -ErrorAction Stop"`       |
| Windows | `powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "Import-Module AutomatedLab -ErrorAction Stop ; Disable-LabTelemetry -ErrorAction Stop"` |

### [Consul](https://www.consul.io/)

> Consul makes use of a HashiCorp service called Checkpoint which is used to check for updates and critical security bulletins.

- [Telemetry details](hhttps://www.consul.io/docs/troubleshoot/faq#q-what-is-checkpoint-does-consul-call-home)
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

### [Vagrant](hhttps://www.vagrantup.com/)

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

#### [Usage data | Enterpise](https://docs.microsoft.com/en-us/windows/privacy/configure-windows-diagnostic-data-in-your-organization)

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

2. [github.com | crazy-max/WindowsSpyBlocker](https://github.com/crazy-max/WindowsSpyBlocker)

    > 🛡 Block spying and tracking on Windows

3. [github.com | Disassembler0/Win10-Initial-Setup-Script](https://github.com/Disassembler0/Win10-Initial-Setup-Script)

    > PowerShell script for automation of routine tasks done after fresh installations of Windows 10 / Server 2016 / Server 2019

4. [github.com | builtbybel/spydish](https://github.com/builtbybel/spydish)

    > 👀👮🐢🔥The Spydish app is the simplest way to perform a quick privacy and security check of your Windows 10 installation

5. [github.com | builtbybel/sharpapp](https://github.com/builtbybel/sharpapp)

    > 💩⭐️🚀A #app with cutting edge technology to #minimize windows-10 telemetry and #maximize privacy plus many more

## Shells

### [PowerShell Core](https://github.com/powershell/powershell)

> PowerShell Core sends basic telemetry data to Microsoft when it is launched. The data includes the OS name, OS version, and PowerShell version. This data allows us to better understand the environments where PowerShell is used and enables us to prioritize new features and fixes.

- [Telemetry details](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_telemetry)
- [Privacy policy](https://privacy.microsoft.com/privacystatement)

List of known telemetry channels:

#### Usage data

Official: ✔

Use methods described below to opt-out of this telemetry channel.

##### 1. Set environment variable

###### Scope: ⧉ Process

```none
POWERSHELL_TELEMETRY_OPTOUT=1
```

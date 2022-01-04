# Contributing

The core of this project is a set of JSON files which describe what telemetry is collected and what can be done to enable or disable it. Tests and README generator are using PowerShell Core.

Contributions need to pass the tests and include generated content if applicable ([/README.md](https://github.com/beatcracker/toptout/blob/master/README.md), [/examples](https://github.com/beatcracker/toptout/blob/master/examples), [/docs/api](https://github.com/beatcracker/toptout/blob/master/docs/api)). Build script takes care of that.

## Adding new telemetry data file

See [/data/README](/data/README.md)

## Using build script

You'll need to run [build.ps1](https://github.com/beatcracker/toptout/blob/master/build.ps1) to make sure that contributions pass tests and to update generated content.

### Dependencies

Build script itself and its tasks require several dependencies from the [PowerShell Gallery](https://www.powershellgallery.com/) and [npm](https://www.npmjs.com/). To avoid polluting your environment, PowerShell dependencies are downloaded on the first run into the `.packages` directory. [Node.js](https://nodejs.org/) based tasks use [npx](https://docs.npmjs.com/cli/v7/commands/npx) to run tools without installing packages globally.

### Prerequisites

To run build and tests, you'll need

- [PowerShell](https://github.com/powershell/powershell) `7+`
- [Node.js](https://nodejs.org/en/download/) `15+`

You can also use VSCode + [development container](https://code.visualstudio.com/docs/remote/containers).

### Tasks

The provided [build.ps1](https://github.com/beatcracker/toptout/blob/master/build.ps1) script includes multiple tasks:

- `test`: run all subtasks below
  - `test-schema`: validate JSON Schema
  - `test-code`: run code tests
  - `test-data`: run data files tests
- `content`: run all subtasks below
  - `content-readme`: generate `README.md`
  - `content-shell`: generate example shell scripts in [/examples](https://github.com/beatcracker/toptout/blob/master/examples)
- `api`: run all subtasks below
  - `api-json`: generate JSON files for static API ([toptout.me/api-docs](https://toptout.me/api-docs/))
  - `api-schema-lint`: lint OpenAPI schema source ([/schema/openapi.yaml](https://github.com/beatcracker/toptout/blob/master/schema/openapi.yaml))
  - `api-schema-bundle`: generate bundled (dereferenced) OpenAPI definition for API documentation ([/docs/api-docs/openapi.yaml](https://github.com/beatcracker/toptout/blob/master/docs/api-docs/openapi.yaml)). Some tools can't handle uris in `$ref`.
- `clean`: remove `.packages` directory. This will force re-download of PowerShell dependencies.

If the build script is run without arguments the `test`, `content`, and `api` tasks are executed. To execute specific task or subtask provide its name as an argument (you can use tab completion): `./build.ps1 test`. For more details about build system, see [Invoke-Build](https://github.com/nightroman/Invoke-Build) docs.

Hint: you can run multiple tasks.

```pwsh
./build.ps1 test, content, api-json
# Or
./build.ps1 test content api-json
```

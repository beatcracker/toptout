# Contributing

The core of this project is a set of JSON files which describe what telemetry is collected and what can be done to enable or disable it. Tests and README generator are using PowerShell Core.

## Prerequisites

While you can hack around without using provided build script, it is not recommended.

- To run the build and tests, you'll need [PowerShell](https://github.com/powershell/powershell) `7+` and [Node.js](https://nodejs.org/en/download/) `15+`.
- On non-Windows systems [Mono](https://www.mono-project.com/) is required for build script to be able to run [Paket](https://fsprojects.github.io/Paket/) to restore dependencies.

## Adding new telemetry data file

See [/data/README](/data/README.md)

## Using build script

Contributions need to pass the tests and include generated content if applicable ([/README.md](https://github.com/beatcracker/toptout/blob/master/README.md), [/examples](https://github.com/beatcracker/toptout/blob/master/examples), [/docs/api](https://github.com/beatcracker/toptout/blob/master/docs/api)). Build script takes care of that.

### Tasks

The provided [build.ps1](https://github.com/beatcracker/toptout/blob/master/build.ps1) script includes multiple tasks:

- `test`: run all subtasks below
  - `test-schema`: validate JSON Schema
  - `test-data`: run code and data files tests
- `content`: run all subtasks below
  - `content-readme`: generate `README.md`
  - `content-shell`: generate example shell scripts in [/examples](https://github.com/beatcracker/toptout/blob/master/examples)
- `api`: run all subtasks below
  - `api-json`: generate JSON files for static API ([toptout.me/swagger](https://toptout.me/swagger/))
  - `api-schema-lint`: lint OpenAPI schema source ([/schema/openapi.yaml](https://github.com/beatcracker/toptout/blob/master/schema/openapi.yaml))
  - `api-schema-bundle`: generate bundled (dereferenced) OpenAPI definition for Swagger ([/docs/swagger/openapi.yaml](https://github.com/beatcracker/toptout/blob/master/docs/swagger/openapi.yaml)). Some tools can't handle uris in `$ref`.

- `clean`: clean local [Paket](https://fsprojects.github.io/Paket/) files. This will force re-download of PowerShell dependencies.

If the build script is run without arguments the `test`, `content`, and `api` tasks are executed. To execute specific task or subtask provide its name as an argument (you can use tab completion): `./build.ps1 test`. For more details about build system, see [Invoke-Build](https://github.com/nightroman/Invoke-Build) docs.

Hint: you can run multiple tasks.

```pwsh
./build.ps1 test, content, api-json
# Or
./build.ps1 test content api-json
```

### Dependencies

Build script itself and its tasks requires several dependencies from the [PowerShell Gallery](https://www.powershellgallery.com/) and [npm](https://www.npmjs.com/). To avoid polluting your environment PowerShell dependencies are downloaded on the first run into the `./packages` and `./paket-files` directory. This is achieved by using [Paket](https://fsprojects.github.io/Paket/) in [magic mode](https://fsprojects.github.io/Paket/bootstrapper.html#Magic-mode). [Node.js](https://nodejs.org/) based tasks use [npx](https://docs.npmjs.com/cli/v7/commands/npx) to run tools without installing packages globally.

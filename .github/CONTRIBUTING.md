# Contributing

The core of this project is a set of JSON files which describe what telemetry is collected and what can be done to enable or disable it. Tests and README generator are using PowerShell Core.

## Prerequisites

While you can hack around without using provided build script, it is not recommended. To run the build and tests, you'll need [PowerShell Core](https://github.com/powershell/powershell).

On non-Windows systems [Mono](https://www.mono-project.com/) is required for build script to be able to run [Paket](https://fsprojects.github.io/Paket/) to restore dependecies.

[Node.js](https://nodejs.org/en/download/) 12+ is required for bundling OpenAPI schema.

## Adding new telemetry data file

See [data/README](/data/README.md)

## Using build script

Contributions need to pass the tests and include generated content if applicable (`./README.md`, `./scripts`, `./docs/api`). Build script takes care of that.

### Tasks

The provided `build.ps1` script includes several tasks:

- `test`: run code and data files tests
- `readme`: generate `README.md`
- `shell`: generate [example shell scripts](/examples/)
- `api`: invokes two subtasks. These can be run separately if needed.
  - `static-files`: generate JSON files for static API
  - `openapi-lint`: lint OpenAPI schema
  - `openapi-bundle`: bundle (dereference) OpenAPI defintion. Some tools can't handle uris in `$ref`.
- `clean`: clean local `Paket` files. This will force re-download of PowerShell dependencies.

If the build script is run without arguments the `test`, `readme`, `shell` and `api` tasks are executed. To execute specific task provide its name as an argument (you can use tab completiton): `./build.ps1 readme`. For more details see [Invoke-Build](https://github.com/nightroman/Invoke-Build) docs.

Hint, you can run multiple tasks:

```pwsh
./build.ps1 readme, shell
./build.ps1 readme shell
```

### Dependencies

Script and tasks require several dependencies from the [PowerShell Gallery](https://www.powershellgallery.com/). To avoid polluting your environment those dependecies are downloaded on the first run into the `./packages` and `./paket-files` directory. This is achieved by using [Paket](https://fsprojects.github.io/Paket/) in [magic mode](https://fsprojects.github.io/Paket/bootstrapper.html#Magic-mode).

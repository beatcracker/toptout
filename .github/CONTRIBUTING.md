# Contributing

The core of this project is a set of JSON files which describe what telemetry is collected and what can be done to enable or disable it. Tests and README generator are using PowerShell Core.

Contributions need to pass the tests and include generated content if applicable ([/README.md](https://github.com/beatcracker/toptout/blob/master/README.md), [/examples](https://github.com/beatcracker/toptout/blob/master/examples), [/docs/api](https://github.com/beatcracker/toptout/blob/master/docs/api)). Build script takes care of that.

## Adding new telemetry data file

See [/data/README](/data/README.md)

## Building and testing

You'll need to run [build.ps1](https://github.com/beatcracker/toptout/blob/master/build.ps1) to make sure that contributions pass tests and to update generated content.

### Setup

Install [mise](https://mise.jdx.dev/getting-started/) and run `mise install` from the repository root.

`build.ps1` requires PowerShell 7.4.6 or newer and restores pinned InvokeBuild, Pester, and PSScriptAnalyzer modules from PowerShell Gallery into a project-local `.packages` directory. It can also run without mise when PowerShell, [jsonschema](https://github.com/sourcemeta/jsonschema), and [redocly](https://github.com/redocly/redoc) (with Node.js) are available on `PATH`.

### Running tasks

`build.ps1` defines build tasks using Invoke-Build. Mise manages development tools and provides commands for common workflows. `mise run build` forwards arguments to `build.ps1`.

With no task specified, the build runs tests and generates content and API files. Run `mise run build ?` or `./build.ps1 ?` to list available tasks.

Run `mise run check` for formatting, linting, and build tests. Run `mise run fmt` to format maintained files.

Run `mise run preview` to serve the generated site locally and open RapiDoc at http://127.0.0.1:8765/api-docs/. Stop the server with Ctrl+C.

```sh
mise run build test
mise run build test-data
mise run build test content api-json
# Or call the script directly:
pwsh -NoProfile -File ./build.ps1 test
```

### Available build tasks

- `test`: run all subtasks below
  - `test-schema`: validate and lint JSON Schema
  - `test-code`: run code tests
  - `test-data`: run data files tests
- `content`: run all subtasks below
  - `content-readme`: generate `README.md`
  - `content-shell`: generate example shell scripts in [/examples](https://github.com/beatcracker/toptout/blob/master/examples)
- `api`: run all subtasks below
  - `api-json`: generate JSON files for static API ([toptout.me/api-docs](https://toptout.me/api-docs/))
  - `api-schema-lint`: lint OpenAPI schema source ([/schema/openapi.yaml](https://github.com/beatcracker/toptout/blob/master/schema/openapi.yaml))
  - `api-schema-bundle`: generate bundled OpenAPI definition for API documentation ([/docs/api-docs/openapi.yaml](https://github.com/beatcracker/toptout/blob/master/docs/api-docs/openapi.yaml)).

`clean` removes `.packages`, which will be restored on the next build.

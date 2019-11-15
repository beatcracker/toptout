# Contributing

The core of this project is a set of JSON files which describe what telemetry is collected and what can be done to enable or disable it. Tests and README generator are using PowerShell Core.

## Prerequisites

While you can hack around without using provided build script, it is not recommended. To run the build and tests, you need [PowerShell Core](https://github.com/powershell/powershell) installed.

## Adding new telemetry data file

See [data/README.md](data/README.md)

## Using build script

The provided `build.ps1` script has several tasks:

- `test`: run code and data files tests
- `readme`: generate `README.md`
- `clean-all`: clean global and local NuGet and cache directories
- `clean-local`: clean local NuGet and cache directories

If build script is run without arguments the `test` and `readme` tasks are executed. To execute specific task provide its name as an argument: `.\build.ps1 readme`

Script and tasks require several dependencies from the PowerShell Gallery. To avoid polluting your enviornmnet those dependecies are downloaded on the first run into the `./packages` directory. This is achieved by using [Paket](https://fsprojects.github.io/Paket/) in [magic mode](https://fsprojects.github.io/Paket/bootstrapper.html#Magic-mode).

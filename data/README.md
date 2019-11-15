# Telemetry data files

The telemetry data file is a JSON document conforming to the JSON Schema: [toptout.schema.json](schema/toptout.schema.json). See [JSON Schema](https://json-schema.org) website for more information.

## Basic example

Describes product which has one telemetry channel which is controlled by the environment variable.

```jsonc
{
  // Product unique ID. Use lowercase and [az-] character set. Must be unique across all files.
  "id": "foo-bar",

  // Friendly name of the product
  "name": "Foo Bar",

  // Friendly category name. The README generator uses it to group products.
  "category": "Development tools",

   // Short description of the collected telemetry. Usually copied from the product's documentation.
  "description": "All your base are belong to us.",

  // Links object
  "links": {
    // Link to the product's website. Mandatory.
    "main": "https://example.com",

    // Link to the product's telemetry description. Optional.
    "telemetry": "https://example.com/telemetry",

    // Link to the product's privacy policy. Optional.
    "privacy": "https://example.com/privacy"
  },

  // Telemetry channels list. Conains name and optionally desription and opt-in/out methods.
  // Optional, since you may wish to add a product that contains telemetry but doesn't provide a way to control it.
  "telemetry": [
    {

      // Telemetry channel unique ID. Use lowercase and [az-] character set.
      // Must be unique in this list.
      "id": "usage-data",

      // Friendly name of the product
      "name": "Usage data",

      // Target object.
      // Optional, since you may wish to describe multiple telemetry channels that don't provide a ways to control them.
      "target": {

        // "Environment variable" target.
        // Sets or removes environment variable.
        "env": {

          // Path object. Contains environment variable name for various OSes.
          // Allowed keys: default, linux, macos, windows
          "path": {
            // Use the 'default' key if the environmnet variable name is the same on any OS.
            "default": "TELEMETRY_OPTOUT"
          },

          // Value object.
          "value": {
            // Set environment variable to this value to opt-out of this telemetry channel
            "opt_out": "false",

            // Set environment variable to this value to opt-in into this telemetry channel.
            // Set to 'null' value (not literal "null" string) to indicate that environment variable should be removed.
            "opt_in": "true"
          }
        }
      }
    }
  ]
}
```

## Telemetry channel targets

Product can have multiple telemetry channels. Some of them could be controlled by multiple methods. Currently supported methods are:

- Environment variable: `env`
- Executable: `exec`
- JSON file: `json_file`
- Plaintext file: `plain_file`

### env

`Environment variable` target. Indicates that this specific telemetry channel is controlled by the environment variable.

```jsonc
"env": {

  // Path object. Contains environment variable name for various OSes.
  // Allowed keys: default, linux, macos, windows
  // If there is no OS-specific key and no default - this OS is not supported.
  "path": {
    // Use the 'default' key if the environment variable name is the same on any OS.
    "default": "FOOBAR_TELEMETRY"
  },

  // Value object.
  "value": {
    // Set environment variable to this value to opt-out of this telemetry channel
    "opt_out": "false",

    // Set environment variable to this value to opt-in into this telemetry channel.
    // Set to 'null' value (not literal "null" string) to indicate that environment variable should be removed.
    "opt_in": "true"
  }
```

### exec

`Execute` target. Indicates that this specific telemetry channel is controlled by executing shell command.

```jsonc
  "exec": {
    // Path object. Contains environment variable name for various OSes.
    // Allowed keys: default, linux, macos, windows
    // If there is no OS-specific key and no default - this OS is not supported.
    "path": {
      // Use the 'default' key if the executable name is the same on any OS.
      "default": "foobar"
    },
    "value": {
      // Use this arguments to opt-out of this telemetry channel.
      "opt_out": "--telemetry-disable",

      // Use this arguments to opt-in into this telemetry channel.
      "opt_in": "--telemetry-enable"
    }
  }
```

### json_file

`JSON file` target. Indicates that this specific telemetry channel is controlled by setting the value in the JSON file.

```jsonc
  "json_file": {
    // Path object. Contains environment variable name for various OSes.
    // Allowed keys: default, linux, macos, windows
    // If there is no OS-specific key and no default - this OS is not supported.
    "path": {
      "linux": "$HOME/.foobar/config.json",
      "macos": "$HOME/.foobar/config.json",
      "windows": "%USERPROFILE%\\.foobar\\config.json"
    },

    // Selector of the telemetry channel control setting in the JSON.
    // Specify as JSON Pointer (https://tools.ietf.org/html/rfc6901)
    "selector": "/telemetry",

    "value": {

      // Use this value to opt-out of this telemetry channel.
      "opt_out": "false",

      // Use this value to opt-in into this telemetry channel.
      "opt_in": "true"
    },

    // Friendly example. Must denote disabled telemetry.
    // Used by README generator.
    "display_value": "{\"telemetry\":false}"
  }
```

### json_file

`Plaintext file` target. Indicates that this specific telemetry channel is controlled by setting the value in the plaintext file.

```jsonc
  "plain_file": {
    // Path object. Contains environment variable name for various OSes.
    // Allowed keys: default, linux, macos, windows
    // If there is no OS-specific key and no default - this OS is not supported.
    "path": {
      "linux": "$HOME/.foobar/config.cfg",
      "macos": "$HOME/.foobar/config.cfg",
      "windows": "%USERPROFILE%\\.foobar\\config.cfg"
    },

    // Selector of the telemetry channel control setting in the plaintext file.
    // Specify as GO regex (https://github.com/google/re2/wiki/Syntax)
    "selector": "^[ \\t]*telemetry[ \t](on|off)\s*$",

    "value": {
      // Use this value to opt-out of this telemetry channel.
      // Specify full string.
      "opt_out": "telemetry off",

      // Use this value to opt-in into this telemetry channel.
      // Specify full string.
      "opt_in": "telemetry on"
    },

    // Friendly example. Must denote disabled telemetry.
    // Used by README generator.
    "display_value": "telemetry off"
  }
```

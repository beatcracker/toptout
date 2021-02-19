# Telemetry data files

The telemetry data file is a JSON document conforming to the JSON Schema: [toptout.schema.json](../schema/toptout.schema.json). See [JSON Schema](https://json-schema.org) website for more information.

## Basic example

Describes a product that has one telemetry channel which is controlled by the environment variable.

```jsonc
{
  // Product unique ID. Use [a-z0-9-] character set. Must be unique across all files.
  "id": "foo-bar",
  // Friendly name of the product
  "name": "Foo Bar",
  // Optional. Provide executable name if presence of this product can be detected by PATH environment variable lookup.
  "executable_name": "foobar",
  // Friendly category name. The README generator uses it to group products.
  "category": "Development",

  // Short description of the collected telemetry. Usually copied from the product's documentation.
  "description": "All your base are belong to us.",
  // Links object
  "links": {
    // Link to the product's website. Mandatory.
    "main": "https://example.com",
    // Link to the product's general telemetry description. Optional.
    "telemetry": "https://example.com/telemetry",
    // Link to the product's privacy policy. Optional.
    "privacy": "https://example.com/privacy"
  },
  // Telemetry channels list. Contains name and optionally desription and opt-in/out methods.
  // Optional, since you may wish to add a product that contains telemetry but doesn't provide a way to control it.
  "telemetry": [
    {
      // Telemetry channel unique ID. Use [a-z0-9-] character set.
      // Must be unique in this list.
      "id": "usage-data",
      // Friendly name of the product
      "name": "Usage data",
      // Optional description
      "description": "Disable usage data reporting",
      // Specify, if this channel oficially supports opt-in/opt-out
      "is_official": true,
      // Optional links
      "links": {
        // Link to the specific telemetry channel description. Optional.
        "main": "https://example.com/foobar",
        // Link to the specific telemetry channel details. Optional.
        "telemetry": "https://example.com/foobar/telemetry",
        // Link to the telemetry channel privacy policy. Optional.
        "privacy": "https://example.com/foobar/privacy"
      },
      // Target object.
      // Optional, since you may wish to describe multiple telemetry channels that don't provide a ways to control them.
      "target": {
        // "Environment variable" target.
        // Set or remove environment variable.
        //
        // Environment variables are by design configured per procces.
        // There are mechanisms to configure them for every new process, but it's up to OS/shell.
        "env": {
          // Target scope. You can use multiple scopes.
          // machine - configures telemetry channel for all users of the computer
          // user    - configures telemetry channel for current user of the computer
          // process - configures telemetry channel for process only
          "scope": {
            "process": {
              // Path object. Contains environment variable name for various OSes.
              // Allowed keys: default, linux, macos, windows
              "path": {
                // Use the 'default' key if the environment variable name is the same on any OS.
                "default": "TELEMETRY_OPTOUT"
              },
              // Value object.
              "value": {
                // Set environment variable to this value to opt-out of this telemetry channel
                "opt_out": "false",
                // Set environment variable to this value to opt-in into this telemetry channel.
                // Set to 'null' value (not literal "null" string) to indicate that environment variable should not exist.
                "opt_in": null
              }
            }
          }
        }
      }
    }
  ]
}
```

## Telemetry channel targets

Product can have multiple telemetry channels. Some of them could be controlled by multiple methods. Currently supported methods are:

- [Environment variable](#environment-variable) (`env`)
- [Execute command](#execute-command) (`exec`)
- [JSON file](#json-file) (`json_file`)
- [Plaintext file](#plaintext-file) (`plain_file`)
- [Windows registry](#windows-registry) (`registry`)
- [No operation](#no-operation) (`noop`)

### Environment variable

Indicates that this specific telemetry channel is controlled by the environment variable.

```jsonc
"env": {
  // Target scope. You can use multiple scopes.
  // machine - configures telemetry channel for all users of the computer
  // user    - configures telemetry channel for current user of the computer
  // process - configures telemetry channel for process only
  "scope": {
    // Environment variables are by design configured per procces.
    // There are mechanisms to configure them for every new process, but it's up to OS/
    "process": {
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
        // Set to 'null' value (not literal "null" string) to indicate that environment variable should not exist.
        "opt_in": null
      }
    }
  }
}
```

### Execute command

Indicates that this specific telemetry channel is controlled by executing shell command.

```jsonc
"exec": {
  // Target scope. You can use multiple scopes.
  // machine - configures telemetry channel for all users of the computer
  // user    - configures telemetry channel for current user of the computer
  // process - configures telemetry channel for process only
  "scope": {
    // In this example, executing shell command will configure per-user preference
    "user": {
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
  }
}
```

### JSON file

Indicates that this specific telemetry channel is controlled by setting the value in the JSON file.

```jsonc
"json_file": {
  // Target scope. You can use multiple scopes.
  // machine - configures telemetry channel for all users of the computer
  // user    - configures telemetry channel for current user of the computer
  // process - configures telemetry channel for process only
  "scope": {
    // In this example, paths point to the per-user configuration file
    "user": {
      // Path object. Contains environment variable name for various OSes.
      // Allowed keys: default, linux, macos, windows
      // If there is no OS-specific key and no default - this OS is not supported.
      "path": {
        "linux": "$HOME/.foobar/config.json",
        "macos": "$HOME/.foobar/config.json",
        "windows": "%USERPROFILE%\\.foobar\\config.json"
      },
      // Selector of the telemetry channel control setting in the JSON object.
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
  }
}
```

### Plaintext file

Indicates that this specific telemetry channel is controlled by setting the value in the plaintext file.

```jsonc
"plain_file": {
  // Target scope. You can use multiple scopes.
  // machine - configures telemetry channel for all users of the computer
  // user    - configures telemetry channel for current user of the computer
  // process - configures telemetry channel for process only
  "scope": {
    // Scope with paths to the machine-wide configuration file
    "machine": {
      // Path object. Contains environment variable name for various OSes.
      // Allowed keys: default, linux, macos, windows
      // If there is no OS-specific key and no default - this OS is not supported.
      "path": {
        "linux": "/opt/foobar/config.cfg",
        "macos": "Applications/Foobar.app/config.cfg",
        "windows": "%ProgramFiles%\\foobar\\config.cfg"
      },
      // Selector of the telemetry channel control setting in the plaintext file.
      // Specify as GO regex (https://github.com/google/re2/wiki/Syntax)
      "selector": "^[ \\t]*telemetry[ \\t](on|off)[ \\t]*$",
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
    },
    // Scope with paths to the per-user configuration file
    "user": {
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
      "selector": "^[ \\t]*telemetry[ \\t](on|off)[ \\t]*$",
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
  }
}
```

### Windows registry

Indicates that this specific telemetry channel is controlled by setting the Windows registry keys and values.

```jsonc
"registry": {
  // Target scope. You can use multiple scopes.
  // machine - configures telemetry channel for all users of the computer
  // user    - configures telemetry channel for current user of the computer
  // process - configures telemetry channel for process only
  "scope": {
    // Scope with paths to the machine-wide configuration
    "machine": {
      // Root key. See a schema for the list of allowed values.
      "root": "HKEY_LOCAL_MACHINE",
      // Registry key path
      "path": "Software\\FooBar",
      // Registry key name
      "key": "telemetry",
      // Registry key type. See a schema for the list of allowed values.
      "type": "REG_DWORD",
      "value": {
        // Use this value to opt-out of this telemetry channel.
        "opt_out": "0",
        // Use this value to opt-in into this telemetry channel.
        "opt_in": "1"
      },
    }
  }
}
```

### No operation

Indicates that user should visit an external link to get details about configuring this telemetry channel. Use this for links to third-party telemetry configuration tools, that are not officially supported.

```jsonc
"noop": [
  {
    "name": "Disable FooBar telemetry",
    "description": "This unoffical patch disables telemetry in FooBar app.",
    "link": "https://example.com/foobar-telemetry-patch"
  },
  {
    "name": "Block FooBar telemetry hosts",
    "description": "This hosts file will block FooBar app telemetry endpoints.",
    "link": "https://example.com/foobar-telemetry-hosts"
  }
]
```

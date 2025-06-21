# `easycmd.nvim`

A basic easy interface for running commands.

1. [Installation](#installation)
2. [Usage](#usage)
3. [Configuration](#configuration)
4. [Planned Features](#planned-features)
5. [References](#references)

## Installation

### Lazy

#### Stable

```lua
return {
    'evictedcucumber/easycmd.nvim',
    cmd = 'EasyCmd'
}
```

#### Unstable

```lua
return {
    'evictedcucumber/easycmd.nvim',
    branch = 'unstable',
    cmd = 'EasyCmd'
}
```

## Usage

All terms can be closed by pressing the default bind `q` when inside the window or setting a custom key in the `window.close_key`.

### Edit Command

To edit a command run the below command replacing `<index>` with a number such as `1`.

```
:EasyCmd edit <index>
```

### Run Command

To run a command again provide a vaild index at `<index>`. Will default to running in a floating window.

```
:EasyCmd run <index>
```

Can change different window modes.

#### Floating

```
:EasyCmd run <index> float
```

#### Tab

```
:EasyCmd run <index> tab
```

#### Horizontal Split

```
:EasyCmd run <index> hsplit
```

#### Vertical Split

```
:EasyCmd run <index> vsplit
```

### List Command

To list all current commands and their indices run the following.

```
:EasyCmd list
```

## Configuration

The following is the default configuration. You do not need to copy this exactly for the plugin to work.
For detailed configuration options see [Configuration](./docs/Configuration.md)

```lua
---@type easycmd.Config
opts = {
    window = {
        close_key = 'q',
        default_type = 'float',
    },
    run = {
        window = {
            default_type = 'float',
        },
    },
    edit = {
        window = {
            default_type = 'float',
        },
    },
}
```

## Planned features
- Interactive terminal window
- Preserve cmd output to view after closing window

## References

Inspiration from [@ej-shafran](https://github.com/ej-shafran)'s [compile-mode.nvim](https://github.com/ej-shafran/compile-mode.nvim) plugin.

How to write a plugin from scratch from [@tjdevries](https://github.com/tjdevries)'s:
- YouTube video: [https://www.youtube.com/watch?v=VGid4aN25iI](https://www.youtube.com/watch?v=VGid4aN25iI)
- Github repo: [https://github.com/tjdevries/present.nvim](https://github.com/tjdevries/present.nvim/tree/master)

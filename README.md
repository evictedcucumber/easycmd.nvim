# `easycmd.nvim`

A basic easy interface for running commands.

1. [Installation](#Installation)
2. [Usage](#Usage)
3. [Configuration](#Configuration)
4. [Planned Features](#Planned Features)
5. [References](#References)


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

To run a command again provide a vaild index at `<index>`.

```
:EasyCmd run <index>
```

### List Command

To list all current commands and their indices run the following.

```
:EasyCmd list
```

## Configuration

The following is the default configuration. You do not need to copy this exactly for the plugin to work.

```lua
{
    window = {
        close_key = 'q',
    },
}
```

## Planned features
- Interactive terminal window
- Store commands per path similar to [Harpoon](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)

## References

Inspiration from [@ej-shafran](https://github.com/ej-shafran)'s [compile-mode.nvim](https://github.com/ej-shafran/compile-mode.nvim) plugin.

How to write a plugin from scratch from [@tjdevries](https://github.com/tjdevries)'s:
- YouTube video: [https://www.youtube.com/watch?v=VGid4aN25iI](https://www.youtube.com/watch?v=VGid4aN25iI)
- Github repo: [https://github.com/tjdevries/present.nvim](https://github.com/tjdevries/present.nvim/tree/master)

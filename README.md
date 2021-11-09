# Terminal integration for [xplr](https://xplr.dev)
---------------------------------------------------

[![alacritty-xplr.gif](https://s9.gifyu.com/images/alacritty-xplr.gif)](https://gifyu.com/image/GJGU)

> **TIP:** Use it with [xclip.xplr](https://github.com/sayanarijit/xclip.xplr) for better copy-paste experience.


## Requirements

- [Kitty](https://github.com/kovidgoyal/kitty) (recommended), [Alacritty](https://github.com/alacritty/alacritty) or any other terminal capable of launching programs


## Installation

- Add the following line in `~/.config/xplr/init.lua`

  ```lua
  package.path = os.getenv("HOME") .. '/.config/xplr/plugins/?/src/init.lua'
  ```

- Clone the plugin

  ```bash
  mkdir -p ~/.config/xplr/plugins

  git clone https://github.com/igorepst/term.xplr ~/.config/xplr/plugins/term
  ```

- Require the module in `~/.config/xplr/init.lua`

  ```lua
  require("term").setup()
  
  -- Or
  
  local term = require('term')
  local k_hsplit = term.profile_kitty_hsplit()
  k_hsplit.key = 'ctrl-h'
  term.setup({term.profile_kitty_vsplit(), k_hsplit})

  -- Or

  require('term').setup({{
    mode = 'default',
    key = 'ctrl-n',
    send_focus = true,
    send_selection = false,
    exe = 'kitty',
    extra_term_args = '@launch --no-response --location=vsplit',
    extra_xplr_args = '',
  }})


  ```

## Profiles
The plugin supports passing multiple profiles, each represented by a Lua table.<br/>
Each profile may have the following keys:

- mode: xplr mode
- key: keybinding to launch profile
- exe: terminal's executable
- exe_launch: terminal's way to launch external program (xplr)
- extra_term_args: extra arguments for the terminal
- extra_xplr_args: extra arguments for xplr
- send_focus: whether to send focus to xplr
- send_selection: whether to send selection to xplr
- prof_name: profile name to show in xplr Help panel


## Built-in profiles
- Default: does not define any terminal, may be used as a base profile. `profile_default()`
- Kitty with vertical split `profile_kitty_vsplit()`
- Kitty with horizontal split `profile_kitty_hsplit()`
- Alacritty `profile_alacritty()`
- Xterm `profile_xterm()`

## Features
- Send current focus to the new session.
- Send current selection to the new session.
- Send active sorters and filters to the new session.

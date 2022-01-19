# Terminal integration for [xplr](https://xplr.dev)
---------------------------------------------------



https://user-images.githubusercontent.com/1630792/141186127-6cabda77-2a03-4fa7-a07f-098a826017c5.mp4




> **TIP:** Use it with [xclip.xplr](https://github.com/sayanarijit/xclip.xplr) for better copy-paste experience.

## Requirements

- [Kitty](https://github.com/kovidgoyal/kitty) (recommended), [tmux](https://github.com/tmux/tmux), [Alacritty](https://github.com/alacritty/alacritty), [wezterm](https://github.com/wez/wezterm) or any other terminal / multiplexer capable of launching programs

## Installation

### Install manually

- Add the following line in `~/.config/xplr/init.lua`

  ```lua
  local home = os.getenv("HOME")
  package.path = home
  .. "/.config/xplr/plugins/?/init.lua;"
  .. home
  .. "/.config/xplr/plugins/?.lua;"
  .. package.path
  ```

- Clone the plugin

  ```bash
  mkdir -p ~/.config/xplr/plugins

  git clone https://github.com/igorepst/term.xplr ~/.config/xplr/plugins/term
  ```

- Require the module in `~/.config/xplr/init.lua`

  ```lua
  require("alacritty").setup()

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

- mode: `xplr` mode
- key: keybinding to launch profile
- exe: terminal's executable
- exe_launch: terminal's way to launch external program (`xplr`)
- extra_term_args: extra arguments for the terminal
- extra_xplr_args: extra arguments for `xplr`
- send_focus: whether to send focus to `xplr`
- send_selection: whether to send selection to `xplr`
- prof_name: profile name to show in `xplr` Help panel

## Built-in profiles
- Default: does not define any terminal, may be used as a base profile. `profile_default()`
- `kitty` with vertical split `profile_kitty_vsplit()`
- `kitty` with horizontal split `profile_kitty_hsplit()`
- `tmux` with vertical split `profile_tmux_vsplit()`
- `tmux` with horizontal split `profile_tmux_hsplit()`
- `Alacritty` `profile_alacritty()`
- `xterm` `profile_xterm()`
- `wezterm` with `profile_wezterm()`
- `wezterm` with tab `profile_wezterm_tab()`
- `wezterm` with vsplit `profile_wezterm_vsplit()`
- `wezterm` with hsplit `profile_wezterm_hsplit()`

## Features
- Send current focus to the new session.
- Send current selection to the new session.
- Send active sorters and filters to the new session.

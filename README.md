[![alacritty-xplr.gif](https://s9.gifyu.com/images/alacritty-xplr.gif)](https://gifyu.com/image/GJGU)

> **TIP:** Use it with [xclip.xplr](https://github.com/sayanarijit/xclip.xplr) for better copy-paste experience.


Requirements
------------

- [Kitty](https://github.com/kovidgoyal/kitty) (recommended), [Alacritty](https://github.com/alacritty/alacritty) or any other terminal capable of launching programs


Installation
------------

### Install manually

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
  
  require("term").setup{
    mode = "default",
    key = "ctrl-n",
    send_focus = true,
    send_selection = true,
    extra_term_args = "",
    extra_xplr_args = "",
  }

  -- Or

  require('term').setup{
    mode = 'default',
    key = 'ctrl-n',
    send_focus = true,
    send_selection = false,
    exe = 'kitty',
    extra_term_args = '@launch --no-response --location=vsplit',
    extra_xplr_args = '',
  }


  -- Press `ctrl-n` to spawn a new terminal window
  ```


Features
--------

- Send current focus to the new session.
- Send current selection to the new session.
- Send active sorters and filters to the new session.

local term = {}

local function quote(str)
  return "'" .. string.gsub(str, "'", [['"'"']]) .. "'"
end

term.profile_default = function()
  return {
    mode = "default",
    key = "ctrl-n",
    extra_term_args = "",
    extra_xplr_args = "",
    send_focus = true,
    send_selection = false,
    prof_name = "default",
  }
end

term.profile_kitty_vsplit = function()
  local def = term.profile_default()
  def.exe = "kitty"
  def.extra_term_args = "@launch --no-response --location=vsplit"
  def.prof_name = "kitty vsplit"
  return def
end

term.profile_kitty_hsplit = function()
  local def = term.profile_default()
  def.exe = "kitty"
  def.extra_term_args = "@launch --no-response --location=hsplit"
  def.prof_name = "kitty hsplit"
  return def
end

term.profile_alacritty = function()
  local def = term.profile_default()
  def.exe = "alacritty"
  def.exe_launch = "--command"
  def.prof_name = "alacritty"
  return def
end

term.profile_xterm = function()
  local def = term.profile_default()
  def.exe = "xterm"
  def.exe_launch = "-e"
  def.prof_name = "xterm"
  return def
end

term.profile_tmux_vsplit = function()
  local def = term.profile_default()
  def.exe = "tmux"
  def.extra_term_args = "split-window -v"
  def.prof_name = "tmux vsplit"
  return def
end

term.profile_tmux_hsplit = function()
  local def = term.profile_default()
  def.exe = "tmux"
  def.extra_term_args = "split-window -h"
  def.prof_name = "tmux hsplit"
  return def
end

term.profile_wezterm = function()
  local def = term.profile_default()
  def.exe = "wezterm"
  def.extra_term_args = "cli spawn --new-window --"
  def.prof_name = "wezterm window"
  return def
end

term.profile_wezterm_tab = function()
  local def = term.profile_default()
  def.exe = "wezterm"
  def.extra_term_args = "cli spawn --"
  def.prof_name = "wezterm tab"
  return def
end

term.profile_wezterm_vsplit = function()
  local def = term.profile_default()
  def.exe = "wezterm"
  def.extra_term_args = "cli split-pane --"
  def.prof_name = "wezterm vsplit"
  return def
end

term.profile_wezterm_hsplit = function()
  local def = term.profile_default()
  def.exe = "wezterm"
  def.extra_term_args = "cli split-pane --horizontal --"
  def.prof_name = "wezterm hsplit"
  return def
end

local common_f = function(app, args)
  local cmd = args.exe .. " "
  if args.extra_term_args then
    cmd = cmd .. args.extra_term_args .. " "
  end
  if args.exe_launch then
    cmd = cmd .. args.exe_launch .. " "
  end

  cmd = cmd .. "xplr --on-load ClearNodeFilters ClearNodeSorters"

  for _, x in ipairs(app.explorer_config.filters) do
    cmd = cmd
      .. [[ 'AddNodeFilter: { filter: "]]
      .. x.filter
      .. [[", input: "]]
      .. x.input
      .. [[" }']]
  end

  for _, x in ipairs(app.explorer_config.sorters) do
    cmd = cmd
      .. [[ 'AddNodeSorter: { sorter: "]]
      .. x.sorter
      .. [[", reverse: ]]
      .. tostring(x.reverse)
      .. [[ }']]
  end

  cmd = cmd .. " ExplorePwd"

  cmd = cmd .. " " .. args.extra_xplr_args

  if args.send_focus and app.focused_node then
    cmd = cmd .. [[ --force-focus -- ]] .. quote(app.focused_node.absolute_path)
  else
    cmd = cmd .. [[ -- ]] .. quote(app.pwd) .. [[]]
  end

  if args.send_selection then
    for _, node in ipairs(app.selection) do
      cmd = cmd .. " " .. quote(node.absolute_path)
    end
  end

  cmd = cmd .. " &"

  os.execute(cmd)
end

term.setup = function(args)
  local terms = {}
  args = args or {}
  for _, v in pairs(args) do
    if type(v) == "table" then
      local d = term.profile_default()
      for k1, v1 in pairs(v) do
        d[k1] = v1
      end
      table.insert(terms, d)
    end
  end
  if #terms == 0 then
    table.insert(terms, term.profile_xterm())
  end

  ---@diagnostic disable
  local xplr = xplr
  ---@diagnostic enable
  for k, v in pairs(terms) do
    xplr.fn.custom["term_spawn_window_" .. k] = function(app)
      common_f(app, v)
    end
    local messages = {
      { CallLua = "custom.term_spawn_window_" .. k },
      "PopMode",
    }
    if v.send_selection then
      table.insert(messages, "ClearSelection")
    end
    local help_msg = v.prof_name or k
    xplr.config.modes.builtin[v.mode].key_bindings.on_key[v.key] = {
      help = "session " .. help_msg,
      messages = messages,
    }
  end
end

return term

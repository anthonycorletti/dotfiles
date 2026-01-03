local theme = {}

local function read_ghostty_config()
  local config_path = os.getenv("HOME") .. "/.config/ghostty/config"
  local theme_name
  for line in io.lines(config_path) do
    local name = line:match("^theme%s*=%s*(.+)")
    if name then
      theme_name = name:gsub("\\ ", " ") -- Handle escaped spaces
      break
    end
  end
  assert(theme_name, "Theme name not found in ghostty config")
  return theme_name
end

local function parse_ghostty_theme_file(theme_name)
  local handle = io.popen("ghostty +list-themes --plain --path | head -n 1 | awk '{print $3}'")
  local themes_dir = handle:read("*a"):gsub("\n", "")
  handle:close()
  local theme_path = themes_dir:gsub("/[^/]*$", "") .. "/" .. theme_name
  local palette = {}
  local mapping = {
    [0]  = "black",
    [1]  = "red",
    [2]  = "green",
    [3]  = "yellow",
    [4]  = "blue",
    [5]  = "magenta",
    [6]  = "cyan",
    [7]  = "white",
    [8]  = "br_black",
    [9]  = "br_red",
    [10] = "br_green",
    [11] = "br_yellow",
    [12] = "br_blue",
    [13] = "br_magenta",
    [14] = "br_cyan",
    [15] = "br_white",
  }

  for line in io.lines(theme_path) do
    local idx, color = line:match("^palette%s*=%s*(%d+)%s*=%s*(#%x+)")
    if idx and color then
      local key = mapping[tonumber(idx)]
      if key then palette[key] = color end
    end

    local k, v = line:match("^(%S+)%s*=%s*(#%x+)")
    if k == "background" then palette.bg = v end
    if k == "foreground" then palette.fg = v end
    if k == "cursor-color" then palette.cursor = v end
    if k == "cursor-text" then palette.cursor_txt = v end
    if k == "selection-background" then palette.sel_bg = v end
    if k == "selection-foreground" then palette.sel_fg = v end
  end

  return palette
end

-- Helper to apply highlight
local function hi(group, fg, bg, style)
  vim.api.nvim_set_hl(0, group, {
    fg = fg and fg or nil,
    bg = bg and bg or nil,
    italic = style == 'italic',
    bold = style == 'bold',
    underline = style == 'underline'
  })
end

-- Apply highlights
function theme.set()
  -- Reload the palette from config
  local ok, theme_name = pcall(read_ghostty_config)
  if not ok then
    vim.notify("Failed to read Ghostty config: " .. tostring(theme_name), vim.log.levels.ERROR)
    return
  end

  local ok2, palette = pcall(parse_ghostty_theme_file, theme_name)
  if not ok2 then
    vim.notify("Failed to parse Ghostty theme: " .. tostring(palette), vim.log.levels.ERROR)
    return
  end

  theme.palette = palette
  local c = theme.palette

  vim.cmd("highlight clear")
  vim.o.background = "dark"
  vim.o.termguicolors = true

  vim.o.fillchars = "eob: "

  -- Basic UI
  hi("Normal",       c.fg, c.bg)
  hi("Cursor",       c.cursor, c.cursor_txt)
  hi("CursorLine",   nil, "#333844")
  hi("CursorColumn", nil, "#333844")
  hi("ColorColumn",  nil, "#3b3f49")
  hi("LineNr",       c.br_black, nil)
  hi("CursorLineNr", c.yellow, nil, "bold")
  hi("VertSplit",    c.br_black, nil)
  hi("Visual",       c.sel_fg, c.sel_bg)
  hi("Search",       c.bg, c.yellow)
  hi("IncSearch",    c.bg, c.red)
  hi("StatusLine",   c.black, c.white)
  hi("StatusLineNC", c.br_black, c.bg)

  -- This is the new highlight group for fillchars
  hi("Whitespace", c.bg, c.bg)

  -- Syntax highlighting
  hi("Comment",      c.br_black, nil, "italic")
  hi("Constant",     c.cyan)
  hi("String",       c.green)
  hi("Character",    c.green)
  hi("Number",       c.magenta)
  hi("Boolean",      c.red)
  hi("Identifier",   c.br_blue)
  hi("Function",     c.blue)
  hi("Statement",    c.red)
  hi("Conditional",  c.yellow)
  hi("Repeat",       c.yellow)
  hi("Operator",     c.fg)
  hi("Keyword",      c.magenta)
  hi("Exception",    c.red)
  hi("PreProc",      c.br_magenta)
  hi("Include",      c.cyan)
  hi("Define",       c.cyan)
  hi("Type",         c.yellow)
  hi("Structure",    c.yellow)
  hi("Special",      c.br_cyan)
  hi("Underlined",   c.blue, nil, "underline")
  hi("Todo",         c.yellow, c.bg, "bold")

  -- Diffs
  hi("DiffAdd",      c.green, "#2e3b2e")
  hi("DiffChange",   c.yellow, "#3b3b2e")
  hi("DiffDelete",   c.red, "#3b2e2e")
  hi("DiffText",     c.br_blue, "#2e3b3b")

  hi("CursorWord", nil, "#444444")
  hi("LspReferenceText", nil, "#444444")
  hi("LspReferenceRead", nil, "#444444")
  hi("LspReferenceWrite", nil, "#444444")
  hi("MatchParen", nil, "#444444")
  hi("WinSeparator", c.br_black, c.bg)

  -- Diagnostic (LSP)
  hi("DiagnosticError", c.red)
  hi("DiagnosticWarn",  c.yellow)
  hi("DiagnosticInfo",  c.blue)
  hi("DiagnosticHint",  c.cyan)

  -- Git
  hi("GitSignsAdd",    c.green)
  hi("GitSignsChange", c.yellow)
  hi("GitSignsDelete", c.red)

  -- Telescope
  hi("TelescopeBorder",       c.br_black, c.bg)
  hi("TelescopePromptBorder", c.blue, c.bg)
  hi("TelescopePromptTitle",  c.bg, c.blue)
  hi("TelescopePromptNormal", c.fg, c.bg)
  hi("TelescopeResultsTitle", c.bg, c.green)
  hi("TelescopePreviewTitle", c.bg, c.magenta)
  hi("TelescopeMatching",     c.yellow)

  hi("NormalFloat", c.fg, c.bg)
  hi("FloatBorder", c.br_black, c.bg)

  -- bufferline - Match terminal background
  hi("BufferLineFill", nil, c.bg)
  hi("BufferLineOffsetSeparator", c.bg, c.bg)
end

-- Set up file watcher using timer-based polling
function theme.setup_auto_reload()
  local config_path = vim.fn.expand("~/.config/ghostty/config")
  local uv = vim.uv or vim.loop

  -- Store the last known theme and modification time
  local last_theme = nil
  local last_mtime = nil

  -- Function to check if theme has changed
  local function check_for_changes()
    local stat = uv.fs_stat(config_path)
    if not stat then
      return
    end

    -- Check if file has been modified
    local current_mtime = stat.mtime.sec
    if last_mtime and current_mtime == last_mtime then
      return -- No changes
    end

    last_mtime = current_mtime

    -- Read the current theme from config
    local ok, current_theme = pcall(read_ghostty_config)
    if not ok then
      return
    end

    -- If theme has changed, reload
    if last_theme ~= current_theme then
      last_theme = current_theme

      vim.schedule(function()
        local success, err = pcall(theme.set)
        if success then
          vim.notify("Ghostty theme reloaded: " .. current_theme, vim.log.levels.INFO)
        else
          vim.notify("Failed to reload Ghostty theme: " .. tostring(err), vim.log.levels.ERROR)
        end
      end)
    end
  end

  -- Initialize with current theme
  pcall(function()
    last_theme = read_ghostty_config()
    local stat = uv.fs_stat(config_path)
    if stat then
      last_mtime = stat.mtime.sec
    end
  end)

  -- Set up timer to poll every 2 seconds
  local timer = uv.new_timer()
  timer:start(2000, 2000, function()
    vim.schedule(check_for_changes)
  end)

  -- Clean up on VimLeave
  vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
      if timer then
        timer:stop()
        timer:close()
      end
    end
  })

  vim.notify("Ghostty theme auto-reload enabled (polling every 2s)", vim.log.levels.INFO)
end

-- Initialize palette on first load
local ok, theme_name = pcall(read_ghostty_config)
if ok then
  local ok2, palette = pcall(parse_ghostty_theme_file, theme_name)
  if ok2 then
    theme.palette = palette
  end
end

return theme

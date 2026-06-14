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
  hi("Normal",        c.fg,      c.bg)
  hi("Cursor",        c.cursor_txt, c.cursor)
  hi("CursorLine",    nil,       "#2c313a")  -- slightly lifted from bg
  hi("CursorColumn",  nil,       "#2c313a")
  hi("ColorColumn",   nil,       "#2c313a")
  hi("LineNr",        c.br_black)            -- #666666, muted
  hi("CursorLineNr",  c.yellow)              -- #f0c674, warm gold
  hi("VertSplit",     c.black)               -- #1d1f21, near invisible
  hi("WinSeparator",  c.black,   c.bg)
  hi("Visual",        c.sel_fg,  c.sel_bg)   -- white on white = inverted
  hi("Search",        c.bg,      c.yellow)
  hi("IncSearch",     c.bg,      c.br_yellow)
  hi("MatchParen",    nil,       "#3e4451")
  hi("Whitespace",    c.bg,      c.bg)
  hi("NormalFloat",   c.fg,      "#21252b")  -- slightly darker than bg
  hi("FloatBorder",   c.br_black, "#21252b")

  -- Statusline — fix the gray bar issue
  hi("StatusLine",    c.fg,      "#21252b")  -- dark bg, not gray
  hi("StatusLineNC",  c.br_black, "#1d1f21")

  -- Syntax — this palette is warm/muted so lean into it
  hi("Comment",       c.br_black, nil, { italic=true })  -- #666666
  hi("Constant",      c.cyan)        -- #8abeb7, teal
  hi("String",        c.green)       -- #b6bd68, olive green
  hi("Character",     c.green)
  hi("Number",        c.br_yellow)   -- #e7c547, brighter gold
  hi("Boolean",       c.red)         -- #cc6566
  hi("Float",         c.br_yellow)
  hi("Identifier",    c.br_blue)     -- #7aa6da, steel blue
  hi("Function",      c.blue)        -- #82a2be, muted blue
  hi("Statement",     c.red)         -- #cc6566
  hi("Conditional",   c.magenta)     -- #b294bb, purple (not yellow — avoids collision with types)
  hi("Repeat",        c.magenta)
  hi("Operator",      c.fg)
  hi("Keyword",       c.red)         -- #cc6566, matches statement
  hi("Exception",     c.br_red)      -- #d54e53, brighter for emphasis
  hi("PreProc",       c.br_magenta)  -- #c397d8
  hi("Include",       c.br_blue)     -- #7aa6da
  hi("Define",        c.br_blue)
  hi("Type",          c.yellow)      -- #f0c674, warm gold
  hi("Structure",     c.yellow)
  hi("Typedef",       c.yellow)
  hi("Special",       c.br_cyan)     -- #70c0b1
  hi("Underlined",    c.blue, nil,   { underline=true })
  hi("Todo",          c.bg, c.yellow, { bold=true })

  -- Diffs
  hi("DiffAdd",       c.green,    "#1e2a1e")
  hi("DiffChange",    c.yellow,   "#2a2a1e")
  hi("DiffDelete",    c.red,      "#2a1e1e")
  hi("DiffText",      c.br_blue,  "#1e2a2a")

  -- LSP
  hi("DiagnosticError",   c.br_red)
  hi("DiagnosticWarn",    c.yellow)
  hi("DiagnosticInfo",    c.blue)
  hi("DiagnosticHint",    c.cyan)
  hi("LspReferenceText",  nil, "#3e4451")
  hi("LspReferenceRead",  nil, "#3e4451")
  hi("LspReferenceWrite", nil, "#3e4451")

  -- Git
  hi("GitSignsAdd",    c.green)
  hi("GitSignsChange", c.yellow)
  hi("GitSignsDelete", c.red)

  -- Bufferline
  hi("BufferLineFill",            nil,  "#21252b")
  hi("BufferLineOffsetSeparator", "#21252b", "#21252b")
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

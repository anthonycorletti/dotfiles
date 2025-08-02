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

theme.palette = parse_ghostty_theme_file(read_ghostty_config())
local c = theme.palette

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

  hi("CursorWord", nil, "#444444")           -- dim gray background, no fg override
  hi("LspReferenceText", nil, "#444444")     -- LSP reference highlight
  hi("LspReferenceRead", nil, "#444444")
  hi("LspReferenceWrite", nil, "#444444")
  hi("MatchParen", nil, "#444444")            -- match parens highlight
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

  -- Neo-tree highlights
  hi("NeoTreeNormal",        c.fg, c.bg)
  hi("NeoTreeNormalNC",      c.fg, c.bg)
  hi("NeoTreeWinSeparator",  c.br_black, c.bg)
  hi("NeoTreeCursorLine",    nil, "#333844")
  hi("NeoTreeDirectoryName", c.blue)
  hi("NeoTreeDirectoryIcon", c.cyan)
  hi("NeoTreeFileName",      c.fg)
  hi("NeoTreeFileIcon",      c.white)
  hi("NeoTreeSymbolicLinkTarget", c.magenta)
  hi("NeoTreeGitModified",   c.yellow)
  hi("NeoTreeGitUntracked",  c.green)
  hi("NeoTreeGitAdded",      c.green)
  hi("NeoTreeGitDeleted",    c.red)
  hi("NeoTreeGitConflict",   c.red)

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

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "ghostty",
  callback = function()
    require("ghostty").set()
  end,
})

return theme

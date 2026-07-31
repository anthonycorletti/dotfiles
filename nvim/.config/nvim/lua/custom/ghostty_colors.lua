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
    [0] = "black",
    [1] = "red",
    [2] = "green",
    [3] = "yellow",
    [4] = "blue",
    [5] = "magenta",
    [6] = "cyan",
    [7] = "white",
    [8] = "br_black",
    [9] = "br_red",
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
      if key then
        palette[key] = color
      end
    end

    local k, v = line:match("^(%S+)%s*=%s*(#%x+)")
    if k == "background" then
      palette.bg = v
    end
    if k == "foreground" then
      palette.fg = v
    end
    if k == "cursor-color" then
      palette.cursor = v
    end
    if k == "cursor-text" then
      palette.cursor_txt = v
    end
    if k == "selection-background" then
      palette.sel_bg = v
    end
    if k == "selection-foreground" then
      palette.sel_fg = v
    end
  end

  return palette
end

-- Helper to apply highlight
local function hi(group, fg, bg, style)
  vim.api.nvim_set_hl(0, group, {
    fg = fg and fg or nil,
    bg = bg and bg or nil,
    italic = style == "italic",
    bold = style == "bold",
    underline = style == "underline",
  })
end

local function adjust_hex(hex, amount)
  hex = hex:gsub("#", "")

  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)

  local function clamp(x)
    return math.max(0, math.min(255, x))
  end

  local function shift(c)
    if amount > 0 then
      return c + (255 - c) * amount
    else
      return c * (1 + amount)
    end
  end

  r = clamp(shift(r))
  g = clamp(shift(g))
  b = clamp(shift(b))

  return string.format("#%02x%02x%02x", r, g, b)
end

local function is_dark(hex)
  hex = hex:gsub("#", "")
  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)
  return (0.299 * r + 0.587 * g + 0.114 * b) < 128
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

  local dir = is_dark(c.bg) and 1 or -1
  local subtle = adjust_hex(c.bg, 0.10 * dir) -- word/reference highlights
  local subtler = adjust_hex(c.bg, 0.06 * dir) -- cursorline

  vim.cmd("highlight clear")
  vim.o.background = "dark"
  vim.o.termguicolors = true

  vim.o.fillchars = "eob: "

  -- Basic UI
  hi("Normal", c.fg, c.bg)
  hi("Cursor", c.cursor_txt, c.cursor)
  hi("CursorLine", nil, subtler)
  hi("CursorColumn", nil, subtler)
  hi("ColorColumn", nil, subtler)
  hi("LineNr", c.br_black) -- #666666, muted
  hi("CursorLineNr", c.yellow) -- #f0c674, warm gold
  hi("VertSplit", c.black) -- #1d1f21, near invisible
  hi("WinSeparator", c.black, c.bg)
  hi("Visual", c.sel_fg, c.sel_bg) -- white on white = inverted
  hi("Search", c.bg, c.yellow)
  hi("IncSearch", c.bg, c.br_yellow)
  hi("MatchParen", nil, subtle)
  hi("Whitespace", c.bg, c.bg)
  hi("NormalFloat", c.fg, c.bg)
  hi("FloatBorder", c.br_black, c.bg)
  hi("NormalNC", nil, c.bg)

  -- Statusline — fix the gray bar issue
  hi("StatusLine", c.fg, c.black) -- dark bg, not gray
  hi("StatusLineNC", c.br_black, c.bg)

  -- Syntax — this palette is warm/muted so lean into it
  hi("Comment", c.br_black, nil, { italic = true }) -- #666666
  hi("Constant", c.cyan) -- #8abeb7, teal
  hi("String", c.green) -- #b6bd68, olive green
  hi("Character", c.green)
  hi("Number", c.br_yellow) -- #e7c547, brighter gold
  hi("Boolean", c.red) -- #cc6566
  hi("Float", c.br_yellow)
  hi("Identifier", c.br_blue) -- #7aa6da, steel blue
  hi("Function", c.blue) -- #82a2be, muted blue
  hi("Statement", c.red) -- #cc6566
  hi("Conditional", c.magenta) -- #b294bb, purple (not yellow — avoids collision with types)
  hi("Repeat", c.magenta)
  hi("Operator", c.fg)
  hi("Keyword", c.red) -- #cc6566, matches statement
  hi("Exception", c.br_red) -- #d54e53, brighter for emphasis
  hi("PreProc", c.br_magenta) -- #c397d8
  hi("Include", c.br_blue) -- #7aa6da
  hi("Define", c.br_blue)
  hi("Type", c.yellow) -- #f0c674, warm gold
  hi("Structure", c.yellow)
  hi("Typedef", c.yellow)
  hi("Special", c.br_cyan) -- #70c0b1
  hi("Underlined", c.blue, nil, { underline = true })
  hi("Todo", c.bg, c.yellow, { bold = true })

  -- Diffs
  hi("DiffAdd", c.br_green, c.green)
  hi("DiffChange", c.br_yellow, c.yellow)
  hi("DiffDelete", c.br_red, c.red)
  hi("DiffText", c.br_blue, c.blue)

  -- LSP
  hi("DiagnosticError", c.br_red)
  hi("DiagnosticWarn", c.yellow)
  hi("DiagnosticInfo", c.blue)
  hi("DiagnosticHint", c.cyan)
  hi("LspReferenceText", nil, subtle)
  hi("LspReferenceRead", nil, subtle)
  hi("LspReferenceWrite", nil, subtle)

  -- Git
  hi("GitSignsAdd", c.green)
  hi("GitSignsChange", c.yellow)
  hi("GitSignsDelete", c.red)

  -- Bufferline
  hi("BufferLineFill", nil, c.bg)
  hi("BufferLineBackground", c.br_black, c.bg)
  hi("BufferLineBuffer", c.fg, c.bg)
  hi("BufferLineBufferVisible", c.fg, c.bg)
  hi("BufferLineSeparator", c.bg, c.bg)
  hi("BufferLineSeparatorVisible", c.bg, c.bg)

  -- snacks
  hi("SnacksExplorerNormal", nil, c.bg)
  hi("SnacksExplorerBorder", c.br_black, c.bg)
  hi("SnacksExplorerTitle", c.fg, c.bg)
  hi("SnacksPicker", c.fg, c.bg)
  hi("SnacksPickerBorder", c.br_black, c.bg)
  hi("SnacksPickerBox", nil, c.bg)
  hi("SnacksPickerInput", c.fg, c.bg)
  hi("SnacksPickerPreview", nil, c.bg)
  hi("SnacksPickerList", nil, c.bg)
  hi("SnacksPickerTitle", c.fg, c.bg)
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

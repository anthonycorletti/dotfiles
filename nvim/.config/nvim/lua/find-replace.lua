local mod = {}
local cmd = vim.cmd

function mod.find_replace()
  -- Get the current search pattern (what you've searched with "/")
  local search_pattern = vim.fn.getreg("/")

  -- Remove any escape characters from the search pattern for display
  local display_pattern = search_pattern:gsub("\\", "")

  -- Prompt user for replacement string
  local replace_with = vim.fn.input('Replace "' .. display_pattern .. '" with: ')

  -- If user cancels (presses Esc), abort
  if replace_with == "" then
    print("Find and replace aborted")
    cmd("let @/ = ''")
    return
  end

  -- Ask if user wants to confirm each replacement
  local confirm = vim.fn.input("Confirm each replacement? (y/N): ")
  local confirm_flag = confirm:lower() == "y" and "c" or ""

  -- Determine range (whole file by default)
  local range = "%"

  -- Execute the substitute command
  local sub_cmd = string.format("%ss/%s/%s/g%s", range, search_pattern, replace_with:gsub("/", "\\/"), confirm_flag)
  cmd(sub_cmd)

  -- Keep the original search pattern highlighted
  cmd("let @/ = '" .. search_pattern:gsub("'", "\\'") .. "'")

  -- Report how many substitutions were made
  local changes = vim.fn.searchcount({ recompute = 1 }).total
  print("Made " .. changes .. " replacements")
  cmd("let @/ = ''")
end

function mod.setup()
  vim.api.nvim_create_user_command(
    "FindReplace",
    mod.find_replace,
    { desc = "Find and replace current search pattern" }
  )
end

return mod

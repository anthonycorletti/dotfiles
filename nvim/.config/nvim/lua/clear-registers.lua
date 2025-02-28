local mod = {}

function mod.clear_registers()
  -- Define the registers seen in `:registers`
  local registers = '0123456789abcdefghijklmnopqrstuvwxyz-"*+'

  -- Clear each register
  for i = 1, #registers do
    local reg = registers:sub(i, i)
    vim.fn.setreg(reg, "")
  end

  print("Cleared all writeable registers")
end

return mod

local status, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then
  print("colorscheme not found")
  return
end

local status, lualine = pcall(require, "lualine")
if not status then
  return
end

local lualine_nightfly = require('lualine.themes.nightfly')

local new_colors = {
  blue = "#65D1FF",
  green = "#3EFFDC",
  violet = "#FF61EF",
  yellow = "#FFDA7B",
  black = "#000000"
}

lualine.setup()

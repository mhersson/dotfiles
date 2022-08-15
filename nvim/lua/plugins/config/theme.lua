local status_ok, onedarkpro = pcall(require, "onedarkpro")
if not status_ok then return end


onedarkpro.setup({
  -- -- The theme function can be overwritten with a string value for the theme
  theme = function()
    if vim.o.background == "dark" then
      return "onedark"
    else
      return "onelight"
    end
  end,
  -- colors = {}, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
  -- hlgroups = {}, -- Override default highlight groups
  -- filetype_hlgroups = {}, -- Override default highlight groups for specific filetypes
  -- plugins = { -- Override which plugins highlight groups are loaded
  --     -- NOTE: Plugins have been omitted for brevity - Please see the plugins section of the README
  -- },
  -- theme = "onedark",
  styles = { -- Choose from "bold,italic,underline"
    strings = "NONE", -- Style that is applied to strings.
    comments = "italic", -- Style that is applied to comments
    keywords = "italic", -- Style that is applied to keywords
    functions = "bold,italic", -- Style that is applied to functions,
    variables = "NONE", -- Style that is applied to variables
    virtual_text = "NONE", -- Style that is applied to virtual text
  },
  options = {
    bold = true, -- Use the themes opinionated bold styles?
    italic = true, -- Use the themes opinionated italic styles?
    underline = true, -- Use the themes opinionated underline styles?
    undercurl = true, -- Use the themes opinionated undercurl styles?
    cursorline = false, -- Use cursorline highlighting?
    transparency = false, -- Use a transparent background?
    terminal_colors = false, -- Use the theme's colors for Neovim's :terminal?
    window_unfocussed_color = false, -- When the window is out of focus, change the normal background?
  }
})

onedarkpro.load()

require('feline').setup()
require('gitsigns').setup()

function ToggleTheme()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end

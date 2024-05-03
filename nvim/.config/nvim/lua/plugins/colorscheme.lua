return {
  'scottmckendry/cyberdream.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('cyberdream').setup {
      -- Recommended - see "Configuring" below for more config options
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      borderless_telescope = true,
      terminal_colors = true,
    }
    vim.cmd 'colorscheme cyberdream' -- set the colorscheme
  end,
}
-- return {
--   'folke/tokyonight.nvim',
--   priority = 1000,
--   opts = {
--     transparent = true,
--     styles = {
--       sidebars = 'transparent',
--       floats = 'transparent',
--     },
--   },
--   init = function()
--     vim.cmd.colorscheme 'tokyonight-night'
--     vim.cmd.hi 'Comment gui=none'
--   end,
-- }

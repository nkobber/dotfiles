return {
  {
    'ellisonleao/gruvbox.nvim',
    enabled = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
  {
    'rose-pine/neovim',
    enabled = false,
    as = 'rose-pine',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    enabled = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'kanagawa'
    end,
  },
  {
    'folke/tokyonight.nvim',
    enabled = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
  {
    'edeneast/nightfox.nvim',
    enabled = true,
    init = function()
      vim.cmd.colorscheme 'terafox'
    end,
  },
  {
    'catppuccin/nvim',
    enabled = false,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
    config = function()
      require('catppuccin').setup {
        flavour = 'auto',
        background = {
          light = 'latte',
          dark = 'mocha',
        },
      }
    end,
  },
}

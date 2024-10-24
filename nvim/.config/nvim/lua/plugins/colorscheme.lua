return {
  'rose-pine/neovim',
  as = 'rose-pine',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'rose-pine'
    vim.cmd.hi 'Comment gui=none'
  end,
  config = function()
    require('rose-pine').setup {
      styles = {
        transparency = true,
      },
    }
  end,
}

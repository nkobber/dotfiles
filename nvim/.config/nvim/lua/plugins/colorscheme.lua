return {
  'scottmckendry/cyberdream.nvim',
  lazy = false,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'cyberdream'
    -- vim.cmd.hi 'Comment gui=none'
  end,
}

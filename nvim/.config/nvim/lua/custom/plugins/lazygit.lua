return {
  'kdheepak/lazygit.nvim',
  cmd = 'LazyGit',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>gg',
      '<cmd>LazyGit<CR>',
      desc = 'LazyGit',
    },
  },
}

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-go',
  },
  keys = {
    {
      '<leader>tt',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run test - closest',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Run test - file',
    },
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-go',
      },
    }
  end,
}

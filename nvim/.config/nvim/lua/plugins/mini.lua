return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.notify').setup()
    require('mini.comment').setup()
    require('mini.surround').setup()
    require('mini.bufremove').setup()
    require('mini.ai').setup()
    require('mini.files').setup {
      vim.keymap.set('n', '<leader>-', '<cmd>lua MiniFiles.open()<CR>', { noremap = true, silent = true, desc = 'Open files' }),
    }
    require('mini.jump2d').setup()
    require('mini.indentscope').setup {}

    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}

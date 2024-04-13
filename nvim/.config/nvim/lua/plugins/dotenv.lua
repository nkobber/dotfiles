return {
  'nkobber/dotenv.nvim',
  config = function()
    require('dotenv').setup {
      file_name = 'local.env',
      enable_on_load = true,
    }
  end,
}

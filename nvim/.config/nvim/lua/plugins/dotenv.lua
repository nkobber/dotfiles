return {
  "ellisonleao/dotenv.nvim",
  event = "BufEnter",
  config = function()
    require("dotenv").setup({
      file_name = "local.env",
      enable_on_load = true,
      event = "BufEnter",
    })
  end,
}

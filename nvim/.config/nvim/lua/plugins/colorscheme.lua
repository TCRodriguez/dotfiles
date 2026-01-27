return {
  "sekke276/dark_flat.nvim",
  priority = 1000,
  config = function()
    require("dark_flat").setup({
      transparent = true,
      color = {},
    })
    require("dark_flat").load()
    vim.cmd("colorscheme dark_flat")
  end,
}

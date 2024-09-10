-- return {
-- 	"navarasu/onedark.nvim",
-- 	priority = 1000,
-- 	opts = { style = "darker" },
-- 	config = function()
-- 		vim.cmd([[colorscheme onedark]])
-- 	end,
-- }

-- return {
-- 	"navarasu/onedark.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		require("onedark").setup({
-- 			style = "darker",
-- 		})
-- 		require("onedark").load()
-- 		vim.cmd("colorscheme onedark")
-- 	end,
-- }
--

return {
	"sekke276/dark_flat.nvim",
	priority = 1000,
	config = function()
		require("dark_flat").setup({
			transparent = false,
			color = {},
		})
		require("dark_flat").load()
		vim.cmd("colorscheme dark_flat")
	end,
}

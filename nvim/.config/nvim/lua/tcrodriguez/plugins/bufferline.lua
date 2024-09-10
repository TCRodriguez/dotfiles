return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			separator_style = "slant",
			buffer_close_icon = "⨯",
		},
	},
	-- config = function()
	-- vim.api.nvim_set_keymap("n", "<leader>b]", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
	-- vim.api.nvim_set_keymap("n", "<leader>b[", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
	-- end,
}

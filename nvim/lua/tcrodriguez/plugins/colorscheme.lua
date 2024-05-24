return {
	"navarasu/onedark.nvim",
	priority = 1000,
	opts = { style = "darker" },
	config = function()
		vim.cmd([[colorscheme onedark]])
	end,
}

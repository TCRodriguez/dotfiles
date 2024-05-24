vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>nh", ":nohl<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>+", "<C-a>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>-", "<C-x>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>sv", "<C-w>v", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sh", "<C-w>s", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>se", "<C-w>=", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sx", ":close<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>to", ":tabnew<CR>", { noremap = true, silent = true }) -- open new tab
vim.api.nvim_set_keymap("n", "<leader>tx", ":tabclose<CR>", { noremap = true, silent = true }) -- close current tab
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { noremap = true, silent = true }) -- go to next tab
vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true, silent = true }) -- go to previous tab

-- vim.api.nvim_set_keymap("n", "<leader>b]", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>b[", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-w>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

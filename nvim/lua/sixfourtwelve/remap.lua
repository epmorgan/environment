vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")

vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.api.nvim_set_keymap('n', 's', 'xi', { noremap = true })


vim.keymap.set("n", "<C-a>", "<cmd>:bprev<CR>zz")
vim.keymap.set("n", "<C-s>", "<cmd>:bnext<CR>zz")
-- vim.keymap.set("n", "<C-w>", "<cmd>:bdelete<CR>zz")
vim.keymap.set("n", "<C-c>", "<cmd>:w<CR>zz")

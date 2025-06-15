local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- buffers
vim.keymap.set("n", "<leader>n", ":bn<cr>")
vim.keymap.set("n", "<leader>p", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual mode" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual mode" })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d", "<C-d>zz", { desc = "Move down in buffer with cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up in buffer with cursor" })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<", "<gv", opts)

-- Clipboard things
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("v", "p", '"_dp', opts)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "x", '"_x', opts) -- prevent char deleted from being copied to clipboard

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Hightlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>") -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>") -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>") -- go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>") -- go to prev.
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>") -- open current tab in new tab.

--split
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
	local filePath = vim.fn.expand("%:~") -- gets the filepath rel to the home dir
	vim.fn.setreg("+", filePath) -- Copy the file path to the clipboard register
	print("File path copied to clipboard: " .. filePath)
end, { desc = "Copy fiel path to clipboard" })

-- nvim-comment
vim.keymap.set({ "n", "v" }, "<leader>/", ":CommentTogg<cr>")

-- lsp format code
vim.keymap.set("n", "<leader>Fmt", vim.lsp.buf.format)

-- Neotree
vim.keymap.set({ "n", "v" }, "<leader>ot", ":Neotree show<CR>")
vim.keymap.set({ "n", "v" }, "<leader>ct", ":Neotree close<CR>")

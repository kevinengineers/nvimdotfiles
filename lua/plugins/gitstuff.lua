return {
	{
		"tpope/vim-fugitive",
		config = function()
			local myFugitive = vim.api.nvim_create_augroup("myFugitive", {})
			local autocmd = vim.api.nvim_create_autocmd

			autocmd("BufWinEnter", {
				group = myFugitive,
				pattern = "*",
				callback = function()
					if vim.bo.ft ~= "fugitive" then
						return
					end

					local bufnr = vim.api.nvim_get_current_buf()
					local opts = { buffer = bufnr, remap = false }

					vim.keymap.set("n", "<leader>P", function()
						vim.cmd.Git("push")
					end, opts)

					--NOTE: Always rebase.
					vim.keymap.set("n", "<leader>p", function()
						vim.cmd.Git({ "pull", "--rebase" })
					end, opts)

					--NOTE: easy setup branch that waasn't setup properly
					vim.keymap.set("n", "<leader>t", ":Git push -U origin ", opts)
				end,
			})
			vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				--
				-- Actions
				map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
				map("v", "<leader>gs", function() -- stage selected hunk
					gs.stage_hunk({ vim.fn.line("."), vin.fn.line("v") })
				end, "Stage hunk")
				map("v", "<leader>gr", function() -- reset selected hunk
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset hunk")
				map("n", "<leader>gS", gs.stage_buffer, "Stage buffer") -- Stage whole buffer
				map("n", "<leader>gR", gs.reset_buffer, "Reset buffer") -- unstage whole buffer

				map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
				map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")

				map("n", "<leader>gbl", function()
					gs.blame_link({ full = true })
				end, "Blame Line")
				map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")

				map("n", "<leader>Gd", gs.diffthis, "Diff this")
				map("n", "<leader>gD", function()
					gs.diffthis("~")
				end, "Diff this ~")

				-- Navigation
				map("n", "]h", gs.next_hunk, "Next Hunk")
				map("n", "[h", gs.prev_hunk, "Prev Hunk")

				map({ "o", "x" }, "ih", ":<C-U>gitsigns select_hunk<CR>", "Gitsigns select hunk")
			end,
		},
	},
}

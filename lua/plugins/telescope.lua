return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install',
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Fuzzy Find Files" })
			vim.keymap.set("n", "<leader>gf", builtin.live_grep, { desc = "Grep Root Dir" })
			vim.keymap.set("n", "<leader>gab", builtin.buffers, { desc = "Grep Buffers" })
			vim.keymap.set("n", "<leader>gb", builtin.current_buffer_fuzzy_find, { desc = "Grep Current Buffer" })
			vim.keymap.set("n", "<leader>gw", function()
				require("telescope.builtin").grep_string({
					search = vim.fn.expand("<cword>"),
					search_dirs = { vim.fn.expand("%:p") },
				})
			end, { desc = "Grep Word" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						".git",
						"dist",
						"coverage",
						"build",
						"__pycache__",
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}

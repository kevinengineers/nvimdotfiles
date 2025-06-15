return {
	"nvim-telescope/telescope.nvim",
	branch = "master", -- using master to fix issues with deprecated to definition warnings 
    -- '0.1.x' for stable ver.,
    lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ 
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            lazy = false,
        },

		"nvim-tree/nvim-web-devicons",
		"andrew-george/telescope-themes",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		-- telescope.load_extension("fzf")
		telescope.load_extension("themes")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
					},
				},
			},
			extensions = {
				themes = {
					enable_previewer = true,
					enable_live_preview = true,
					persist = {
						enabled = true,
						path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
					},
				},
			},
		})
        local function safe_telescope(fn)
            return function()
                vim.schedule(function()
                    require("telescope.builtin")[fn]()
                end)
            end
        end

        vim.api.nvim_create_autocmd("VimEnter", {
            once = true,
            callback = function() 
                vim.keymap.set('n', '<leader>sh', safe_telescope("help_tags"), { desc = '[S]earch [H]elp' })
                vim.keymap.set('n', '<leader>sk', safe_telescope("keymaps"), { desc = '[S]earch [K]eymaps' })
                vim.keymap.set('n', '<leader>sf', safe_telescope("find_files"), { desc = '[S]earch [F]iles' })
                vim.keymap.set('n', '<leader>ss', safe_telescope("builtin"), { desc = '[S]earch [S]elect Telescope' })
                vim.keymap.set('n', '<leader>sw', safe_telescope("grep_string"), { desc = '[S]earch current [W]ord' })
                vim.keymap.set('n', '<leader>sg', safe_telescope("live_grep"), { desc = '[S]earch by [G]rep' })
                vim.keymap.set('n', '<leader>sd', safe_telescope("diagnostics"), { desc = '[S]earch [D]iagnostics' })
                vim.keymap.set('n', '<leader>sr', safe_telescope("resume"), { desc = '[S]earch [R]esume' })
                vim.keymap.set('n', '<leader>s.', safe_telescope("oldfiles"), { desc = '[S]earch Recent Files ("." for repeat)' })
                vim.keymap.set('n', '<leader><leader>', safe_telescope("buffers"), { desc = '[ ] Find existing buffers' })
                vim.keymap.set("n", "<leader>ths", "<cmd>Telescope themes<CR>", { noremap = true, silent = true, desc = "Theme Switcher" })
            end,
        })
    end,
}

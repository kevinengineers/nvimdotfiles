return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()
		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, {desc = "Harpoon: Add File"})
		vim.keymap.set("n", "<leader>hm", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, {desc = "Harpoon: Show Menu"})

		vim.keymap.set("n", "<leader>hq", function()
			harpoon:list():select(1)
		end, {desc = "Harpoon: Select 1"})
		vim.keymap.set("n", "<leader>hw", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon: Select 2"})
		vim.keymap.set("n", "<leader>he", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon: Select 3"})
		vim.keymap.set("n", "<leader>hr", function()
			harpoon:list():select(4)
		end, {  desc = "Harpoon: Select 4"})

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { desc = "Harpoon: Toggle Previous"})
		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():next()
		end, { desc = "Harpoon: Toggle Nex"})
	end,
}

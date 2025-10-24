
  return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Set keymaps.
      vim.keymap.set('n', '<leader>eo', ':Neotree filesystem reveal left<CR>')
      vim.keymap.set('n', '<leader>ec', ':Neotree filesystem close<CR>')

      -- function to auto close when a file from neotree is selected/opened.
      --
      --
      require("neo-tree").setup({
        event_handlers = {
        {
          event = "file_open_requested",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end
        },
      }
    }) 
    end
  }
 

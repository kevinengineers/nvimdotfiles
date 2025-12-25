return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "gopls" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()

      -- Diagnostics configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            staticcheck = true,
            analyses = {
              unusedparams = true,
              nilness = true,
              unusedwrite = true,
            },
          },
        },
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            },
          },
        },
      })
    end
  }
}

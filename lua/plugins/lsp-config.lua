
--[[
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
        ensure_installed = {
          "lua_ls",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config('omnisharp', {
         cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
         enable_editorconfig_support = true,
         enable_ms_build_load_projects_on_demand = true,
      })
      vim.lsp.config('lua-ls', {})
      vim.lsp.config('tsserver', {})
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
      vim.diagnostic.config({
          virtual_text = true,
          signs = true,
          underline = true,
          update_in_insert = false,
})
    end
  }
}
]]--

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
        ensure_installed = { "lua_ls" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Keymaps for all LSP servers
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set({'n','v'}, '<leader>ca', vim.lsp.buf.code_action, opts)
      end

      -- OmniSharp (C#) setup
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cs",
        callback = function()
          local root = vim.fs.find({"*.sln", "*.csproj"}, { upward = true })[1]
          local root_dir = root and vim.fs.dirname(root) or vim.loop.cwd()

          vim.lsp.start({
            name = "omnisharp",
            cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
            root_dir = root_dir,
            on_attach = on_attach,
            handlers = {
              -- Disable semantic tokens for instant highlighting
              ["textDocument/semanticTokens/full"] = function() return end
            },
            -- Optional: load projects on demand for faster startup
            enable_ms_build_load_projects_on_demand = true,
          })
        end,
      })

      -- Lua and TypeScript/JavaScript LSPs
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "typescript", "javascript" },
        callback = function()
          local ft = vim.bo.filetype
          local cmd
          local root_dir = vim.loop.cwd()

          if ft == "lua" then
            cmd = { "lua-language-server" }
          elseif ft == "typescript" or ft == "javascript" then
            cmd = { "typescript-language-server", "--stdio" }
          end

          if cmd then
            vim.lsp.start({
              name = ft .. "_ls",
              cmd = cmd,
              root_dir = root_dir,
              on_attach = on_attach,
            })
          end
        end,
      })

      -- Diagnostics configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })
    end
  }
}


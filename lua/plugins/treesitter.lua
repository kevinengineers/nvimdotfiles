return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "csharp",
      "javascript",
      "typescript",
      "html"
    },

    auto_install = true,

    highlight = {
      enabled = true,
      additional_vim_regex_highlighting = false,
    },
  },
}


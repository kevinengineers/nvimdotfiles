return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {"c_sharp"},
    auto_install = true,
    highlight = {
      enabled = true,
      additional_vim_regex_highlighting = false,
    },
  },
}


return {
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  config = function ()
    require("nvim-dap-virtual-text").setup ({
      enabled = true,
      enabled_commands = true,
      commented = false
    })
  end
}

return {
  "rose-pine/neovim",

  name = "rose-pine",
  opts = {
    styles = {
      transparency = true,
    },
  },
  priority = 1000,

  init = function() vim.cmd.colorscheme "rose-pine-main" end,
}

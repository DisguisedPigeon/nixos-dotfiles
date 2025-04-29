return {
  {
    "catppuccin/nvim",
    name = "catppuccin",

    opts = {
      transparent_background = true,
      flavour = "mocha"
    },
    priority = 1000,

    init = function() vim.cmd.colorscheme "catppuccin" end,
  }
  --[[ {
    "EdenEast/nightfox.nvim",

    opts = {
      options = {
        transparent = true,
      },
    },
    priority = 1000,

    init = function() vim.cmd.colorscheme "duskfox" end,
  },]]

  --[[ {
     "rose-pine/neovim",

     name = "rose-pine",
     opts = {
       styles = {
         transparency = true,
       },
     },
     priority = 1000,

     init = function() vim.cmd.colorscheme "rose-pine-main" end,
  }]]
}

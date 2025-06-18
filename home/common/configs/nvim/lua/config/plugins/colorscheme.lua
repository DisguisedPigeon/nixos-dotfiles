return {
  --[[{
    "catppuccin/nvim",
    name = "catppuccin",

    config = function()
      require("catppuccin").setup {
        transparent_background = true
      }

      vim.cmd.colorscheme "catppuccin-mocha"
    end,
    priority = 1000,
  },
  ]]
  --[[ {
    "EdenEast/nightfox.nvim",

    opts = {
      options = {
        transparent = true,
      },
    },
    priority = 1000,

    init = function() vim.cmd.colorscheme "duskfox" end,
  },
  ]]

  {
    "rose-pine/neovim",

    name = "rose-pine",
    priority = 1000,

    config = function()
      require("rose-pine").setup {
        styles = {
          transparency = true,
        },
      }
      vim.cmd.colorscheme "rose-pine-moon"
    end,
  },
}

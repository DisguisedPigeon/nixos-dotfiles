return {
  {
    "catppuccin/nvim",
    name = "catppuccin",

    config = function()
      local mocha = require("catppuccin.palettes").get_palette "mocha"

      require("catppuccin").setup {
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = mocha.crust,
            crust = mocha.mantle
          }
        }
      }

      vim.cmd.colorscheme "catppuccin-mocha"
    end,
    priority = 1000,
  },
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

  {
    "rose-pine/neovim",

    name = "rose-pine",
    opts = {
      styles = {
        transparency = true,
      },
    },
    priority = 1000,

    --init = function() vim.cmd.colorscheme "rose-pine-main" end,
  }
}

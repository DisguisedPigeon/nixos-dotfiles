return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    opts = {
      palettes = { duskfox = { bg1 = "#27253e" } },
    },
    -- init = function()
    --   vim.cmd.colorscheme "duskfox"
    --   vim.cmd.hi "Comment gui=none"
    -- end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    -- init = function()
    --   vim.cmd.colorscheme 'tokyonight-storm'
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    -- init = function()
    --   vim.cmd.colorscheme 'catppuccin-macchiato'
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",

    opts = {
      styles = {
        transparency = true,
      },
      palette = {
        moon = {
          base = "#232137",
        },
        main = {
          --base = "#191723",
        },
      },
    },
    priority = 1000,
    init = function()
      vim.cmd.colorscheme "rose-pine-main"
      vim.cmd.hi "Comment gui=none"
    end,
  },
}

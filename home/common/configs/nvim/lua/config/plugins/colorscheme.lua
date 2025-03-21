return {
  {
    "EdenEast/nightfox.nvim",

    opts = {
      options = {
        transparent = true,
      },
    },
    priority = 1000,

    init = function() vim.cmd.colorscheme "duskfox" end,
  },

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

return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_general_viewer = "okular"
    vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
    vim.g.vimtex_compiler_latexmk = {
      executable = "latexmk",
      options = {
        "-xelatex",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }
  end,
}

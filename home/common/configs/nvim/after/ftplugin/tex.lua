vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true

vim.api.nvim_create_user_command("LatexCleanAux", function(_)
  vim.lsp.client:exec_cmd({ command = "texlab.cleanAuxiliary", title = "latex clean aux files" })
end, {})

vim.treesitter.start()

--#region Execute lua
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Execute full file" })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "Execute line" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "Execute selection" })
--#endregion

--#region Terminal
-- QuickEsc
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Execute selection" })

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("term-open-setup", { clear = true }),
  callback = function()
    vim.o.nu = false
    vim.o.rnu = false
  end,
})

-- Terminal tab
vim.keymap.set("n", "<space>tt", function()
  vim.cmd.tabnew()
  vim.cmd.term()
end)

-- Terminal split
vim.keymap.set("n", "<space>ts", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 10)
  vim.cmd.term()
end)
--#endregion

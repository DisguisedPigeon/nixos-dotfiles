return {
  "shortcuts/no-neck-pain.nvim",
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>c", "<cmd>NoNeckPain<CR>")
  end
}

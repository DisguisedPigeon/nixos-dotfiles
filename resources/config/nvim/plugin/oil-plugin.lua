local oil = require("oil")
oil.setup({})

local lib = require("lib")
lib.nmap("-", require("oil").open, "Open parent directory")

-- Remove startup screen and run oil automatically
vim.opt.shortmess:append("I")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" then
      vim.schedule(oil.open)
    end
  end,
})

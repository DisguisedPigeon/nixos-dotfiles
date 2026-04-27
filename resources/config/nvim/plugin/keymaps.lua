-- Keymaps avaliable in default nvim.
-- ordered from more generally useful to more niche.

-- For plugin-specific, check init.lua and the /plugin/*-plugin.lua files

local lib = require("lib")

lib.nmap("<C-d>", "<C-d>zz", "Scroll down half screen, center")
lib.nmap("<C-u>", "<C-u>zz", "Scroll up half screen, center")

vim.keymap.set(
  "t",
  "<esc><esc>",
  "<C-\\><C-n>",
  { desc = "Quick normal mode from term mode" }
)

lib.nmap("<leader>x", function()
  vim.cmd(".lua")
end, "Execute the current line in lua")
lib.nmap("<leader>X", function()
  vim.cmd("source %")
end, "Execute the current file")

lib.nmap("<leader>tt", function()
  vim.cmd("tabnew")
  vim.cmd("term")
end, "open term in new tab")

vim.keymap.set(
  "i",
  "<C- >",
  "<C-x><C-o>",
  { desc = "Easier omnifunc completion access (~lsp completion)" }
)

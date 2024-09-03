local harpoon = require("harpoon")

harpoon:setup()
vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "harpoon add" })
vim.keymap.set("n", "<leader>hv", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "harpoon view" })

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, {desc = "harpoon 1st element"})
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, {desc = "harpoon 2nd element"})
vim.keymap.set("n", " C-k>", function() harpoon:list():select(3) end, {desc = "harpoon 3rd element"})
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, {desc = "harpoon 4th element"})

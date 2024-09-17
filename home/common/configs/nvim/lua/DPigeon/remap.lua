--Im stoopid, no arrows
vim.keymap.set({ "n", "v", "i", "x" }, "<Up>", "<Nop>")
vim.keymap.set({ "n", "v", "i", "x" }, "<Down>", "<Nop>")
vim.keymap.set({ "n", "v", "i", "x" }, "<Left>", "<Nop>")
vim.keymap.set({ "n", "v", "i", "x" }, "<Right>", "<Nop>")
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<leader>gr", vim.cmd.GBrowse, { desc = "Git Repository" })
vim.keymap.set("n", "<leader>gp", vim.cmd.Git, { desc = "Git Panel" })
vim.keymap.set("n", "<A-p>", vim.cmd.Git, { desc = "Git Previous" })
vim.keymap.set("n", "<A-n>", vim.cmd.Git, { desc = "Git Next" })
vim.keymap.set("n", "<A-v>", vim.cmd.Git, { desc = "Git View" })

vim.keymap.set("n", "<leader>wi", "<cmd>Neorg index<CR>", { desc = "Wiki Index" })
vim.keymap.set("n", "<leader>wr", "<cmd>Neorg return<CR>", { desc = "Wiki return" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

local key_assignments = require("DPigeon.key_functions")

key_assignments.telescope_keymaps()

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "toggle Undotree" })

vim.keymap.set("n", "<leader>pf", vim.diagnostic.open_float, { desc = "Problems Floating window" })

--Open oil.nvim (file view)
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil, { desc = "Open file view" })

--Visual mode J/K moves all lines selected
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--J doesn't move cursor now
vim.keymap.set("n", "J", "mzJ`z")

--Control+D/U leaves cursor on the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--On search: Center found instance when navigating
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--do not copy when deleting things on paste with <leader>p
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste (no override default registry)" })

--copy to external clipboard only when pressing <leader>y
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system" })
vim.keymap.set(
	"n",
	"<leader>Y",
	[["+Y] ], { desc = "Copy line to system" })

--do not copy when deleting with <leader>d
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]],
	{ desc = "Delete (no copy)" }
)

--ex mode is cringe
vim.keymap.set("n", "Q", "<nop>")

--maybe look into this
--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

--format buffer
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "format buffer" })

--control + j/k goes to next thing in the quickfix list
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>zz")
--<leader> + j/k does the same but with current window list
vim.keymap.set("n", "<leader>ln", "<cmd>lnext<CR>zz", { desc = "cycle window quickfix list up" })
vim.keymap.set("n", "<leader>lp", "<cmd>lprev<CR>zz", { desc = "cycle window quickfix list up" })

--<leader> + s edits all appearances of the word under the cursor
--vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "substitute word" })

--<leader> + x adds eXecute permission to current file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "make file executable" })

vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, { desc = "code actions" })

--2<leader> adds current file to nvim source for easy config editing
--NOTE: maybe comment when not editing config
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end, { desc = "source file" })

vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-N>")

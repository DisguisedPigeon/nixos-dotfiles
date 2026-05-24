require("mini.ai").setup()
require("mini.align").setup()
require("mini.comment").setup()
local extra = require("mini.extra")
require("mini.icons").setup()
require("mini.surround").setup()
local statusline = require("mini.statusline")

statusline.setup({ use_icons = true })
-- statusline.section_location = function()
-- 	return "%2l:%-2v"
-- end

extra.setup()

local lib = require("lib")

local pick = require("mini.pick")

local choose_all = function()
  local mappings = pick.get_picker_opts().mappings
  vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
end

pick.setup({
  mappings = {
    choose_all = { char = "<C-q>", func = choose_all },
  },
})

lib.nmap("<leader>fh", pick.builtin.help, "[F]ind [H]elp")
lib.nmap("<leader>ff", pick.builtin.files, "[F]ind [F]iles")
lib.nmap("<leader>fg", pick.builtin.grep_live, "[F]ind [G]rep")
lib.nmap("<leader>fd", pick.registry.diagnostic, "[F]ind [D]iagnostics")
lib.nmap("<leader>fr", pick.builtin.resume, "[F]ind [R]esume")
lib.nmap(
  "<leader>f.",
  pick.registry.oldfiles,
  '[F]ind Recent Files ("." for repeat)'
)
lib.nmap("<leader><leader>", pick.builtin.buffers, "[ ] Find existing buffers")
lib.nmap("<leader>f<leader>", extra.pickers.buf_lines, "[F]ind [R]esume")

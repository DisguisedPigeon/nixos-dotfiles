require("mini.ai").setup()
require("mini.align").setup()
require("mini.comment").setup()
require("mini.extra").setup()
require("mini.icons").setup()
require("mini.surround").setup()
local statusline = require("mini.statusline")
local pick = require("mini.pick")
pick.setup()

statusline.setup({ use_icons = true })
-- statusline.section_location = function()
-- 	return "%2l:%-2v"
-- end

local lib = require("lib")

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

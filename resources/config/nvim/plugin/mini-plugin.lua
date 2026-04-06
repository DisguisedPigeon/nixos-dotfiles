local lib = require("lib")
--#region Mini
require("mini.extra").setup()
require("mini.surround").setup()
require("mini.ai").setup({ n_lines = 500, search_method = "cover" })

local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })
statusline.section_location = function()
	return "%2l:%-2v"
end

local ext3_blocklist = { scm = true, txt = true, yml = true }
local ext4_blocklist = { json = true, yaml = true }

require("mini.icons").setup({
	use_file_extension = function(ext, _)
		return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
	end,
})

require("mini.align").setup()
require("mini.comment").setup()

local pick = require("mini.pick")
pick.setup()

lib.nmap("<leader>fh", pick.builtin.help, "[F]ind [H]elp")
lib.nmap("<leader>ff", pick.builtin.files, "[F]ind [F]iles")
lib.nmap("<leader>fg", pick.builtin.grep_live, "[F]ind [G]rep")
lib.nmap("<leader>fd", pick.registry.diagnostic, "[F]ind [D]iagnostics")
lib.nmap("<leader>fr", pick.builtin.resume, "[F]ind [R]esume")
lib.nmap("<leader>f.", pick.registry.oldfiles, '[F]ind Recent Files ("." for repeat)')
lib.nmap("<leader><leader>", pick.builtin.buffers, "[ ] Find existing buffers")
--#endregion

local M = {}

local nmap = function (keybind, call, desc)
    vim.keymap.set('n', keybind, call, {desc = desc})
end

M.telescope_keymaps = function()
    local function find_git_root()
        local current_file = vim.api.nvim_buf_get_name(0)
        local current_dir
        local cwd = vim.fn.getcwd()

        if current_file == "" then
            current_dir = cwd
        else
            current_dir = vim.fn.fnamemodify(current_file, ":h")
        end

        local git_root

        if current_dir ~= nil then
            git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
        end
        if vim.v.shell_error ~= 0 then
            print("Not a git repository. Searching on current working directory")
            return cwd
        end
        return git_root
    end



    --Builtin
    local function live_grep_git_root()
        local git_root = find_git_root()
        if git_root then
            require('telescope.builtin').live_grep({
                search_dirs = { git_root },
            })
        end
    end
    local telescope_builtin = require('telescope.builtin')
    nmap('<leader>tp', telescope_builtin.find_files, "Telescope Project")
    nmap('<leader>tf', telescope_builtin.current_buffer_fuzzy_find, "Telescope File (find)")
    nmap('<leader>tb', telescope_builtin.buffers, "Telescope existing Buffers")
    nmap('<leader>tH', telescope_builtin.help_tags, "Telescope Help")
    nmap('<leader>tr', function() telescope_builtin.grep_string({ search = vim.fn.input("grep: ") }) end, "Telescope REGEX")
    nmap('<leader>to', telescope_builtin.oldfiles, "Telescope Opened files")
    nmap('<leader>tq', telescope_builtin.quickfix, "Telescope Quickfix")
    nmap('<leader>tk', telescope_builtin.keymaps, "Telescope Keymaps")
    nmap('<leader>tt', telescope_builtin.treesitter, "Telescope Treesitter (idk what it does for now)" )

    -- Git
    nmap('<leader>tgf', telescope_builtin.git_files, "Telescope Git Files")
    nmap('<leader>tgc', telescope_builtin.git_commits, "Telescope Git Files")
    nmap('<leader>tgb', telescope_builtin.git_branches, "Telescope Git Files")
    nmap('<leader>tgl', live_grep_git_root, "Telescope Git Grep") 

    local telescope_harpoon = require("telescope").load_extension('harpoon')
    nmap('<leader>th', telescope_harpoon.marks, "Telescope Harpoon Marks")
end

M.harpoon_keymaps = function ()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    nmap("<leader>ha", mark.add_file, "Harpoon Add (mark)")
    nmap("<leader>hv", ui.toggle_quick_menu, "Harpoon View")

    nmap("<A-h>", function() ui.nav_file(1) end, "jump to mark 1" )
    nmap("<A-j>", function() ui.nav_file(2) end, "jump to mark 2" )
    nmap("<A-k>", function() ui.nav_file(3) end, "jump to mark 3" )
    nmap("<A-l>", function() ui.nav_file(4) end, "jump to mark 4" )
end

return M

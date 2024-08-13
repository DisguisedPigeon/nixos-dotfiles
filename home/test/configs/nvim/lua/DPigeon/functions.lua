local M = {}

M.gitsigns_on_attach = function(bufnr)
    vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, {
        buffer = bufnr, desc = 'Git Previous (change)'
    })
    vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, {
        buffer = bufnr, desc = 'Git Next (change)'
    })
    vim.keymap.set('n', '<leader>gv', require('gitsigns').next_hunk, {
        buffer = bufnr, desc = 'Git View (changes)'
    })
end

M.ibl_config = function()
    vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
            if string.find(vim.api.nvim_buf_get_name(0), ".*%.java") then
                require("ibl").setup {
                    indent = {
                        char = "󰇷",
                        highlight = { "Function", "Label" },
                        smart_indent_cap = true,
                        priority = 2,
                    }
                }
            else
                require("ibl").setup {
                    indent = {
                        char = "|",
                        highlight = { "Function", "Label" },
                        smart_indent_cap = true,
                        priority = 2,
                    }
                }
            end
        end
    })
end

M.lsp_on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = '[L]SP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end
    nmap('<leader>lr', vim.lsp.buf.rename, '[R]ename')
    nmap('<leader>lf', vim.lsp.buf.rename, '[F]ormat')
    nmap('<leader>lc', vim.lsp.buf.code_action, '[C]ode action')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>lt', vim.lsp.buf.type_definition, '[T]ype definition')
    nmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, 'document [S]ymbols')
    nmap('<leader>lws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace ')
    nmap('<leader>ld', require('telescope.builtin').diagnostics, '[D]iagnostics')

    nmap('K', vim.lsp.buf.hover, 'Khover documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'type Signature')

    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>lwl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')
end

return M

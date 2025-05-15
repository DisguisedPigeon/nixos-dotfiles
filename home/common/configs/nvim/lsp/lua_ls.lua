local runtime_files = vim.api.nvim_get_runtime_file('', true)
for k, v in ipairs(runtime_files) do
  if v == "/home/my-login/.config/nvim/after" or v == "/home/my-login/.config/nvim" then
    table.remove(runtime_files, k)
  end
end

local capabilities = require "blink.cmp".get_lsp_capabilities({}, true)
return {
  capabilities = capabilities,
  cmd = { "/usr/bin/env", "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },

      workspace = {
        checkThirdParty = false,
        --[[ WARNING : this might be a better way to do this. Testing dev experience on nixos rn

        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
          '${3rd}/busted/library'
        }
        ]]
        library = runtime_files
      }
    })
  end,

  settings = {
    Lua = {}
  }
}

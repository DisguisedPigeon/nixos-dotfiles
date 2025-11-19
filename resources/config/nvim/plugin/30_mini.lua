local now, later = MiniDeps.now, MiniDeps.later
local now_if_args = _G.Config.now_if_args

-- mini basics.
-- - set leaderkey
-- - set file's default plugin and indent on
-- - set file backups on until write
-- - set mouse
-- - set undofile
-- - set breakindent
now(function()
  require("mini.basics").setup({
    options = { extra_ui = true },
    mappings = { windows = true, move_with_alt = true },
  })
end)

later(function()
  require("mini.extra").setup()
end)

--#region now

--#region multiline
now(function()
  local ext3_blocklist = { scm = true, txt = true, yml = true }
  local ext4_blocklist = { json = true, yaml = true }
  require("mini.icons").setup({
    use_file_extension = function(ext, _)
      return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
    end,
  })

  later(MiniIcons.mock_nvim_web_devicons)
  later(MiniIcons.tweak_lsp_kind)
end)
--#endregion

--#region single-line
now(function()
  require("mini.notify").setup()
end)
now(function()
  require("mini.starter").setup()
end)
now(function()
  require("mini.statusline").setup()
end)
--#endregion
--#endregion

--#region now_if_args

--#region multiline

now_if_args(function()
  require("mini.misc").setup() -- zoom and resize to editable
  MiniMisc.setup_auto_root() -- change root to editing file's .git or similar directory
  MiniMisc.setup_restore_cursor() -- save cursor position between sessions
  MiniMisc.setup_termbg_sync() -- colorscheme to termbg
end)
--#endregion
--#endregion

--#region later

--#region multiline

later(function()
  local ai = require("mini.ai")
  ai.setup({
    custom_textobjects = {
      B = MiniExtra.gen_ai_spec.buffer(),
      F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    },
    search_method = "cover",
  })
end)

later(function()
  local miniclue = require("mini.clue")
  miniclue.setup({
    clues = {
      Config.leader_group_clues,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
    },
    triggers = {
      { mode = "n", keys = "<Leader>" }, -- Leader triggers
      { mode = "x", keys = "<Leader>" },
      { mode = "n", keys = "\\" }, -- mini.basics
      { mode = "n", keys = "[" }, -- mini.bracketed
      { mode = "n", keys = "]" },
      { mode = "x", keys = "[" },
      { mode = "x", keys = "]" },
      { mode = "i", keys = "<C-x>" }, -- Built-in completion
      { mode = "n", keys = "g" }, -- `g` key
      { mode = "x", keys = "g" },
      { mode = "n", keys = "'" }, -- Marks
      { mode = "n", keys = "`" },
      { mode = "x", keys = "'" },
      { mode = "x", keys = "`" },
      { mode = "n", keys = '"' }, -- Registers
      { mode = "x", keys = '"' },
      { mode = "i", keys = "<C-r>" },
      { mode = "c", keys = "<C-r>" },
      { mode = "n", keys = "<C-w>" }, -- Window commands
      { mode = "n", keys = "z" }, -- `z` key
      { mode = "x", keys = "z" },
    },
  })
end)

later(function()
  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  local process_items = function(items, base)
    return MiniCompletion.default_process_items(items, base, process_items_opts)
  end
  require("mini.completion").setup({
    lsp_completion = {
      source_func = "omnifunc",
      auto_setup = false,
      process_items = process_items,
    },
  })
  local on_attach = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
  end
  _G.Config.new_autocmd("LspAttach", nil, on_attach, "Set 'omnifunc'")
  vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

later(function()
  local hipatterns = require("mini.hipatterns")
  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
      hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
      todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
      note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

later(function()
  require("mini.operators").setup()
  vim.keymap.set("n", "(", "gxiagxila", { remap = true, desc = "Swap arg left" })
  vim.keymap.set("n", ")", "gxiagxina", { remap = true, desc = "Swap arg right" })
end)

later(function()
  local latex_patterns = { "latex/**/*.json", "**/latex.json" }
  local lang_patterns = {
    tex = latex_patterns,
    plaintex = latex_patterns,
    markdown_inline = { "markdown.json" },
  }

  local snippets = require("mini.snippets")
  local config_path = vim.fn.stdpath("config")
  snippets.setup({
    snippets = {
      snippets.gen_loader.from_file(config_path .. "/snippets/global.json"),
      snippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
    },
  })
  MiniSnippets.start_lsp_server()
end)
--#endregion

--#region single-line
later(function()
  require("mini.surround").setup()
end)
later(function()
  require("mini.trailspace").setup()
end)
later(function()
  require("mini.align").setup()
end)
later(function()
  require("mini.bracketed").setup()
end)
later(function()
  require("mini.comment").setup()
end)
later(function()
  require("mini.diff").setup()
end)
later(function()
  require("mini.git").setup()
end)
later(function()
  require("mini.keymap").setup()
end)
later(function()
  require("mini.move").setup()
end)
later(function()
  local choose_all = function()
    local mappings = require("mini.pick").get_picker_opts().mappings
    vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
  end

  require("mini.pick").setup({
    mappings = {
      choose_all = { char = "<C-q>", func = choose_all },
    },
  })
end)

-- TODO: check rose-pine background change to #000
-- later(function()
--   require("mini.colors").setup()
-- end)

-- TODO: Might delete it???? Depends wether I use it.
later(function()
  require("mini.jump2d").setup()
end)
--#endregion
--#endregion

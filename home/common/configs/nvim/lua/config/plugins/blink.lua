return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets", { "L3MON4D3/luasnip", version = '2.*' } },

  version = "*",
  build = "nix run .#build-plugin",

  opts_extend = { "sources.default" },

  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    --[[
    local sn = ls.snippet_node
    local isn = ls.indent_snippet_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local r = ls.restore_node
    local events = require("luasnip.util.events")
    local ai = require("luasnip.nodes.absolute_indexer")
    local extras = require("luasnip.extras")
    local l = extras.lambda
    local rep = extras.rep
    local p = extras.partial
    local m = extras.match
    local n = extras.nonempty
    local dl = extras.dynamic_lambda
    local fmt = require("luasnip.extras.fmt").fmt
    local fmta = require("luasnip.extras.fmt").fmta
    local conds = require("luasnip.extras.expand_conditions")
    local postfix = require("luasnip.extras.postfix").postfix
    local types = require("luasnip.util.types")
    local parse = require("luasnip.util.parser").parse_snippet
    local ms = ls.multi_snippet
    local k = require("luasnip.nodes.key_indexer").new_key
    --]]

    local function copy(args)
      return args[1]
    end

    ---@param args [string, [string]]
    local function copy_to_gleam_declaration(args)
      local v = args[1][1]
      v = v:gsub(", ", "\n")

      v = v:gsub(":.-$", " = Nil")

      v = v:gsub("^", "let ")

      return { v }
    end

    local function copy_gleam_arg_without_type(args)
      local v = args[1][1]
      v = v:gsub(":.-,", ",")
      v = v:gsub(":.-$", "")

      return { v }
    end

    ls.add_snippets(nil, {
      gleam = {
        s("lt", { t("html."), i(1), t("(["), i(2), t("], ["), i(3), t("])") }),
        s("la", { t("attribute."), i(1), t("(["), i(2), t("])") }),
        s("tup", { t("#("), i(1), t(")") }),

        s("doc",
          { t(
            "/// "), i(1), t({ "",
            "/// # Examples" }), t({ "",
            "/// ```gleam" }), t({ "",
            "/// " }), i(2), t({ "",
            "/// ```" }) }),

        s("fdoc",
          { t(
            "/// "), i(1, "A short description"), t({ "",
            "/// # Examples" }), t({ "",
            "/// ```gleam" }), t({ "",
            "/// " }), f(copy_to_gleam_declaration, 3), t({ "",
            "/// " }), f(copy, 2), t("("), f(copy_gleam_arg_without_type, 3), t({ ")",
            "/// // ->" }), i(6, "Nil"), t({ "",
            "/// ```" }), t({ "",
            "fn " }), i(2, "foo"), t("("), i(3, "a: Nil, b: Nil"), t(") -> "), i(4, "Nil"), t({ " {",
            "  " }), i(5, "todo"), t({ "",
            "}" }),
          })
      }
    })

    require("blink.cmp").setup {
      keymap = {
        preset = "none",
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<C-y>'] = { 'select_and_accept' },

        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-h>'] = { 'snippet_backward' },
        ['<C-l>'] = { 'snippet_forward', 'select_and_accept', 'fallback' },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      sources = {
        default = { "lsp", "path", "snippets", "luasnip", "buffer" },
      },
      snippets = {
        expand = function(snippet) ls.lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then
            return ls.jumpable(filter.direction)
          end
          return ls.in_snippet()
        end,
        jump = function(direction) ls.jump(direction) end,
      },
    }
  end
}

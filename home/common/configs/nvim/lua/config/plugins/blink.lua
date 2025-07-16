return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets", { "L3MON4D3/luasnip", version = "2.*" } },

  version = "1.*",

  opts_extend = { "sources.default" },

  init = function() require "config.snippets" end,

  opts = {
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<C-y>"] = { "select_and_accept" },

      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-h>"] = { "snippet_backward" },
      ["<C-l>"] = { "snippet_forward", "fallback" },

      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },

    appearance = {
      nerd_font_variant = "normal",
    },

    snippets = {
      preset = "luasnip",
    },

    sources = {
      default = { "snippets", "lsp", "path", "buffer" },
      per_filetype = {
        lua = { inherit_defaults = true, 'lazydev' },
      },
    },

    fuzzy = {
      sorts = { "exact", "score", "kind" }
    },

    completion = {
      keyword = { range = "full" },
      documentation = { auto_show = true }
    },

    signature = { enabled = true, },
  },
}

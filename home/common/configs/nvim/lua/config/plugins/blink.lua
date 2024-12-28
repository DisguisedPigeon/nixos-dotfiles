return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/luasnip" },

  version = "*",
  build = "nix run .#build-plugin",

  opts = {
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
  },
  opts_extend = { "sources.default" },
}

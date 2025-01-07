return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
    },

    opts = {
      extensions = { fzf = {}, ["ui-select"] = { require("telescope.themes").get_dropdown {} } },
    },

    config = function()
      local telescope = require "telescope"
      local builtin = require "telescope.builtin"
      local themes = require "telescope.themes"
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")

      -- TODO : add
      --[[
        lsp_references
        lsp_incoming_calls
        lsp_workspace_symbols
        diagnostics (theme ivy)
        lsp_implementations
        lsp_definitions
        lsp_type_definitions
      ]]

      vim.keymap.set(
        "n",
        "<space>ff",
        function() builtin.find_files() end,
        { desc = "telescope find files" }
      )
      vim.keymap.set(
        "n",
        "<space>fgf",
        function() builtin.git_files() end,
        { desc = "telescope find git files" }
      )
      vim.keymap.set(
        "n",
        "<space>fgg",
        function() builtin.live_grep(themes.get_ivy()) end,
        { desc = "telescope grep" }
      )
      vim.keymap.set(
        "n",
        "<space><space>",
        function() builtin.buffers(themes.get_ivy()) end,
        { desc = "telescope buffers" }
      )
      vim.keymap.set(
        "n",
        "<space>fo",
        function() builtin.oldfiles(themes.get_ivy()) end,
        { desc = "telescope find old files" }
      )
      vim.keymap.set(
        "n",
        "<space>fh",
        function() builtin.help_tags(themes.get_ivy()) end,
        { desc = "telescope find help" }
      )
      vim.keymap.set(
        "n",
        "<space>fm",
        function() builtin.man_pages(themes.get_ivy()) end,
        { desc = "telescope find man" }
      )
      vim.keymap.set(
        "n",
        "<space>fcs",
        function() builtin.colorscheme() end,
        { desc = "telescope find colors" }
      )
      vim.keymap.set(
        "n",
        "<space>fq",
        function() builtin.quickfix(themes.get_ivy()) end,
        { desc = "telescope find quickFixList" }
      )
      vim.keymap.set(
        "n",
        "<space>fk",
        function() builtin.keymaps(themes.get_ivy()) end,
        { desc = "telescope find keys" }
      )
      vim.keymap.set(
        "n",
        "<space>fch",
        function() builtin.highlights() end,
        { desc = "telescope find highlights" }
      )
      vim.keymap.set(
        "n",
        "<space>f<space>",
        function() builtin.current_buffer_fuzzy_find(themes.get_ivy()) end,
        { desc = "telescope find in buffer" }
      )
      vim.keymap.set(
        "n",
        "<space>fgcc",
        function() builtin.git_commits() end,
        { desc = "telescope find git commits" }
      )
      vim.keymap.set(
        "n",
        "<space>fgcb",
        function() builtin.git_bcommits() end,
        { desc = "telescope find git commits in buffer" }
      )
      vim.keymap.set(
        "n",
        "<space>fgb",
        function() builtin.git_branches() end,
        { desc = "telescope find git branch" }
      )
      vim.keymap.set(
        "n",
        "<space>fgs",
        function() builtin.git_status() end,
        { desc = "telescope git status" }
      )
      vim.keymap.set(
        "n",
        "<space>ft",
        function() builtin.treesitter() end,
        { desc = "telescope find treesitter" }
      )
      vim.keymap.set(
        "n",
        "<space>fp",
        function() builtin.planets() end,
        { desc = "telescope find planets" }
      )
      vim.keymap.set(
        "n",
        "<space>fs",
        function() builtin.builtin() end,
        { desc = "telescope find searchers" }
      )
    end,
  },
  { "dressing.nvim", opts = {} },
}

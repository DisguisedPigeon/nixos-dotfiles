return {
  'vieitesss/miniharp.nvim',
  config = function()
    require("miniharp").setup {
      autoload = true,
      autosave = true,
      show_on_autoload = true
    }
    vim.keymap.set('n', '<leader>ht', require('miniharp').toggle_file, { desc = 'miniharp: toggle file mark' })
    vim.keymap.set('n', '<C-n>', require('miniharp').next, { desc = 'miniharp: next file mark' })
    vim.keymap.set('n', '<C-p>', require('miniharp').prev, { desc = 'miniharp: prev file mark' })
    vim.keymap.set('n', '<leader>hv', require('miniharp').show_list, { desc = 'miniharp: list marks' })
  end
}

--[[
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    local harpoon = require "harpoon"

    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)

    vim.keymap.set("n", "<leader>hv", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<A-h>", function() harpoon:list():select(1) end)

    vim.keymap.set("n", "<A-j>", function() harpoon:list():select(2) end)

    vim.keymap.set("n", "<A-k>", function() harpoon:list():select(3) end)

    vim.keymap.set("n", "<A-l>", function() harpoon:list():select(4) end)

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
    end

    vim.keymap.set("n", "<leader>ht", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    local conf = require("telescope.config").values
  end,
}
]]

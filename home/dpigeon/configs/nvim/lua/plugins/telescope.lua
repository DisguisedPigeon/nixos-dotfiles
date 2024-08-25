require("telescope").setup()
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

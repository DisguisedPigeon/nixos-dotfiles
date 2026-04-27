local M = {}

M.nmap = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

M.iter_directory = function(directory)
  local acc = {}

  for file_name in vim.fs.dir(directory) do
    table.insert(acc, file_name)
  end

  return vim.iter(acc)
end

return M

-- vim: ts=2 sts=2 sw=2 et

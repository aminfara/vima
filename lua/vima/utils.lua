local M = {}

M.notify_missing_plugin = function(name)
  vim.notify('Failed to load plugin ' .. name .. '.', 'warn', { title = name })
end

return M

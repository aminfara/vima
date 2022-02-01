local M = {}

M.notify_missing = function(name, title)
  title = title or name
  vim.notify('Could not find ' .. name .. '.', 'warn', { title = title })
end

M.toggle_quickfix_window = function()
  local tabnr = vim.fn.tabpagenr()
  local win_info = vim.fn.getwininfo()
  for _, win in pairs(win_info) do
    if win['tabnr'] == tabnr then
      if win['quickfix'] > 0 then
        vim.cmd('cclose')
        return
      end
    end
  end
  vim.cmd('copen')
end

return M

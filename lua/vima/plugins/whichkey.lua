local present, which_key = pcall(require, 'which-key')
if not present then
  vim.notify('Failed to load which-key.', 'warn', { title = 'which-key' })
  return
end

which_key.setup({
  window = {
    border = 'rounded',
  },
})

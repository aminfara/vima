local present, which_key = pcall(require, 'which-key')
if not present then
  require('vima.utils').notify_missing_plugin('which-key.nvim')
  return
end

which_key.setup({
  window = {
    border = 'rounded',
  },
})

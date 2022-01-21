local present, which_key = pcall(require, 'which-key')
if not present then
  require('vima.utils').notify_missing_plugin('which-key.nvim')
  return
end

which_key.setup({
  window = {
    border = 'rounded',
  },
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { 'j', 'k' },
    v = { 'j', 'k' },
    n = { 'v' },
  },
})

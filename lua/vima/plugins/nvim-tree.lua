local present, nvim_tree = pcall(require, 'nvim-tree')
if not present then
  require('vima.utils').notify_missing('nvim-tree')
  return
end

nvim_tree.setup({
  ignore_ft_on_setup = {
    'startify',
    'dashboard',
    'alpha',
  },
  respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    mappings = {
      list = {
        { key = '<C-_>', action = 'toggle_help' },
      },
    },
  },
})

local present, nvim_tree = pcall(require, 'nvim-tree')
if not present then
  require('vima.utils').notify_missing_plugin('nvim-tree')
  return
end

vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
}

vim.g.nvim_tree_respect_buf_cwd = 1

nvim_tree.setup({
  ignore_ft_on_setup = {
    'startify',
    'dashboard',
    'alpha',
  },
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

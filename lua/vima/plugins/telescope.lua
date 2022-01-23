local present, telescope = pcall(require, 'telescope')
if not present then
  require('vima.utils').notify_missing_plugin('telescope.nvim')
  return
end

local actions = require('telescope.actions')

telescope.setup({
  defaults = {

    prompt_prefix = '  ',
    selection_caret = ' ',
    path_display = { 'smart' },

    mappings = {
      i = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-h>'] = actions.which_key,
      },
      n = {
        ['<C-c>'] = actions.close,
        ['<C-h>'] = actions.which_key,
      },
    },
  },
  pickers = {},
  extensions = {},
})

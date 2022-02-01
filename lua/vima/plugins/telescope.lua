local present, telescope = pcall(require, 'telescope')
if not present then
  require('vima.utils').notify_missing('telescope.nvim')
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
      },
      n = {
        ['<C-c>'] = actions.close,
        ['<C-_>'] = actions.which_key,
      },
    },
  },
  pickers = {},
  extensions = {
    termfinder = {
      mappings = {
        rename_term = '<C-n>',
        delete_term = '<C-x>',
        vertical_term = '<C-v>',
        horizontal_term = '<C-h>',
        float_term = '<C-f>',
      },
    },
  },
})

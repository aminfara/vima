local present, ts_configs = pcall(require, 'nvim-treesitter.configs')
if not present then
  require('vima.utils').notify_missing_plugin('nvim-treesitter')
  return
end

-- TODO: key mappings
-- TODO: Folds, Locals, Indents, Injections
-- TODO: textobjects and movements
-- TODO: commenting
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

ts_configs.setup({
  ensure_installed = require('vima.languages').get_treesitter_languages(),
  sync_install = false,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
})

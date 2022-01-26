local present, indent_blankline = pcall(require, 'indent_blankline')
if not present then
  require('vima.utils').notify_missing_plugin('indent-blankline.nvim')
  return
end

vim.opt.termguicolors = true
vim.cmd([[highlight! link IndentBlanklineIndent1 NonText]])

indent_blankline.setup({
  char = '┊',
  char_highlight_list = {
    'IndentBlanklineIndent1',
  },
  show_current_context = true,
  show_current_context_start = true,
  filetype_exclude = { 'alpha', 'NvimTree' },
})

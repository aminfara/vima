local present, indent_blankline = pcall(require, 'indent_blankline')
if not present then
  require('vima.utils').notify_missing_plugin('indent-blankline.nvim')
  return
end

vim.opt.termguicolors = true
vim.cmd([[highlight! link IndentBlanklineIndent1 NonText]])

indent_blankline.setup({
  indentLine_enabled = 1,
  char = '▏',
  context_char = '▏',
  filetype_exclude = {
    'help',
    'terminal',
    'alpha',
    'dashboard',
    'packer',
    'lspinfo',
    'TelescopePrompt',
    'TelescopeResults',
    'nvchad_cheatsheet',
    'lsp-installer',
    '',
  },
  buftype_exclude = { 'terminal' },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  char_highlight_list = {
    'IndentBlanklineIndent1',
  },
  use_treesitter = true,
  show_current_context = true,
  show_current_context_start = true,
  show_current_context_start_on_current_line = false,
})

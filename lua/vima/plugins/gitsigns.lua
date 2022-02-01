local present, gitsigns = pcall(require, 'gitsigns')
if not present then
  require('vima.utils').notify_missing('gitsigns.nvim')
  return
end

local on_attach = function(bufnr)
  require('vima.plugins.which-key').setup_gitsigns_mappings(gitsigns, bufnr)
end

gitsigns.setup({
  on_attach = on_attach,
  signs = {
    add = {
      hl = 'GitSignsAdd',
      text = '▎',
      numhl = 'GitSignsAddNr',
      linehl = 'GitSignsAddLn',
    },
    change = {
      hl = 'GitSignsChange',
      text = '▎',
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
    delete = {
      hl = 'GitSignsDelete',
      text = '契',
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    topdelete = {
      hl = 'GitSignsDelete',
      text = '契',
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    changedelete = {
      hl = 'GitSignsChange',
      text = '▎',
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
  },
  current_line_blame = false,
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
  preview_config = {
    border = 'rounded',
  },
})

local present, lualine = pcall(require, 'lualine')
if not present then
  require('vima.utils').notify_missing_plugin('lualine.nvim')
  return
end

-- TODO: hide, show on specific filetypes

lualine.setup({
  options = {
    section_separators = { left = ' ', right = ' ' },
    component_separators = { left = ' ', right = ' ' },
    disabled_filetypes = { 'alpha', 'NvimTree' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = { 'branch', 'diff', 'diagnostics' },
    lualine_x = { 'filetype', 'encoding', 'fileformat' },
    lualine_y = { 'location', 'progress' },
    lualine_z = { 'os.date("%H:%M")' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { 'filename' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'location', 'progress' },
    lualine_z = {},
  },
})

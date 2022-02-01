local present, null_ls = pcall(require, 'null-ls')
if not present then
  require('vima.utils').notify_missing('null-ls.nvim')
  return
end

local sources = {}

for _, lang in pairs(require('vima.languages').supported_languages) do
  -- try to load language config
  local present, lang_config = pcall(require, 'vima.languages.' .. lang)

  if present then
    sources = vim.tbl_deep_extend('force', sources, lang_config.get_null_ls_config(null_ls))
  end
end

null_ls.setup({
  debug = false,
  update_in_insert = true,
  sources = sources,
})

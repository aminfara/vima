local present, alpha = pcall(require, 'alpha')
if not present then
  require('vima.utils').notify_missing_plugin('alpha-nvim')
  return
end

local present, npairs = pcall(require, 'nvim-autopairs')
if not present then
  require('vima.utils').notify_missing_plugin('nvim-autopairs')
  return
end

npairs.setup({
  check_ts = true,
  ts_config = {},
  disable_filetype = { 'TelescopePrompt' },
  fast_wrap = {},
})

-- Map <CR>
-- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo

local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local present, cmp = pcall(require, 'cmp')
if not present then
  require('vima.utils').notify_missing_plugin('nvim-cmp')
  return
end

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

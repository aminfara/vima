-- Low level native mappings
-- TODO more UX mappings

vim.g.mapleader = ' '

local map = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }
local expr_options = { noremap = true, silent = true, expr = true }

-- empty mode is same as using :map

map('', '<Space>', '<NOP>', options)
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
map('', 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', expr_options)
map('', 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', expr_options)
map('', '<Down>', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', expr_options)
map('', '<Up>', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', expr_options)

-- normal mode

map('n', '<Esc>', '<Cmd>noh<CR>', options)
map('n', 'x', '"_d', options) -- do not copy deleted in register
map('n', 'xx', '"_dd', options)

-- insert mode

map('i', 'jk', '<Esc>', options)
map('i', 'kj', '<Esc>', options)

-- visual mode

map('v', 'x', '"_d', options) -- do not copy deleted in register
map('v', 'p', '"_dP', options) -- do not copy deleted text in register after paste

-- which-key mappings

local present, which_key = pcall(require, 'which-key')
if not present then
  require('vima.utils').notify_missing_plugin('which-key.nvim')
  vim.notify('Key mappings are not loaded', 'error', { title = 'Key mappings' })
  return
end

-- TODO: Add spellings

which_key.setup({
  window = {
    border = 'rounded',
  },
  presets = {
    operators = true,
    motions = true,
    text_objects = true,
    windows = true,
    nav = true,
    z = true,
    g = true,
  },
  triggers_blacklist = {
    i = { 'j', 'k' },
    v = { 'j', 'k' },
    n = { 'v' },
  },
})

which_key.register({
  ['<leader>'] = {
    f = { -- TODO: Add LSP finders
      name = 'Find',
      b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
      d = { '<cmd>Telescope diagnostics<cr>', 'Diagnostics' },
      f = { '<cmd>Telescope find_files<cr>', 'Files' },
      g = { '<cmd>Telescope live_grep<cr>', 'Grep' },
      h = { '<cmd>Telescope help_tags<cr>', 'Help tags' },
      j = { '<cmd>Telescope jumplist<cr>', 'Jump list' },
      q = { '<cmd>Telescope quickfix<cr>', 'Quickfix' },
      r = { '<cmd>Telescope oldfiles<cr>', 'Recent file' },
      R = { '<cmd>Telescope registers<cr>', 'Registers' },
      s = { '<cmd>Telescope git_status<cr>', 'Git status' },
      t = { '<cmd>Telescope<cr>', 'Telescope' },
    },
  },
}, { mode = 'n' })

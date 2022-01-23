-- Low level native mappings

vim.g.mapleader = ' '

local map = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }
local expr_options = { noremap = true, silent = true, expr = true }

map('', '<Space>', '<NOP>', options)

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

--------------------------------------------------------------------------------
-- core mappings

which_key.register({
  ['<Esc>'] = { '<Cmd>noh<CR>', 'Remove search highlights' },

  -- better delete / yank
  x = { '"_d', 'Delete without yank' },
  ['xx'] = { '"_dd', 'Delete line without yank' },
  Y = { 'yg$', 'Yank to the end of line' },

  -- better window management
  ['<C-h>'] = { '<C-w>h', 'Window Left' },
  ['<C-j>'] = { '<C-w>j', 'Window Down' },
  ['<C-k>'] = { '<C-w>k', 'Window Up' },
  ['<C-l>'] = { '<C-w>l', 'Window Right' },
  ['<C-S-Down>'] = { '<cmd>resize -2<CR>', 'Shrink window vertically' },
  ['<C-S-Up>'] = { '<cmd>resize +2<CR>', 'Extend window vertically' },
  ['<C-S-Left>'] = { '<cmd>vertical resize -2<CR>', 'Shrink window horizontally' },
  ['<C-S-Right>'] = { '<cmd>vertical resize +2<CR>', 'Extend window horizontally' },

  -- QuickFix
  ['[q'] = { ':cprev<CR>', 'Previous QuickFix' },
  [']q'] = { ':cnext<CR>', 'Next QuickFix' },
  ['<C-q>'] = { require('vima.utils').toggle_quickfix_window, 'Toggle QuickFix' },
}, { mode = 'n' })

which_key.register({
  -- better delete / yank
  x = { '"_d', 'Delete without yank' },
  p = { '"_dP', 'Paste without yank' },

  -- better indent
  ['<'] = { '<gv', 'Indent left' },
  ['>'] = { '>gv', 'Indent right' },
}, { mode = 'v' })

which_key.register({
  -- back to normal mode
  ['jj'] = { '<Esc>', 'Normal mode' },
  ['jk'] = { '<Esc>', 'Normal mode' },
  ['kj'] = { '<Esc>', 'Normal mode' },
  ['kk'] = { '<Esc>', 'Normal mode' },

  --better movements
  ['<C-h>'] = { '<Left>', 'Move left' },
  ['<C-j>'] = { '<Down>', 'Move down' },
  ['<C-k>'] = { '<Up>', 'Move up' },
  ['<C-l>'] = { '<Right>', 'Move right' },
  ['<C-a>'] = { '<Esc>I', 'Insert at the beginning of line' },
  ['<C-e>'] = { '<Esc>A', 'Insert at the end of line' },
}, { mode = 'i' })

which_key.register({
  -- wildmenu next/prev
  ['<C-j>'] = { 'pumvisible() ? "<C-n>" : "<C-j>"', 'Next', expr = true, silent = false },
  ['<C-k>'] = { 'pumvisible() ? "<C-p>" : "<C-k>"', 'Previous', expr = true, silent = false },
}, { mode = 'c' })

--------------------------------------------------------------------------------
-- plugin mappings

which_key.register({
  -- leader mappings
  ['<leader>'] = {
    t = { -- TODO: Add LSP finders
      name = 'Telescope',
      b = { '<Cmd>Telescope buffers<CR>', 'Buffers' },
      c = { '<Cmd>Telescope command_history<CR>', 'Command history' },
      C = { '<Cmd>Telescope commands<CR>', 'Commands' },
      d = { '<Cmd>Telescope diagnostics<CR>', 'Diagnostics' },
      f = { '<Cmd>Telescope find_files<CR>', 'Files' },
      g = { '<Cmd>Telescope live_grep<CR>', 'Grep' },
      h = { '<Cmd>Telescope help_tags<CR>', 'Help tags' },
      j = { '<Cmd>Telescope jumplist<CR>', 'Jump list' },
      q = { '<Cmd>Telescope quickfix<CR>', 'Quickfix' },
      R = { '<Cmd>Telescope oldfiles<CR>', 'Recent file' },
      r = { '<Cmd>Telescope registers<CR>', 'Registers' },
      s = { '<Cmd>Telescope git_status<CR>', 'Git status' },
      t = { '<Cmd>Telescope<CR>', 'Telescope' },
    },
  },
}, { mode = 'n' })

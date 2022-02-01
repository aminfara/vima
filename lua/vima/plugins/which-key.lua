local M = {}

local present, which_key = pcall(require, 'which-key')
if not present then
  require('vima.utils').notify_missing('which-key.nvim')
  vim.notify('Key mappings are not loaded', 'error', { title = 'Key mappings' })
end

M.setup_core_mappings = function()
  if not present then
    return
  end

  -- Low level native mappings

  vim.g.mapleader = ' '

  local map = vim.api.nvim_set_keymap
  local options = { noremap = true, silent = true }
  local expr_options = { noremap = true, silent = true, expr = true }

  map('', '<Space>', '<NOP>', options)

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
    ['jk'] = { '<Esc>', 'Normal mode' },
    ['kj'] = { '<Esc>', 'Normal mode' },

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
end
--------------------------------------------------------------------------------
-- plugin mappings

M.setup_plugin_mappings = function()
  if not present then
    return
  end

  which_key.register({
    -- trigger which_key
    ['<C-_>'] = { '<Cmd>WhichKey<CR>', 'Trigger which-key' },

    -- leader mappings
    ['<leader>'] = {
      e = {
        name = 'File tree',
        e = { '<Cmd>NvimTreeToggle<CR>', 'Toggle file tree' },
        f = { '<Cmd>NvimTreeFocus<CR>', 'Focus file tree' },
      },
      f = { -- TODO: Add LSP finders
        name = 'Find',
        b = { '<Cmd>Telescope buffers<CR>', 'Buffers' },
        c = { '<Cmd>Telescope command_history<CR>', 'Command history' },
        C = { '<Cmd>Telescope commands<CR>', 'Commands' },
        d = { '<Cmd>Telescope diagnostics<CR>', 'Diagnostics' },
        f = { '<Cmd>Telescope find_files<CR>', 'Files' },
        g = { '<Cmd>Telescope live_grep<CR>', 'Grep' },
        h = { '<Cmd>Telescope help_tags<CR>', 'Help tags' },
        j = { '<Cmd>Telescope jumplist<CR>', 'Jump list' },
        p = { '<Cmd>Telescope projects<CR>', 'Projects' },
        q = { '<Cmd>Telescope quickfix<CR>', 'Quickfix' },
        r = { '<Cmd>Telescope oldfiles<CR>', 'Recent file' },
        R = { '<Cmd>Telescope registers<CR>', 'Registers' },
        s = { '<Cmd>Telescope git_status<CR>', 'Git status' },
        T = { '<Cmd>Telescope<CR>', 'Telescope' },
      },
      s = {
        name = 'Treesitter',
        i = { '<Cmd>TSInstallInfo<CR>', 'Install info' },
        c = { '<Cmd>TSConfigInfo<CR>', 'Config info' },
        u = { '<Cmd>TSUpdate<CR>', 'Update parsers' },
        h = { '<Cmd>TSBufToggle highlight<CR>', 'Toggle highlights' },
      },
    },

    -- treesitter incremental select
    ['gnn'] = 'Init incremental select',

    -- treesitter text_objects movements
    [']b'] = 'Next block start',
    [']m'] = 'Next method start',
    [']]'] = 'Next class start',
    [']B'] = 'Next block end',
    [']M'] = 'Next method end',
    [']['] = 'Next class end',
    ['[b'] = 'Previous block start',
    ['[m'] = 'Previous method start',
    ['[['] = 'Previous class start',
    ['[B'] = 'Previous block end',
    ['[M'] = 'Previous method end',
    ['[]'] = 'Previous class end',
  }, { mode = 'n' })

  which_key.register({
    -- treesitter text_objects
    ['ab'] = 'outer block',
    ['ib'] = 'inner block',
    ['ac'] = 'outer class',
    ['ic'] = 'inner class',
    ['a/'] = 'comment',
    ['i/'] = 'comment',
    ['ai'] = 'outer conditional',
    ['ii'] = 'inner conditional',
    ['af'] = 'outer function',
    ['if'] = 'inner function',
    ['al'] = 'outer loop',
    ['il'] = 'inner loop',
  }, { mode = 'o' })

  which_key.register({
    -- treesitter incremental select
    ['gr'] = {
      name = 'Incremental select',
      n = 'Increase node select',
      m = 'Decrease node select',
      c = 'Increase scope select',
    },
    -- treesitter text_objects
    ['ab'] = 'outer block',
    ['ib'] = 'inner block',
    ['ac'] = 'outer class',
    ['ic'] = 'inner class',
    ['a/'] = 'comment',
    ['i/'] = 'comment',
    ['ai'] = 'outer conditional',
    ['ii'] = 'inner conditional',
    ['af'] = 'outer function',
    ['if'] = 'inner function',
    ['al'] = 'outer loop',
    ['il'] = 'inner loop',
  }, { mode = 'v' })
end

M.setup_gitsigns_mappings = function(gs, bufnr)
  if not present then
    return
  end

  which_key.register({

    -- Navigation
    ['[c'] = { "&diff ? '[c' : '<Cmd>Gitsigns prev_hunk<CR>'", 'Previous git hunk', expr = true },
    [']c'] = { "&diff ? ']c' : '<Cmd>Gitsigns next_hunk<CR>'", 'Next git hunk', expr = true },

    g = {
      b = {
        name = 'Block comment',
        c = 'Current line',
      },
      c = {
        name = 'Line comment',
        A = 'Add end of line',
        c = 'Current line',
        o = 'Add next line',
        O = 'Add prev line',
      },
    },

    -- Actions
    ['<leader>'] = {
      g = {
        name = 'Git',
        b = {
          function()
            gs.blame_line({ full = true })
          end,
          'Blame current line',
        },
        B = { gs.toggle_current_line_blame, 'Toggle line blame' },
        d = { gs.diffthis, 'Diff' },
        D = {
          function()
            gs.diffthis('~')
          end,
          'Diff last commit',
        },
        n = { gs.next_hunk, 'Next hunk' },
        p = { gs.prev_hunk, 'Previous hunk' },
        P = { gs.preview_hunk, 'Preview hunk' },
        s = { gs.stage_hunk, 'Stage hunk' },
        S = { gs.stage_buffer, 'Stage buffer' },
        r = { gs.reset_hunk, 'Reset hunk' },
        R = { gs.reset_buffer, 'Reset Buffer' },
        u = { gs.undo_stage_hunk, 'Undo stage hunk' },
      },
    },
  }, { mode = 'n', buffer = bufnr })

  -- Text object
  which_key.register({
    ['ih'] = { ':<C-U>Gitsigns select_hunk<CR>', 'git hunk' },
    ['ah'] = { ':<C-U>Gitsigns select_hunk<CR>', 'git hunk' },
  }, { mode = 'o' })

  which_key.register({
    ['ih'] = { ':<C-U>Gitsigns select_hunk<CR>', 'git hunk' },
    ['ah'] = { ':<C-U>Gitsigns select_hunk<CR>', 'git hunk' },
    g = {
      b = 'Block comment',
      c = 'Line comment',
    },
  }, { mode = 'v' })
end

M.setup_toggleterm_mappings = function(terminals)
  local opts = { noremap = true }
  vim.api.nvim_set_keymap('t', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_set_keymap('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_set_keymap('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_set_keymap('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_set_keymap('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)

  local terminal_mappings = {
    name = 'Terminal',
    ['1'] = { '<Cmd>1ToggleTerm<CR>', 'Toggle main terminal (1)' },
    ['2'] = { '<Cmd>2ToggleTerm<CR>', 'Toggle second terminal' },
    ['3'] = { '<Cmd>3ToggleTerm<CR>', 'Toggle third terminal' },
    ['4'] = { '<Cmd>4ToggleTerm<CR>', 'Toggle forth terminal' },
    t = { '<Cmd>1ToggleTerm<CR>', 'Toggle main terminal (1)' },
    a = { '<Cmd>ToggleTermToggleAll<CR>', 'Toggle all terminals' },
    f = { '<Cmd>Telescope termfinder find<CR>', 'Find' },
  }

  terminal_mappings = vim.tbl_deep_extend('force', terminal_mappings, terminals)

  which_key.register({
    ['<C-t>'] = 'ToggleTerm', -- Add a label to toggleterm trigger
    ['<leader>'] = {
      ['ft'] = { '<Cmd>Telescope termfinder find<CR>', 'Terminals' },
      t = terminal_mappings,
    },
  }, { mode = 'n' })
end

M.get_lsp_mappings = function(bufnr)
  which_key.register({
    ['gd'] = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'Go to definition' },
    ['gD'] = { '<cmd>lua vim.lsp.buf.declaration()<CR>', 'Go to declaration' },
    ['gh'] = { '<cmd>lua vim.lsp.buf.hover({ border = "rounded" })<CR>', 'Hover' },
    ['gl'] = { '<cmd>lua vim.diagnostic.open_float()<CR>', 'Line diagnostics' },
    -- TODO: use Telescope for references and diagnostics
  }, { buffer = bufnr })
end

return M

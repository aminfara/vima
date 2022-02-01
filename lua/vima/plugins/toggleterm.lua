local present, toggleterm = pcall(require, 'toggleterm')
if not present then
  require('vima.utils').notify_missing('toggleterm.nvim')
  vim.notify('Key mappings are not loaded', 'error', { title = 'Key mappings' })
end

toggleterm.setup({
  size = 25,
  open_mapping = [[<c-t>]],
  float_opts = {
    border = 'curved',
  },
})

local function register_q(term)
  vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
end

local Terminal = require('toggleterm.terminal').Terminal
local terminals = {}

if vim.fn.executable('lazygit') > 0 then
  local lazygit = Terminal:new({
    cmd = 'lazygit',
    direction = 'float',
    count = 5,
    on_open = register_q,
  })
  terminals['g'] = {
    function()
      lazygit:toggle()
    end,
    'LazyGit',
  }
end

if vim.fn.executable('htop') > 0 then
  local htop = Terminal:new({ cmd = 'htop', direction = 'float', count = 6 })
  terminals['h'] = {
    function()
      htop:toggle()
    end,
    'htop',
  }
end

if vim.fn.executable('python3') > 0 then
  local cmd = 'python3'
  if vim.fn.executable('bpython') > 0 then
    cmd = 'python3 -m bpython'
  end
  local python = Terminal:new({ cmd = cmd, count = 7 })
  terminals['p'] = {
    function()
      python:toggle()
    end,
    'Python',
  }
end

if vim.fn.executable('node') > 0 then
  local node = Terminal:new({ cmd = 'node', count = 8 })
  terminals['n'] = {
    function()
      node:toggle()
    end,
    'NodeJS',
  }
end

if vim.fn.executable('ts-node') > 0 or vim.fn.executable('node_modules/.bin/ts-node') then
  local cmd = 'ts-node'
  if vim.fn.executable('node_modules/.bin/ts-node') then
    cmd = 'npx ts-node'
  end
  local tsnode = Terminal:new({ cmd = cmd, count = 9 })
  terminals['y'] = {
    function()
      tsnode:toggle()
    end,
    'TSNode',
  }
end

require('vima.plugins.which-key').setup_toggleterm_mappings(terminals)

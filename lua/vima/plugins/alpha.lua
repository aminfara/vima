local present, alpha = pcall(require, 'alpha')
if not present then
  require('vima.utils').notify_missing_plugin('alpha-nvim')
  return
end

local default_header = {
  type = 'text',
  val = {
    [[            /   /                 ]],
    [[           /   /                  ]],
    [[ __    _ __\_  \___    __  ____   ]],
    [[\  \  //|    ||    \  /  ||    \  ]],
    [[ \  \// |    ||     \/   ||     \ ]],
    [[  \__/  |____||__/\__/|__||__|\__\]],
    [[         /  /                     ]],
    [[        / /                       ]],
    [[       //                         ]],
    [[      /                           ]],
  },
  opts = {
    position = 'center',
    hl = 'Type',
  },
}

local footer = {
  type = 'text',
  val = {
    [[https://github.com/aminfara/vima]],
    [[                                ]],
    [[         Try <C-/>              ]],
  },
  opts = {
    position = 'center',
    hl = 'Number',
  },
}

-- from https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/dashboard.lua
local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')

  local opts = {
    position = 'center',
    shortcut = sc,
    cursor = 5,
    width = 50,
    align_shortcut = 'right',
    hl_shortcut = 'Keyword',
  }
  if keybind then
    keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { 'n', sc_, keybind, keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
    vim.api.nvim_feedkeys(key, 'normal', false)
  end

  return {
    type = 'button',
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

local buttons = {
  type = 'group',
  val = {
    button('e', '  New file', '<Cmd>ene <CR>'),
    -- TODO: add projects
    button('SPC f f', '  Find file'),
    button('SPC f r', '  Recently opened files'),
    button('SPC f g', '  Find word'),
    button('q', '  Exit vima', '<Cmd>q<CR>'),
  },
  opts = {
    spacing = 1,
  },
}

local config = {
  layout = {
    { type = 'padding', val = 6 },
    default_header,
    { type = 'padding', val = 6 },
    buttons,
    { type = 'padding', val = 2 },
    footer,
  },
  opts = {
    margin = 5,
  },
}

alpha.setup(config)

local present, packer = pcall(require, 'packer')

if not present then
  local packer_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  vim.notify('Bootstrapping packer.nvim . . .')
  vim.fn.delete(packer_path, 'rf')
  PACKER_BOOTSTRAP = vim.fn.system({
    'git',
    'clone',
    'https://github.com/wbthomason/packer.nvim',
    '--depth',
    '20',
    packer_path,
  })
  vim.cmd('packadd packer.nvim')
  present, packer = pcall(require, 'packer')

  if present then
    vim.notify('Packer installed successfully.')
  else
    error('Could not bootstrap packer!')
    return false
  end
end

return packer.startup({
  function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')
    -- utility functions used by other plugins
    use('nvim-lua/plenary.nvim')
    -- icons used by other plugins
    use({
      'kyazdani42/nvim-web-devicons',
      event = 'VimEnter',
    })

    --color scheme
    use({
      'RRethy/nvim-base16',
      config = function()
        require('vima.plugins.colorscheme')
      end,
      after = { 'nvim-web-devicons' },
    })

    -- notifications
    use({
      'rcarriga/nvim-notify',
      config = function()
        require('vima.plugins.nvim-notify')
      end,
      after = 'nvim-base16',
    })

    -- statusline
    use({
      'nvim-lualine/lualine.nvim',
      config = function()
        require('vima.plugins.lualine')
      end,
      after = 'nvim-notify',
    })

    -- which-key shows possible keys
    use({
      'folke/which-key.nvim',
      config = function()
        require('vima.plugins.which-key').setup_core_mappings()
        require('vima.plugins.which-key').setup_plugin_mappings()
      end,
      after = 'nvim-notify',
    })

    -- telescope fuzzy finder
    use({
      'nvim-telescope/telescope.nvim',
      config = function()
        require('vima.plugins.telescope')
      end,
      after = { 'which-key.nvim' },
    })

    -- git management and signs
    use({
      'lewis6991/gitsigns.nvim',
      config = function()
        require('vima.plugins.gitsigns')
      end,
      after = { 'which-key.nvim' },
    })

    -- terminal management
    use({
      'akinsho/toggleterm.nvim',
      config = function()
        require('vima.plugins.toggleterm')
      end,
      after = { 'which-key.nvim' },
    })

    use({
      'tknightz/telescope-termfinder.nvim',
      config = function()
        local present, telescope = pcall(require, 'telescope')
        if present then
          telescope.load_extension('termfinder')
        end
      end,
      after = { 'telescope.nvim', 'toggleterm.nvim' },
    })

    -- init screen dashboard
    use({
      'goolord/alpha-nvim',
      config = function()
        require('vima.plugins.alpha')
      end,
      after = 'nvim-notify',
    })

    -- file explorer
    use({
      'kyazdani42/nvim-tree.lua',
      config = function()
        require('vima.plugins.nvim-tree')
      end,
      after = 'nvim-notify',
    })

    -- project manager
    use({
      'ahmedkhalf/project.nvim',
      config = function()
        require('vima.plugins.project')
      end,
      after = { 'telescope.nvim', 'nvim-tree.lua' },
    })

    use({
      'andymass/vim-matchup',
      event = 'BufRead',
      after = 'nvim-notify',
    })

    -- Treesitter syntax support
    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      event = 'BufRead',
      after = { 'nvim-notify', 'vim-matchup' },
    })

    use({
      'p00f/nvim-ts-rainbow', -- Rainbow brackets
      after = { 'nvim-treesitter' },
    })

    use({
      'nvim-treesitter/nvim-treesitter-textobjects',
      after = { 'nvim-ts-rainbow' },
    })

    use({
      'JoosepAlviste/nvim-ts-context-commentstring',
      config = function()
        require('vima.plugins.treesitter')
      end,
      after = { 'nvim-treesitter-textobjects' },
    })

    -- context aware commenting
    use({
      'numToStr/Comment.nvim',
      after = { 'nvim-ts-context-commentstring' },
      config = function()
        require('vima.plugins.comment')
      end,
    })

    -- indent blank lines
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('vima.plugins.indent-blankline')
      end,
      after = 'nvim-treesitter',
    })

    -- autocomplete and snippets plugins
    use({
      'rafamadriz/friendly-snippets',
      module = 'cmp_luasnip',
      event = 'InsertEnter',
    })

    use({
      'L3MON4D3/LuaSnip',
      requires = 'friendly-snippets',
      after = 'nvim-notify',
    })

    use({
      'hrsh7th/nvim-cmp',
      config = function()
        require('vima.plugins.nvim-cmp')
      end,
      after = { 'LuaSnip' },
    })

    use({
      'hrsh7th/cmp-nvim-lsp',
      after = { 'nvim-cmp' },
    })

    use({
      'hrsh7th/cmp-buffer',
      after = { 'nvim-cmp' },
    })

    use({
      'hrsh7th/cmp-path',
      after = { 'nvim-cmp' },
    })

    use({
      'hrsh7th/cmp-cmdline',
      after = { 'nvim-cmp' },
    })

    use({
      'saadparwaiz1/cmp_luasnip',
      after = { 'nvim-cmp' },
    })

    -- auto paris
    use({
      'windwp/nvim-autopairs',
      config = function()
        require('vima.plugins.autopairs')
      end,
      after = { 'nvim-cmp' },
    })

    -- language servers
    use({
      'folke/lua-dev.nvim',
      ft = { 'lua' },
      after = 'nvim-notify',
    })

    use({
      'neovim/nvim-lspconfig',
      ft = require('vima.languages').supported_languages,
      after = 'nvim-notify',
    })

    use({
      'ray-x/lsp_signature.nvim',
      after = 'nvim-lspconfig',
    })

    use({
      'jose-elias-alvarez/null-ls.nvim',
      after = { 'nvim-lspconfig' },
    })

    use({
      'williamboman/nvim-lsp-installer',
      config = function()
        require('vima.plugins.lsp')
      end,
      after = { 'lsp_signature.nvim', 'cmp-nvim-lsp', 'null-ls.nvim' },
    })

    -- Fix cursor hold delay
    use({
      'antoinemadec/FixCursorHold.nvim',
      after = 'nvim-notify',
    })

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
      vim.cmd('hi clear Pmenu')
      vim.cmd([[autocmd User PackerComplete execute "PackerLoad nvim-web-devicons alpha-nvim" | q | Alpha]])
      packer.sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end,
    },
  },
})

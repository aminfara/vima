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
      event = 'VimEnter',
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

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
      vim.cmd('hi clear Pmenu')
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

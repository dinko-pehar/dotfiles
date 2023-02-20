local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') ..
                             '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            'git', 'clone', '--depth', '1',
            'https://github.com/wbthomason/packer.nvim', install_path
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Themes
    use "savq/melange-nvim"
    use 'lifepillar/vim-gruvbox8'
    use {"bluz71/vim-nightfly-colors", as = "nightfly"}
    use 'folke/tokyonight.nvim'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons' -- optional, for file icons
        },
        config = function() require("nvim-tree").setup() end,
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use {
        'ms-jpq/chadtree',
        branch = 'chad',
        run = 'python3 -m chadtree deps',
        config = function()
            -- silent means no displayed in CMD
            vim.api.nvim_set_keymap('n', '<F2>', ':CHADopen<CR>',
                                    {noremap = true, silent = true})
            local chadtree_settings = {theme = {text_colour_set = 'nord'}}
            vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
        end,
        requires = 'arcticicestudio/nord-dircolors'
    }

    use {
        'akinsho/bufferline.nvim',
        tag = "v3.2.0",
        requires = 'nvim-tree/nvim-web-devicons'
    }

    use {
        'Eandrju/cellular-automaton.nvim',
        requires = 'nvim-treesitter/nvim-treesitter'
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup(require('custom.lualine'))
        end,
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use {
        'gelguy/wilder.nvim',
        config = function() require('wilder').setup({modes = {':', '?'}}) end
    }

    use {'sbdchd/neoformat'}
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup(require('custom.dashboard'))
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }

    use {'LnL7/vim-nix'}

    use {'dstein64/vim-startuptime'}

    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }

    if packer_bootstrap then require('packer').sync() end
end)

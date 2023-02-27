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
    use 'lifepillar/vim-gruvbox8'
    -- Themes

    -- Core --
    use {
        "numToStr/FTerm.nvim",
        config = function()

            -- Example keybindings
            vim.keymap
                .set('n', '<F3>', '<CMD>lua require("FTerm").toggle()<CR>')
            vim.keymap.set('t', '<F3>',
                           '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
        end
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons' -- optional, for file icons
        },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            local lib = require("nvim-tree.lib")
            local view = require("nvim-tree.view")

            local function collapse_all()
                require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
            end

            local function edit_or_open()
                -- open as vsplit on current node
                local action = "edit"
                local node = lib.get_node_at_cursor()

                -- Just copy what's done normally with vsplit
                if node.link_to and not node.nodes then
                    require('nvim-tree.actions.node.open-file').fn(action,
                                                                   node.link_to)

                elseif node.nodes ~= nil then
                    lib.expand_or_collapse(node)

                else
                    require('nvim-tree.actions.node.open-file').fn(action,
                                                                   node.absolute_path)
                end

            end

            local function vsplit_preview()
                -- open as vsplit on current node
                local action = "vsplit"
                local node = lib.get_node_at_cursor()

                -- Just copy what's done normally with vsplit
                if node.link_to and not node.nodes then
                    require('nvim-tree.actions.node.open-file').fn(action,
                                                                   node.link_to)

                elseif node.nodes ~= nil then
                    lib.expand_or_collapse(node)

                else
                    require('nvim-tree.actions.node.open-file').fn(action,
                                                                   node.absolute_path)

                end

            end
            require("nvim-tree").setup({
                filters = {custom = {"^\\.git$"}},
                view = {
                    hide_root_folder = true,
                    mappings = {
                        custom_only = false,
                        list = {
                            {
                                key = "e",
                                action = "edit",
                                action_cb = edit_or_open
                            },
                            {
                                key = "v",
                                action = "vsplit_preview",
                                action_cb = vsplit_preview
                            }, {key = "h", action = "close_node"},
                            {
                                key = "H",
                                action = "collapse_all",
                                action_cb = collapse_all
                            }
                        }
                    }
                },
                renderer = {icons = {git_placement = "after"}},
                actions = {open_file = {quit_on_open = false}}
            })
            vim.api.nvim_set_keymap("n", "<F2>", ":NvimTreeToggle<cr>",
                                    {silent = true, noremap = true})
            -- vim.api.nvim_create_autocmd({"VimEnter"}, --{
            -- callback = function()
            -- require("nvim-tree.api").tree.open({
            --    path = nil,
            --   current_window = false,
            --    find_file = false,
            --    update_root = false
            -- })
            -- end
            -- })
        end,
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use {
        'kdheepak/tabline.nvim',
        config = function()
            require'tabline'.setup {
                -- Defaults configuration options
                enable = true,
                options = {
                    -- If lualine is installed tabline will use separators configured in lualine by default.
                    -- These options can be used to override those settings.
                    section_separators = {'', ''},
                    component_separators = {'', ''},
                    max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
                    show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
                    show_devicons = true, -- this shows devicons in buffer section
                    show_bufnr = false, -- this appends [bufnr] to buffer section,
                    show_filename_only = true, -- shows base filename only instead of relative path in filename
                    modified_icon = "+ ", -- change the default modified icon
                    modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
                    show_tabs_only = true -- this shows only tabs instead of tabs + buffers
                }
            }
            vim.cmd [[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
    ]]
        end,
        requires = {
            {'hoob3rt/lualine.nvim', opt = true},
            {'kyazdani42/nvim-web-devicons', opt = true}
        }
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({options = {theme = 'horizon'}})
        end,
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
        'gelguy/wilder.nvim',
        config = function()
            local wilder = require('wilder')
            wilder.setup({modes = {':', '/', '?'}})

            local highlighters = {
                wilder.basic_highlighter(), wilder.lua_fzy_highlighter()
            }

            local popupmenu_renderer = wilder.popupmenu_renderer(
                                           wilder.popupmenu_border_theme({
                    border = 'rounded',
                    empty_message = wilder.popupmenu_empty_message_with_spinner(),
                    highlighter = highlighters,
                    left = {
                        ' ', wilder.popupmenu_devicons(),
                        wilder.popupmenu_buffer_flags({
                            flags = ' a + ',
                            icons = {['+'] = '', a = '', h = ''}
                        })
                    },
                    right = {' ', wilder.popupmenu_scrollbar()}
                }))

            local wildmenu_renderer = wilder.wildmenu_renderer({
                highlighter = highlighters,
                separator = ' · ',
                left = {' ', wilder.wildmenu_spinner(), ' '},
                right = {' ', wilder.wildmenu_index()}
            })

            wilder.set_option('renderer', wilder.renderer_mux({
                [':'] = popupmenu_renderer,
                ['/'] = wildmenu_renderer,
                substitute = wildmenu_renderer
            }))
        end,
        requires = {'romgrk/fzy-lua-native', opt = false}
    }
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = function()
            local builtin = require('telescope.builtin')
            vim.g.mapleader = ','
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end
    }
    use {
        'lewis6991/gitsigns.nvim',
        tag = 'release',
        config = function()
            require('gitsigns').setup({show_deleted = true})
        end
    }

    use 'nvim-treesitter/nvim-treesitter'

    -- Core

    -- Fun
    use {'Eandrju/cellular-automaton.nvim'}
    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup({
                theme = 'hyper',
                config = {
                    week_header = {enable = true},
                    shortcut = {
                        {
                            desc = ' Update',
                            group = '@property',
                            action = 'Lazy update',
                            key = 'u'
                        }, {
                            icon = ' ',
                            icon_hl = '@variable',
                            desc = 'Files',
                            group = 'Label',
                            action = 'Telescope find_files',
                            key = 'f'
                        }, {
                            desc = ' Apps',
                            group = 'DiagnosticHint',
                            action = 'Telescope app',
                            key = 'a'
                        }, {
                            desc = ' dotfiles',
                            group = 'Number',
                            action = 'Telescope dotfiles',
                            key = 'd'
                        }
                    }
                }
            })
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }
    use {'dstein64/vim-startuptime'}
    use {
        "m4xshen/smartcolumn.nvim",
        config = function()
            -- TODO: Update this with multiple cc after it's done.
            require("smartcolumn").setup({colorcolumn = 80})
        end
    }

    use {
        'karb94/neoscroll.nvim',
        config = function() require('neoscroll').setup() end

    }
    -- Fun

    -- Dev 
    require('packer').use {
        'mhartington/formatter.nvim',

        config = function()

            -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
            require("formatter").setup {
                logging = true,

                log_level = vim.log.levels.WARN,
                filetype = {
                    lua = {require("formatter.filetypes.lua").luaformat},
                    nix = {require("formatter.filetypes.nix").nixfmt},
                    json = {require("formatter.filetypes.json").jq},
                    python = {require("formatter.filetypes.python").black},
                    ruby = {require("formatter.filetypes.ruby").rubocop},
                    rust = {require("formatter.filetypes.rust").rustfmt},
                    toml = {require("formatter.filetypes.toml").taplo}
                }
            }
        end

    }

    use({
        "Pocco81/auto-save.nvim",
        config = function()
            -- FIXME: Enable autosave callbacks to format when it is fixed 
            require("auto-save").setup {}
        end
    })

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                signs = true,
                colors = {
                    error = {"DiagnosticError", "ErrorMsg", "#DC2626"},
                    warning = {"DiagnosticWarn", "WarningMsg", "#FBBF24"},
                    info = {"DiagnosticInfo", "#2563EB"},
                    hint = {"DiagnosticHint", "#10B981"},
                    default = {"Identifier", "#7C3AED"},
                    test = {"Identifier", "#FF00FF"}
                }
            }
        end
    }

    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }
    use {'LnL7/vim-nix'}
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    -- Dev

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        config = function()

            local lspconfig = require('lspconfig')


            local signs = {
                Error = " ",
                Warn = "",
                Hint = " ",
                Info = " "
            }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
            end

            vim.diagnostic.config({
                virtual_text = {
                    source = "if_many" -- Or "if_many"
                },
                float = {
                    source = "if_many" -- Or "if_many"
                }
            })

            local on_attach = function(client, bufnr)
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc',
                                            'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = {noremap = true, silent = true, buffer = bufnr}
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                vim.keymap
                    .set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                -- Telescope specific for references
                vim.keymap.set('n', 'gr', function()
                    require('telescope.builtin').lsp_references()
                end, {noremap = true, silent = true})

                -- Workspace specific
                vim.keymap.set('n', '<space>wa',
                               vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wr',
                               vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts)

                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition,
                               bufopts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<space>f', function()
                    vim.lsp.buf.format {async = true}
                end, bufopts)

            end

            local lua_ls = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {'vim'}
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true)
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {enable = false}
                }
            }

            lspconfig['pyright'].setup({
                on_attach = on_attach
            })
            lspconfig['lua_ls'].setup({
                on_attach = on_attach,
                settings = lua_ls
            })
        end
    }
    -- use({
    --     "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    --     config = function()
    --         vim.diagnostic.config({virtual_text = false})
    --         require("lsp_lines").setup()
    --         -- Disable virtual_text since it's redundant due to lsp_lines.
    --     end
    -- })
    use {
        'simrat39/symbols-outline.nvim',

        config = function()
            require("symbols-outline").setup()

            vim.api.nvim_set_keymap("n", "<F8>", ":SymbolsOutline<cr>",
                                    {silent = true, noremap = true})

        end

    }
    -- use {
    --     "amrbashir/nvim-docs-view",
    --     opt = true,
    --     cmd = {"DocsViewToggle"},
    --     config = function()
    --         require("docs-view").setup {position = "bottom"}
    --     end
    -- }
    -- use {
    --     'kosayoda/nvim-lightbulb',
    --     requires = 'antoinemadec/FixCursorHold.nvim',
    --     config = function()
    --         require('nvim-lightbulb').setup({autocmd = {enabled = true}})
    --     end
    -- }
    use {
        'mfussenegger/nvim-lint',
        config = function()
            vim.api.nvim_create_autocmd({"BufWritePost"}, {
                callback = function() require("lint").try_lint() end
            })
            require('lint').linters_by_ft = {
                python = {'bandit', 'vulture', 'flake8'},
                nix = {'nix'}
            }
        end
    }
    -- use {
    --
    --     "ray-x/lsp_signature.nvim",
    --     config = function() require"lsp_signature".setup() end
    -- }
    -- LSP

    if packer_bootstrap then require('packer').sync() end
end)

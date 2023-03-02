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

            local fterm = require("FTerm")

            local term_1 = fterm:new({
                ft = 'Terminal_1',
                dimensions = {width = 0.5, height = 0.7},
                border = "double"
            })
            local term_2 = fterm:new({
                ft = 'Terminal_2',
                dimensions = {width = 0.5, height = 0.7},
                border = "double"
            })

            -- Example keybindings, allows creating 2 terminals.
            vim.keymap.set('n', '<F3>', function() term_1:toggle() end)
            vim.keymap.set('t', '<F3>', function() term_1:toggle() end)
            vim.keymap.set('n', '<leader><F3>', function()
                term_2:toggle()
            end)
            vim.keymap.set('t', '<leader><F3>', function()
                term_2:toggle()
            end)
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

            local nvim_tree = require('nvim-tree')

            nvim_tree.setup({
                filters = {custom = {"^\\.git$"}},
                live_filter = {
                    prefix = "[FILTER]: ",
                    always_show_folders = true
                },
                view = {hide_root_folder = true},
                renderer = {icons = {git_placement = "after"}},
                actions = {open_file = {quit_on_open = false}}
            })
            -- Focus on NVim-Tree
            vim.api.nvim_set_keymap("n", "<F2>", ":NvimTreeFocus<cr>",
                                    {silent = true, noremap = true})
            -- Closes NVim-Tree if open
            vim.api.nvim_set_keymap("n", "<leader><F2>", ":NvimTreeToggle<cr>",
                                    {silent = true, noremap = true})
        end,
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    -- use {
    --     'kdheepak/tabline.nvim',
    --     config = function()
    --         require'tabline'.setup {
    --             -- Defaults configuration options
    --             enable = true,
    --             options = {
    --                 -- If lualine is installed tabline will use separators configured in lualine by default.
    --                 -- These options can be used to override those settings.
    --                 section_separators = {'', ''},
    --                 component_separators = {'', ''},
    --                 max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
    --                 show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
    --                 show_devicons = true, -- this shows devicons in buffer section
    --                 show_bufnr = false, -- this appends [bufnr] to buffer section,
    --                 show_filename_only = true, -- shows base filename only instead of relative path in filename
    --                 modified_icon = "+ ", -- change the default modified icon
    --                 modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
    --                 show_tabs_only = true -- this shows only tabs instead of tabs + buffers
    --             }
    --         }
    --         vim.cmd [[
    --   set guioptions-=e " Use showtabline in gui vim
    --   set sessionoptions+=tabpages,globals " store tabpages and globals in session
    -- ]]
    --     end,
    --     requires = {
    --         {'hoob3rt/lualine.nvim', opt = true},
    --         {'kyazdani42/nvim-web-devicons', opt = true}
    --     }
    -- }

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
            -- Set up Wilder modes (Command and search).
            local modes = {modes = {':', '/'}}
            wilder.setup(modes)

            -- Pipelines define how each of the modes would use it's filters.
            -- Similar to Signals, Hooks or Events callbacks based on
            -- particular mode.
            wilder.set_option('pipeline', {
                wilder.branch(wilder.python_file_finder_pipeline({
                    file_command = function(ctx, arg)
                        if string.find(arg, '.') ~= nil then
                            return {'rg', '--files'}
                        else
                            return {'rg', '--files'}
                        end
                    end,
                    dir_command = {'fd', '-td'},
                    filters = {'fuzzy_filter', 'difflib_sorter'},
                    debounce = 2
                }), wilder.cmdline_pipeline({
                    -- sets the language to use, 'vim' and 'python' are supported
                    language = 'vim',
                    -- 0 turns off fuzzy matching
                    -- 1 turns on fuzzy matching
                    -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
                    fuzzy = 2
                }), wilder.python_search_pipeline({
                    -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
                    pattern = wilder.python_fuzzy_delimiter_pattern(),
                    -- omit to get results in the order they appear in the buffer
                    sorter = wilder.python_difflib_sorter(),
                    engine = 're'
                }))
            })

            -- This is how Command mode should display.
            local command_mode = wilder.popupmenu_renderer(
                                     wilder.popupmenu_border_theme({
                    border = 'rounded',
                    empty_message = wilder.popupmenu_empty_message_with_spinner(),
                    highlights = {
                        accent = wilder.make_hl('WilderAccent', 'Pmenu', {
                            {a = 2}, {a = 2},
                            {foreground = '#fe8019', italic = true}
                        })
                    },
                    highlighter = {wilder.lua_fzy_highlighter()},
                    left = {
                        ' ', wilder.popupmenu_devicons(),
                        wilder.popupmenu_buffer_flags({
                            flags = ' a + ',
                            icons = {['+'] = '', a = '', h = ''}
                        })
                    },
                    right = {' ', wilder.popupmenu_scrollbar()}
                }))

            -- This is how search mode should display.
            local search_mode = wilder.wildmenu_renderer({
                highlighter = {wilder.lua_fzy_highlighter()},
                highlights = {
                    accent = wilder.make_hl('WilderAccent', 'Pmenu', {
                        {a = 1}, {a = 1},
                        {foreground = '#fe8019', italic = true}
                    })
                },
                separator = ' § ',
                left = {' ', wilder.wildmenu_spinner(), ' '},
                right = {' ', wilder.wildmenu_index()}
            })

            wilder.set_option('renderer', wilder.renderer_mux({
                [':'] = command_mode,
                ['/'] = search_mode,
                substitute = search_mode
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
        config = function()
            require('neoscroll').setup({
                hide_cursor = true,
                easing_function = "sine"
            })
        end
    }
    -- Fun

    -- Dev 
    use {
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
            -- HOTFIX:Enable autosave callbacks to format when it is fixed
            require("auto-save").setup {}
        end
    })

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            -- NOTE: :TodoTelescope command is supported along with keywords
            -- Example > :TodoTelescope keywords=TODO,FIX
            require("todo-comments").setup {
                signs = true,
                keywords = {
                    FIX = {
                        -- a set of other keywords that all map to this FIX keywords
                        alt = {"FIXME", "BUG", "FIXIT", "ISSUE", "HOTFIX"}
                    }
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
    use 'hrsh7th/nvim-cmp' -- Autocomplete plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP Source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use {
        'neovim/nvim-lspconfig',
        config = function()

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
                capabilities = capabilities,
                on_attach = on_attach
            })
            lspconfig['lua_ls'].setup({
                on_attach = on_attach,
                settings = lua_ls,
                capabilities = capabilities
            })

            -- Set up nvim-cmp.
            local cmp = require('cmp')
            -- luasnip setup yeaheahw
            local luasnip = require('luasnip')

            cmp.setup({
                enabled = function()
                    -- disable completion in comments
                    local context = require 'cmp.config.context'
                    -- keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == 'c' then
                        return true
                    else
                        return not context.in_treesitter_capture("comment") and
                                   not context.in_syntax_group("Comment")
                    end
                end,
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered()
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ['<CR>'] = cmp.mapping.confirm({select = true}),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, {'i', 's'}),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {'i', 's'})
                }),
                sources = {
                    {name = 'nvim_lsp'}, {name = 'snippy'},
                    {name = 'nvim_lsp_signature_help'}
                }
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
            require("symbols-outline").setup({
                width = 15,
                show_symbol_details = false,
                autofold_depth = 0,
                keymaps = { -- These keymaps can be a string or a table for multiple keys
                    close = {"<Esc>", "q"},
                    goto_location = "<Cr>",
                    focus_location = "o",
                    hover_symbol = "<C-space>",
                    toggle_preview = "K",
                    rename_symbol = "r",
                    code_actions = "a",
                    fold = "h",
                    unfold = "l",
                    fold_all = "W",
                    unfold_all = "E",
                    fold_reset = "R"
                }
            })

            vim.api.nvim_set_keymap("n", "<F8>", ":SymbolsOutline<cr>",
                                    {silent = true, noremap = true})

        end

    }
    use {
        'mfussenegger/nvim-lint',
        config = function()

            local nvim_lint = require('lint')

            vim.api.nvim_create_user_command('Lint', function() 
              nvim_lint.try_lint()
            end, {})

            local function file_exists(name)
                local f = io.open(name, "r")
                if f ~= nil then
                    io.close(f)
                    return true
                else
                    return false
                end
            end
            local bandit = require('lint').linters.bandit
            if file_exists('bandit.yml') then
                bandit.args = {
                    "-f", "custom", "-c", "bandit.yml", "--msg-template",
                    "{line}:{col}:{severity}:{test_id} {msg}"
                }
            end

            nvim_lint.linters_by_ft = {
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

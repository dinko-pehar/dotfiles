local function on_attach(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    -- Telescope specific for references
    vim.keymap.set("n", "gr", function()
        require("telescope.builtin").lsp_references()
    end, { noremap = true, silent = true })

    -- Workspace specific
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)

    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
end
local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
    { "b0o/schemastore.nvim" },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "j-hui/fidget.nvim", config = true },
            { "simrat39/rust-tools.nvim" },
            {
                "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
                config = true,
                init = function()
                    -- Disable virtual_text since it's redundant due to lsp_lines.
                    vim.diagnostic.config({ virtual_text = false })
                end,
            },
            {
                "hrsh7th/nvim-cmp",
                dependencies = {
                    { "hrsh7th/cmp-nvim-lsp" },
                    { "dcampos/nvim-snippy" },
                    { "dcampos/cmp-snippy" },
                    { "honza/vim-snippets" },
                    { "onsails/lspkind.nvim" },
                }
            },
        },
        config = function()
            local snippy = require("snippy")
            local cmp = require("cmp")
            cmp.setup({
                enabled = function()
                    -- disable completion in comments
                    local context = require("cmp.config.context")
                    -- keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    else
                        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                    end
                end,
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        before = function(_, vim_item)
                            return vim_item
                        end,
                    }),
                },
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        snippy.expand_snippet(args.body)
                    end,
                },
                window = { completion = cmp.config.window.bordered() },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif snippy.can_expand_or_advance() then
                            snippy.expand_or_advance()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif snippy.can_jump(-1) then
                            snippy.previous()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = { { name = "nvim_lsp" }, { name = "snippy" } },
            })
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            lspconfig["lua_ls"].setup({
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim" },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = { enable = false },
                    },
                },
                capabilities = capabilities,
            })
            lspconfig["pyright"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            local extended_capatibilities = require("cmp_nvim_lsp").default_capabilities()
            extended_capatibilities.textDocument.completion.completionItem.snippetSupport = true
            lspconfig["html"].setup({
                on_attach = on_attach,
                capabilities = extended_capatibilities,
            })
            lspconfig["cssls"].setup({
                on_attach = on_attach,
                capabilities = extended_capatibilities,
            })
            lspconfig["emmet_ls"].setup({
                on_attach = on_attach,
                filetypes = {
                    "html",
                    "typescriptreact",
                    "javascriptreact",
                    "css",
                    "sass",
                    "scss",
                    "less",
                    "eruby",
                    "jinja"
                },
                capabilities = capabilities,
            })
            lspconfig["jsonls"].setup({
                capabilities = extended_capatibilities,
                on_attach = on_attach,
                settings = {
                    json = {
                        schemas = vim.list_extend({
                            {
                                description = "PyRight Schema",
                                fileMatch = { ".pyrightconfig.json" },
                                name = "Pyrightconfig",
                                url = "https://raw.githubusercontent.com/fannheyward/coc-pyright/master/schemas/pyrightconfig.schema.json",
                            },
                        }, require("schemastore").json.schemas()),
                        validate = { enable = true },
                    },
                },
            })

            -- TODO:GradleLS, Java, GraphQL, Ruby
            for _, value in pairs({
                "tsserver",
                "gopls",
                "nil_ls",
                "dockerls",
                "docker_compose_language_service",
                "intelephense",
                "bashls",
                "cmake",
                "kotlin_language_server"
            }) do
                lspconfig[value].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end
            require("rust-tools").setup()

            -- Add Code diagnostic
            local signs = {
                Error = " ",
                Warn = "",
                Hint = " ",
                Info = " ",
            }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },
}

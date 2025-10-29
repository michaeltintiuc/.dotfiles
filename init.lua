-- Leader key
vim.g.mapleader = " "

-- Options
vim.opt.exrc = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.mouse = "a"
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.showmode = false
vim.opt.hidden = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.pumheight = 15
vim.opt.completeopt = { "menuone", "longest" }
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "•", extends = "#", nbsp = "." }
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.incsearch = true
vim.opt.cursorline = true
vim.opt.synmaxcol = 2048
vim.opt.lazyredraw = true
vim.opt.updatetime = 100
vim.opt.termguicolors = true
vim.opt.guicursor = ""
vim.opt.clipboard = "unnamedplus"

-- Plugin manager: lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    checker = { enabled = true },
    -- UI
    { "nvim-lualine/lualine.nvim", opts = { options = { theme = "gruvbox" } } },
    { "numToStr/Comment.nvim",     config = true },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    { "echasnovski/mini.move",                     version = "*",                             config = true },
    { "editorconfig/editorconfig-vim" },
    { "RRethy/base16-nvim" },
    { "kylechui/nvim-surround",                    version = "*",                             config = true },

    -- LSP & Completion
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    { 'nvimtools/none-ls.nvim' },

    -- Git
    { "lewis6991/gitsigns.nvim" },

    -- Telescope
    { "nvim-telescope/telescope.nvim",             dependencies = { "nvim-lua/plenary.nvim" } },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { "nvim-telescope/telescope-file-browser.nvim" },

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter",           build = ":TSUpdate" },
    { "windwp/nvim-ts-autotag" },

    -- Auto pairs
    { "windwp/nvim-autopairs" },
})

require('bufferline').setup({
    options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end
    }
})

-- Colorscheme
vim.cmd.colorscheme("base16-tomorrow-night")

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "ts_ls",
        "pyright",
        "angularls",
    },
    automatic_enable = false
})
require("mason-tool-installer").setup({
    ensure_installed = {
        "prettierd",
        "eslint_d"
    }
})

-- LSP setup
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim', 'require' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    }
})

vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    settings = {
        javascript = {
            inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = false,
            },
        },
        typescript = {
            inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = false,
            },
        },
    }
})
vim.lsp.enable({'ts_ls', 'eslint', 'pyright', 'angularls'})

vim.lsp.inlay_hint.enable(false)


local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettierd.with({
            filetypes = {
                "javascript", "typescript", "typescriptreact", "json",
                "css", "html", "yaml", "markdown", "vue", "svelte"
            },
        }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        async = false,
                        bufnr = bufnr,
                        timeout_ms = 3000,
                    })
                end,
            })
        end
    end,
})

-- Completion setup
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    sources = {
        { name = "nvim_lsp" },
    },
})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- Treesitter
require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "javascript", "typescript", "python", "tsx" },
    highlight = { enable = true },
})
require("nvim-ts-autotag").setup({})

-- Gitsigns
require("gitsigns").setup({
    numhl = true
})

-- Telescope
local ts = require("telescope")
ts.setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        }
    }
})
ts.load_extension('ui-select')
ts.load_extension('file_browser')

-- Autopairs
require("nvim-autopairs").setup()

-- Keymaps
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, {})
vim.keymap.set("n", "<leader>fo", require("telescope.builtin").oldfiles, {})
vim.keymap.set("n", "<leader>fe", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, {})
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, {})
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, {})
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, {})
vim.keymap.set("n", "<leader>l", ":nohlsearch<CR>", { desc = "Clear search highlight" })

vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic message under cursor" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename Symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
-- LSP-related
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "List references" })

vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { silent = true, noremap = true,  desc = "LSP Signature Help" })

vim.keymap.set("n", "<leader>ih", function()
    local enabled = vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(not enabled)
end, { desc = "Toggle Inlay Hints" })

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.js", "*.ts", "*.vue", "*.tsx", "*.scss", "*.ejs", "*.json" },
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.softtabstop = 2
        vim.bo.expandtab = true
    end
})

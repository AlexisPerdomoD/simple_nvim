-- local M = { 'nvim-treesitter/nvim-treesitter' }
-- M.event = 'BufReadPost'
-- M.build = ':TSUpdate'
-- M.dependencies = { { 'nvim-treesitter/nvim-treesitter-textobjects' } }
-- M.main = 'nvim-treesitter.configs'
-- M.opts = {
--     ensure_installed = {
--       "lua",
--       "vim",
--       "vimdoc",
--       "query",
--
--       "bash",
--       "json",
--       "yaml",
--       "toml",
--
--       "html",
--       "css",
--       "javascript",
--       "typescript",
--       "tsx",
--
--       "go",
--       "rust",
--       "python",
--
--       "markdown",
--       "markdown_inline",
--     },
--     auto_install = true,
--     fold = {
--         enable = true,
--     },
--     highlight = {
--         enable = true,
--     },
--     indent = {
--         enable = true,
--     },
--     textobjects = {
--         enable = true,
--         select = {
--             enable = true,
--             lookahead = true,
--             keymaps = {
--                 ['tf'] = '@function.outer',
--                 ['taf'] = '@function.inner',
--                 ['tc'] = '@conditional.outer',
--                 ['tac'] = '@conditional.inner',
--                 ['tl'] = '@loop.outer',
--                 ['tal'] = '@loop.inner',
--             },
--         },
--     },
-- }

local M = { 'nvim-treesitter/nvim-treesitter' }

M.event = 'BufReadPost'
M.build = ':TSUpdate'
M.dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' }

M.opts = {
    ensure_installed = {
        'lua',
        'vim',
        'vimdoc',
        'query',
        'bash',
        'json',
        'yaml',
        'toml',
        'html',
        'css',
        'javascript',
        'typescript',
        'tsx',
        'go',
        'rust',
        'python',
        'markdown',
        'markdown_inline',
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['tf'] = '@function.outer',
                ['taf'] = '@function.inner',
                ['tc'] = '@conditional.outer',
                ['tac'] = '@conditional.inner',
                ['tl'] = '@loop.outer',
                ['tal'] = '@loop.inner',
            },
        },
    },
}

return M

return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "p00f/nvim-ts-rainbow",
        --"nvim-treesitter/playground",
    },
    build = ":TSUpdate",
    event = "BufReadPost",
    main = "nvim-treesitter.configs",
    opts = {
        ensure_installed = {
            "lua",
            "luadoc",
            "query",
            "javascript",
            "typescript",
            "html",
            "css",
            "json",
            "go",
        },
        auto_install = true,
        fold = {
            enable = true,
        },
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["gf"] = "@function.outer",
                    ["gif"] = "@function.inner",
                    ["gd"] = "@conditional.outer",
                    ["gid"] = "@conditional.inner",
                    ["gl"] = "@loop.outer",
                    ["gil"] = "@loop.inner",
                },
            },
        },
        -- playground = {
        --     enable = true,
        --     disable = {},
        --     updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
        --     persist_queries = false, -- Whether the query persists across vim sessions
        --     keybindings = {
        --         toggle_query_editor = 'o',
        --         toggle_hl_groups = 'i',
        --         toggle_injected_languages = 't',
        --         toggle_anonymous_nodes = 'a',
        --         toggle_language_display = 'I',
        --         focus_language = 'f',
        --         unfocus_language = 'F',
        --         update = 'R',
        --         goto_node = '<cr>',
        --         show_help = '?',
        --     },
        -- },
        rainbow = {
            enable = true,
            extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        },
    },
}

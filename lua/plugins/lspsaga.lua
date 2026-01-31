local M = { 'nvimdev/lspsaga.nvim' }
M.dependencies = {
    -- Language servers instaletions
    'williamboman/mason.nvim',
    -- extended funcionality for c#
    -- 'decodetalkers/csharpls-extended-lsp.nvim',
    -- java lsp setup
    'mfussenegger/nvim-jdtls',
    'nvim-tree/nvim-web-devicons',
}

M.event = 'VeryLazy'
M.default_config = {
    ui = {
        winbar_prefix = '',
        border = 'rounded',
        devicon = true,
        foldericon = true,
        title = true,
        expand = '⊞',
        collapse = '⊟',
        code_action = '⚡',
        lines = { '┗', '┣', '┃', '━', '┏' },
        kind = nil,
        button = { '', '' },
        imp_sign = '󰳛 ',
        use_nerd = true,
    },
    hover = {
        max_width = 0.9,
        max_height = 0.8,
        open_link = 'gx',
        open_cmd = '!chrome',
        border = 'rounded',
    },
    diagnostic = {
        show_layout = 'float',
        on_insert = false,
        show_normal_height = 10,
        jump_num_shortcut = true,
        auto_preview = false,
        max_width = 0.8,
        max_height = 0.6,
        max_show_width = 0.9,
        max_show_height = 0.6,
        wrap_long_lines = true,
        extend_relatedInformation = false,
        diagnostic_only_current = false,
        border = 'rounded',
        keys = {
            exec_action = 'o',
            quit = 'q',
            toggle_or_jump = '<CR>',
            quit_in_show = { 'q', '<ESC>' },
        },
    },
    code_action = {
        num_shortcut = true,
        border = 'rounded',
        show_server_name = false,
        extend_gitsigns = false,
        only_in_cursor = true,
        max_height = 0.3,
        cursorline = true,
        keys = {
            quit = 'q',
            exec = '<CR>',
        },
    },
    lightbulb = {
        enable = true,
        sign = true,
        debounce = 50,
        sign_priority = 10,
        virtual_text = true,
        enable_in_insert = true,
        ignore = {
            clients = {},
            ft = {},
        },
    },
    scroll_preview = {
        scroll_down = '<C-f>',
        scroll_up = '<C-b>',
    },
    request_timeout = 2000,
    finder = {
        max_height = 0.5,
        left_width = 0.4,
        methods = {},
        default = 'ref+imp',
        layout = 'float',
        silent = false,
        filter = {},
        fname_sub = nil,
        sp_inexist = false,
        sp_global = false,
        ly_botright = false,
        number = vim.o.number,
        relativenumber = vim.o.relativenumber,
        keys = {
            shuttle = '[w',
            toggle_or_open = 'o',
            vsplit = 's',
            split = 'i',
            tabe = 't',
            tabnew = 'r',
            quit = 'q',
            close = '<C-c>k',
        },
    },
    definition = {
        width = 0.6,
        height = 0.5,
        save_pos = false,
        number = vim.o.number,
        relativenumber = vim.o.relativenumber,
        keys = {
            edit = '<C-o>',
            vsplit = '<C-v>',
            split = '<C-x>',
            tabe = '<C-t>',
            tabnew = '<C-c>n',
            quit = 'q',
            close = '<ESC>',
        },
    },
    rename = {
        in_select = true,
        auto_save = false,
        project_max_width = 0.5,
        project_max_height = 0.5,
        keys = {
            quit = '<C-k>',
            exec = '<CR>',
            select = 'x',
        },
    },
    symbol_in_winbar = {
        enable = false,
        hide_keyword = true,
        separator = ' › ',
        ignore_patterns = nil,
        show_file = true,
        folder_level = 1,
        color_mode = true,
        delay = 1000,
    },
    outline = {
        win_position = 'right',
        win_width = 30,
        auto_preview = true,
        detail = true,
        auto_close = true,
        close_after_jump = false,
        layout = 'normal',
        max_height = 0.5,
        left_width = 0.3,
        keys = {
            toggle_or_jump = 'o',
            quit = 'q',
            jump = 'e',
        },
    },
    callhierarchy = {
        layout = 'float',
        left_width = 0.2,
        keys = {
            edit = 'e',
            vsplit = 's',
            split = 'i',
            tabe = 't',
            close = '<C-c>k',
            quit = 'q',
            shuttle = '[w',
            toggle_or_req = 'u',
        },
    },
    typehierarchy = {
        layout = 'float',
        left_width = 0.2,
        keys = {
            edit = 'e',
            vsplit = 's',
            split = 'i',
            tabe = 't',
            close = '<C-c>k',
            quit = 'q',
            shuttle = '[w',
            toggle_or_req = 'u',
        },
    },
    implement = {
        enable = false,
        sign = true,
        lang = {},
        virtual_text = true,
        priority = 100,
    },
    beacon = {
        enable = true,
        frequency = 7,
    },
    floaterm = {
        height = 0.7,
        width = 0.7,
    },
}

M.config = function()
    require('lspsaga').setup(M.default_config)
    -- Configuración de capabilities con UTF-16 para consistencia
    -- local capabilities_settings = vim.lsp.protocol.make_client_capabilities()
    --
    -- capabilities_settings = vim.tbl_deep_extend('force', capabilities_settings, {
    --     offsetEncoding = { 'utf-16' },
    --     general = {
    --         positionEncodings = { 'utf-16' },
    --     },
    -- })

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp_saga', {}),
        callback = function(args)
            -- require('cmp_nvim_lsp').default_capabilities(capabilities_settings)
            local bufnr = args.buf
            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.keymap.set('n', '<space>[', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
            vim.keymap.set('n', '<space>]', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)

            vim.keymap.set('n', 'F', '<cmd>Lspsaga finder<CR>', opts)
            vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', opts)
            vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
            vim.keymap.set('n', 'ca', '<cmd>Lspsaga code_action<CR>', opts)
            vim.keymap.set('n', 'gr', '<cmd>Lspsaga finder ref<CR>', opts)

            vim.keymap.set('n', '<space>wd', '<cmd>Lspsaga show_workspace_diagnostics<CR>', opts)
            vim.keymap.set('n', '<space>wb', '<cmd>Lspsaga show_buf_diagnostics<CR>', opts)
        end,
    })

    -- JAVA LSP AUTOCOMAND
    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'java',
        callback = function()
            local jdtls_setup = require 'utils/jdtls_setup'
            jdtls_setup:setup()
        end,
    })
end

return M

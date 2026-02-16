-- Configuración de capabilities con UTF-16 para consistencia
local signs = { Error = '', Warn = '', Hint = '', Info = '' }
local capabilities_settings = vim.lsp.protocol.make_client_capabilities()
vim.lsp.config('*', { capabilities = capabilities_settings })
vim.diagnostic.config {
    virtual_text = true,
    float = { border = 'rounded' },
    virtual_lines = { current_line = true, severity = vim.diagnostic.severity.ERROR },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.HINT] = signs.Hint,
            [vim.diagnostic.severity.INFO] = signs.Info,
        },
    },
}

local default_progress_handler = vim.lsp.handlers['$/progress'] or function(_, _, _) end

vim.lsp.handlers['$/progress'] = function(err, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then return end

    if client.name == 'pyright' then
        -- MOLESTO
        return
        -- local value = result and result.value
        -- if type(value) == 'table' and type(value.message) == 'string' and value.message:find 'analyze' then return end
    end

    return default_progress_handler(err, result, ctx)
end

vim.lsp.set_log_level 'ERROR'

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
    callback = function(args)
        -- require('cmp_nvim_lsp').default_capabilities(capabilities_settings)
        -- esto no se llama porque no está en el setup

        local bufnr = args.buf
        if not vim.api.nvim_buf_is_valid(bufnr) then
            vim.notify('No es un buffer valido', vim.log.levels.ERROR, { title = 'lsp' })
            return
        end
        local opts = { buffer = bufnr, noremap = true, silent = true, desc = 'LSP' }

        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc' -- algo de autocompletadito
        vim.keymap.set('n', '.e', vim.diagnostic.open_float)
        vim.keymap.set('n', '.L', vim.diagnostic.setloclist)
        vim.keymap.set('n', 'DE', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<leader><leader>', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>hs', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            local wdirs = vim.inspect(vim.lsp.buf.list_workspace_folders())
            vim.notify(wdirs, vim.log.levels.INFO, { title = 'working dirs' })
        end, opts)
        vim.keymap.set('n', 'td', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
        vim.keymap.set(
            'n',
            '<space>l',
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr }) end,
            opts
        )
    end,
})

local lsp_dir = vim.fn.stdpath 'config' .. '/lsp'
for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
    if file:match '%.lua$' then
        local server_name = file:gsub('%.lua$', '')
        vim.lsp.enable(server_name)
    end
end

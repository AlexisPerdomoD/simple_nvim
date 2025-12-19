-- Configuración de capabilities con UTF-16 para consistencia
local capabilities_settings = vim.lsp.protocol.make_client_capabilities()

capabilities_settings = vim.tbl_deep_extend('force', capabilities_settings, {
    offsetEncoding = { 'utf-16' },
    general = {
        positionEncodings = { 'utf-16' },
    },
})
-- Primero configurar los capabilities por defecto
vim.lsp.config('*', { capabilities = capabilities_settings })
vim.diagnostic.config { virtual_text = true, float = { border = 'rounded' } }

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        require('cmp_nvim_lsp').default_capabilities(capabilities_settings)

        local bufnr = args.buf
        local opts = { buffer = bufnr, noremap = true, silent = true }

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
    end,
})

local lsp_dir = vim.fn.stdpath 'config' .. '/lsp'
for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
    if file:match '%.lua$' then
        local server_name = file:gsub('%.lua$', '')
        vim.lsp.enable(server_name)
    end
end

local M = { 'neovim/nvim-lspconfig' }

M.dependencies = { 'williamboman/mason.nvim' }
M.event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' }

M.lsp_servers = {
    'ts_ls',
    'bashls',
    'cssls',
    'dockerls',
    'eslint',
    'gopls',
    'golangci_lint_ls',
    'html',
    'jsonls',
    'lua_ls',
    'pyright',
    'ruff',
    'rust_analyzer',
    'tailwindcss',
    'yamlls',
    'hyprls',
    'clangd',
}

M.config = function()
    vim.lsp.log.set_level 'ERROR'

    local function map_if_supported(client, bufnr, method, lhs, rhs, desc, mode)
        if not client:supports_method(method, bufnr) then
            return
        end

        vim.keymap.set(mode or 'n', lhs, rhs, {
            buffer = bufnr,
            desc = desc,
            silent = true,
        })
    end

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client == nil then
                return
            end

            local bufnr = ev.buf

            -- Completion is manual to avoid an unsolicited popup in empty insert mode.
            if client:supports_method('textDocument/completion', bufnr) then
                vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })
                vim.keymap.set('i', '<C-Space>', function()
                    vim.lsp.completion.get()
                end, {
                    buffer = bufnr,
                    desc = 'LSP: show completion',
                    silent = true,
                })
            end

            -- Diagnostics do not depend on completion support.
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
                buffer = bufnr,
                desc = 'Diagnostic: line details',
                silent = true,
            })
            vim.keymap.set('n', '<leader>L', vim.diagnostic.setloclist, {
                buffer = bufnr,
                desc = 'Diagnostic: location list',
                silent = true,
            })
            vim.keymap.set('n', '<leader>[', function()
                vim.diagnostic.jump { count = -1 }
            end, { buffer = bufnr, desc = 'Diagnostic: previous', silent = true })
            vim.keymap.set('n', '<leader>]', function()
                vim.diagnostic.jump { count = 1 }
            end, { buffer = bufnr, desc = 'Diagnostic: next', silent = true })

            local method_maps = {
                { 'textDocument/declaration', 'DE', vim.lsp.buf.declaration, 'LSP: declaration' },
                { 'textDocument/definition', 'gd', vim.lsp.buf.definition, 'LSP: definition' },
                { 'textDocument/typeDefinition', 'td', vim.lsp.buf.type_definition, 'LSP: type definition' },
                { 'textDocument/implementation', 'gi', vim.lsp.buf.implementation, 'LSP: implementation' },
                { 'textDocument/references', 'grr', vim.lsp.buf.references, 'LSP: references' },
                { 'textDocument/hover', '<leader><leader>', vim.lsp.buf.hover, 'LSP: hover' },
                { 'textDocument/signatureHelp', '<leader>sh', vim.lsp.buf.signature_help, 'LSP: signature help' },
                { 'textDocument/codeAction', 'cA', vim.lsp.buf.code_action, 'LSP: code action' },
                { 'textDocument/rename', 'rn', vim.lsp.buf.rename, 'LSP: rename' },
            }

            for _, mapping in ipairs(method_maps) do
                map_if_supported(client, bufnr, mapping[1], mapping[2], mapping[3], mapping[4])
            end

            local workspace_folders = client.server_capabilities.workspace
                and client.server_capabilities.workspace.workspaceFolders
            if workspace_folders and workspace_folders.supported then
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, {
                    buffer = bufnr,
                    desc = 'LSP: add workspace folder',
                    silent = true,
                })
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, {
                    buffer = bufnr,
                    desc = 'LSP: remove workspace folder',
                    silent = true,
                })
                vim.keymap.set('n', '<space>wl', function()
                    vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), vim.log.levels.INFO, {
                        title = 'Workspace folders',
                    })
                end, { buffer = bufnr, desc = 'LSP: list workspace folders', silent = true })
            end

            map_if_supported(client, bufnr, 'textDocument/inlayHint', '<space>l', function()
                local is_active = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
                vim.lsp.inlay_hint.enable(not is_active, { bufnr = bufnr })
            end, 'LSP: toggle inlay hints')
        end,
    })

    for _, server_name in ipairs(M.lsp_servers) do
        vim.lsp.enable(server_name)
    end
end

return M

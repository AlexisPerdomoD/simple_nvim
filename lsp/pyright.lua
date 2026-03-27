---@brief
---
--- https://github.com/microsoft/pyright
---
--- `pyright`, a static type checker and language server for python
local function set_python_path(command)
    local bufnr = vim.api.nvim_get_current_buf()
    if not vim.api.nvim_buf_is_valid(bufnr) then return end

    local path = command.args
    local clients = vim.lsp.get_clients {
        bufnr = bufnr,
        name = 'pyright',
    }
    for _, client in ipairs(clients) do
        if client.settings then
            client.settings.python =
                vim.tbl_deep_extend('force', client.settings.python --[[@as table]], { pythonPath = path })
        else
            client.config.settings =
                vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
        end

        client.config.capabilities.workspace.didChangeConfiguration = true

        client:notify('workspace/didChangeConfiguration', {
            settings = client.config.settings,
        })
    end
end

local function get_python_path(root_dir)
    local venv_path = root_dir .. '/.venv/bin/python'

    if vim.fn.executable(venv_path) == 1 then return venv_path end

    return vim.fn.exepath 'python3'
end

---@type vim.lsp.Config
return {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },

    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        if fname == '' then
            on_dir()
            return
        end
        local root = vim.fs.root(fname, {
            'pyproject.toml',
            'setup.py',
            'setup.cfg',
            'requirements.txt',
            'ruff.toml',
            '.git',
        })

        on_dir(root or vim.fn.getcwd())
    end,

    settings = {
        pyright = { autoImportCompletion = true },
        python = {
            -- venvPath = vim.fn.getcwd(),
            -- venv = ".venv",
            -- pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
            analysis = {
                inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                    callArgumentNames = true,
                },

                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                -- diagnosticMode = 'openFilesOnly',
                diagnosticMode = 'workspace',
                typeCheckingMode = 'standard',
                exclude = {
                    '**/__pycache__',
                    '**/.venv',
                    '**/.git',
                    '**/node_modules',
                },
                -- include = { '.' },
            },
        },
    },

    before_init = function(_, config)
        config.root_dir = config.root_dir
        local root = config.root_dir or vim.fn.getcwd()
        local python_path = get_python_path(root)
        vim.notify('Setting python path to ' .. python_path, vim.log.levels.INFO, { title = 'pyright' })
        config.settings = config.settings or {}
        config.settings.python = config.settings.python or {}
        ---@diagnostic disable-next-line: inject-field
        config.settings.python.pythonPath = python_path
    end,

    on_attach = function(_, bufnr)
        -- client.offset_encoding = 'utf-8'
        -- client.server_capabilities.hoverProvider = true

        vim.api.nvim_buf_create_user_command(bufnr, 'PyrightSetPythonPath', set_python_path, {
            desc = 'Reconfigure pyright with the provided python path',
            nargs = 1,
            complete = 'file',
        })

        vim.api.nvim_buf_create_user_command(bufnr, 'PyrightRestart', function()
            for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr, name = 'pyright' }) do
                vim.lsp.stop_client(client.id)
            end

            -- start lsp server
            vim.defer_fn(function() vim.cmd 'edit' end, 300)
        end, { desc = 'Restart pyright' })
    end,
}

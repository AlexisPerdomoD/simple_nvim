return {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", 'nicholasmata/nvim-dap-cs' },
    lazy = true,
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup() -- Iniciar dapui

        -- Configuración para netcoredbg (.NET Core)
        -- requiere tener instalado netcoredbg, es decir, la herramienta de depuración de .NET
        -- instalado con yay en arch linux (netcoredbg) yay -S netcoredbg

        -- Additional dap configurations can be added.
        -- dap_configurations accepts a list of tables where each entry
        -- represents a dap configuration. For more details do:
        -- :help dap-configuration
        require('dap-cs').setup {


            dap_configurations = {
                {

                    type = "coreclr", -- Must be "coreclr" or it will be ignored by the plugin
                    name = "Attach remote",
                    mode = "remote",
                    request = "launch",
                },
            },
            netcoredbg = {
                path = "netcoredbg"
            }
        }

        -- Configuración para iniciar nvim-dap-ui junto con nvim-dap
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

        -- Configura teclas rápidas si las necesitas
        vim.keymap.set("n", ".dt", dap.toggle_breakpoint, {})
        vim.keymap.set("n", ".dc", dap.continue, {})


        -- abrir y cerrar interfaz de depuración
        vim.keymap.set("n", ".di", dapui.toggle, { noremap = true })



        -- vim.api.nvim_set_keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", { noremap = true, silent = true })
        -- vim.api.nvim_set_keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
        -- vim.api.nvim_set_keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
        -- vim.api.nvim_set_keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
    end
}









-- dap.adapters.coreclr = {
--     type = 'executable',
--     command = 'netcoredbg',
--     args = { '--interpreter=vscode' },
-- }
-- dap.configurations.cs = {
--     {
--         type = "coreclr",
--         name = "Launch - .NET Core",
--         request = "launch",
--         program = function()
--             return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
--         end,
--     },
-- }

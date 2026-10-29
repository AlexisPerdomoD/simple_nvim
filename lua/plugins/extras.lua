return {

    -- ADDS SUPPORT TO LUA INTO NVIM
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                -- { path = '${3rd}/vim/library', word = 'vim%.fn' },
            },
        },
    },

    -- ADDS SUPPORT TO CLOSE TAGS IN HTML
    {
        'windwp/nvim-ts-autotag',
        ft = { 'html', 'jsx', 'tsx' },
        config = function()
            local autotag = require 'nvim-ts-autotag'
            autotag.setup {
                opts = {
                    -- Defaults
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = true, -- Auto close on trailing </
                },
            }
        end,
    },

    -- ADDS SUPPORT TO AUTOPAIRS IN INSERT MODE
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },

    -- JAVA LSP AUTOCOMAND SPECIFIC CONFIGURATION
    {
        'mfussenegger/nvim-jdtls',
        ft = 'java',
        config = function()
            local sep = package.config:sub(1, 1)
            local home = vim.fn.getenv 'HOME'
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
            local workspace_dir = vim.fn.stdpath 'data' .. sep .. 'jdtls-workspace' .. sep .. project_name
            ---@diagnostic disable-next-line:undefined-field
            local os_name = vim.loop.os_uname().sysname
            -- resolver java: preferir JAVA_HOME/bin/java si existe
            local java_home_path = vim.fn.getenv 'JAVA_HOME'
            local java_runtimes_path = home .. sep .. '.sdkman/candidates/java'
            local java_cmd = nil
            if java_home_path and java_home_path ~= vim.NIL and java_home_path ~= '' then
                java_cmd = java_home_path .. sep .. 'bin' .. sep .. 'java'
            else
                local ex = vim.fn.exepath 'java'
                java_cmd = (ex ~= '' and ex) or 'java'
            end

            -- -- buscar launcher jar en plugins, preferir gtk.linux.x86_64 para Arch x86_64
            local mason_jdtls_dir_path = vim.fn.stdpath 'data'
                .. sep
                .. 'mason'
                .. sep
                .. 'packages'
                .. sep
                .. 'jdtls'
                .. sep
                .. 'plugins'
                .. sep

            local launcher = vim.fn.globpath(mason_jdtls_dir_path, 'org.eclipse.equinox.launcher_*.jar')
            local configuration_system_path = vim.fn.stdpath 'data'
                .. sep
                .. 'mason'
                .. sep
                .. 'packages'
                .. sep
                .. 'jdtls'
                .. sep
                .. 'config_'
                .. (os_name == 'Windows_NT' and 'win' or os_name == 'Linux' and 'linux' or 'mac')
            local lombok_jar_path = home
                .. sep
                .. '.local'
                .. sep
                .. 'share'
                .. sep
                .. 'nvim'
                .. sep
                .. 'mason'
                .. sep
                .. 'share'
                .. sep
                .. 'jdtls'
                .. sep
                .. 'lombok.jar'
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            local config = {}
            config.capabilities = capabilities
            config.flags = { allow_incremental_sync = true }
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            config.settings = {}
            config.settings.java = {}
            config.settings.java.signatureHelp = { enabled = true }
            config.settings.java.maven = { downloadSources = false } -- revisar
            config.settings.java.implementationsCodeLens = { enabled = true }
            config.settings.java.referencesCodeLens = { enabled = true }
            config.settings.java.references = { includeDecompiledSources = false } -- revisar
            config.settings.java.format = { enabled = true }
            config.settings.java.completion = {}
            config.settings.java.completion.favoriteStaticMembers = {
                'org.hamcrest.MatcherAssert.assertThat',
                'org.hamcrest.Matchers.*',
                'org.hamcrest.CoreMatchers.*',
                'org.junit.jupiter.api.Assertions.*',
                'java.util.Objects.requireNonNull',
                'java.util.Objects.requireNonNullElse',
                'org.mockito.Mockito.*',
            }
            config.settings.java.completion.importOrder = { 'java', 'javax', 'com', 'org' }

            config.settings.java.sources = {}
            config.settings.java.sources.organizeImports = {}
            config.settings.java.sources.organizeImports.starThreshold = 9999
            config.settings.java.sources.organizeImports.staticStarThreshold = 9999

            config.settings.java.codeGeneration = {}
            config.settings.java.codeGeneration.toString =
                { template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}' }
            config.settings.java.codeGeneration.useBlocks = true

            -- config.settings.java.edit = {}
            -- config.settings.java.edit.validateAllOpenBuffersOnChanges = nil -- verificar

            config.settings.java.configuration = {}
            config.settings.java.configuration.runtimes = {
                { name = 'JavaSE-17', path = java_runtimes_path .. '/17.0.12-tem/bin/java' },
                { name = 'JavaSE-21', path = java_runtimes_path .. '/21.0.10-tem/bin/java' },
                { name = 'JavaSE-25', path = java_runtimes_path .. '/25.0.2-tem/bin/java' },
            }

            -- Language server `initializationOptions`
            -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
            config.init_options = { bundles = {} }
            config.root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew' }

            config.cmd = { java_cmd }
            table.insert(config.cmd, '-Declipse.application=org.eclipse.jdt.ls.core.id1')
            table.insert(config.cmd, '-Dosgi.bundles.defaultStartLevel=4')
            table.insert(config.cmd, '-Declipse.product=org.eclipse.jdt.ls.core.product')
            table.insert(config.cmd, '-Dlog.protocol=true')
            table.insert(config.cmd, '-Dlog.level=ERROR')
            table.insert(config.cmd, '-Xmx1g')
            table.insert(config.cmd, '--add-modules=ALL-SYSTEM')
            table.insert(config.cmd, '--add-opens')
            table.insert(config.cmd, 'java.base/java.util=ALL-UNNAMED')
            table.insert(config.cmd, '-javaagent:' .. lombok_jar_path)
            table.insert(config.cmd, '-jar')
            table.insert(config.cmd, launcher)
            table.insert(config.cmd, '-configuration')
            table.insert(config.cmd, configuration_system_path)
            table.insert(config.cmd, '-data')
            table.insert(config.cmd, workspace_dir)

            -- JAVA LSP AUTOCOMAND SPECIFIC CONFIGURATION
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'java',
                callback = function(_)
                    local jdtls = require 'jdtls'
                    jdtls.start_or_attach(config)
                end,
            })
        end,
    },

    -- USEFUL TOGGLETERM CONFIGURATION
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        event = 'VeryLazy',
        config = function()
            local p = require 'toggleterm'
            p.setup {
                size = function(term)
                    if term.direction == 'horizontal' then
                        return 15
                    elseif term.direction == 'vertical' then
                        return vim.o.columns * 0.4
                    else
                        return 20
                    end
                end,
                open_mapping = [[<c-.>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
                -- on_create = fun(t: Terminal), -- function to run when the terminal is first created
                -- on_open = fun(t: Terminal), -- function to run when the terminal opens
                -- on_close = fun(t: Terminal), -- function to run when the terminal closes
                -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
                -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
                -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
                hide_numbers = true, -- hide the number column in toggleterm buffers
                shade_filetypes = {},
                --
                highlights = {
                    -- highlights which map to a highlight group name and a table of it's values
                    -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
                    Normal = {
                        guibg = 'NONE',
                        guifg = '#00FF9C',
                    },
                    NormalFloat = {
                        link = 'Normal',
                    },
                    FloatBorder = {
                        guifg = '#00FF9C',
                        guibg = 'NONE',
                    },
                },
                shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
                shading_factor = '3', -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
                start_in_insert = true,
                insert_mappings = true, -- whether or not the open mapping applies in insert mode
                terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
                persist_size = true,
                persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
                direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float',
                close_on_exit = true, -- close the terinal window when the process exits
                -- Change the default shell. Can be a string or a function returning a string
                shell = vim.o.shell,
                auto_scroll = true, -- automatically scroll to the bottom on terminal output
                -- This field is only relevant if direction is set to 'float'
                float_opts = {
                    -- The border key is *almost* the same as 'nvim_open_win'
                    -- see :h nvim_open_win for details on borders however
                    -- the 'curved' border is a custom border type
                    -- not natively supported but implemented in this plugin.
                    border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
                    -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
                    --  width = 100,
                    --  height = vim.o.columns * 0.5,
                    --  row = 2,
                    --  col = vim.o.columns * 0.3,
                    --  winblend = 3,
                    --  zindex = <value>,
                    title_pos = 'center', -- 'left' | 'center' | 'right', position of the title of the floating window
                },
                -- winbar = {
                --   enabled = false,
                --   name_formatter = function(term) --  term: Terminal
                --     return term.name
                --   end
                -- },
            }
        end,
    },
}

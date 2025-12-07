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
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local M = {}
M.config = nil
---@param extendedClientCapabilities table
function M:get_config(extendedClientCapabilities)
    if self.config == nil then
        local config = {}
        config.capabilities = capabilities
        config.flags = { allow_incremental_sync = true }
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        config.settings = {}
        config.settings.java = {}
        config.settings.java.signatureHelp = { enabled = true }
        config.settings.java.extendedClientCapabilities = extendedClientCapabilities
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
            { name = 'JavaSE-21', path = java_runtimes_path .. '/21.0.5-tem/bin/java' },
            { name = 'JavaSE-25', path = java_runtimes_path .. '/25.0.1-tem/bin/java' },
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
        self.config = config
    end
    return self.config
end

function M:setup()
    local ok, jdtls = pcall(require, 'jdtls')
    if not ok then
        vim.notify('jdtls not properly load or not found', vim.log.levels.ERROR)
        return
    end

    jdtls.start_or_attach(self:get_config(jdtls.extendedClientCapabilities))
end

return M

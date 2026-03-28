return {

    cmd = { "typescript-language-server", "--stdio" },

    init_options = {
        hostInfo = "neovim",
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = "", -- "/usr/local/lib/node_modules/@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
            },
        },
    },
    filetypes = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
    },


    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" }


}

return {
    cmd = { "vscode-html-language-server", "--stdio" },
    init_options = { provideFormatter = true },
    embedded_languages = {
        css = true,
        javascript = true,
    },
    filetypes = { "html", "templ" },
    root_markers = { "package.json", ".git" }
}

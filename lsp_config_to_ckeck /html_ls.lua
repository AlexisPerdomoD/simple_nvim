return {
    cmd = { 'vscode-html-language-server', '--stdio' },
    init_options = { provideFormatter = true },
    embedded_languages = {
        css = true,
        javascript = true,
    },
    filetypes = { 'html', 'templ', 'vue', 'svelte' },
    root_markers = { 'package.json', '.git' },
}

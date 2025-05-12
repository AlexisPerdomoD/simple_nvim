return {
    on_init = function() require("csharpls_extended").buf_read_cmd_bind() end,
    cmd = { "csharp-ls" },
    filetypes = { "cs", "csx" },
    init_options = {
        AutomaticWorkspaceInit = true,
    },
    root_markers = { ".git", ".csxc", ".csproj", ".sln" },
}

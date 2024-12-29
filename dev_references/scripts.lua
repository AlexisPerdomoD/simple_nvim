-- Este es el script que será ejecutado al inicio de Neovim.
local eslintd_script = [[
  if ! command -v eslint_d &> /dev/null; then
    echo "ESLint no está instalado. Asegúrate de instalarlo primero."
    exit 1
  fi

  CONFIG_FILES=(".eslintrc.js" ".eslintrc.cjs" ".eslintrc.json" ".eslintrc.yml" ".eslintrc.yaml" "package.json")

  FOUND_CONFIG=false
  for CONFIG in "${CONFIG_FILES[@]}"; do
    if [ -f "$CONFIG" ]; then
      FOUND_CONFIG=true
      break
    fi
  done

  if [ "$FOUND_CONFIG" = true ]; then
    eslint_d "$@"
  else
    eslintd_d --no-eslintrc --env "browser,es2020" --rule "no-unused-vars: off" --rule "react-refresh/enable: off" --rule "react-refresh/only-export-components: [warn, {allowConstantExport: true}]" --ignore-pattern "dist" .
  fi
]]

-- Ruta del archivo temporal
local tempfile = os.getenv("HOME") .. "/scripts/eslint_d_custom.sh"
-- Verifica si el archivo ya existe, si no, lo crea
if vim.fn.filereadable(tempfile) == 0 then
    print("condicional 1")
    local file = io.open(tempfile, "w")
    file:write(eslintd_script)
    file:close()

    -- Otorgamos permisos de ejecución al script
    os.execute("chmod +x " .. tempfile)
end

local aliasfile_script = [[
    alias eslint_d="bash -c 'source ~/scripts/eslint_d_custom.sh'"
]]
local aliasfile = os.getenv("HOME") .. "/scripts/nvim_aliases_bin.sh"

if vim.fn.filereadable(aliasfile) == 0 then
    print("condicional 2")
    local file = io.open(aliasfile, "w")
    file:write(aliasfile_script)
    file:close()
    -- Otorgamos permisos de ejecución al script
    os.execute("chmod +x " .. aliasfile)
end
-- Ejecuta el script de linting
os.execute(aliasfile_script)

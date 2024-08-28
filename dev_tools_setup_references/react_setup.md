# Setup para react con typescript y react native (compatible con react puro)

## .eslintrc.mjs

```javascript
module.exports = {
root: true,
env: { browser: true, es2020: true },
extends: [
'expo',
'eslint:recommended',
'plugin:react/recommended',
'plugin:react/jsx-runtime',
'plugin:react-hooks/recommended'
],
ignorePatterns: ['dist', '.eslintrc.cjs'],
parserOptions: { ecmaVersion: 'latest', sourceType: 'module' },
settings: { react: { version: '18.2' } },
plugins: ['react-refresh'],
rules: {
'react-refresh/enable': 'off',
'no-unused-vars': 'off',
'@typescript-eslint/no-unused-vars': 'off',

'react-refresh/only-export-components': ['warn', { allowConstantExport: true }]
}
}
```

## package.json referencia

```json
"devDependencies": {
    "eslint": "^8.57.0",
    "eslint-config-expo": "^7.1.2",
    "eslint-plugin-react": "^7.35.0",
    "eslint-plugin-react-hooks": "^4.6.2",
    "eslint-plugin-react-refresh": "^0.4.11",
  }
```

## .prettierrc.json
```json
{
    "trailingComma": "none",
    "tabWidth": 4,
    "semi": false,
    "singleQuote": true,
    "printWidth": 120
}
```

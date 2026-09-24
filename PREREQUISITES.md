# Prerequisites


## `jupytext` (for jupytext plugin)

```bash
pip install jupytext
```

## `pylatexenc` (for render-markdown.nvim LaTeX rendering)

Provides the `latex2text` executable that `render-markdown.nvim` uses to render
`$...$` / `$$...$$` math as unicode.

```bash
pip install pylatexenc
```

## `markdownlint` (for markdown linting)

Installed and managed via Mason (`ensure_installed` in `init.lua`), no manual step
needed. To install manually: `npm install --global markdownlint-cli`.

## 'iamcco/markdown-preview.nvim'

- yarn:
```bash
npm install --global yarn
```

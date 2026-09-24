# Customizations vs upstream `lazy` branch

This document describes every difference between this fork (branch `master`) and the
official upstream branch `lazy` of [`nvim-lua/kickstart.nvim`](https://github.com/nvim-lua/kickstart.nvim).

The fork tracks upstream via the git remote `upstream` and is kept in sync by merging
`upstream/lazy` into `master`. Upstream `master` is NOT used: it migrated to the new
built-in `vim.pack` plugin manager, while this fork stays on `lazy.nvim`.

---

## Git / repo-level differences

- `lazy-lock.json` is **tracked** in git (upstream ignores it to avoid merge conflicts).
  It pins every plugin to a specific commit/branch.
- `upstream` remote configured:
  - `origin`  = `git@github.com:piotrdurniat/kickstart.nvim.git` (private fork)
  - `upstream` = `https://github.com/nvim-lua/kickstart.nvim.git` (public)
- `.gitignore` is smaller: no `lazy-lock.json`, no `.DS_Store` (lockfile is versioned).
- `PREREQUISITES.md` added with manual install notes (jupytext, yarn for markdown-preview).

---

## `init.lua` changes

### Global options
- `vim.g.have_nerd_font = true` (icons/nerd-font glyphs enabled).
- `vim.o.relativenumber = true`.
- Custom section after the core options:
  - `colorcolumn = '90'`
  - `tabstop = 4`, `shiftwidth = 4`, `expandtab = true`, `softtabstop = 4`
  - `fillchars` tuned for `nvim-ufo` folding (`eob`, `fold`, `foldopen`, `foldsep`, `foldinner`, `foldclose`).
- `TextYankPost` uses `vim.highlight.on_yank()` (non-deprecated) instead of `vim.hl.on_yank()`.

### gitsigns.nvim
- Custom sign glyphs (`┃`, `┆`, `_`, `‾`, `~`) for both `signs` and `signs_staged`
  (upstream uses `+`/`~`/...).
- Full `on_attach` keymap set, disabled for `*.ipynb` buffers:
  - `]c`/`[c` hunk navigation, `<leader>hs/hr` stage/reset (normal + visual),
    `<leader>hS/hR` stage/reset buffer, `<leader>hp` preview, `<leader>hi` inline preview,
    `<leader>hb` blame line, `<leader>hd/hD` diff, `<leader>hQ/hq` quickfix lists,
    `<leader>tb/tw` toggles, `ih` textobject.

### telescope.nvim
- `<C-p>` → `git_files`, `<leader>sb` → `git_branches`.
- Custom remaps:
  - `<leader>pv` → `:Ex` (netrw project view)
  - `<leader>gs` → fugitive `:Git`, `<leader>gb` branches, `<leader>gc` commits,
    `<leader>gC` buffer commits, `<leader>gS` stash
  - `Alt-j`/`Alt-k` move lines down/up (visual + normal)
  - `n`/`N` → `nzzzv`/`Nzzzv` (keep cursor centered while searching)
  - `<leader>p` (visual) → paste over selection via void register (`"_dP`)
  - `<Esc>` (terminal) → exit terminal mode

### LSP (`nvim-lspconfig` / Mason)
- Extra LSP attach keymaps: `<leader>e` diagnostic float, `K` hover.
- Custom `vim.diagnostic.config`: severity-sorted, rounded float, error-only underline,
  nerd-font sign glyphs, and a `virtual_text` filter that hides LTeX `'Dummy...'` messages.
- Additional servers in `servers`:
  - `ltex_ls` — `cmd = 'ltex-silenced'`, language `pl-PL`, LaTeX `commands = {}`.
  - `pyright` — filetypes `{ 'python' }` (markdown/jupyter/ipynb were removed so pyright
    stops parsing prose as Python; embedded Python is handled by otter.nvim), auto-import/type-check settings.
  - `texlab` — build args `-pdf -interaction=nonstopmode -synctex=1 -shell-escape %f`.
- `mason-tool-installer` `ensure_installed` is an explicit list (upstream derives it from
  `servers`): `lua_ls`, `stylua`, `texlab`, `ltex-ls`, `pyright`, `shfmt`, `markdownlint`.
- Diagnostic `jump` uses `on_jump` (the deprecated `jump.float` was removed in favor of it).

### conform.nvim
- `format_on_save` always formats: falls back to
  `{ timeout_ms = 1500, lsp_format = 'fallback' }` (upstream returns `nil`).
- `formatters_by_ft`:
  - `lua = { 'stylua' }`, `sh`/`bash = { 'shfmt' }`
  - `python = { 'isort', 'black' }`, `['python.jupytext'] = { 'isort', 'black' }`

### Colorscheme
- `rose-pine/neovim` (`rosepine`, variant `dawn`, dark_variant `moon`) instead of
  `folke/tokyonight.nvim`; loads `rose-pine`.

### mini.nvim
- Extra `mini.comment` setup remapping `<C-_>` as the line/visual comment key while
  keeping `gc` textobject/comment.

### blink.cmp
- `fuzzy.implementation = 'prefer_rust_with_warning'` (upstream defaults to the Lua
  implementation). Downloads a prebuilt `blink_cmp_fuzzy` binary on supported systems and
  falls back to Lua with a warning otherwise.

### nvim-treesitter (new rewrite, `branch = 'main'`)
- Extra parsers: `python`, `go`, `rust`, `latex` added to the install list
  (`latex` is needed by `render-markdown.nvim` for math).
- Added dependency `nvim-treesitter/nvim-treesitter-textobjects` with:
  - select textobjects `af`/`if` (function), `ac`/`ic` (class), `aa`/`ia` (parameter)
  - move keymaps `]f`/`]F`/`[f`/`[F` (function), `]c`/`]C`/`[c`/`[C` (class)
  - `select.lookahead = true`, `move.set_jumps = true`.
  - Note: keymaps are registered manually because the new textobjects release no longer
    auto-maps from config.

### nvim-lint / markdownlint
- `require 'kickstart.plugins.lint'` enabled (was commented out) to lint markdown with
  `markdownlint` (installed via Mason, added to `ensure_installed`).

### Bottom of file
- `{ import = 'custom.plugins' }` enabled (loads everything under `lua/custom/plugins/`).
- `require 'custom.watch_file'` loaded at startup (the no-op `require 'custom.ltex_toggle'`
  was removed; `lua/custom/ltex_toggle.lua` is entirely commented out).

---

## Custom plugins (`lua/custom/plugins/`)

- `99.lua` — `ThePrimeagen/99` (agent-driven refactoring); logger to
  `/tmp/<basename>.99.debug`; keymaps `<leader>9f` fill-in-function, `<leader>9v` visual,
  `<leader>9s` stop-all.
- `copilot.lua` — `zbirenbaum/copilot.lua` (suggestions/panel disabled) +
  `CopilotC-Nvim/CopilotChat.nvim` with floating window; keymaps `<leader>cc` toggle,
  `<leader>ce` explain, `<leader>cf` fix, `<leader>co` optimize, `<leader>cq` quick-ask.
- `git.lua` — `tpope/vim-fugitive` and `tpope/vim-rhubarb`.
- `harpoon.lua` — `ThePrimeagen/harpoon` on `branch = 'harpoon2'`: `<leader>ha` add,
  `<leader>hv` menu, `<leader>1..7` select. Harpoon2 dropped the built-in `term`/`cmd-ui`
  modules, so `<leader>t1/t2` are standalone numbered terminals (create-on-first-use,
  replacing the current window instead of opening a split) and the old `<leader>hc`
  command menu is gone.
- `jupyter.lua` — `goerz/jupytext.nvim`, `benlubas/molten-nvim` (+ `3rd/image.nvim`
  with kitty backend), full molten keymap set (`<leader>ji/je/jr/jd/jh/js/jp/jb/jo`),
  auto `MoltenSave`/`MoltenLoad` on `*.ipynb`.
- `markdown-preview.lua` — `iamcco/markdown-preview.nvim`, `<leader>mp` toggle.
- `opencode.lua` — `sudo-tee/opencode.nvim` + `render-markdown.nvim` (with
  `opencode_output` filetype) and `blink.cmp`. Telescope is used as the picker provider
  (`snacks.nvim` was removed to avoid an unconfigured dependency).
  `render-markdown.nvim` has LaTeX rendering enabled (`latex2text` converter, inline +
  block math, `RenderMarkdownMath` highlight), toggleable via the local `enable_latex`
  flag at the top of the file.
- `otter.lua` — `jmbuhr/otter.nvim` activated on `markdown`/`quarto` with
  `{ 'python', 'lua' }`; wrapped in `pcall` to suppress buffer-name conflicts.
- `treesitter-context.lua` — `nvim-treesitter/nvim-treesitter-context`,
  `multiline_threshold = 5`.
- `ufo.lua` — `kevinhwang91/nvim-ufo` folding with treesitter/indent providers,
  `zR`/`zM`, `K` fold peek (falls back to LSP hover).
- `vimtex.lua` — `lervag/vimtex` (`lazy = false`), zathura viewer, latexmk with
  `-shell-escape -synctex=1 -interaction=nonstopmode`.

## Custom Lua utilities

- `lua/custom/watch_file.lua` — `:Watch <file>` / `:Unwatch` commands using
  `vim.uv.new_fs_event()` to auto `checktime` on external file changes.
- `lua/custom/ltex_toggle.lua` — commented-out `:LtexToggle` command that detaches /
  re-attaches the LTeX LSP client for the current buffer.
return {
  {
    'lervag/vimtex',
    -- This is CRITICAL as per the README you provided.
    -- Do not lazy-load vimtex.
    lazy = false,
    init = function()
      -- This is the recommended place for VimTeX configuration.
      -- Set your preferred PDF viewer.
      -- (Change 'zathura' to 'Skim' on macOS or 'SumatraPDF' on Windows)
      vim.g.vimtex_view_method = 'zathura'

      -- This is the default compiler, but it's good to be explicit
      vim.g.vimtex_compiler_method = 'latexmk'

      -- Optional: Enable folding
      -- vim.g.vimtex_fold_enabled = 1
    end,
  },
}

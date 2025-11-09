-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

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

  {
    'iamcco/markdown-preview.nvim',
    -- This command builds the plugin's web app. It requires npm.
    build = 'cd app && npm install',
    -- This makes it load only when you open a markdown file
    ft = { 'markdown' },
    -- We can also add a nice keymap for it
    config = function()
      -- Set the keymap <leader>mp (space + m + p)
      vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>', { desc = '[M]arkdown [P]review' })
    end,
  },
}

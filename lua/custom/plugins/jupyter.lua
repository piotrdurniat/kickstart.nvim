return {
  -- 1. THE ENGINE (molten-nvim)
  {
    'benlubas/molten-nvim',
    -- This is the main plugin, so IT gets the filetype trigger
    ft = { 'ipynb' },
    -- It depends on jupytext (for file conversion) and image (for viewing)
    dependencies = { 'goerz/jupytext.nvim', '3rd/image.nvim' },
    config = function()
      -- By the time this config runs, dependencies are loaded
      require('molten').setup {
        image_provider = require 'image',
      }
      -- Add keymaps
      vim.keymap.set('n', '<leader>rr', '<cmd>MoltenRunCell<CR>', { desc = '[R]un Cell' })
      vim.keymap.set('n', '<leader>ra', '<cmd>MoltenRunAll<CR>', { desc = '[R]un All' })
      vim.keymap.set('v', '<leader>rr', '<cmd>MoltenRunVisual<CR>', { desc = '[R]un (Visual)' })
    end,
  },

  -- 2. THE CONVERTER (jupytext)
  {
    'goerz/jupytext.nvim',
    -- This is now a dependency of molten, but we can still
    -- define its own config here. lazy.nvim will merge them.
    version = '0.2.0',
    opts = {}, -- This will just run require('jupytext').setup({})
  },

  -- 3. THE IMAGE VIEWER (for plots)
  {
    '3rd/image.nvim',
    -- This is also a dependency of molten.
    config = function()
      require('image').setup {
        backend = 'kitty',
      }
    end,
  },
}

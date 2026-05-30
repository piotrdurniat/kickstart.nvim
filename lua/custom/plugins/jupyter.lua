return {
  {
    'goerz/jupytext.nvim',
    version = '0.2.0',
    lazy = false,
    opts = {},
  },
  {
    'benlubas/molten-nvim',
    version = '^1.0.0',
    dependencies = { '3rd/image.nvim' },
    build = ':UpdateRemotePlugins',
    init = function()
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_output_virt_lines = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_enter_output_behavior = 'open_and_enter'
      vim.g.molten_open_cmd = '/home/piotr/.local/bin/molten-browser'

      vim.api.nvim_create_autocmd('BufWinLeave', {
        pattern = '*.ipynb',
        callback = function()
          pcall(vim.cmd, 'MoltenSave')
        end,
      })

      vim.api.nvim_create_autocmd('BufWinEnter', {
        pattern = '*.ipynb',
        callback = function()
          pcall(vim.cmd, 'MoltenLoad')
        end,
      })
    end,
    -- [[ REFACTORED KEYMAPS START HERE ]]
    keys = {
      -- Core
      { '<leader>ji', '<cmd>MoltenInit<cr>', desc = '[J]upyter [I]nit' },
      { '<leader>je', '<cmd>MoltenExportOutput<cr>', desc = '[J]upyter [E]xport Output' },

      -- Run
      { '<leader>jr', '<cmd>MoltenReevaluateCell<cr>', desc = '[J]upyter [R]un Cell' },
      { '<leader>jr', ':<C-u>MoltenEvaluateVisual<CR>gv', mode = 'v', desc = '[J]upyter [R]un Visual' },
      { '<leader>jd', '<cmd>MoltenDelete<cr>', desc = '[J]upyter [D]elete Cell' },

      -- Output Manipulation
      { '<leader>jh', '<cmd>MoltenHideOutput<cr>', desc = '[J]upyter [H]ide Output' },
      { '<leader>js', '<cmd>noautocmd MoltenEnterOutput<cr>', desc = '[J]upyter [S]how/Enter Output' },

      -- Images/Browser
      { '<leader>jp', '<cmd>MoltenImagePopup<cr>', desc = '[J]upyter [P]opup (Image)' },
      { '<leader>jb', '<cmd>MoltenOpenInBrowser<cr>', desc = '[J]upyter Open [B]rowser (Component)' },

      -- Open the actual Notebook file in Jupyter Lab/Notebook
      {
        '<leader>jo',
        function()
          local filepath = vim.fn.expand '%:p'
          -- Uses 'jupyter notebook' command. You can change to 'jupyter lab' if you prefer.
          -- 'detach = true' ensures Neovim doesn't freeze while the server runs.
          vim.fn.jobstart({ 'jupyter', 'notebook', filepath }, { detach = true })
        end,
        desc = '[J]upyter [O]pen Notebook',
      },
    },
  },

  -- 3. THE IMAGE VIEWER (Kept same)
  {
    '3rd/image.nvim',
    opts = {
      backend = 'kitty',
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = false,
      integrations = {
        markdown = {
          enabled = false,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { 'markdown', 'vimwiki' },
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { 'norg' },
        },
      },
    },
  },
}

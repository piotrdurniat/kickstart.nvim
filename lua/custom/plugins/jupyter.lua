return {
  -- 1. THE ENGINE (molten-nvim)
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- Pin version for stability
    dependencies = { '3rd/image.nvim' },
    build = ':UpdateRemotePlugins', -- CRITICAL from README: Molten is a remote plugin
    init = function()
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_output_win_max_height = 20

      -- 1. DISABLE POPUP
      vim.g.molten_auto_open_output = false

      -- This pushes text down to show output in the "ghost" space
      vim.g.molten_output_virt_lines = true

      -- 3. TEXT WRAPPING
      vim.g.molten_wrap_output = true

      -- Optional: Keep the side virtual text for short status messages
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true

      -- Makes <leader>os open the window AND jump into it in one go
      vim.g.molten_enter_output_behavior = 'open_and_enter'

      vim.g.molten_open_cmd = '/home/piotr/.local/bin/molten-browser'
      --- Automatic save/load
      vim.api.nvim_create_autocmd('BufWinLeave', {
        pattern = '*.ipynb',
        callback = function()
          -- Try to save. The pcall prevents errors if Molten isn't initialized
          pcall(vim.cmd, 'MoltenSave')
        end,
      })

      vim.api.nvim_create_autocmd('BufWinEnter', {
        pattern = '*.ipynb',
        callback = function()
          -- Try to load data. If a save file exists, it loads it.
          -- If not, it does nothing silently.
          pcall(vim.cmd, 'MoltenLoad')
        end,
      })
    end,
    keys = {
      { '<leader>mi', '<cmd>MoltenInit<cr>', desc = '[M]olten [I]nit' },

      -- CHANGED: Used the official command from README table
      { '<leader>rr', '<cmd>MoltenReevaluateCell<cr>', desc = '[R]un Cell' },

      -- CHANGED: Visual mode mapping as per README instructions (using :<C-u>...gv)
      { '<leader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', mode = 'v', desc = '[R]un Visual Selection' },

      -- ADDED: Highly recommended by README
      { '<leader>oe', '<cmd>MoltenEvaluateOperator<cr>', desc = '[O]perator [E]valuate (e.g. oeip)' },

      { '<leader>rd', '<cmd>MoltenDelete<cr>', desc = '[R]un Delete Cell' },
      { '<leader>rh', '<cmd>MoltenHideOutput<cr>', desc = '[R]un Hide Output' },
      { '<leader>os', '<cmd>noautocmd MoltenEnterOutput<cr>', desc = '[O]pen [S]how Output' },
      { '<leader>ob', '<cmd>MoltenOpenInBrowser<cr>', desc = '[O]pen in [B]rowser' },
      { '<leader>op', '<cmd>MoltenImagePopup<cr>', desc = '[O]pen [P]opup (Image)' },
    },
  },

  -- 2. THE CONVERTER (jupytext)
  {
    'goerz/jupytext.nvim',
    version = '0.2.0',
    opts = {},
  },

  -- 3. THE IMAGE VIEWER (for plots)
  {
    '3rd/image.nvim',
    opts = {
      backend = 'kitty',
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = false,

      -- ADD THIS SECTION TO FIX THE CRASH
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

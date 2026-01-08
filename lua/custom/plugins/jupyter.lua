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
      -- Adjust this path if needed
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
    keys = {
      { '<leader>mi', '<cmd>MoltenInit<cr>', desc = '[M]olten [I]nit' },
      { '<leader>rr', '<cmd>MoltenReevaluateCell<cr>', desc = '[R]un Cell' },
      { '<leader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', mode = 'v', desc = '[R]un Visual Selection' },
      { '<leader>oe', '<cmd>MoltenEvaluateOperator<cr>', desc = '[O]perator [E]valuate' },
      { '<leader>rd', '<cmd>MoltenDelete<cr>', desc = '[R]un Delete Cell' },
      { '<leader>rh', '<cmd>MoltenHideOutput<cr>', desc = '[R]un Hide Output' },
      { '<leader>os', '<cmd>noautocmd MoltenEnterOutput<cr>', desc = '[O]pen [S]how Output' },
      { '<leader>ob', '<cmd>MoltenOpenInBrowser<cr>', desc = '[O]pen in [B]rowser' },
      { '<leader>op', '<cmd>MoltenImagePopup<cr>', desc = '[O]pen [P]opup (Image)' },
    },
  },

  -- 3. THE IMAGE VIEWER
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

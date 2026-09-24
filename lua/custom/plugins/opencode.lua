-- Flip to false to disable LaTeX equation rendering in markdown buffers.
-- (Keep the 'latex' treesitter parser in init.lua installed either way.)
local enable_latex = true

return {
  {
    'sudo-tee/opencode.nvim',
    config = function()
      require('opencode').setup {}
      -- Restore the old `NickvanDyke/opencode.nvim` `<leader>oa` "ask" keymap.
      -- The current plugin's quick chat opens an input prefilled with the
      -- current selection (visual) or current line (normal) context, which is
      -- the successor to the old `@this` ask.
      vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
        require('opencode.api').quick_chat()
      end, { desc = '[o]pencode [a]sk' })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          anti_conceal = { enabled = false },
          file_types = { 'markdown', 'opencode_output' },
          -- file_types = {},
          latex = {
            enabled = enable_latex,
            converter = { 'latex2text' },
            inline = true,
            block = true,
            highlight = 'RenderMarkdownMath',
            position = 'center',
          },
        },
        ft = { 'markdown', 'Avante', 'copilot-chat', 'opencode_output' },
        -- ft = { 'Avante', 'copilot-chat' },
      },
      -- Optional, for file mentions and commands completion, pick only one
      'saghen/blink.cmp',
      -- 'hrsh7th/nvim-cmp',

      -- Optional, for file mentions picker, pick only one
      -- 'folke/snacks.nvim',
      -- 'nvim-telescope/telescope.nvim',
      -- 'ibhagwan/fzf-lua',
      -- 'nvim_mini/mini.nvim',
    },
  },
}

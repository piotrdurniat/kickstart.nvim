return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {
      debug = false,
      show_help = false,
      window = {
        layout = 'float', -- (float) or 'vertical' (side panel)
        width = 0.6, -- width (60% window width)
        height = 0.6,
      },
    },
    keys = {
      {
        '<leader>cc',
        ':CopilotChatToggle<cr>',
        mode = { 'n', 'v' },
        desc = '[C]opilot [C]hat Toggle',
      },

      {
        '<leader>ce',
        ':CopilotChatExplain<cr>',
        mode = 'v',
        desc = '[C]opilot [E]xplain selection',
      },
      {
        '<leader>cf',
        ':CopilotChatFix<cr>',
        mode = 'v',
        desc = '[C]opilot [F]ix bugs in selection',
      },
      {
        '<leader>co',
        ':CopilotChatOptimize<cr>',
        mode = 'v',
        desc = '[C]opilot [O]ptimize selection',
      },

      {
        '<leader>cq',
        function()
          local input = vim.fn.input 'Prompt: '
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').visual or nil })

            -- require("CopilotChat").ask(input, { selection = function(source) return source.visual end })
            -- require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
            -- require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
          end
        end,
        mode = { 'n', 'v' },
        desc = '[C]opilot [Q]uick ask',
      },
    },
  },
}

return {
  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- Recommended/example keymaps.
      vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
        require('opencode').ask('@this: ', { submit = true })
      end, { desc = '[o]pencode [a]sk' })
      vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
        require('opencode').select()
      end, { desc = '[o]pencode [s]elect' })
      vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
        require('opencode').toggle()
      end, { desc = '[o]pencode [t]oggle' })

      -- Close opencode terminal with double ESC
      vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

      vim.keymap.set({ 'n', 'x' }, '<leader>oo', function()
        return require('opencode').operator '@this '
      end, { expr = true, desc = '[o]pencode [o]perator' })
      vim.keymap.set('n', '<leader>ool', function()
        return require('opencode').operator '@this ' .. '_'
      end, { expr = true, desc = '[o]pencode [l]ine' })

      vim.keymap.set('n', '<leader>ou', function()
        require('opencode').command 'session.half.page.up'
      end, { desc = '[o]pencode [u]p' })
      vim.keymap.set('n', '<leader>od', function()
        require('opencode').command 'session.half.page.down'
      end, { desc = '[o]pencode [d]own' })

      -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
      vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
      vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
    end,
  },
}

return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = '[H]arpoon [A]dd' })

      vim.keymap.set('n', '<leader>hv', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = '[H]arpoon [V]iew' })

      for i = 1, 7 do
        vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon file ' .. i })
      end

      -- Harpoon2 dropped the built-in `harpoon.term` module, so these are
      -- standalone numbered terminals (create-on-first-use, reused after).
      -- They take over the current window rather than opening a split.
      local terms = {}
      local function goto_term(index)
        local bufnr = terms[index]
        if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
          vim.api.nvim_win_set_buf(0, bufnr)
        else
          vim.cmd 'terminal'
          terms[index] = vim.api.nvim_get_current_buf()
        end
        vim.cmd 'startinsert'
      end

      vim.keymap.set('n', '<leader>t1', function() goto_term(1) end, { desc = '[T]erminal 1' })
      vim.keymap.set('n', '<leader>t2', function() goto_term(2) end, { desc = '[T]erminal 2' })
    end,
  },
}

return {
  'theprimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'
    local term = require 'harpoon.term'
    local cmd_ui = require 'harpoon.cmd-ui'

    vim.keymap.set('n', '<leader>ha', mark.add_file, { desc = '[H]arpoon [A]dd' })
    vim.keymap.set('n', '<leader>hv', ui.toggle_quick_menu, { desc = '[H]arpoon [V]iew' })

    vim.keymap.set('n', '<leader>1', function()
      ui.nav_file(1)
    end)
    vim.keymap.set('n', '<leader>2', function()
      ui.nav_file(2)
    end)
    vim.keymap.set('n', '<leader>3', function()
      ui.nav_file(3)
    end)
    vim.keymap.set('n', '<leader>4', function()
      ui.nav_file(4)
    end)
    vim.keymap.set('n', '<leader>5', function()
      ui.nav_file(5)
    end)
    vim.keymap.set('n', '<leader>6', function()
      ui.nav_file(6)
    end)
    vim.keymap.set('n', '<leader>7', function()
      ui.nav_file(7)
    end)

    vim.keymap.set('n', '<leader>t1', function()
      term.gotoTerminal(1)
    end, { desc = '[H]arpoon [T]erminal' })
    vim.keymap.set('n', '<leader>t2', function()
      term.gotoTerminal(2)
    end, { desc = '[H]arpoon [T]erminal 2' })
    vim.keymap.set('n', '<leader>hc', function()
      cmd_ui.toggle_quick_menu()
    end, { desc = '[H]arpoon [C]ommands' })
  end,
}

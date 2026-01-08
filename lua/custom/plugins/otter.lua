return {
  'jmbuhr/otter.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {},
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'markdown', 'quarto' },
      callback = function()
        -- [[ FIX: Use pcall to suppress "Buffer with this name already exists" error ]]
        -- This allows Otter to attach even if Jupytext has claimed the buffer name
        local ok, err = pcall(require('otter').activate, { 'python', 'lua' }, true, true, nil)

        -- Optional: Log error to debug only if needed, otherwise stay silent
        -- if not ok and not err:match("E95") then vim.notify(err, vim.log.levels.WARN) end
      end,
    })
  end,
}

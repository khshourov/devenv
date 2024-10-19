require('dashboard').setup({
  theme = 'doom',
  config = {
    header = { '', '', '', '', '', '', '', '', '' },
    center = {
      { icon = '  ',                              key_format = '%s',  desc = 'New file                  ', action = 'enew' },
      { icon = '  ', key = 'f', keymap = 'SPC f', key_format = ' %s', desc = 'Find file                 ', action = 'Telescope find_files' },
      { icon = '  ', key = 'h', keymap = 'SPC h', key_format = ' %s', desc = 'Recent files              ', action = 'Telescope oldfiles' },
      { icon = '  ', key = 'g', keymap = 'SPC g', key_format = ' %s', desc = 'Find Word                 ', action = 'Telescope live_grep' },
    },
    footer = { '' }
  }
})

vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#6272a4' })
vim.api.nvim_set_hl(0, 'DashboardCenter', { fg = '#f8f8f2' })
vim.api.nvim_set_hl(0, 'DashboardShortcut', { fg = '#bd93f9' })
vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#6272a4' })

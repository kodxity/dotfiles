return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', {
      desc = 'NeoTree reveal',
      silent = true,
    })

    require('neo-tree').setup({
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    })
  end,
}

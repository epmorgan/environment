require 'nvim-tree'.setup {
  git = {
    ignore = false
  },
  update_focused_file = {
    enable = true,
  },
  view = {
    width = 24,
    adaptive_size = true,
    float = {
      quit_on_focus_loss = true,
      enable = true
    }
  }
}

vim.keymap.set('n', '<C-n>', vim.cmd.NvimTreeToggle)
vim.keymap.set('n', '<leader>ff', vim.cmd.NvimTreeFindFile)

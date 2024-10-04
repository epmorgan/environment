vim.api.nvim_create_augroup('setIndent', { clear = true })
-- vim.api.nvim_create_autocmd('Filetype', {
--  group = 'setIndent',
--  pattern = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' },
--  command = 'setlocal shiftwidth=2 tabstop=2'
-- })

vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'c' },
  command = 'setlocal shiftwidth=8 tabstop=8'
})

vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'objc', 'objcpp' },
  command = 'setlocal shiftwidth=4 tabstop=4'
})

vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'cpp' },
  command = 'setlocal shiftwidth=4 tabstop=4'
})

vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'cs' },
  command = 'setlocal shiftwidth=4 tabstop=4'
})

vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'zig' },
  command = 'setlocal shiftwidth=4 tabstop=4'
})

vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'go' },
  command = 'setlocal shiftwidth=8 tabstop=8'
})


vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'odin' },
  command = 'setlocal shiftwidth=8 tabstop=8'
})

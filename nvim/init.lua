local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("sixfourtwelve")

local formatter_ocamlformat = {
  function()
    return {
      exe = "ocamlformat",
      args = { vim.api.nvim_buf_get_name(0) },
      stdin = true
    }
  end
}

require('formatter').setup({
  logging = true,
  filetype = {
    ocamlformat = formatter_ocamlformat,
  }
})

vim.api.nvim_exec([[
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
]], true)

vim.api.nvim_command(
  "autocmd BufWritePre *.ex,*.go,*.lua,*.rb,*.hs,*.py,*.ml,*.mli,*.c,*.h,*.cc,*.hh,*.cpp,*.hpp,*.m,*.mm,*.php,*.odin,*.rs,*.cs,*.java,*.re,*.rei,*.res,*.resi,*.scala,*.sbt,*.gleam,*.ts,*.tsx,*.test.ts,*.test.tsx,*.js,*.jsx,*.test.js,*.test.jsx,*.cr  lua vim.lsp.buf.format()")

-- vim.api.nvim_command("autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll")

vim.o.termguicolors = true

vim.o.background = "dark"

vim.cmd [[colorscheme bore]]
-- vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]

vim.api.nvim_set_option("clipboard", "unnamed")

require('gitsigns').setup()

require("tokyonight").setup({
  style = {
    comments = { italic = false },
    keywords = { italic = false },
    functions = { italic = false },
    variables = { italic = false },
  }
})

vim.api.nvim_exec([[
set statusline=%!StatusLineNormal()

let g:currentmode={
  \ 'n': 'Normal',
  \ 'no': 'Normal·Operator Pending',
  \ 'v': 'Visual',
  \ 'V': 'Visual Line',
  \ '^V': 'Visual Block',
  \ 's': 'Select',
  \ 'S': 'S Line',
  \ '^S': 'S Block',
  \ 'i': 'Insert',
  \ 'R': 'Replace',
  \ 'Rv': 'V Replace',
  \ 'c': 'Command',
  \ 'cv': 'Vim Ex',
  \ 'ce': 'Ex',
  \ 'r': 'Prompt',
  \ 'rm': 'More',
  \ 'r?': 'Confirm',
  \ '!': 'Shell',
  \ 't': 'Terminal'
  \ }
let g:endoflines = {
  \ 'unix': 'lf',
  \ 'windows': 'crlf'
  \ }


function StatusLineNormal() abort
  let b:leftstatus = ''
  let b:rightstatus = ''

  hi SshGroup guibg=#fafafa guifg=#0d0d0d
  let b:leftstatus .= "%#SshGroup#   %#StatusLine#"
  let b:leftstatus .= '   '
  let b:leftstatus .= ' %{StatusErrors()} '
  let b:leftstatus .= ' %{StatusWarnings()}   '
  let b:leftstatus .= '-- %{toupper(g:currentmode[mode()])} --'
  let b:rightstatus .= 'File: %t   '
  let b:rightstatus .= 'Spaces: %{&shiftwidth}'
  let b:rightstatus .= '   %{empty(&fenc)?toupper(&fenc):toupper(&enc)}'
  let b:rightstatus .= '   %{toupper(g:endoflines[&ff])}'
  if !empty(&ft) && &ft != 'TelescopePrompt'
    let b:rightstatus .= '    %{&ft}'
  endif
  let b:rightstatus .= '   '
  return b:leftstatus . '%=' . b:rightstatus
endfunction
function StatusWarnings() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '0' | endif
  return info['warning']
endfunction
function StatusErrors() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '0' | endif
  return info['error']
endfunction

]], true)

require("ts-error-translator").setup()
require 'ocaml_mlx'

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
  "autocmd BufWritePre *.ex,*.go,*.lua,*.rb,*.hs,*.py,*.ml,*.mli,*.c,*.h,*.cc,*.hh,*.cpp,*.hpp,*.m,*.mm,*.php,*.odin,*.rs,*.cs,*.java,*.re,*.rei,*.res,*.resi,*.scala,*.sbt,*.gleam lua vim.lsp.buf.format()")

vim.api.nvim_command("autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll")

vim.o.termguicolors = true

vim.o.background = "dark"

vim.cmd [[colorscheme tokyonight-moon]]
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

require("ts-error-translator").setup()
require 'ocaml_mlx'

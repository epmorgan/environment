require('nvim-treesitter.configs').setup {
  ensure_installed = { "typescript", "c", "cpp", "javascript", "lua", "ocaml", "go", "dockerfile", "php", "perl", "json", "yaml", "toml", "html", "css", "bash", "tsx", "python", "rust", "haskell" },
  sync_install = false,
  auto_install = true,
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require('treesitter-context').setup {
  enable = false
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 4

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.rescript = {
  install_info = {
    url = "https://github.com/rescript-lang/tree-sitter-rescript",
    branch = "main",
    files = { "src/parser.c", "src/scanner.c" },
    generate_requires_npm = false,
    requires_generate_from_grammar = true,
    use_makefile = true, -- macOS specific instruction
  },
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.fsharp = {
  install_info = {
    url = 'https://github.com/ionide/tree-sitter-fsharp',
    branch = 'main',
    files = { 'src/scanner.c', 'src/parser.c' },
  },
  requires_generate_from_grammar = false,
  filetype = 'fsharp',
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.unison = {
  install_info = {
    url = 'https://github.com/kylegoetz/tree-sitter-unison',
    branch = 'main',
    files = { 'src/scanner.c', 'src/parser.c' },
  },
  requires_generate_from_grammar = false,
  filetype = 'unison',
}

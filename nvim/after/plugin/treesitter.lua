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

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.crystal = {
  install_info = {
    url = "https://github.com/crystal-lang-tools/tree-sitter-crystal",
    files = { "src/parser.c", "src/scanner.c" },
    -- optional entries:
    branch = "main",
  },
  filetype = "haxe",
}

require('treesitter-context').setup {
  enable = true
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 4

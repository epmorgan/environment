---@diagnostic disable: undefined-global
---
vim.g.mapleader = " "
vim.g.maplocalleader = ","

return require("lazy").setup({
  { "vim-crystal/vim-crystal" },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { "folke/tokyonight.nvim" },
  { 'dmmulroy/ts-error-translator.nvim' },
  { 'Olical/conjure' },
  { "ocaml-mlx/ocaml_mlx.nvim" },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup({})
    end
  },
  { 'fatih/vim-go' },
  { "nvim-treesitter/nvim-treesitter", build = ':TSUpdate', lazy = false },
  { "nvim-treesitter/playground" },
  { 'nvim-lualine/lualine.nvim' },
  { "tpope/vim-fugitive" },
  { "chrisbra/Colorizer" },
  { "lewis6991/gitsigns.nvim" },
  { "f-person/git-blame.nvim" },
  { 'sixfourtwelve/bore.vim' },
  { "j-hui/fidget.nvim" },
  { 'MunifTanjim/nui.nvim' },
  { "folke/noice.nvim" },
  {
    "hedyhli/outline.nvim",
    config = function()
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
        { desc = "Toggle Outline" })

      require("outline").setup {
        outline_window = {
          width = 25,
          relative_width = true,
          focus_on_open = true,
          auto_jump = false
        },
        preview_window = {
          auto_preview = true,
          open_hover_on_preview = true,
          width = 50,
          min_width = 50,
          relative_width = true,
          border = 'single',
          winhl = 'NormalFloat:',
        },
      }
    end,
  },
  { 'windwp/nvim-autopairs' },
  {
    'VonHeikemen/lsp-zero.nvim',
    lazy = false,
    branch = 'v1.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  },
  { 'mhartington/formatter.nvim' },
  { 'kyazdani42/nvim-tree.lua',               dependencies = 'kyazdani42/nvim-web-devicons' },
  { 'nvim-telescope/telescope.nvim',          dependencies = { { 'nvim-lua/plenary.nvim' } } },
  { "mbbill/undotree" },
  { "nvim-treesitter/nvim-treesitter-context" },
  { "catppuccin/nvim",                        name = "catppuccin",                           priority = 1000 },
}, opts)

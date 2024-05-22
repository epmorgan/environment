vim.g.mapleader = " "

return require("lazy").setup({
  {
    "topazape/md-preview.nvim",
    ft = { "md", "markdown", "mkd", "mkdn", "mdwn", "mdown", "mdtxt", "mdtext", "rmd", "wiki" },
    config = function()
      require("md-preview").setup({
        viewer = {
          exec = "glow",
          args = { "-s", "dark" },

        },
        term = {
          reload = {
            enable = true,
            events = { "InsertLeave", "TextChanged" },
          },
          direction = "vertical",
          keys = {
            close = { "q" },
            refresh = "r",
          },
        },
      })
    end
  },
  { 'fatih/vim-go' },
  { 'junegunn/goyo.vim' },
  { "nvim-treesitter/nvim-treesitter", build = ':TSUpdate', lazy = false },
  { "nvim-treesitter/playground" },
  { 'nvim-lualine/lualine.nvim' },
  { "tpope/vim-fugitive" },
  { "chrisbra/Colorizer" },
  -- Git stuff
  { "lewis6991/gitsigns.nvim" },
  { "f-person/git-blame.nvim" },

  -- UI
  { 'sixfourtwelve/bore.vim' },
  { "j-hui/fidget.nvim" },
  { 'MunifTanjim/nui.nvim' },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },
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
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  },
  { 'mhartington/formatter.nvim' },
  { 'kyazdani42/nvim-tree.lua',               dependencies = 'kyazdani42/nvim-web-devicons' },
  { 'nvim-telescope/telescope.nvim',          dependencies = { { 'nvim-lua/plenary.nvim' } } },
  { 'ggandor/lightspeed.nvim' },
  { "mbbill/undotree" },
  { 'alexanderjeurissen/lumiere.vim' },
  { "nvim-treesitter/nvim-treesitter-context" },
  --  { 'andweeb/presence.nvim' },
}, opts)

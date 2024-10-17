vim.g.mapleader = " "

return require("lazy").setup({
  { "dmmulroy/tsc.nvim" },
  { "dmmulroy/ts-error-translator.nvim" },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.on_attach = function(client, bufnr)
        -- your on_attach function
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  },
  { "github/copilot.vim" },
  { "ocaml-mlx/ocaml_mlx.nvim" },
  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
  },
  { 'reasonml-editor/vim-reason-plus' },
  { 'danielo515/nvim-treesitter-reason' },
  { 'rescript-lang/vim-rescript',       ft = "rescript" },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup({})
    end
  },
  { 'junegunn/limelight.vim' },
  { 'folke/tokyonight.nvim' },
  {
    'akinsho/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    config = true,
  },
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
  {
    -- Unison
    "unisonweb/unison",
    branch = "trunk",
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/editor-support/vim")
      require("lazy.core.loader").packadd(plugin.dir .. "/editor-support/vim")
    end,
    init = function(plugin)
      require("lazy.core.loader").ftdetect(plugin.dir .. "/editor-support/vim")
    end,
  },
  -- { "Olical/conjure" },
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
  { "nvim-treesitter/nvim-treesitter-context" },
  { "catppuccin/nvim",                        name = "catppuccin",                           priority = 1000 },
}, opts)

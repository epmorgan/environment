local lspkind = require('lspkind')
local lsp = require("lsp-zero")
local cmp = require('cmp')
local lspconfig = require("lspconfig")

lsp.preset("recommended")
lsp.setup()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-x>'] = cmp.mapping.confirm({ select = true }),
    ['<tab>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 's', }),
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = {
        menu = 100,             -- leading text (labelDetails)
        abbr = 100,             -- actual suggestion item
      },
      ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        -- ...
        return vim_item
      end
    })
  }
})

local options = { buffer = bufnr, remap = false }
local on_attach =
    lsp.on_attach(function(client, bufnr)
      vim.keymap.set('n', 'gd', '<cmd>lua require"telescope.builtin".lsp_definitions({jump_type="vsplit"})<CR>', options)
      vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, options)
      vim.keymap.set("n", "bh", function() vim.lsp.buf.hover() end, options)
      vim.keymap.set("n", "ca", function() vim.lsp.buf.code_action() end, options)
      vim.keymap.set("n", "cr", function() vim.lsp.buf.rename() end, options)
      vim.keymap.set("n", "gv", function() vim.lsp.buf.signature_help() end, options)
      vim.keymap.set("n", "gl", function() vim.diagnostic.show_line_diagnostics() end, options)
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, options)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, options)
    end)


lsp.configure("vtsls", {
  root_dir = require("lspconfig").util.root_pattern("pnpm-workspace.yaml", "pnpm-lock.yaml", "yarn.lock",
    "package-lock.json", "bun.lockb", "package.json"),
  experimental = {
    completion = {
      entriesLimit = 3
    }
  }
})


lspconfig.ruby_lsp.setup {}
lspconfig.rescriptls.setup {}
lspconfig.gleam.setup({})

lspconfig.eslint.setup(
  {
    experimental = {
      useFlatConfig = true
    },
    on_attach = function(_client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
      "html",
      "markdown",
      "json",
      "jsonc",
      "yaml",
      "toml",
      "xml",
      "gql",
      "graphql",
      "astro",
      "svelte",
      "css",
      "less",
      "scss",
      "pcss",
      "postcss"
    },
  }
)

lspconfig.roc_ls.setup {}
lspconfig.zls.setup {}
lspconfig.ols.setup {
  init_options = {
    checker_args = "-strict-style"
  },
}

require('lspconfig')['unison'].setup {
  on_attach = on_attach,
}

lspconfig.sourcekit.setup {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
}
lspconfig.hls.setup {
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
  settings = {
    haskell = {
      cabalFormattingProvider = "cabalfmt",
      formattingProvider = "fourmolu"
    }
  }
}


vim.diagnostic.config({
  virtual_text = true
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true
  }
)


vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
  local locations = command.arguments[3]
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if locations and #locations > 0 then
    local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
    vim.fn.setloclist(0, {}, " ", { title = "References", items = items, context = ctx })
    vim.api.nvim_command("lopen")
  end
end

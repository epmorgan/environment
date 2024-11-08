local lspkind = require('lspkind')
local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")
local cmp = require('cmp')

lsp.preset("recommended")

lsp.set_preferences({
  sign_icons = { error = " ", warn = " ", hint = " ", info = " " }
})

local cmp_select = { behavior = cmp.SelectBehavior.Insert }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-x>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
  ['<Tab>'] = cmp.mapping.select_next_item({ behaviour = cmp.SelectBehavior.Insert }),
  ['<S-Tab>'] = cmp.mapping.select_prev_item({ behaviour = cmp.SelectBehavior.Insert })
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 1 },
    { name = 'buffer',   keyword_length = 3 },
    { name = 'luasnip',  keyword_length = 2 },
  }
})


local options = { buffer = bufnr, remap = false }
lsp.on_attach(function(client, bufnr)
  lsp.buffer_autoformat()
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


local on_attach = function(client, bufnr)
  vim.o.signcolumn = 'yes'

  vim.o.updatetime = 250

  vim.diagnostic.config({ virtual_text = false })

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

  vim.keymap.set('n', 'K', vim.lsp.buf.hover)
end

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


vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
  local locations = command.arguments[3]
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if locations and #locations > 0 then
    local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
    vim.fn.setloclist(0, {}, " ", { title = "References", items = items, context = ctx })
    vim.api.nvim_command("lopen")
  end
end

cmp.setup({
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
    })
  },
})


lsp.setup()

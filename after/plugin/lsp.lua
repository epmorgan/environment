local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
  "vtsls",
})

lsp.set_preferences({
  sign_icons = { error = " ", warn = " ", hint = " ", info = " " }
})

local cmp = require('cmp')
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
  root_dir = require("lspconfig").util.root_pattern(".git", "pnpm-workspace.yaml", "pnpm-lock.yaml", "yarn.lock",
    "package-lock.json", "bun.lockb"),
  experimental = {
    completion = {
      entriesLimit = 3
    }
  }
})

-- This function is for configuring a buffer when an LSP is attached
local on_attach = function(client, bufnr)
  -- Always show the signcolumn, otherwise it would shift the text each time
  -- diagnostics appear/become resolved
  vim.o.signcolumn = 'yes'

  -- Update the cursor hover location every 1/4 of a second
  vim.o.updatetime = 250

  -- Disable appending of the error text at the offending line
  vim.diagnostic.config({ virtual_text = false })

  -- Enable a floating window containing the error text when hovering over an error
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

  -- This setting is to display hover information about the symbol under the cursor
  vim.keymap.set('n', 'K', vim.lsp.buf.hover)
end

-- Setup the Unison LSP
require('lspconfig')['unison'].setup {
  on_attach = on_attach,
}

-- require('lspconfig').hls.setup {}

require('lspconfig').rescriptls.setup {}

lsp.setup()

require 'lspconfig'.sourcekit.setup {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
}

require 'lspconfig'.dartls.setup {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  init_options = {
    closingLabels = true,
    flutterOutline = true,
    onlyAnalyzeProjectsWithOpenFiles = true,
    outline = true,
    suggestFromUnimportedLibraries = true
  },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true
    }
  },
}

vim.diagnostic.config({
  virtual_text = true
})

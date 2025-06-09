-- Setup Mason to automatically install LSP servers
require('mason').setup()
require('mason-lspconfig').setup({ automatic_installation = true })

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lua language server
require('lspconfig').lua_ls.setup({ capabilities = capabilities })

-- Typescript & Javascript language server
require('lspconfig').ts_ls.setup({ capabilities = capabilities })

-- JSON
require('lspconfig').jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
})

--- nvim-lint setup (Diagnostics)
local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  json = {},
  -- Add more filetypes if needed
}

lint.linters.eslint_d.condition = function(ctx)
  return vim.fs.find(".eslint.config.mjs", { upward = true, path = ctx.filename })[1] ~= nil
end

-- Trailing space checker
lint.linters.trail_space = {
  cmd = "grep",
  stdin = false,
  args = { "-nH", "\\s\\+$" },
  stream = "stderr",
  ignore_exitcode = true,
  parser = require("lint.parser").from_pattern(
    "([^:]+):(%d+):() (.+)",
    { "filename", "lnum", "col", "message" },
    { source = "trail_space", severity = vim.diagnostic.severity.WARN }
  )
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  callback = function()
    if vim.bo.filetype ~= "NvimTree" then
      lint.try_lint()
      lint.try_lint("trail_space")
    end
  end,
})

-- conform.nvim setup (Formatting)
require("conform").setup({
  format_on_save = {
    lsp_fallback = true,
  },
  formatters_by_ft = {
    javascript = { "eslint_d", "prettierd" },
    typescript = { "eslint_d", "prettierd" },
    json = { "prettierd" },
    -- Add more as needed
  },
  formatters = {
    eslint_d = {
      condition = function(ctx)
        return vim.fs.find(".eslint.config.mjs", { upward = true, path = ctx.filename })[1] ~= nil
      end,
    },
  },
})

-- Keymaps
vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

-- Commands
vim.api.nvim_create_user_command('Format', 'vim.lsp.buf.formatting', {})

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = false,
  float = {
    source = true,
  }
})
-- Sign configuration
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

local lsp = require('lsp-zero').preset({})


lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})
end)


lsp.ensure_installed({
    'tsserver',
    'eslint',
})

local lspconfig = require('lspconfig')

-- (Optional) Configure lua language server for neovim
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lspconfig.tsserver.setup{
    settings = {
        -- Check types in JS.
        implicitProjectConfiguration = {
            checkJs = true
        },
    }
}
--- Format on =
vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format {async = true}
    end, {})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.setup()

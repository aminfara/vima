local M = {}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local sumneko_lua_config = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT',
      -- Setup your lua path
      path = runtime_path,
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { 'vim' },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file('', true),
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
  },
}

local present, lua_dev = pcall(require, 'lua-dev')
if present then
  sumneko_lua_config = lua_dev.setup({ lsp_config = sumneko_lua_config })
end

M.get_lsp_configs = function(capabilities, on_attach)
  return {
    sumneko_lua = vim.tbl_deep_extend('force', sumneko_lua_config, {
      capabilities = capabilities,
      on_attach = on_attach,
    }),
  }
end

M.get_null_ls_config = function(null_ls)
  return {
    null_ls.builtins.formatting.stylua.with({
      condition = function(utils)
        if not (vim.fn.executable('stylua') > 0) then
          require('vima.utils').notify_missing('stylua', 'null-ls.nvim')
          return false
        end
        return true
      end,
    }),
  }
end

return M

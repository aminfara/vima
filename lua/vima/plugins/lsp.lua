local present, lsp_installer_servers = pcall(require, 'nvim-lsp-installer.servers')
if not present then
  require('vima.utils').notify_missing_plugin('nvim-lsp-installer')
  return
end

local present, lsp_signature = pcall(require, 'lsp_signature')
if not present then
  require('vima.utils').notify_missing_plugin('lsp_signature.nvim')
  return
end

local present, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not present then
  require('vima.utils').notify_missing_plugin('cmp-nvim-lsp')
  return
end

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

vim.diagnostic.config({
  signs = {
    active = signs,
  },
  virtual_text = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
          augroup vima_lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]],
      false
    )
  end
end

local on_attach = function(client, bufnr)
  -- TODO: format on save
  lsp_signature.on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = 'rounded',
    },
  }, bufnr)

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

  require('vima.plugins.which-key').get_lsp_mappings(bufnr)
  lsp_highlight_document(client)
end

for _, lang in pairs(require('vima.languages').supported_languages) do
  -- try to load language config
  local present, lang_config = pcall(require, 'vima.languages.' .. lang)

  if present then
    -- get all lsp configs for the language
    local lsp_configs = lang_config.get_lsp_configs(capabilities, on_attach)

    for lsp_name, lsp_config in pairs(lsp_configs) do
      vim.inspect(lsp_config)
      local server_available, requested_server = lsp_installer_servers.get_server(lsp_name)

      if server_available then
        requested_server:on_ready(function()
          requested_server:setup(lsp_config)
        end)

        if not requested_server:is_installed() then
          requested_server:install()
          vim.notify(lsp_name .. ' is being installed.')
        end
      end
    end
  end
end

local present, comment = pcall(require, 'Comment')
if not present then
  require('vima.utils').notify_missing_plugin('Comment.nvim')
  return
end

local present, ts_context_commentstring = pcall(require, 'ts_context_commentstring')
if not present then
  require('vima.utils').notify_missing_plugin('nvim_ts_context_commentstring')
  return
end

require('Comment').setup({
  pre_hook = function(ctx)
    local U = require('Comment.utils')

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end

    return require('ts_context_commentstring.internal').calculate_commentstring({
      key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      location = location,
    })
  end,
})

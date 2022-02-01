local present, notify = pcall(require, 'notify')
if not present then
  require('vima.utils').notify_missing('nvim-notify')
end
-- redirect all notifications to this module
vim.notify = notify

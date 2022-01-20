local present, notify = pcall(require, 'notify')
if not present then
  vim.notify('Failed to load nvim-notify.')
end
-- redirect all notifications to this module
vim.notify = notify

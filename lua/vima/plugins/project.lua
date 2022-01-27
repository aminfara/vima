local present, project = pcall(require, 'project_nvim')
if not present then
  require('vima.utils').notify_missing_plugin('project.nvim')
  return
end

project.setup({})

local present, telescope = pcall(require, 'telescope')
if present then
  telescope.load_extension('projects')
end

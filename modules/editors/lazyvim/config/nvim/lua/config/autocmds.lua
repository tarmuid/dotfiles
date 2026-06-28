-- Autocmds are automatically loaded on the VeryLazy event.
-- Add any additional autocmds here.

local disable_markdown_spell = function()
  vim.opt_local.spell = false
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "markdown.mdx" },
  callback = disable_markdown_spell,
})

if vim.bo.filetype == "markdown" or vim.bo.filetype == "markdown.mdx" then
  disable_markdown_spell()
end

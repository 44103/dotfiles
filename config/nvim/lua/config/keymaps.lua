-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Copy file path / name to clipboard
vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy relative file path" })

vim.keymap.set("n", "<leader>cP", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy absolute file path" })

vim.keymap.set("n", "<leader>cf", function()
  local name = vim.fn.expand("%:t")
  vim.fn.setreg("+", name)
  vim.notify("Copied: " .. name)
end, { desc = "Copy file name" })

-- Reverse Ctrl+Left/Right in right-side explorer so visual direction matches
local function is_explorer_window()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local bufname = vim.api.nvim_buf_get_name(buf)
  return ft == "snacks_picker_list" or ft == "snacks_picker_input" or bufname:match("explorer")
end

vim.keymap.set("n", "<C-Left>", function()
  if is_explorer_window() then
    vim.cmd("vertical resize +2")
  else
    vim.cmd("vertical resize -2")
  end
end, { desc = "Resize window width (direction-aware)" })

vim.keymap.set("n", "<C-Right>", function()
  if is_explorer_window() then
    vim.cmd("vertical resize -2")
  else
    vim.cmd("vertical resize +2")
  end
end, { desc = "Resize window width (direction-aware)" })


-- Open the commit/PR page for the current line's git blame
vim.keymap.set("n", "<leader>gp", function()
  local line = vim.fn.line(".")
  local file = vim.fn.expand("%:p")
  -- Get commit hash from git blame
  local blame = vim.fn.systemlist(string.format("git blame -L %d,%d --porcelain %s", line, line, file))
  local commit = blame[1] and blame[1]:match("^(%x+)")

  if commit and not commit:find("^0+$") then
    -- Open commit page with gh browse (PR link is shown on GitHub commit page)
    local result = vim.fn.system(string.format("gh browse %s 2>&1", commit))
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to open: " .. result, vim.log.levels.ERROR)
    end
  else
    vim.notify("No blame info found", vim.log.levels.WARN)
  end
end, { desc = "Open commit (with PR link) for current line" })

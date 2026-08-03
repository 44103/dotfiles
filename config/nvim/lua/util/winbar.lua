-- Winbar: Display path from repository root in breadcrumb format
local M = {}

--- Get git repository root
---@return string|nil
local function get_git_root()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
  if vim.v.shell_error ~= 0 or not git_root then
    return nil
  end
  return git_root
end

--- Convert file path to breadcrumb format
---@return string
function M.get_winbar()
  local bufname = vim.api.nvim_buf_get_name(0)

  -- Skip empty or special buffers
  if bufname == "" then
    return ""
  end

  local buftype = vim.bo.buftype
  if buftype ~= "" then
    return ""
  end

  -- Convert to absolute path
  local filepath = vim.fn.fnamemodify(bufname, ":p")

  -- Get relative path from git root
  local git_root = get_git_root()
  local display_path

  if git_root then
    -- Relative path from git root
    if filepath:sub(1, #git_root) == git_root then
      display_path = filepath:sub(#git_root + 2) -- +2 for trailing slash
    else
      display_path = vim.fn.fnamemodify(bufname, ":~:.")
    end
  else
    -- Relative path from CWD if not in a git repository
    display_path = vim.fn.fnamemodify(bufname, ":~:.")
  end

  -- Convert path to breadcrumb format (/ to ›)
  local parts = vim.split(display_path, "/", { plain = true })

  -- Highlight filename part
  if #parts > 1 then
    local dirs = table.concat(vim.list_slice(parts, 1, #parts - 1), " › ")
    local filename = parts[#parts]
    return "%#WinBarPath#" .. dirs .. " › %#WinBarFile#" .. filename .. "%*"
  else
    return "%#WinBarFile#" .. parts[1] .. "%*"
  end
end

return M

local M = {}

local uv = vim.uv or vim.loop

local function is_windows()
  return vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
end

local function is_file(path)
  if not path or path == "" then
    return false
  end

  local stat = uv.fs_stat(path)
  return stat ~= nil and stat.type == "file"
end

local function python_from_venv_root(root, conda)
  if not root or root == "" then
    return nil
  end

  if is_windows() then
    if conda then
      return root .. "\\python.exe"
    end
    return root .. "\\Scripts\\python.exe"
  end

  return root .. "/bin/python"
end

local function get_from_venv_selector()
  local ok, selector = pcall(require, "venv-selector")
  if not ok then
    return nil
  end

  local ok_python, python = pcall(selector.python)
  if not ok_python or type(python) ~= "string" or python == "" then
    return nil
  end

  if is_file(python) then
    return python
  end

  return nil
end

local function get_from_env_vars()
  local venv = vim.env.VIRTUAL_ENV
  local venv_python = python_from_venv_root(venv, false)
  if is_file(venv_python) then
    return venv_python
  end

  local conda = vim.env.CONDA_PREFIX
  local conda_python = python_from_venv_root(conda, true)
  if is_file(conda_python) then
    return conda_python
  end

  return nil
end

local function find_local_venv_python(start_dir)
  local dir = start_dir
  while dir and dir ~= "" do
    for _, name in ipairs({ ".venv", "venv", ".env", "env" }) do
      local python = python_from_venv_root(vim.fs.joinpath(dir, name), false)
      if is_file(python) then
        return python
      end
    end

    local parent = vim.fs.dirname(dir)
    if parent == dir then
      break
    end
    dir = parent
  end

  return nil
end

local function candidate_roots(explicit_root)
  local roots = {}
  local seen = {}

  local function add(path)
    if not path or path == "" or seen[path] then
      return
    end

    seen[path] = true
    table.insert(roots, path)
  end

  add(explicit_root)

  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file ~= "" then
    add(vim.fs.dirname(current_file))
  end

  add(vim.fn.getcwd())

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    add(client.config and client.config.root_dir or nil)
  end

  return roots
end

function M.get_python(root)
  local selector_python = get_from_venv_selector()
  if selector_python then
    return selector_python
  end

  local env_python = get_from_env_vars()
  if env_python then
    return env_python
  end

  for _, candidate_root in ipairs(candidate_roots(root)) do
    local local_python = find_local_venv_python(candidate_root)
    if local_python then
      return local_python
    end
  end

  local system_python = vim.fn.exepath("python3")
  if system_python ~= "" then
    return system_python
  end

  system_python = vim.fn.exepath("python")
  if system_python ~= "" then
    return system_python
  end

  return "python"
end

return M

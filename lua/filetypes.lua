local function in_salesforce_project(path)
  local dir = vim.fs.dirname(path)
  local root = vim.fs.find({ "sfdx-project.json", ".forceignore" }, {
    upward = true,
    path = dir,
  })[1]
  return root ~= nil
end

vim.filetype.add({
  extension = {
    soql = "soql",
    sosl = "sosl",
  },
  pattern = {
    [".*%.cls"] = function(path)
      if in_salesforce_project(path) then
        return "apex"
      end
    end,
    [".*%.trigger"] = function(path)
      if in_salesforce_project(path) then
        return "apex"
      end
    end,
    [".*%.page"] = function(path)
      if in_salesforce_project(path) then
        return "visualforce"
      end
    end,
    [".*%.component"] = function(path)
      if in_salesforce_project(path) then
        return "visualforce"
      end
    end,
    [".*%.cmp"] = function(path)
      if in_salesforce_project(path) then
        return "xml"
      end
    end,
    [".*%.app"] = function(path)
      if in_salesforce_project(path) then
        return "xml"
      end
    end,
    [".*%.evt"] = function(path)
      if in_salesforce_project(path) then
        return "xml"
      end
    end,
    [".*%.auradoc"] = function(path)
      if in_salesforce_project(path) then
        return "xml"
      end
    end,
    [".*%.design"] = function(path)
      if in_salesforce_project(path) then
        return "xml"
      end
    end,
    [".*%.tokens"] = function(path)
      if in_salesforce_project(path) then
        return "xml"
      end
    end,
  },
})

local M = {}

---@alias FMTElement
---| FMTTable
---| FMTArray
---| integer
---| number
---| boolean
---| nil

---@alias FMTArray FMTElement[]

---@class FMTTable
---@field obj FMTArray
---@field opts FMTOpts

---@class FMTOpts Formatting options for reducing an array of objects to a single string
---@field sep? string Separator between each element defaults to " "
---@field bool? FMTBooleanOpts
---
---@class FMTBooleanOpts Formatting a boolean
---@field true string
---@field false string

---@alias FMTString string The final string element from a reduced FMTTable or from a regular string
---@alias FMTStrings FMTString[] List of `FMTString`'s to be used in a

-- Formats a FMTElement with its FMTOpts
---@param obj FMTElement
---@param opts FMTOpts
---@return FMTString
function M.format(obj, opts)
  local transferable_types = {
    string = true, -- FMTString
    integer = true, -- TODO: Create custom FMTIntegerOpts
    number = true, -- TODO: Create custom FMTNumberOpts
    boolean = true, -- TODO: Create custom FMTBooleanOpts
    userdata = true,
    ["function"] = true,
  }

  local object_type = type(obj)

  if transferable_types[object_type] == true then
    return tostring(obj)
  end

  if object_type == "table" then
    ---@type FMTStrings
    local array = {}
    if obj["obj"] == nil and obj["opts"] == nil then -- FMTArray
      for _, new_obj in ipairs(obj) do
        table.insert(array, M.format(new_obj, opts)) -- Pass down opts to any obj in the array
      end
    elseif obj["opts"] ~= nil then -- FMTTable
      local new_opts = vim.tbl_extend("force", opts, obj["opts"])
      local new_obj = obj["obj"]
      table.insert(array, M.format(new_obj, new_opts))
    end
    local sep = opts["sep"]
    if sep == nil then
      sep = " "
    end
    return table.concat(array, sep)
  end

  return "ERROR"
end

-- Formats a FMTTable
---@param tbl FMTTable
function M.format_tbl(tbl)
  return M.format(tbl.obj, tbl.opts)
end

return M

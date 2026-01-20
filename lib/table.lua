local table = {}

---Merges table t2 into table t1, overwriting existing values.
---@param t1 table
---@param t2 table
---@return table
table.merge = function(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

return table

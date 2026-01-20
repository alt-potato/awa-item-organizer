local safe_set = {}

---@alias sort_attribute "subgroup"|"group"|"order"

---@alias category "item"|"item-with-entity-data"|"tool"|"ammo"|"recipe"|"technology"
---@alias name string
---@param attributes table<sort_attribute, any>
---@param objects table<name, "default"|category|category[]>[]
---@param default? category[]
safe_set.set = function(attributes, objects, default)
	for name, categories in pairs(objects) do
		if default and categories == "default" then
			categories = default
		end
		if type(categories) ~= "table" then
			assert(type(categories) == "string", "categories must be a string or a table")
			categories = { categories }
		end

		for _, category in pairs(categories) do
			local object = data.raw[category][name]
			if object then
				for attribute, value in pairs(attributes) do
					object[attribute] = value
				end
			else
				log("WARNING: Failed to set " .. category .. " `" .. name .. "`")
			end
		end
	end
end

safe_set.default_categories = {
	item = { "item", "recipe" },
	tool = { "tool", "recipe" },
	ammo = { "ammo", "recipe" },
	vehicle = { "item-with-entity-data", "recipe" }
}

return safe_set

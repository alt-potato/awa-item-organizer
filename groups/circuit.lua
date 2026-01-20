if not mods["SchallCircuitGroup"] then
	return
end

local set = require("lib.safe-set").set

if mods["cybersyn-combinator"] then
	set({ subgroup = "circuit-combinator" }, { ["cybersyn-combinator"] = { "item", "recipe" } })
end

if mods["UPSFriendlyNixieTubeDisplay"] then
	data:extend({
		{
			type = "item-subgroup",
			name = "nixie",
			group = "circuit",
			order = "b",
		},
	})

	set({ subgroup = "nixie" }, {
		["classic-nixie-tube"] = { "item", "recipe" },
		["reinforced-nixie-tube"] = { "item", "recipe" },
		["small-reinforced-nixie-tube"] = { "item", "recipe" },
	})
end

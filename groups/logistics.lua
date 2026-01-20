local set = require("lib.safe-set").set
local item_default = require("lib.safe-set").default_categories.item

if mods["FusionPoweredRobots"] then
	-- sir your drones are in the wrong order i think
	set({ order = "a[robot]-c[fusion-robot]-a[logistic]" }, { ["fusion-logistic-robot"] = "default" }, item_default)
	set(
		{ order = "a[robot]-c[fusion-robot]-b[construction]" },
		{ ["fusion-construction-robot"] = "default" },
		item_default
	)
end

data:extend({
	-- (b) energy
	{
		type = "item-subgroup",
		name = "energy-burner",
		group = "production",
		order = "b-a",
	},
	{
		type = "item-subgroup",
		name = "energy-solar",
		group = "production",
		order = "b-b",
	},
	{
		type = "item-subgroup",
		name = "energy-nuclear",
		group = "production",
		order = "b-c",
	},
	{
		type = "item-subgroup",
		name = "energy-fusion",
		group = "production",
		order = "b-d",
	}
})

local set = require("lib.safe-set").set
local merge = require("lib.table").merge
local item_default = require("lib.safe-set").default_categories.item

--#region (b-a) burner power
local burner_power_subgroup = {
	["boiler"] = "default",
	["steam-engine"] = "default",
}
if mods["corrundum"] then
	merge(burner_power_subgroup, {
		["red-boiler"] = "default",
		["red-steam-engine"] = "default",
	})
end
if mods["planet-muluna"] then
	merge(burner_power_subgroup, {
		["muluna-advanced-boiler"] = "default",
		["muluna-cycling-steam-turbine"] = "default",
	})
end
if mods["stirling-generator"] then
	merge(burner_power_subgroup, { ["stirling-generator"] = "default" })
end
set({ subgroup = "energy-burner" }, burner_power_subgroup, item_default)
--#endregion

--#region (b-b) solar power
local solar_power_subgroup = {
	["solar-panel"] = "default",
	["accumulator"] = "default",
}
if mods["planet-muluna"] then
	merge(solar_power_subgroup, { ["muluna-silicon-solar-panel"] = "recipe" })
end
if mods["SolarMatrix"] then
	merge(solar_power_subgroup, { ["solar-matrix"] = "default" })
end
if mods["Accumulator-V2"] then
	merge(solar_power_subgroup, { ["accumulator-v2"] = "default" })
end
if mods["snouz-big-solar-panel"] then
	merge(solar_power_subgroup, { ["big-solar-panel"] = "default" })
end
if mods["snouz-big-accumulator"] then
	merge(solar_power_subgroup, { ["big-accumulator"] = "default" })
end
if mods["ch-concentrated-solar"] then
	merge(solar_power_subgroup, {
		["chcs-heliostat-mirror"] = "default",
		["chcs-solar-power-tower"] = "default",
	})
end
set({ subgroup = "energy-solar" }, solar_power_subgroup, item_default)
--#endregion

--#region (b-c) nuclear power
local nuclear_power_subgroup = {
	["nuclear-reactor"] = "default",
	["heat-pipe"] = "default",
	["heat-exchanger"] = "default",
	["steam-turbine"] = "default",
}
if mods["Cerys-Moon-of-Fulgora"] then
	merge(nuclear_power_subgroup, { ["cerys-mixed-oxide-reactor"] = "default" })
end
if mods["maraxsis"] then
	merge(nuclear_power_subgroup, {
		["maraxsis-salt-reactor"] = "default",
		["maraxsis-oversized-steam-turbine"] = "default",
	})
end
if mods["secretas"] then
	merge(nuclear_power_subgroup, { ["gold-heat-pipe"] = "default" })
end
set({ subgroup = "energy-nuclear" }, nuclear_power_subgroup, item_default)

--#endregion

--#region (b-d) fusion power
local fusion_power_subgroup = {
	["fusion-reactor"] = "default",
	["fusion-generator"] = "default",
	["plasma-duct"] = "default",
}
set({ subgroup = "energy-fusion" }, fusion_power_subgroup, item_default)
--#endregion

--#region (idk) extraction-machine
if mods["VoidProcessing"] then
	-- sir i think your drill is in the wrong subgroup
	set({ subgroup = "extraction-machine" }, { ["deep_mining_drill"] = "default" }, item_default)
end
--#endregion

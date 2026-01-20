if not mods["SchallTransportGroup"] then
	log("SchallTransportGroup not found, skipping...")
	return
end

-- transport (the vanilla subgroup): Contains miscellanous items, e.g., spidertron-remote.
-- train-transport (another vanilla subgroup): Contains miscellanous items, e.g., rails, signals, stations.
-- vehicles-railway: All rail vehicles, e.g., train locomotives and wagons.
-- vehicles-railway-electric: All electric rail vehicles, e.g., electric locomotives.
-- vehicles-civilian: Non-combat vehicles, e.g., vanilla car.
-- vehicles-military: Combat vehicles, e.g., tanks, Spidertrons.
-- vehicle-equipment: Most vehicle-only equipment, e.g, vehicle battery from Schall Tank Platoon. But excluding military and defense equipment.
-- autodrive-equipment : Remote controls and sensors from Autodrive.
-- vehicle-equipment-military: Vehicle-only military equipment, e.g., vehicle energy shields from Schall Tank Platoon. But excluding defense equipment.
-- vehicle-equipment-defense: Vehicle-only defense equipment, e.g., gun pods from Schall Gun Pod.
data:extend({
	-- (a) transport (default)
	-- (a-a) train-transport (SchallTransportGroup)
	{
		type = "item-subgroup",
		name = "water-transport",
		group = "transport",
		order = "a-b",
	},
	-- (b) vehicles-railway
	-- (b-1/a) vehicles-railway-electric
	-- (c) vehicles-civilian
	{
		type = "item-subgroup",
		name = "vehicles-civilian-water",
		group = "transport",
		order = "c-a",
	},
	{
		type = "item-subgroup",
		name = "vehicles-civilian-air",
		group = "transport",
		order = "c-b",
	},
	-- (d) vehicles-military
	{
		type = "item-subgroup",
		name = "vehicles-military-water",
		group = "transport",
		order = "d-a",
	},
	{
		type = "item-subgroup",
		name = "vehicles-military-air",
		group = "transport",
		order = "d-b",
	},
	-- (j) vehicle-equipment
	-- (j-a) autodrive-equipment
	-- (m) vehicle-equipment-military
	-- (r) vehicle-equipment-defense
	-- (t) ai-vehicles
})

local set = require("lib.safe-set").set
local merge = require("lib.table").merge
local item_default = require("lib.safe-set").default_categories.item
local vehicle_default = require("lib.safe-set").default_categories.vehicle

--#region (a-a) train-transport
if data.raw["item-subgroup"]["train-transport"] then
	data.raw["item-subgroup"]["train-transport"].order = "a-a"
end
--#endregion

--#region (a-b) water-transport
local water_transport_subgroup = {}
if mods["cargo-ships"] then
	merge(water_transport_subgroup, {
		["port"] = "default",
		["buoy"] = "default",
		["chain_buoy"] = "default",
		["bridge_base"] = "default",
	})
end
if mods["maraxsis"] then
	merge(water_transport_subgroup, { ["sp-spidertron-dock"] = { "item", "recipe" } })
end
set({ item_group = "transport", subgroup = "water-transport" }, water_transport_subgroup, item_default)
--#endregion

--#region (b) vehicles-railway
local vehicles_railway_subgroup = {}
if mods["rubia"] then
	merge(vehicles_railway_subgroup, {
		["rubia-armored-locomotive"] = "default",
		["rubia-armored-cargo-wagon"] = "default",
		["rubia-armored-fluid-wagon"] = "default",
	})
end
if mods["plasma_handling"] then
	merge(vehicles_railway_subgroup, { ["plasma-mini-fluid-wagon"] = { "item", "recipe" } })
	set({ order = "c[rolling-stock]-c[fluid-wagon]-z" }, { ["plasma-mini-fluid-wagon"] = { "item", "recipe" } })
end
set({ item_group = "transport", subgroup = "vehicles-railway" }, vehicles_railway_subgroup, vehicle_default)
--#endregion

--#region (b-1) vehicles-railway-electric
if not data.raw["item-subgroup"]["vehicles-railway-electric"] then
	data:extend({
		{
			type = "item-subgroup",
			name = "vehicles-railway-electric",
			group = "transport",
			order = "b-a", -- why is it b-1 in SchallTransportGroup
		},
	})
end

local vehicles_railway_electric_subgroup = {}
if mods["se-space-trains"] then
	merge(vehicles_railway_electric_subgroup, {
		["space-locomotive"] = "default",
		["space-cargo-wagon"] = "default",
		["space-fluid-wagon"] = "default",
	})
end
if mods["electric-trains"] then
	merge(vehicles_railway_electric_subgroup, {
		["electric-locomotive"] = "default",
		["electric-locomotive-wagon"] = "default",
		["electric-cargo-wagon"] = "default",
		["electric-fluid-wagon"] = "default",
		["electric-artillery-wagon"] = "default",
	})
end
set(
	{ item_group = "transport", subgroup = "vehicles-railway-electric" },
	vehicles_railway_electric_subgroup,
	vehicle_default
)
--#endregion

--#region (c) vehicles-civilian
local vehicles_civilian_subgroup = {}
if mods["aai-vehicles-miner"] then
	merge(vehicles_civilian_subgroup, {
		["vehicle-miner"] = "default",
		["vehicle-miner-mk2"] = "default",
		["vehicle-miner-mk3"] = "default",
		["vehicle-miner-mk4"] = "default",
		["vehicle-miner-mk5"] = "default",
	})
end
if mods["aai-vehicles-hauler"] then
	merge(vehicles_civilian_subgroup, { ["vehicle-hauler"] = "default" })
end
set({ item_group = "transport", subgroup = "vehicles-civilian" }, vehicles_civilian_subgroup, vehicle_default)
--#endregion

--#region (c-a) vehicles-civilian-water
local vehicles_civilian_water_subgroup = {}
if mods["cargo-ships"] then
	merge(vehicles_civilian_water_subgroup, {
		["boat"] = "default",
		["cargo_ship"] = "default",
		["oil_tanker"] = "default",
	})
end
if mods["maraxsis"] then
	merge(vehicles_civilian_water_subgroup, {
		["maraxsis-diesel-submarine"] = "default",
		["maraxsis-nuclear-submarine"] = "default",
	})
end
set(
	{ item_group = "transport", subgroup = "vehicles-civilian-water" },
	vehicles_civilian_water_subgroup,
	vehicle_default
)
--#endregion

--#region (c-b) vehicles-civilian-air
local vehicles_civilian_air_subgroup = {}
if mods["lex-aircraft"] then
	merge(vehicles_civilian_air_subgroup, { ["lex-flying-cargo"] = "default" })
end
set({ item_group = "transport", subgroup = "vehicles-civilian-air" }, vehicles_civilian_air_subgroup, vehicle_default)
--#endregion

--#region (d) vehicles-military
local vehicles_military_subgroup = {}
if mods["aai-vehicles-warden"] then
	merge(vehicles_military_subgroup, { ["vehicle-warden"] = "default" })
end
if mods["aai-vehicles-chaingunner"] then
	merge(vehicles_military_subgroup, { ["vehicle-chaingunner"] = "default" })
end
if mods["aai-vehicles-flame-tumbler"] then
	merge(vehicles_military_subgroup, { ["vehicle-flame-tumbler"] = "default" })
end
if mods["aai-vehicles-flame-tank"] then
	merge(vehicles_military_subgroup, { ["vehicle-flame-tank"] = "default" })
end
if mods["aai-vehicles-laser-tank"] then
	merge(vehicles_military_subgroup, { ["vehicle-laser-tank"] = "default" })
end
set({ item_group = "transport", subgroup = "vehicles-military" }, vehicles_military_subgroup, vehicle_default)
--#endregion

--#region (d-a) vehicles-military-water
local vehicles_military_water_subgroup = {}
if mods["aai-vehicles-ironclad"] then
	merge(vehicles_military_water_subgroup, { ["ironclad"] = "default" })
end
if mods["ironclad-gunboat-and-mortar-turret-fork"] then
	merge(vehicles_military_water_subgroup, { ["ironclad-gunboat"] = "default" })
	set({ order = "b[personal-transport]-b[tank]-a[gunboat]" }, { ["ironclad-gunboat"] = vehicle_default })
end
set(
	{ item_group = "transport", subgroup = "vehicles-military-water" },
	vehicles_military_water_subgroup,
	vehicle_default
)
--#endregion

--#region (d-b) vehicles-military-air
local vehicles_military_air_subgroup = {}
if mods["FTL-Ships"] then
	merge(vehicles_military_air_subgroup, {
		["ftl_ships_Fed_Scout"] = "default",
		["ftl_ships_Bomber"] = "default",
		["ftl_ships_Kestrel"] = "default",
		["ftl_ships_Stealth"] = "default",
		["ftl_ships_Fed_Cruiser"] = "default",
	})
	set({ order = "c[fed]-a[fed-scout]" }, { ["ftl_ships_Fed_Scout"] = vehicle_default })
	set({ order = "c[fed]-b[bomber]" }, { ["ftl_ships_Bomber"] = vehicle_default })
	set({ order = "c[fed]-c[kestrel]" }, { ["ftl_ships_Kestrel"] = vehicle_default })
	set({ order = "c[fed]-d[stealth]" }, { ["ftl_ships_Stealth"] = vehicle_default })
	set({ order = "c[fed]-e[fed-cruiser]" }, { ["ftl_ships_Fed_Cruiser"] = vehicle_default })
end
if mods["lex-aircraft"] then
	merge(vehicles_military_air_subgroup, {
		["lex-flying-gunship"] = "default",
		["lex-flying-heavyship"] = "default",
	})
end
set({ item_group = "transport", subgroup = "vehicles-military-air" }, vehicles_military_air_subgroup, vehicle_default)
--#endregion

--#region (t) ai-vehicles
-- move aai subgroups from logistics to transport
if data.raw["item-subgroup"]["programmable-structures"] then
	data.raw["item-subgroup"]["programmable-structures"].group = "transport"
	data.raw["item-subgroup"]["programmable-structures"].order = "t"
end
if data.raw["item-subgroup"]["ai-vehicles"] then
	data.raw["item-subgroup"]["ai-vehicles"].group = "transport"
	data.raw["item-subgroup"]["ai-vehicles"].order = "t-a"
end
if data.raw["item-subgroup"]["ai-vehicles-reverse"] then
	data.raw["item-subgroup"]["ai-vehicles-reverse"].group = "transport"
	data.raw["item-subgroup"]["ai-vehicles-reverse"].order = "t-b"
end
--#endregion

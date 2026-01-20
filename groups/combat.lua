data:extend({
	-- (a) gun
	-- (b) ammo
	{
		type = "item-subgroup",
		name = "mixed",
		group = "combat",
		order = "b",
	},
	{
		type = "item-subgroup",
		name = "ammo-cannon",
		group = "combat",
		order = "b-a",
	},
	{
		type = "item-subgroup",
		name = "ammo-rocket",
		group = "combat",
		order = "b-b",
	},
	{
		type = "item-subgroup",
		name = "ammo-aai",
		group = "combat",
		order = "b-c",
	},
	{
		type = "item-subgroup",
		name = "ammo-mortar",
		group = "combat",
		order = "b-d",
	},
	{
		type = "item-subgroup",
		name = "ammo-artillery",
		group = "combat",
		order = "b-e",
	},
	-- (c) capsule
	-- (d) armor
	-- (e) equipment
	-- (f) utility-equipment
	-- (g) military-equipment
	-- (h) defensive-structure
	-- (i) turret
	{
		type = "item-subgroup",
		name = "turret-kinetic",
		group = "combat",
		order = "i-a",
	},
	{
		type = "item-subgroup",
		name = "turret-electric",
		group = "combat",
		order = "i-b",
	},
	--  (i-c) turret (fallback)
	{
		type = "item-subgroup",
		name = "turret-artillery",
		group = "combat",
		order = "i-d",
	},
	-- (j) ammo-category
})

local set = require("lib.safe-set").set
local merge = require("lib.table").merge
local ammo_default = require("lib.safe-set").default_categories.ammo
local item_default = require("lib.safe-set").default_categories.item

--#region (b-a) ammo-cannon
local ammo_cannon_subgroup = {
	["cannon-shell"] = "default",
	["explosive-cannon-shell"] = "default",
	["uranium-cannon-shell"] = "default",
	["explosive-uranium-cannon-shell"] = "default",
	["railgun-ammo"] = "default",
}
set({ subgroup = "ammo-cannon" }, ammo_cannon_subgroup, { "ammo", "recipe" })
--#endregion

--#region (b-a-a) ammo-cannon-magazine
if mods["vtk-cannon-turret"] then
	data:extend({
		{
			type = "item-subgroup",
			name = "ammo-cannon-magazine",
			group = "combat",
			order = "b-a-a",
		},
	})

	local ammo_cannon_magezine_subgroup = {
		["cannon-shell-magazine"] = "default",
		["cannon-shell-magazine-batch"] = "recipe",
		["explosive-cannon-shell-magazine"] = "default",
		["explosive-cannon-shell-magazine-batch"] = "recipe",
		["uranium-cannon-shell-magazine"] = "default",
		["uranium-cannon-shell-magazine-batch"] = "recipe",
		["explosive-uranium-cannon-shell-magazine"] = "default",
		["explosive-uranium-cannon-shell-magazine-batch"] = "recipe",
	}

	set({ subgroup = "ammo-cannon-magazine" }, ammo_cannon_magezine_subgroup, ammo_default)
end
--#endregion

--#region (b-b) ammo-rocket
local ammo_rocket_subgroup = {
	["rocket"] = "default",
	["explosive-rocket"] = "default",
	["atomic-bomb"] = "default",
}
if mods["chemical-rocket"] then
	merge(ammo_rocket_subgroup, {
		["chemical-rocket"] = "default",
		["incendiary-rocket"] = "default",
	})
end
if mods["Cerys-Moon-of-Fulgora"] then
	merge(ammo_rocket_subgroup, { ["cerys-hydrogen-bomb"] = "default" })
end
if mods["corrundum"] then
	merge(ammo_rocket_subgroup, { ["blue-rocket"] = "default" })
end
if mods["metal-and-stars"] then
	merge(ammo_rocket_subgroup, {
		["gauss-rocket"] = "default",
		["gauss-rocket-casting"] = "recipe",
	})
end
if mods["skewer_planet_vesta"] then
	merge(ammo_rocket_subgroup, { ["fusion-missile"] = "default" })
end
set({ subgroup = "ammo-rocket" }, ammo_rocket_subgroup, ammo_default)
--#endregion

--#region (b-c) ammo-aai
local ammo_aai_subgroup = {}
if mods["aai-programmable-vehicles"] then
	merge(ammo_aai_subgroup, {
		["cannon-shell-precision"] = "default",
		["explosive-cannon-shell-precision"] = "default",
	})
end
if mods["aai-vehicles-flame-tank"] or mods["aai-vehicles-flame-tumbler"] then
	merge(ammo_aai_subgroup, {
		["flamejet-ammo"] = "default",
		["flamethrower-ammo"] = "default",
	})
end
if mods["aai-vehicles-laser-tank"] then
	merge(ammo_aai_subgroup, {
		["laser-cannon-battery-focussed"] = "default",
		["laser-cannon-battery-piercing"] = "default",
	})
end
if mods["aai-vehicles-warden"] then
	merge(ammo_aai_subgroup, { ["electroshock-pulse-ammo"] = "default" })
end
if mods["aai-vehicles-ironclad"] then
	merge(ammo_aai_subgroup, {
		["mortar-bomb"] = "default",
		["mortar-cluster-bomb"] = "default",
	})
end
set({ subgroup = "ammo-aai" }, ammo_aai_subgroup, ammo_default)
--#endregion

--#region (b-d) ammo-mortar
local ammo_mortar_subgroup = {}
if mods["ironclad-gunboat-and-mortar-turret-fork"] and mods["aai-vehicles-ironclad"] then
	merge(ammo_mortar_subgroup, {
		["mortar-bomb"] = "default",
		["mortar-cluster-bomb"] = "default",
		["mortar-poison-bomb"] = "default",
		["mortar-fire-bomb"] = "default",
	})
end
if mods["strategy-mortar-turret"] then
	-- THERE ARE SO MANY OF THEM HELP
	merge(ammo_mortar_subgroup, {
		["mortar-poison-bomb"] = "default",
		["mortar-fire-bomb"] = "default",
	})

	local mortar_variants = {
		"shrapnel",
		"light-nuclear",
		"heavy",
		"energy",
		"slowdown",
		"illumination",
		"hypnosis",
		"defender-robot",
		"distractor-robot",
		"destroyer-robot",
		"lure-robot",
	}
	for _, variant in pairs(mortar_variants) do
		ammo_mortar_subgroup["mortar-" .. variant .. "-ammo"] = "default"
	end
end
set({ subgroup = "ammo-mortar" }, ammo_mortar_subgroup, ammo_default)
--#endregion

--#region (b-e) ammo-artillery
local ammo_artillery_subgroup = {
	["artillery-shell"] = "default",
}
if mods["atomic-artillery-reborn"] then
	merge(ammo_artillery_subgroup, { ["atomic-artillery-shell"] = "default" })
end
if mods["doeworks-deer"] then
	merge(ammo_artillery_subgroup, {
		["dw-deer-ammo-basic"] = "default",
		["dw-deer-crating-basic"] = "recipe",
		["dw-deer-uncrating-basic"] = "recipe",
	})
end
if mods["Age-of-Production"] then
	merge(ammo_artillery_subgroup, { ["aop-advanced-artillery-shell-manufacturing"] = "recipe" })
end
if mods["Cerys-Moon-of-Fulgora"] then
	merge(ammo_artillery_subgroup, { ["cerys-neutron-bomb"] = "default" })
end
if mods["lilys-radar-shell"] then
	merge(ammo_artillery_subgroup, { ["radar-artillery-shell"] = "default" })
end
if mods["maraxsis"] then
	merge(ammo_artillery_subgroup, { ["maraxsis-fat-man"] = "default" })
end
if mods["NapalmArtillery"] then
	merge(ammo_artillery_subgroup, { ["napalm-artillery-shell"] = "default" })
end
set({ subgroup = "ammo-artillery" }, ammo_artillery_subgroup, ammo_default)
--#endregion

--#region (i-a) turret-kinetic (direct fire)
local turret_kinetic_subgroup = {
	["gun-turret"] = "default",
	["rocket-turret"] = "default",
	["railgun-turret"] = "default",
}
if mods["snouz_long_electric_gun_turret"] then
	merge(turret_kinetic_subgroup, { ["snouz_long_electric_gun_turret"] = "default" })
end
if mods["cannon_turrets_touhma"] then
	merge(turret_kinetic_subgroup, { ["vtk-cannon-turret"] = "default" })
end
if mods["vtk-cannon-turret"] then
	merge(turret_kinetic_subgroup, {
		["vtk-cannon-turret"] = "default",
		["vtk-cannon-turret-heavy"] = "default",
	})
end
if mods["rubia"] then
	merge(turret_kinetic_subgroup, { ["rubia-sniper-turret"] = "default" })
end
if mods["secretas"] then
	merge(turret_kinetic_subgroup, { ["gold-railgun-turret"] = "default" })
end
set({ subgroup = "turret-kinetic" }, turret_kinetic_subgroup, item_default)
--#endregion

--#region (i-b) turret-electric
local turret_electric_subgroup = {
	["laser-turret"] = "default",
	["tesla-turret"] = "default",
}
if mods["ch-concentrated-solar"] then
	merge(turret_electric_subgroup, { ["chcs-solar-laser-tower"] = "default" })
end
if mods["Extended-Laser-Turrets"] then
	merge(turret_electric_subgroup, {
		["laser-turret-mk2-long"] = "default",
		["laser-turret-mk2-stro"] = "default",
		["laser-turret-mk3-long"] = "default",
		["laser-turret-mk3-stro"] = "default",
	})
end
set({ subgroup = "turret-electric" }, turret_electric_subgroup, item_default)
--#endregion

--#region (i-c) turret (fallback)
if data.raw["item-subgroup"]["turret"] then
	data.raw["item-subgroup"]["turret"].order = "i-c"
end
--#endregion

--#region (i-d) turret-artillery
local turret_artillery_subgroup = {
	["artillery-turret"] = "default",
}
if mods["strategy-mortar-turret"] then
	merge(turret_artillery_subgroup, {
		["mortar-turret"] = "default",
		["heavy-mortar-turret"] = "default",
	})
end
if mods["doeworks-deer"] then
	merge(turret_artillery_subgroup, { ["dw-deer-turret"] = "default" })
end
set({ subgroup = "turret-artillery" }, turret_artillery_subgroup, item_default)
--#endregion

--#region (z) go away castra
if data.raw["item-subgroup"]["castra-military"] then
	data.raw["item-subgroup"]["castra-military"].order = "z"
end
--#endregion

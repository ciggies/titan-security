Config = Config or {}   

Config.Store = {
        label = "Titan Armory",  slots = 5,     -- 5 Slots set feel free to change the number to as many as you need
        items = {
        [1] = { name = "ifak", price = 250, amount = 1, info = {}, type = "item", slot = 1, },    --Items just copy and paste this line and change the slot number
        [2] = { name = "weapon_minigun", price = 1, amount = 1, info = {}, type = "weapon", slot = 2, },
        [3] = { name = "ifak", price = 1, amount = 1, info = {}, type = "item", slot = 3, },
        [4] = { name = "ifak", price = 1, amount = 1, info = {}, type = "item", slot = 4, },
        [5] = { name = "ifak", price = 1, amount = 1, info = {}, type = "item", slot = 5, }     -- if adding more keep this at the end or add a comma to the end of the line
    },
}

Config.Zones = vector4(-395.41, 1225.08, 325.64, 68.79)     -- Helicopter Spawn Point

Config.Zone = vector4(-422.48, 1192.73, 325.64, 185.4)      -- Vehicle Spawn Point


Config.Locations = {
    -- Heli Location
    ["titanheli"] = {
        [1] = vector4(-412.82, 1208.95, 325.64, 345.36),
    },
    -- Vehicle Garage
    ["titangarage"] = {
        [1] = vector4(-426.4, 1195.4, 325.64, 160.2),
    },
    ["VehicleSpawn"] = {
        [1] = vector4(-423.13, 1195.24, 325.67, 196.95),
    },
}

Config.Car1 = {
    ["zentorno"] = "Zentorno",
}

Config.titanVehicles = {
    -- These lads suck
    [0] = {
        ["adder"] = "adder",
    },
    -- Kinda getting better
    [1] = {
        ["zentorno"] = "zentorno",
    },
    -- Yeah its alright i guess
    [2] = {
        ["zentorno"] = "zentorno",
    },
    -- wow acutally going places
    [3] = {
        ["adder"] = "adder",
    },
    -- you've really gone places now
    [4] = {
        ["adder"] = "adder",
    },
    -- owns a business wow must be rich
    [5] = {
        ["adder"] = "adder",
    }
}

Config.TitanHelicopter = "POLMAV" -- Forgot the spawn code
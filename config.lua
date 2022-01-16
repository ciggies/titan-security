Config = Config or {}   

Config.Store = {
        label = "Titan Armory",  slots = 5,     -- 5 Slots set feel free to change the number to as many as you need
        items = {
        [1] = { name = "ifak", price = 250, amount = 1, info = {}, type = "item", slot = 1, },    --Items just copy and paste this line and change the slot number
        [2] = { name = "ifak", price = 1, amount = 1, info = {}, type = "item", slot = 2, },
        [3] = { name = "ifak", price = 1, amount = 1, info = {}, type = "item", slot = 3, },
        [4] = { name = "ifak", price = 1, amount = 1, info = {}, type = "item", slot = 4, },
        [5] = { name = "ifak", price = 1, amount = 1, info = {}, type = "item", slot = 5, }     -- if adding more keep this at the end or add a comma to the end of the line
    },
}

Config.Locations = {
    -- Heli Location
    ["titanheli"] = {
        [1] = vector3(63.06, 95.29, 78.83),
    },
    -- Vehicle Garage
    ["titangarage"] = {
        [1] = vector3(73.01, 90.97, 78.8),
    },
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
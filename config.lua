Config = Config or {}   

Config.Store = {
        label = "Titan Armory",  slots = 5,     -- 5 Slots set feel free to change the number to as many as you need
        items = {
        [1] = { name = "ifak", price = 250, amount = 1, info = {}, type = "item", slot = 1, },    --Items just copy and paste this line and change the slot number
        [2] = { name = "", price = 1, amount = 1, info = {}, type = "item", slot = 2, },
        [3] = { name = "", price = 1, amount = 1, info = {}, type = "item", slot = 3, },
        [4] = { name = "", price = 1, amount = 1, info = {}, type = "item", slot = 4, },
        [5] = { name = "", price = 1, amount = 1, info = {}, type = "item", slot = 5, }     -- if adding more keep this at the end or add a comma to the end of the line
    }
}

Config.Locations - {
    -- Heli Location
    ["titanheli"] = {
        [1] = vector3(),
    },
    -- Vehicle Garage
    ["titangarage"] = {
        [1] = vector3(),
    },
}

Config.titanVehicles = {
    -- These lads suck
    [0] = {
        ["vehicle"] = "vehicle",
    },
    -- Kinda getting better
    [1] = {
        ["vehicle"] = "vehicle",
    },
    -- Yeah its alright i guess
    [2] = {
        ["vehicle"] = "vehicle",
    },
    -- wow acutally going places
    [3] = {
        ["vehicle"] = "vehicle",
    },
    -- you've really gone places now
    [4] = {
        ["vehicle"] = "vehicle",
    },
    -- owns a business wow must be rich
    [5] = {
        ["vehicle"] = "vehicle",
    }
}
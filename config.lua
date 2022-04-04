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

-- Helicopter Spawn Point
Config.Zones = vector4(-395.41, 1225.08, 325.64, 68.79)     -- Helicopter Spawn Point

-- Vehicle Spawn Point
Config.Zone = vector4(-422.48, 1192.73, 325.64, 185.4)      -- Vehicle Spawn Point


Config.Locations = {
    ["titanheli"] = {           -- This is the location for the cd_drawtextui and the DrawText3D depending on which one you use
        [1] = vector4(-412.82, 1208.95, 325.64, 345.36),
    },
}

Config.JobName = {"titan"} 

Config.PlateText = {"TITAN"}

Config.HeliCopterHash = {"frogger"}
**qb-smallreasources/server/consumables.lua**
```lua
QBCore.Functions.CreateUsableItems("ifak", function(source, items)
    local src = source
    TriggerClientEvent('consumables:client:AddHealthIfak', src)
end)
```

**qb-smallreasources/client/consumables.lua**
```lua
    RegisterNetEvent('consumables:client:AddHealthIfak', function()
        if GetEntityHealth(PlayerPedId()) == 100 then QBCore.Functions.Notify('You have full health', 'error') return end
        local ped = PlayerPedId()
        local PlayerData = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Progressbar("use_ifak", "Using IFAK..", 5000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            if PlayerData.charinfo.gender == 0 then
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["ifak"], "remove")
            TriggerServerEvent("QBCore:Server:RemoveItem", "ifak", 1)
            SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 20) -- the +20 is adding 20 health per use you can change to any number
        end)
    end)
```





**qb-core/shared.lua**
```lua
    ['ifak'] 			 	 	 = {['name'] = 'ifak', 			  			['label'] = 'IFAK', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'ifak.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Sometimes you just need a boost'},
```

**qb-ambulancejob/client/wounding.lua under line __63__***
```lua 
RegisterNetEvent('hospital:client:UseIfak', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("use_bandage", "Using IFAK..", 6000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "anim@amb@business@weed@weed_inspecting_high_dry@",
		anim = "weed_inspecting_high_base_inspector",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "ifak", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["ifak"], "remove")
        SetEntityHealth(ped, GetEntityHealth(ped) + 25)
        if math.random(1, 100) < 50 then
            RemoveBleed(1)
        end
        if math.random(1, 100) < 7 then
            ResetPartial()
        end
    end, function() -- Cancel
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)
```

**qb-ambulancejob/server/main.lua under line __360__**
```lua 
QBCore.Functions.CreateUseableItem("ifak", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("hospital:client:UseIfak", src)
	end
end)
```

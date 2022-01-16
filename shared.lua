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
local exports['qb-core']:GetCoreObject()

RegisterNetEvent('titan:security')
AddEventHandler('titan:security', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
        if Player.PlayerData.job.name == "police" then
            TriggerServerEvent("inventory:server:OpenInventory", "shop", "TitanStore", Config.Store)    -- just opens the store
        end
end)


    exports['qb-target']:AddBoxZone("name", vector3(x, y, z), 1.5, 1.6, {
      name = "name",
      heading = 12.0, 
      debugPoly = false,
      minZ = 36.7, 
      maxZ = 38.9,
    }, {
      options = {
        {
          type = "client", -- This specifies the type of event the target has to trigger on click, this can be "client", "server", "command" or "qbcommand", this is OPTIONAL and will only work if the event is also specified
          event = "titan:security",
          icon = 'fas fa-example',
          label = 'Test',
          targeticon = 'fas fa-example',
      },
      distance = 2.5, -- This is the distance for you to be at for the target to turn blue
    })
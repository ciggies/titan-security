local exports['qb-core']:GetCoreObject()

currentGarage = 0

RegisterNetEvent('titan:security')
AddEventHandler('titan:security', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
        if Player.PlayerData.job.name == "police" then
            TriggerServerEvent("inventory:server:OpenInventory", "shop", "TitanStore", Config.Store)    -- just opens the store
        end
end)

RegisterNetEvent('titan:personalstash')
AddEventHandler('titan:personalstash', function()
    if LocalPlayer.state.isLoggedIn and PlayerJob.name == "titan" then
        TriggerServerEvent('inventory:server:OpenInventory', 'stash' 'titanstash'..QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent('inventory:client:SetCurrentStash', 'titanstash'..QBCore.Functions.GetPlayerData().citizenid)
    end
end)

--==================================================
--                      Garage
--==================================================

function MenuGarge(currentSelection)
  local vehicleMenu = {
    {
    header = "Titan Vehicles",
    isMenuHeader - true
    }
  }

  local titanVehicles = Config.titanVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
  for veh, label in pairs(authorizedVehicles) do
    vehicleMenu[#vehicleMenu+1] = {
      header = label,
      txt = "",
      params = {
          event = "titan:TakeOutVehicle"
          args = {
            vehicle = veh,
            currentSelection = currentSelection
          }
        }
      }
    end
  end

    vehicleMenu[#vehicleMenu+1] = {
    header = "⬅ Close Menu",
    txt = "",
    params = {
      event = "qb-menu:client:closeMenu"
    }
  }
  exports['qb-menu']:openMenu(vehicleMenu)
end

    RegisterNetEvent('titan:TakeOutVehicle')
    AddEventHandler('titan:TakeOutVehicle', function(data)
      local pos = GetEntityCoords(PlayerPedId())
      local takeDist = Config.Locations['titangarage'][data.currentSelection]
      takeDist = vector3(takeDist.x, takeDist.y,  takeDist.z)
      if #(pos - takeDist) <= 1.5 then
          local vehicle = data.vehicle
          TakeOutVehicle(vehicle)
      end
  end)

RegisterNetEvent('titan:garageHeader')
AddEventHandler('titan:garageHeader', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords()
    local takeDist = Config.Locations['titangarage'][data.currentSelection]
    takeDist = vector3(takeDist.x, takeDist.y, takeDist.z)
    if #(pos - takeDist) <= 1.5 then
      MenuGarage(data.currentSelection)
      currentGarage = data.currentSelection
    end
end)

RegisterNetEvent('titan:garage')
AddEventHandler('titan:garage', function()
  if LocalPlayer.state.isLoggedIn and PlayerJob.name == "titan" then
      if not headerDrawn then
        headerDrawn = true
          exports['qb-menu']:showHeader({
            {
              header = 'Titan Garage',
              params = {
                event = ''
                args = {
                  currentSelection = k,
                }
              }
            }
          })
    
end)


--==================================================
--                    END GARAGE
--==================================================

--==================================================
--                 START Helicopter
--==================================================

RegisterNetEvent('titan:helicopter')
AddEventHandler('titan:helicopter', function(data)
  if LocalPlayer.state.isLoggedIn and PlayerJob.name == "titan" then
    for k, v in pairs(Config.Locations["titanheli"]) do
      if #(pos - vector3(v.x, v.y, v.z)) < 7.5 then
        if onDuty then
          sleep = 5
          if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
              DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Store Helicopter")
            else
              DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Take A Helicopter")
            end
              QBCore.Functions.DeleteVehicle(GetVehicelPedIsIn(PlayerPedId()))
            else
              local coords = Config.Locations["titanheli"]
              QBCore.Functions.SpawnVehicle(Config.TitanHelicopter, function(veh)
                SetVehicleLivery(veh, 0)
                SetVehicleMod(veh, 0, 48)
                SetVehicleNumberPlateText(veh, "TITAN"..tostring(math.random(1000, 9999)))
                SetEntityHeading(veh, coords.w)
                exports['lj-fuel']:SetFuel(veh, 100.0)
                closeMenuFull()
                TaskWarpPedIntoVehicle(PlayedPedId(), veh, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GrtPlate(veh))
                SetVehicleEngineOn(veh, true, true)
              end, coords, true)
            end
          end
        end
      end
    end
  end)
--==================================================
--                END Helicopter
--==================================================

--==================================================
--                      ARMORY
--==================================================
    exports['qb-target']:AddBoxZone("tarmory", vector3(x, y, z), 1.5, 1.6, {
      name = "tarmory",
      heading = 12.0, 
      debugPoly = false,
      minZ = 36.7, 
      maxZ = 38.9,
    }, {
      options = {
        {
          type = "client", -- This specifies the type of event the target has to trigger on click, this can be "client", "server", "command" or "qbcommand", this is OPTIONAL and will only work if the event is also specified
          event = "titan:security",
          icon = 'fas fa-shopping-basket',
          label = 'Armory',
      },
      distance = 2.5, -- This is the distance for you to be at for the target to turn blue
    })

--==================================================
--                  Personal Stash
--==================================================

    exports['qb-target']:AddBoxZone("personalstash", vector3(x, y, z), 1.5, 1.6, {
        name = "personalstash",
        heading = 12.0, 
        debugPoly = false,
        minZ = 36.7, 
        maxZ = 38.9,
      }, {
        options = {
          {
            type = "client", -- This specifies the type of event the target has to trigger on click, this can be "client", "server", "command" or "qbcommand", this is OPTIONAL and will only work if the event is also specified
            event = "titan:personalstash",
            icon = 'fas fa-lock',
            label = 'Personal Locker',
        },
        distance = 2.5, -- This is the distance for you to be at for the target to turn blue
      })
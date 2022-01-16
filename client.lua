local QBCore = exports['qb-core']:GetCoreObject()

local heli = vector3(-411.6, 1207.5, 325.64)
currentGarage = 0

local function DrawText3D(x, y, z, text)
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(true)
  AddTextComponentString(text)
  SetDrawOrigin(x,y,z, 0)
  DrawText(0.0, 0.0)
  local factor = (string.len(text)) / 370
  DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
  ClearDrawOrigin()
end

RegisterNetEvent('titan:security')
AddEventHandler('titan:security', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
        if Player.PlayerData.job.name == "titan" then
            TriggerServerEvent("inventory:server:OpenInventory", "shop", "TitanStore", Config.Store)    -- just opens the store
        end
end)

RegisterNetEvent('titan:personal:stash')
AddEventHandler('titan:personal:stash', function()
    if LocalPlayer.state.isLoggedIn and QBCore.Functions.GetPlayerData().job.name == "titan" then
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'titanstash'..QBCore.Functions.GetPlayerData().citizenid)
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
          event = "titan:TakeOutVehicle",
          args = {
            vehicle = veh,
            currentSelection = currentSelection
          }
        }
      }
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
  if LocalPlayer.state.isLoggedIn and QBCore.Functions.GetPlayerData().job.name == "titan" then
      if not headerDrawn then
        headerDrawn = true
          exports['qb-menu']:showHeader({
            {
              header = 'Titan Garage',
              params = {
                event = 'titan:garageHeader',
                args = {
                  currentSelection = k,
                }
              }
            }
          })
        end
      end
    end)



--==================================================
--                    END GARAGE
--==================================================

--==================================================
--                 START Helicopter
--==================================================

RegisterNetEvent('fuckwit:helicopter')
AddEventHandler('fuckwit:helicopter', function(data)
    if QBCore.Functions.GetPlayerData().job.name == "titan" then
      DrawText3D(heli.x, heli.y, heli.z, "PLEASE WORK")
      SetVehicleNumberPlateText(veh, "TITAN"..tostring(math.random(1000, 9999)))
        QBCore.Functions.SpawnVehicle('POLMAV', function(veh)
          TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        end)
      end
    end)

      Citizen.CreateThread(
        function()
          while true do
            Citizen.Wait(0)
            local pos = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Config.Locations["titanheli"]) do
              if #(pos - vector3(v.x, v.y, v.z)) < 7.5 then
                DrawText3D(v.x, v.y, v.z, "~g~E~w~ Fucking work cuz")
                if IsControlJustReleased(0, 38) then
                SetVehicleNumberPlateText(veh, "TITAN"..tostring(math.random(1000, 9999)))
                 QBCore.Functions.SpawnVehicle('POLMAV', function(veh)
                   TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                   TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            end)
          end
        end
      end

--==================================================
--                END Helicopter
--==================================================

--==================================================
--                      ARMORY
--==================================================

exports["qb-target"]:AddCircleZone("tarmory", vector3(441.21, -981.89, 30.69), 1.0, {
  name ="tarmory",
  useZ = true,
  debugPoly=false
  }, {
      options = {
          {
              event = "titan:security",
              icon = "fas fa-shopping-basket",
              label = "Armory",
          },
       },
       job = {"all"},
      distance = 2.1
  })

--==================================================
--                  Personal Stash
--==================================================


exports["qb-target"]:AddCircleZone("personalstash", vector3(441.21, -981.89, 30.69), 1.0, {
  name ="personalstash",
  useZ = true,
  debugPoly=false
  }, {
      options = {
          {
              event = "titan:personalstash",
              icon = "as fa-lock",
              label = "Personal Locker",
          },
       },
       job = {"all"},
      distance = 2.1
  })
end
end)
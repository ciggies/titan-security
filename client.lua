local QBCore = exports['qb-core']:GetCoreObject()
local SpawnVehicle = false
local ClosestShop = nil
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
--    local Player = QBCore.Functions.GetPlayer(src)
        if QBCore.Functions.GetPlayerData().job.name == "titan" then
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

RegisterNetEvent('titan:menu', function(data)
  local id = data.id
  local number = data.number
  TriggerEvent('nh-context:sendMenu', {
      {
          id = 1,
          header = "< Go Back",
          txt = "",
          params = {
              event = "titan:menu"
          }
      },
      {
          id = 2,     -- If your copy and pasteing this code below make sure to cahnge the ID
          header = "APC", --- This is the first vehicle can this to what ever
          txt = "This APC is armored",  -- Basically a description of the vehicle
          params = {
            event = "titan:cars"
          }
      },
      {
        id = 3,     -- If your copy and pasteing this code below make sure to cahnge the ID
        header = "Return Vehicle", --- This is the first vehicle can this to what ever
        txt = "",  -- Basically a description of the vehicle
        params = {
          event = "titan:return"
        }
    },
  })
end)

RegisterNetEvent('titan:return')  -- Not 100% sure if that is doing anything but it doesn't seem to affect performance so i've left it in here
AddEventHandler('titan:return', function(data)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
    else
      QBCore.Functions.DeleteVehicle(GetClosestVehicle(PlayerPedId()))
    end
  end)

--==================================================
--           Duplicate Code to add more cars
--==================================================

    RegisterNetEvent('titan:cars')    -- Change titan:cars to somthing else
    AddEventHandler('titan:cars', function(data)  -- Changed titan:cars to same as above
      if LocalPlayer.state.isLoggedIn and QBCore.Functions.GetPlayerData().job.name == "titan" then -- Change "titan" to name of job
        QBCore.Functions.SpawnVehicle('apc', function(veh)    -- change 'apc' to spawn name of the vehicle wanted
          SetEntityCoords(veh, Config.Zone.x, Config.Zone.y, Config.Zone.z)
          SetEntityHeading(veh, Config.Zone.w)  -- This is just the heading of the vehicle when it spawns
          SetVehicleLivery(veh, 0)
          SetVehicleMod(veh, 0, 48)
          SetVehicleNumberPlateText(veh, "TITAN"..tostring(math.random(1000, 9999)))    -- "TITAN" puts TITAN in at start of Number Plate
          exports['lj-fuel']:SetFuel(veh, 100.0)    -- Can Changed ['lj-fuel'] to ['LegacyFuel'] depending on script used
          TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
          TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))   -- Set's ownership of vehicle to person who spawned it
          SetVehicleEngineOn(veh, true, true)  
          SpawnVehicle = true   -- Alows the return vehicle script to work properly
        end)
      end
    end)

--==================================================
--                  END Duplicate
--==================================================

RegisterNetEvent('titan:return')
AddEventHandler('titan:return', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Notify('Returned vehicle!', 'success')
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        NetworkFadeOutEntity(car, true,false)
        Citizen.Wait(2000)
        QBCore.Functions.DeleteVehicle(car)
    else 
        QBCore.Functions.Notify("No vehicle to return", "error")
    end
    SpawnVehicle = false
end)
--==================================================
--                    END GARAGE
--==================================================

--==================================================
--       START Helicopter OLD  - Uses DrawText3D
--==================================================

--       Citizen.CreateThread(function()
--         Wait(1000)  
--         while true do
--             local sleep = 2000
--             if LocalPlayer.state.isLoggedIn and QBCore.Functions.GetPlayerData().job.name == "titan" then
--             local pos = GetEntityCoords(PlayerPedId())
--             for k, v in pairs(Config.Locations["titanheli"]) do
--               if #(pos - vector3(v.x, v.y, v.z)) < 7.5 then
--                 sleep = 5
--                 if IsPedInAnyVehicle(PlayerPedId(), false) then
--                 DrawText3D(v.x, v.y, v.z, "~r~E~w~ Store Helicopter")
--               else
--                 DrawText3D(v.x, v.y, v.z, "~g~E~w~ Fucking shitty cunt")
--               end
--                 if IsControlJustReleased(0, 38) then
--                   if IsPedInAnyVehicle(PlayerPedId(), false) then
--                     QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
--                   else
--                 SetVehicleNumberPlateText(veh, "TITAN"..tostring(math.random(1000, 9999)))
--                  QBCore.Functions.SpawnVehicle('frogger', function(veh)
--                   TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
--                   exports['lj-fuel']:SetFuel(veh, 100.0)
--                    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
--                    SetVehicleEngineOn(veh, true, true)
--                  end)
--             end
--           end
--         end
--       end
--     end
--     Wait(sleep)
--   end
-- end)

--==================================================
--       END Helicopter OLD  - Uses DrawText3D
--==================================================

--==================================================
--       START Helicopter - Uses cd_drawtextui
--==================================================

RegisterNetEvent('titan:heli')
AddEventHandler('titan:heli', function(data)
  if LocalPlayer.state.isLoggedIn and QBCore.Functions.GetPlayerData().job.name == "titan" then   -- Replace "titan" with the job name
    local pos = GetEntityCoords(PlayerPedId())
      if IsPedInAnyVehicle(PlayerPedId(), false) then
        QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
      else
        SetVehicleNumberPlateText(veh, "TITAN"..tostring(math.random(1000, 9999)))
          QBCore.Functions.SpawnVehicle('frogger', function(veh)    -- Replace frogger with spawn code of helicopter wished to use
            SetEntityCoords(veh, Config.Zones.x, Config.Zones.y, Config.Zones.z)
            SetEntityHeading(veh, Config.Zones.w)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            exports['lj-fuel']:SetFuel(veh, 100.0)    -- Can change the export to LegacyFuel if that is what you wish to use
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))   -- Give the person who spawned it keys to the vehicle
            SetVehicleEngineOn(veh, true, true)
          end)
        end
      end
    end)

--==================================================
--      END Helicopter  - Uses cd_drawtextui
--==================================================

--==================================================
--                  START THREADS
--==================================================

Citizen.CreateThread(function(data)
  local alreadyEnteredZone = false
  local text = nil
  while true do
      wait = 5
      local ped = PlayerPedId()
      local inZone = false
      for k, v in pairs(Config.Locations["titanheli"]) do
          local dist = #(GetEntityCoords(ped)-vector3(Config.Zones.x, Config.Zones.y, Config.Zones.z))
          if dist <= 7.5 then
              wait = 5
              inZone  = true
              text = '<b>[E] Helicopter</b>'

              if IsControlJustReleased(0, 38) then
                  TriggerEvent('titan:heli')
              end
              break
          else
              wait = 2000
          end
      end
      
      if inZone and not alreadyEnteredZone then
          alreadyEnteredZone = true
          TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
      end

      if not inZone and alreadyEnteredZone then
          alreadyEnteredZone = false
          TriggerEvent('cd_drawtextui:HideUI')
      end
      Citizen.Wait(wait)
  end
end)
--==================================================
--                  END THREADS
--==================================================

--==================================================
--                      ARMORY
--==================================================

exports["qb-target"]:AddCircleZone("tarmory", vector3(-424.41, 1213.82, 325.76), 1.0, { -- Change AddCircleZone to AddBoxZone to create a box around the armory
  name ="tarmory",
  useZ = true,
  debugPoly=true    -- Shows the giant green box / cirlce
  }, {
      options = {
          {
              event = "titan:security",
              icon = "fas fa-shopping-basket",
              label = "Armory",
          },
       },
       job = {"titan"},   -- Change "titan" to the name of the job
      distance = 2.1
  })

--==================================================
--                  Personal Stash
--==================================================


exports["qb-target"]:AddCircleZone("personalstash", vector3(-426.27, 1215.98, 325.76), 1.0, { -- Change AddCircleZone to AddBoxZone to create a box around the armory
  name ="personalstash",
  useZ = true,
  debugPoly=false  -- Shows the giant green box / cirlce
  }, {
      options = {
          {
              event = "titan:personal:stash",
              icon = "as fa-lock",
              label = "Personal Locker",
          },
       },
       job = {"titan"},  -- Change "titan" to the name of the job
      distance = 2.1
  })
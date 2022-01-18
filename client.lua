local QBCore = exports['qb-core']:GetCoreObject()

local heli = vector3(-411.6, 1207.5, 325.64)
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

--[[function TakeOutVehicle(vehicleInfo)
--  local coords = Config.Locations["titangarage"][currentGarage]
--  if coords then
      QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
          SetCarItemsInfo()
          SetVehicleNumberPlateText(veh, "TITAN"..tostring(math.random(1000, 9999)))
          SetEntityHeading(veh)
          exports['lj-fuel']:SetFuel(veh, 100.0)
          closeMenuFull()
          TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
          TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
--          TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.CarItems)
          SetVehicleEngineOn(veh, true, true)
      end)
    end

function MenuGarage(currentSelection)
  local vehicleMenu = {
    {
    header = "Titan Vehicles",
    isMenuHeader = true
    }
  }

  local titanVehicles = Config.titanVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
  for veh, label in pairs(titanVehicles) do
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
--      local pos = GetEntityCoords(PlayerPedId())
--      local takeDist = Config.Locations['titangarage'][data.currentSelection]
--      takeDist = vector3(takeDist.x, takeDist.y,  takeDist.z)
--      if #(pos - takeDist) <= 1.5 then
          local vehicle = data.vehicle
          TakeOutVehicle(vehicle)
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

    CreateThread(function()
      Wait(1000)
      while true do
      local headerDrawn = false
        local sleep = 2000 
        if LocalPlayer.state.isLoggedIn and QBCore.Functions.GetPlayerData().job.name == "titan" then
          local pos = GetEntityCoords(PlayerPedId())
          for k, v in pairs(Config.Locations['titangarage']) do
            if #(pos - vector3(v.x, v.y, v.z)) < 7.5 then
              sleep = 5
              if IsPedInAnyVehicle(PlayerPedId(), false) then
                DrawText3D(v.x, v.y, v.z, "~r~E~w~ Store Shitter")
              else
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
              if IsControlJustReleased(0, 38) then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                  QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                end
              end
            else
              if headerDrawn then
                headerDrawn = false
                exports['qb-menu']:closeMenu()
              end
            end
          end
        end
      end
      Wait(sleep)
    end)]]


--[[Citizen.CreateThread(function(data)
  Wait(1000)
  while true do
    local sleep = 2000
    if LocalPlayer.state.isLoggedIn and QBCore.Functions.GetPlayerData().job.name == "titan" then
      local pos = GetEntityCoords(PlayerPedId())
      for k, v in pairs(Config.Locations["titangarage"]) do
        if #(pos - vector3(v.x, v.y, v.z)) < 7.5 then
          sleep = 5
          if IsPedInAnyVehicle(PlayerPedId(), false) then
            DrawText3D(v.x, v.y, v.z, "~r~E~w~ Store Vehicle")
          else
            DrawText3D(v.x, v.y, v.z, "~g~E~w~ Vehicle")
          end
          if IsControlJustReleased(0, 38) then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
              QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
            else
              SetVehicleNumberPlateText(veh, "TITAN"..tostring(math.random(1000, 9999)))
              -- TriggerEvent('titan:garageHeader')
              TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
              exports['lj-fuel']:SetFuel(veh, 100.0)
              TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
              SetVehicleEngineOn(veh, true, true)
            end
          end
        end
      end
    end
  end
end)]]

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
  })
end)

    RegisterNetEvent('titan:cars')      -- Duplate this script if you want to add more vehicles
    AddEventHandler('titan:cars', function(data)
      if LocalPlayer.state.isLoggedIn and QBCore.Functions.GetPlayerData().job.name == "titan" then
        QBCore.Functions.SpawnVehicle('apc', function(veh)
          SetEntityCoords(veh, Config.Zone.x, Config.Zone.y, Config.Zone.z)
          SetEntityHeading(veh, Config.Zone.w)
          SetVehicleLivery(veh, 0)
          SetVehicleMod(veh, 0, 48)
          SetVehicleNumberPlateText(veh, "TITAN"..tostring(math.random(1000, 9999)))
          exports['lj-fuel']:SetFuel(veh, 100.0)
          TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
          TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
          SetVehicleEngineOn(veh, true, true)  
        end)
      end
    end)

--[[Citizen.CreateThread(function(data)
  local alreadyEnteredZone = false
  local text = nil
  while true do
      wait = 5
      local ped = PlayerPedId()
      local inZone = false
      for cd = 1, #Config.Zones do
          local dist = #(GetEntityCoords(ped)-vector3(Config.Zones.x, Config.Zones.y, Config.Zones.z))
          if dist <= 7.5 then
              wait = 5
              inZone  = true
              text = '<b>Title</b></p>[E] Press E to be bald'

              if IsControlJustReleased(0, 38) then
                  TriggerEvent('titan:menu')
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
end)]]
--==================================================
--                    END GARAGE
--==================================================

--==================================================
--                 START Helicopter
--==================================================

--[[RegisterNetEvent('fuckwit:helicopter')
AddEventHandler('fuckwit:helicopter', function(data)
    if QBCore.Functions.GetPlayerData().job.name == "titan" then
      SetVehicleNumberPlateText(veh, "TITAN"..tostring(math.random(1000, 9999)))
        QBCore.Functions.SpawnVehicle('POLMAV', function(veh)
          TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        end)
      end
    end)]]

      Citizen.CreateThread(function()
        Wait(1000)  
        while true do
            local sleep = 2000
            if LocalPlayer.state.isLoggedIn and QBCore.Functions.GetPlayerData().job.name == "titan" then
            local pos = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Config.Locations["titanheli"]) do
              if #(pos - vector3(v.x, v.y, v.z)) < 7.5 then
                sleep = 5
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                DrawText3D(v.x, v.y, v.z, "~r~E~w~ Store Helicopter")
              else
                DrawText3D(v.x, v.y, v.z, "~g~E~w~ Fucking work cuz")
              end
                if IsControlJustReleased(0, 38) then
                  if IsPedInAnyVehicle(PlayerPedId(), false) then
                    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                  else
                SetVehicleNumberPlateText(veh, "TITAN"..tostring(math.random(1000, 9999)))
                 QBCore.Functions.SpawnVehicle('POLMAV', function(veh)
                  TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                  exports['lj-fuel']:SetFuel(veh, 100.0)
                   TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                   SetVehicleEngineOn(veh, true, true)
                 end)
            end
          end
        end
      end
    end
    Wait(sleep)
  end
end)

RegisterNetEvent('titan:heli')
AddEventHandler('titan:heli', function(data)
  if LocalPlayer.state.isLoggedIn and QBCore.Functions.GetPlayerData().job.name == "titan" then
    local pos = GetEntityCoords(PlayerPedId())
      if IsPedInAnyVehicle(PlayerPedId(), false) then
        QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
      else
        SetVehicleNumberPlateText(veh, "TITAN"..tostring(math.random(1000, 9999)))
          QBCore.Functions.SpawnVehicle('POLMAV', function(veh)
            SetEntityCoords(veh, Config.Zones.x, Config.Zones.y, Config.Zones.z)
            SetEntityHeading(veh, Config.Zones.w)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            exports['lj-fuel']:SetFuel(veh, 100.0)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
          end)
        end
      end
    end)
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
--                END Helicopter
--==================================================

--==================================================
--                      ARMORY
--==================================================

exports["qb-target"]:AddCircleZone("tarmory", vector3(-424.41, 1213.82, 325.76), 1.0, {
  name ="tarmory",
  useZ = true,
  debugPoly=true
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


exports["qb-target"]:AddCircleZone("personalstash", vector3(-426.27, 1215.98, 325.76), 1.0, {
  name ="personalstash",
  useZ = true,
  debugPoly=false
  }, {
      options = {
          {
              event = "titan:personal:stash",
              icon = "as fa-lock",
              label = "Personal Locker",
          },
       },
       job = {"all"},
      distance = 2.1
  })
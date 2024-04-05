
local QBCore = exports['qb-core']:GetCoreObject()
local sonafyon = 1
local objeSpawn = false
local AllObjects = {}
CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst2 = #(playercoords - Config.Afyontoplama[sonafyon])
        if dst2 < 30 then
            if not objeSpawn then
                SpawnObjeler()
            end
            if dst2 < 15 then
                sleep = 5
                DrawMarker(2, Config.Afyontoplama[sonafyon].x, Config.Afyontoplama[sonafyon].y, Config.Afyontoplama[sonafyon].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.1, 255, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0)
                DrawText3Ds(Config.Afyontoplama[sonafyon].x, Config.Afyontoplama[sonafyon].y, Config.Afyontoplama[sonafyon].z + 0.3, '[E] Afyon Topla')
                if dst2 < 2 then
                    if IsControlJustReleased(0, 38) then
                        sonafyon = math.random(1, #Config.Afyontoplama)
                        afyontopla()
                    end
                end
            end
        elseif dst2 > 30 and objeSpawn then
            for k, v in pairs(AllObjects) do
                QBCore.Functions.DeleteObject(v)
                objeSpawn = false
            end
        end
        Wait(sleep)
    end
end)



function afyontopla()
    if not topluyormu then
        topluyormu = true
        QBCore.Functions.Progressbar("afyontopla", "Afyon Topluyorsun..", 8000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            disableInventory = true,
        }, {
            animDict = "mp_arresting",
            anim = "a_uncuff",
            flags = 49,
        }, {}, {}, function()
            TriggerServerEvent('cqwerafyontoplama')
            topluyormu = false
        end, function()
        end) -- Cancel
    end
end

--isleme

CreateThread(function()
    local sleep = 2000
    while true do
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local distance = GetDistanceBetweenCoords(playercoords, Config.Afyonisleme.x, Config.Afyonisleme.y, Config.Afyonisleme.z, true)
        if distance < 5 then
            sleep = 0
            DrawMarker(2, Config.Afyonisleme.x, Config.Afyonisleme.y, Config.Afyonisleme.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.1, 255, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0)
            if distance < 2 then
                DrawText3Ds(Config.Afyonisleme.x,Config.Afyonisleme.y,Config.Afyonisleme.z, '[E] Afyonlarını İşle')
                if IsControlJustReleased(0, 38) then
                    QBCore.Functions.Progressbar("afyontopla", "Afyon İşliyorsun..", 8000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                        disableInventory = true,
                    }, {
                        animDict = "mp_arresting",
                        anim = "a_uncuff",
                        flags = 49,
                    }, {}, {}, function()
                        TriggerServerEvent("cqwerafyonisleme")
                    end, function()
                    end) -- Cancel
                end
            else
                sleep = 1000
            end
        end
        Wait(sleep)
    end
end)


function SpawnObjeler()
    for k, v in pairs(Config.Afyontoplama) do
        SpawnLocalObject('prop_weed_01', v, function(obj) --- change this prop to whatever plant you are trying to use 
            PlaceObjectOnGroundProperly(obj)
            FreezeEntityPosition(obj, true)
            AllObjects[#AllObjects+1] = obj
        end)
    end
    objeSpawn = true
end



SpawnLocalObject = function(model, coords, cb)
    local model = (type(model) == 'number' and model or GetHashKey(model))
    CreateThread(function()
        RequestModel(model)
        local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)
        SetModelAsNoLongerNeeded(model)
        if cb then
            cb(obj)
        end
        return
    end)
end
-- Satış



function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 75)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 75)
end
--blips


CreateThread(function()
    local blip = AddBlipForCoord(Config.AfyonislemeBlip.x, Config.AfyonislemeBlip.y, Config.AfyonislemeBlip.z)
    SetBlipSprite(blip, 403)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.AfyonislemeBlipAd)
    EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
    local blip = AddBlipForCoord(Config.AfyontoplamaBlip.x, Config.AfyontoplamaBlip.y, Config.AfyontoplamaBlip.z)
    SetBlipSprite(blip, 403)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.AfyontoplamaBlipAd)
    EndTextCommandSetBlipName(blip)
end)


CreateThread(function()
    local blip = AddBlipForCoord(Config.satistoplu.x, Config.satistoplu.y, Config.satistoplu.z)
    SetBlipSprite(blip, 403)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.satistopluad)
    EndTextCommandSetBlipName(blip)
end)




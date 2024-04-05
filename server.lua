local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("cqwerafyontoplama")
AddEventHandler("cqwerafyontoplama", function()
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddItem("afyon", math.random(Config.AfyonMin,Config.AfyonMax))
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['afyon'], "add",1)
end)

RegisterNetEvent("cqwerafyonisleme")
AddEventHandler("cqwerafyonisleme", function()
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local item = math.random(1,100)
    if xPlayer.Functions.RemoveItem("afyon", Config.AfyonislemeMiktar) then
        xPlayer.Functions.AddItem("afyonislenmis", 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['afyon'], "remove",Config.AfyonislemeMiktar)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['afyonislenmis'], "add",1)
        TriggerClientEvent('QBCore:Notify', source, "Afyon İşledin")
    else
        TriggerClientEvent('QBCore:Notify', source, "Yeterli Afyon Yok", "error")
    end
end)


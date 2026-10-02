local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('buyStuffSystem:getItems', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM ' .. Config.Database.TableName, {}, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('buyStuffSystem:buyItem')
AddEventHandler('buyStuffSystem:buyItem', function(itemName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = nil

    for _, v in ipairs(Config.Items) do
        if v.name == itemName then
            item = v
            break
        end
    end

    if item then
        if xPlayer.getMoney() >= item.price then
            xPlayer.removeMoney(item.price)
            xPlayer.addInventoryItem(item.name, 1)
            TriggerClientEvent('buyStuffSystem:notify', source, 'You bought ' .. item.label .. ' for $' .. item.price, 'success')
        else
            TriggerClientEvent('buyStuffSystem:notify', source, 'You do not have enough money', 'error')
        end
    else
        TriggerClientEvent('buyStuffSystem:notify', source, 'Item not found', 'error')
    end
end)
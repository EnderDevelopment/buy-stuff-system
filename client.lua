local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 38) then -- E key
            OpenBuyMenu()
        end
    end
end)

function OpenBuyMenu()
    ESX.UI.Menu.CloseAll()

    local elements = {}
    for _, item in ipairs(Config.Items) do
        table.insert(elements, {label = item.label .. ' - $' .. item.price, value = item.name})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_menu', {
        title    = Config.Menu.Title,
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        TriggerServerEvent('buyStuffSystem:buyItem', data.current.value)
    end, function(data, menu)
        menu.close()
    end)
end

RegisterNetEvent('buyStuffSystem:notify')
AddEventHandler('buyStuffSystem:notify', function(message, type)
    ESX.ShowNotification(message)
end)
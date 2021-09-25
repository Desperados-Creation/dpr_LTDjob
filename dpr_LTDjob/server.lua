ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'ltd', ('ltd'), true, true)
TriggerEvent('esx_society:registerSociety', 'ltd', 'ltd', 'society_ltd', 'society_ltd', 'society_ltd', {type = 'private'})

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

-- Prendre item stock
RegisterServerEvent('dpr_LTDshop:TakeItem')
AddEventHandler('dpr_LTDshop:TakeItem', function(Name, Item) 
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(Item, 1)
	Citizen.Wait(500) 
	TriggerClientEvent('esx:showAdvancedNotification', _src, 'LTD', '~o~2~r~4~g~7', "Vous venez de prendre ~b~1x "..Name.." ~s~!", 'CHAR_ACTING_UP', 1)
end)

-- Gestion annonce
RegisterServerEvent('dpr_LTDJob:AnnonceOuverture')
AddEventHandler('dpr_LTDJob:AnnonceOuverture', function()
	local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LTD', '~y~Annonce', 'Le magasin LTD est désormais ~g~ouvert ~s~!', 'CHAR_ACTING_UP', 1)
    end
end)

RegisterServerEvent('dpr_LTDJob:AnnonceFermeture')
AddEventHandler('dpr_LTDJob:AnnonceFermeture', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LTD', '~y~Annonce', 'Le magasin LTD est désormais ~r~fermer ~s~!', 'CHAR_ACTING_UP', 1)
    end
end)

RegisterServerEvent('dpr_LTDJob:AnnonceRecrutement')
AddEventHandler('dpr_LTDJob:AnnonceRecrutement', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LTD', '~y~Annonce', 'Le magasin LTD ~y~recrute ~s~rendez-vous dans notre magasin ~y~pour plus d\'information ~s~!', 'CHAR_ACTING_UP', 1)
    end
end)

RegisterCommand('ltd', function(source, args, rawCommand)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if xPlayer.job.name == "ltd" then
        local src = source
        local msg = rawCommand:sub(4)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LTD', '~y~Annonce', ''..msg..'', 'CHAR_ACTING_UP', 1)
            end
        else
            TriggerClientEvent('esx:showAdvancedNotification', _src, 'LTD', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_ACTING_UP', 1)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _src, 'LTD', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_ACTING_UP', 1)
    end
end)

RegisterCommand('eltd', function(source, args, rawCommand)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if xPlayer.job.name == "ltd" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'ltd' then
                    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LTD', '~y~Annonce', ''..msg..'', 'CHAR_ACTING_UP', 1)
                end
            end
        else
            TriggerClientEvent('esx:showAdvancedNotification', _src, 'LTD', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_ACTING_UP', 1)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _src, 'LTD', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_ACTING_UP', 1)
    end
end)

-- Coffre
RegisterServerEvent('dpr_LTDJob:prendreitems')
AddEventHandler('dpr_LTDJob:prendreitems', function(itemName, count)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ltd', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then

			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _src, "quantité invalide")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _src, 'Objet retiré', count, inventoryItem.label)
			end
		else
			TriggerClientEvent('esx:showNotification', _src, "quantité invalide")
		end
	end)
end)


RegisterNetEvent('dpr_LTDJob:stockitem')
AddEventHandler('dpr_LTDJob:stockitem', function(itemName, count)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ltd', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _src, "Objet déposé "..count..""..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _src, "quantité invalide")
		end
	end)
end)


ESX.RegisterServerCallback('dpr_LTDJob:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('dpr_LTDJob:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ltd', function(inventory)
		cb(inventory.items)
	end)
end)

-- Preparation
RegisterNetEvent('dpr_LTD:Preparation')
AddEventHandler('dpr_LTD:Preparation', function(Nom, ItemRequis, ItemCuisiner)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    local ItemBesoin = xPlayer.getInventoryItem(ItemRequis).count
    local ItemDonner = xPlayer.getInventoryItem(ItemCuisiner).count

    if ItemDonner > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Tu à ateint la limite')
    elseif ItemBesoin < 1 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il vous manques des ingredients')
    else
        xPlayer.removeInventoryItem(ItemRequis, 1)
        xPlayer.addInventoryItem(ItemCuisiner, 1)    
    end
end)

-- Stock
RegisterNetEvent('dpr_LTD:GiveItem')
AddEventHandler('dpr_LTD:GiveItem', function(Nom, Item)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    xPlayer.addInventoryItem(Item, 1)
end)
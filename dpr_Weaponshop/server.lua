ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterServerEvent('dpr_Weaponshop:AchatArme')
AddEventHandler('dpr_Weaponshop:AchatArme', function(Label, Weapon, Price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getBank() >= Price) then
		xPlayer.removeAccountMoney('bank', Price)
		
		if not xPlayer.hasWeapon(Weapon) then
			xPlayer.addWeapon(Weapon, 1)
			local xPlayers	= ESX.GetPlayers()
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				Citizen.Wait(500) 
				TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Ammunation', 'Armurier', 'Merci pour ton achat !', 'CHAR_AMMUNATION', 1)
				Citizen.Wait(10000)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Banque', 'Conseiller', "Un prélèvement de ~r~"..Price.." ~s~a été effectué sur votre compte pour ~o~"..Label.." ~s~!", 'CHAR_BANK_MAZE', 1)
			end
		else
			local xPlayers	= ESX.GetPlayers()
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				Citizen.Wait(500)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Ammunation', 'Armurier', 'Tu en as déjà un sur toi !', 'CHAR_AMMUNATION', 1)
			end
		end
	else
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Banque', 'Conseiller', "Vous n'avez pas suffisament d'argent sur votre compte bancaire ~s~!", 'CHAR_BANK_MAZE', 1)
	end	
end)


-- Accessoires --
RegisterServerEvent('dpr_Weaponshop:AchatItem')
AddEventHandler('dpr_Weaponshop:AchatItem', function(Label, Item, Price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getBank() >= Price) then
		xPlayer.removeAccountMoney('bank', Price)
		
		xPlayer.addInventoryItem(Item, 1)				
		local xPlayers	= ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			Citizen.Wait(500) 
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Ammunation', 'Armurier', 'Merci pour ton achat !', 'CHAR_AMMUNATION', 1)
			Citizen.Wait(10000)
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Banque', 'Conseiller', 'Un prélèvement de ~r~100$ ~s~a été effectué sur votre compte pour une lampe !', 'CHAR_BANK_MAZE', 1)
		end
	else
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Banque', 'Conseiller', "Vous n'avez pas suffisament d'argent sur votre compte bancaire ~s~!", 'CHAR_BANK_MAZE', 1)
	end	
end)

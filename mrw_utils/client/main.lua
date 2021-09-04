-- Authors: Morow
-- Github: https://github.com/Morow73
-- No Sale !!!

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
 
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)


local weapon = {
    -- pistol
    [453432689] = {munitions = '9 mm'},
    
    -- pistol cal.50
    [-1716589765] = {munitions = '357 Magnum'},
    
    -- combat pistol
    [0x5EF9FEC4] = {munitions = '9 mm'},
    
    -- Ap pistol
    [0x22D8FE39] = {munitions = '9 mm'},
    
    --smg
    [0x2BE6766B] = {munitions = '.45 ACP'},
    
    -- micro smg
    [0x13532244] = {munitions = '9 mm'},
     
    -- assault smg
    [-270015777] = {munitions = '.45 ACP'},
    
    -- assault rifle
    [-1074790547] = {munitions = '7.62 mm'},
    
    -- carabine
    [-2084633992] = {munitions = '9 mm'},
    
    -- advanced rifle
    [-1357824103] = {munitions = '7.62 mm'},
    
    -- special carabine
    [-1063057011] = {munitions = '9 mm'},
    
    -- shotgun
    [0x1D073A89] = {munitions = '12 mm'},

    -- sniper
    [0x05FC3C11] = {munitions = '7.62 mm'},
}
 
local Anim = true 
local amountBox = 150 -- number of ammo per box
local amountBrokenBproof = 10 -- limit before destroy

function GetAmmoWeapon()

    for k,v in pairs(weapon) do
        local PlayerChoise = GetSelectedPedWeapon(PlayerPedId())

        if PlayerChoise == k then
          ammo = v.munitions
          break
        end 
    end
    return ammo 
end

RegisterNetEvent('mrw_utils:bproof')
AddEventHandler('mrw_utils:bproof', function(val)

    local Ply = PlayerPedId()
    Armour = GetPedArmour(PlayerPedId())

    if not HasBProof then

        TriggerEvent('skinchanger:getSkin', function(skin)

            if skin.sex == 0 then
                clothesSkin = {
                    ['bproof_1']  = 6,  ['bproof_2']  = 4
                }
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                Anim = true
                SetPedArmour(Ply, val)
 
            else
                clothesSkin = {
                    ['bproof_1']  = 6,  ['bproof_2']  = 4
                }
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                Anim = true
                SetPedArmour(Ply, val)
            end
        end)
    end
        
    if HasBProof == true then 

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)

            TriggerEvent('skinchanger:loadSkin', skin)
            SetPedArmour(Ply, 0) 
            Anim = true   
            if Armour <= amountBrokenBproof then
               TriggerServerEvent('mrw_utils:DelBProof') 
               TriggerServerEvent('mrw_utils:SaveBproof', 0)                  
               ESX.ShowNotification('Votre gilet est trop endommagé vous devez le remplacer')  
            else   
            	TriggerServerEvent('mrw_utils:SaveBproof', Armour)
            end    
                         
        end)  
        clothesSkin = false
    end

    if Anim == true then 
        Citizen.CreateThread(function()
            RequestAnimDict('clothingtie')

            while not HasAnimDictLoaded('clothingtie') do
                Citizen.Wait(1)
            end

            TaskPlayAnim(Ply, 'clothingtie', 'try_tie_neutral_a', 1.0, -1.0, 2667, 0, 1, true, true, true)
        end)
    end

  HasBProof = not HasBProof
end)

RegisterNetEvent('mrw_utils:AmmoBox')
AddEventHandler('mrw_utils:AmmoBox', function(type)
    
    local Ply  = PlayerPedId() 
    local ammo = GetAmmoWeapon()

    if type == '9 mm' then 
        if ammo == type then 
           SetPedAmmo(Ply, GetSelectedPedWeapon(Ply), amountBox) 
           ESX.ShowNotification('Vous avez recharger votre arme avec des munitions de type '..type)
        else 
           ESX.ShowNotification('Ces munitions ne conviennent pas pour cette arme')
           TriggerServerEvent('mrw_utils:ReturnIsNotValid', type)
        end   
    elseif type == '357 Magnum' then 
        if ammo == type then 
           SetPedAmmo(Ply, GetSelectedPedWeapon(Ply), amountBox) 
           ESX.ShowNotification('Vous avez recharger votre arme avec des munitions de type '..type)
        else 
           ESX.ShowNotification('Ces munitions ne conviennent pas pour cette arme')
           TriggerServerEvent('mrw_utils:ReturnIsNotValid', type)
        end  
    elseif type == '.45 ACP' then 
        if ammo == type then 
           SetPedAmmo(Ply, GetSelectedPedWeapon(Ply), amountBox)  
           ESX.ShowNotification('Vous avez recharger votre arme avec des munitions de type '..type)
        else 
           ESX.ShowNotification('Ces munitions ne conviennent pas pour cette arme')
           TriggerServerEvent('mrw_utils:ReturnIsNotValid', type)
        end 
    elseif type == '7.62 mm' then 
        if ammo == type then 
           SetPedAmmo(Ply, GetSelectedPedWeapon(Ply), amountBox) 
           ESX.ShowNotification('Vous avez recharger votre arme avec des munitions de type '..type)
        else 
           ESX.ShowNotification('Ces munitions ne conviennent pas pour cette arme')
           TriggerServerEvent('mrw_utils:ReturnIsNotValid', type)
        end 
    elseif type == '12 mm' then 
        if ammo == type then 
           SetPedAmmo(Ply, GetSelectedPedWeapon(Ply), amountBox)  
           ESX.ShowNotification('Vous avez recharger votre arme avec des munitions de type '..type)
        else 
           ESX.ShowNotification('Ces munitions ne conviennent pas pour cette arme')
           TriggerServerEvent('mrw_utils:ReturnIsNotValid', type)
        end     
    end    
end)    


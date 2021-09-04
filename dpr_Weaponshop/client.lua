ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

-- Menu --
local open = false 
local Ammu = RageUI.CreateMenu('Ammunation', 'Interaction')
local AmmuBlanche = RageUI.CreateSubMenu(Ammu, "Armes blanche", "Interaction")
local AmmuAccessoire = RageUI.CreateSubMenu(Ammu, "Accessoires", "Interaction")
local AmmuDivers = RageUI.CreateSubMenu(Ammu, "Divers", "Interaction")
Ammu.Display.Header = true 
Ammu.Closed = function()
  open = false
end

function OpenAmmuMenu()
	if open then 
		open = false
		RageUI.Visible(Ammu, false)
		return
	else
		open = true 
		RageUI.Visible(Ammu, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(Ammu,function() 

			RageUI.Separator("↓~b~    Ammunation    ~s~↓")
			RageUI.Button("Armes blanche", "Voir le catalogue des armes blanches", {RightLabel = "~y~→→→"}, true , {}, AmmuBlanche)

			RageUI.Button("Accessoires d'armes", "Voir le catalogue des accessoires d'arme", {RightLabel = "~y~→→→"}, true , {}, AmmuAccessoire)

			RageUI.Button("Divers", "Voir le catalogue de divers objets (boites de munition, jumelle ...)", {RightLabel = "~y~→→→"}, true , {}, AmmuDivers)

			RageUI.Separator("↓ ~r~    Fermer    ~s~↓")
			RageUI.Button("~r~Fermer", "Fermer le menu", {RightLabel = "~y~→→"}, true , {
				onSelected = function()
					RageUI.CloseAll()
				end
			})
			end)

			-- Menu Ammu Armes blanche
			RageUI.IsVisible(AmmuBlanche,function() 
			
			RageUI.Separator("↓ ~b~    Armes blanche    ~s~↓")
			for k, v in pairs(Config.ArmeBlanche) do
				RageUI.Button(v.Label, nil, {RightLabel = "~r~"..v.Price.."$"}, true , {
					onSelected = function()
						TriggerServerEvent('dpr_Weaponshop:AchatArme', v.Label, v.Weapon, v.Price)
					end
				})
			end

			RageUI.Separator("↓ ~r~    Fermer    ~s~↓")
			RageUI.Button("~r~Fermer", "Fermer le menu", {RightLabel = "~y~→→"}, true , {
				onSelected = function()
					RageUI.CloseAll()
				end
			})
			end)

			-- Menu Ammu Accessoires
			RageUI.IsVisible(AmmuAccessoire,function() 

			RageUI.Separator("↓ ~b~    Accessoires    ~s~↓")
			for k, v in pairs(Config.Accessoire) do
				RageUI.Button(v.Label, nil, {RightLabel = "~r~"..v.Price.."$"}, true , {
					onSelected = function()
						TriggerServerEvent('dpr_Weaponshop:AchatItem', v.Label, v.Item, v.Price)
					end
				})
			end

			RageUI.Separator("↓ ~r~    Fermer    ~s~↓")
			RageUI.Button("~r~Fermer", "Fermer le menu", {RightLabel = "~y~→→"}, true , {
				onSelected = function()
					RageUI.CloseAll()
				end
			})
			end)
	
			-- Menu Ammu Divers
			RageUI.IsVisible(AmmuDivers,function() 
	
			RageUI.Separator("↓ ~b~    Divers    ~s~↓")
			for k, v in pairs(Config.Divers) do
				RageUI.Button(v.Label, nil, {RightLabel = "~r~"..v.Price.."$"}, true , {
					onSelected = function()
						TriggerServerEvent('dpr_Weaponshop:AchatArme', v.Label, v.Weapon, v.Price)
					end
				})
			end

			RageUI.Separator("↓ ~r~    Fermer    ~s~↓")
			RageUI.Button("~r~Fermer", "Fermer le menu", {RightLabel = "~y~→→"}, true , {
				onSelected = function()
					RageUI.CloseAll()
				end
			})
			end)
		Wait(0)
		end
	 end)
  end
end

-- Ouvrir le menu --
Citizen.CreateThread(function()
    while true do
		local wait = 750

			for k, v in pairs(Config.positionWeaponshop.InteractZone) do
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)

			if dist <= 3.0 then
                wait = 0
                Visual.Subtitle(Config.Text, 1)
                if IsControlJustPressed(1,51) then
                    OpenAmmuMenu()
                end
		    end
		end
    Citizen.Wait(wait)
    end
end)

-- Ped --
local positionPedAmmu = {
	{x = 23.17, y = -1105.32, z = 28.8, a = 160.2},
	{x = -3173.81, y = 1088.71, z = 19.83, a = 246.79},
	{x = -331.92, y = 6085.38, z = 30.45, a = 223.21},
	{x = 1692.01, y = 3761.31, z = 33.70, a = 228.42},
	{x = 2567.77, y = 292.12, z = 107.73, a = 357.27},
	{x = 254.20, y = -50.88, z = 68.94, a = 72.29},
	{x = -662.0, y = -933.46, z = 20.82, a = 186.4}
}

Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_y_ammucity_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
	end
	for k,v in pairs(positionPedAmmu) do
	ped = CreatePed("PED_TYPE_CIVMALE", "s_m_y_ammucity_01", v.x, v.y, v.z, v.a, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
	end
end)

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(1)
    end
end

-- Blips --
Citizen.CreateThread(function()
    if Config.blip then
        for k, v in pairs(Config.positionWeaponshop.InteractZone) do
            local blip = AddBlipForCoord(v.x, v.y, v.z)

            SetBlipSprite(blip, Config.BlipId)
            SetBlipScale (blip, Config.BlipTaille)
            SetBlipColour(blip, Config.BlipCouleur)
            SetBlipAsShortRange(blip, Config.BlipRange)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName('Supérette')
            EndTextCommandSetBlipName(blip)
        end
    end
end)
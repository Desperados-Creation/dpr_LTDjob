ESX = nil

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

-- Menu --
local open = false
local MenuStockMenu = RageUI.CreateMenu("Stock", "INTERACTION")
MenuStockMenu.Display.Header = true
MenuStockMenu.Closed = function() 
    open = false
end

function OpenStockMenu() 
    if open then 
        open = false
        RageUI.Visible(MenuStockMenu, false)
        return
    else
        open = true
        RageUI.Visible(MenuStockMenu, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(MenuStockMenu, function()
                    RageUI.Separator("↓    ~g~Stock     ~s~↓")
                    for k,v in pairs(Config.StockItem) do 
                        RageUI.Button(v.Name, nil, {RightLabel = "~y~Prix de revente: ~r~"..v.Price.."$"}, true, {
                            onSelected = function() 
                                TriggerServerEvent('dpr_LTDshop:TakeItem', v.Name, v.Item)
                            end
                        })
                    end
                    RageUI.Separator("↓    ~r~Fermer    ~s~↓")
                    RageUI.Button("Fermer", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                            open = false
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do 
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ltd' then
            for k in pairs(Config.Positions.Stock) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local pos = Config.Positions.Stock
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

                if dist <= Config.MarkerDistance then 
                    wait = 0
                    DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)
                    if dist <= 1.0 then 
                        wait = 0
                        Visual.Subtitle(Config.Text)
                        if IsControlJustPressed(1, 51) then 
                            OpenStockMenu()
                        end
                    end
                end
            end
        end
    Wait(wait)
    end
end)
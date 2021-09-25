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
local MenuF6LTD = RageUI.CreateMenu("LTD", "INTERACTION")
local MenuAnnonceLTD = RageUI.CreateSubMenu(MenuF6LTD, "Annonce LTD", "INTERACTION")
MenuF6LTD.Display.Header = true
MenuF6LTD.Closed = function()
    open = false
end

function OpenMenuF6LTD()
    if open then
        open = false
        RageUI.Visible(MenuF6LTD, false)
        return
    else
        open = true
        RageUI.Visible(MenuF6LTD, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(MenuF6LTD, function()
                    RageUI.Separator("↓    ~g~Annonce    ~s~↓")
                    RageUI.Button("Annonce", nil, {RightLabel = "~y~→→→"}, true, {}, MenuAnnonceLTD)

                    RageUI.Separator("↓    ~g~Facture    ~s~↓")
                    RageUI.Button("Facture", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function() 
                            local player, distance = ESX.Game.GetClosestPlayer()
                            local raison = ""
                            local montant = 0
                            AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then
                                    raison = result
                                    result = nil
                                    AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Wait(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        result = GetOnscreenKeyboardResult()
                                        if result then
                                            montant = result
                                            result = nil
                                            if player ~= -1 and distance <= 3.0 then
                                                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_LTD', ('LTD'), montant)
                                                TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~LTD', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_LTD_FLEECA', 9)
                                            else
                                                ESX.ShowNotification("~r~Aucuns joueurs à proximité !")
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    })

                    RageUI.Separator("↓    ~r~Fermeture    ~s~↓")
                    RageUI.Button("~r~Fermer", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                            open = false
                        end
                    })
                end)

                -- Menu Annonce
                RageUI.IsVisible(MenuAnnonceLTD, function()
                    RageUI.Separator("↓    ~g~Annonce    ~s~↓")
                    RageUI.Button("Annonce Ouverture", nil, {RightLabel = "~y~→"}, true, {
                        onSelected = function()
                            TriggerServerEvent('dpr_LTDJob:AnnonceOuverture')
                        end
                    })
                    RageUI.Button("Annonce Fermeture", nil, {RightLabel = "~y~→"}, true, {
                        onSelected = function()
                            TriggerServerEvent('dpr_LTDJob:AnnonceFermeture')
                        end
                    })
                    RageUI.Button("Annonce Recrutement", nil, {RightLabel = "~y~→"}, true, {
                        onSelected = function()
                            TriggerServerEvent('dpr_LTDJob:AnnonceRecrutement')
                        end
                    })

                    RageUI.Separator("↓    ~y~Personalisé    ~s~↓")
                    RageUI.Button("Annonce Personalisé", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            local msg = KeyboardInput("Message", "", 100)
                            ExecuteCommand("ltd " ..msg)
                        end
                    })

                    RageUI.Button("Message Employer", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            local msg = KeyboardInput("Message Employer", "", 100)
                            ExecuteCommand("eltd " ..msg)
                        end
                    })

                    RageUI.Separator("↓    ~r~Fermeture    ~s~↓")
                    RageUI.Button("~r~Fermer", nil, {RightLabel = "~y~→→"}, true, {
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

Keys.Register('F6', 'LTD', 'Ouvrir le menu F6 LTD', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ltd' then
    	OpenMenuF6LTD()
	end
end)

-- Function --
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

RegisterNetEvent('dpr_LTDJob:MessageEmployer')
AddEventHandler('dpr_LTDJob:MessageEmployer', function(service, nom, message)
	if service == 'employer' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Message LTD', '~y~Message:', 'Employer: ~g~'..nom..'\n~w~Message: ~g~'..message..'', 'CHAR_ESTATE_AGENT', 1)
		Wait(14000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)	
	end
end)

-- Blips --
Citizen.CreateThread(function()
    if Config.BlipLTD then
        for k, v in pairs(Config.Positions.Stock) do
            local blipLTD = AddBlipForCoord(v.x, v.y, v.z)

            SetBlipSprite(blipLTD, Config.BlipLTDId)
            SetBlipScale (blipLTD, Config.BlipLTDTaille)
            SetBlipColour(blipLTD, Config.BlipLTDCouleur)
            SetBlipAsShortRange(blipLTD, Config.BlipLTDRange)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Config.BlipLTDName)
            EndTextCommandSetBlipName(blipLTD)
        end
    end
end)
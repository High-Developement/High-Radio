local frequenzaradio = 'Non sei connesso'

openHighScriptsRadio = function ()
    local options = {
        {
            title = 'Sei connesso nella frequenza radio: ' .. frequenzaradio,
        },
        {
            title = 'Entra in una frequenza',
            description = 'premi qui per entrare in una frequenza radio',
            onSelect = function()
                local input = lib.inputDialog('Connetti ad una frequenza', {'Inserisci una frequenza radio'})
                if not input then return end

                input = tonumber(input[1])
                    
                if input then
                    if input <= HighScriptsConfig.MaxFrequenze then
                        exports['pma-voice']:setRadioChannel(input)
                        frequenzaradio = input
                    else
                        lib.notify({
                            title = 'Notifica',
                            description = 'Non puoi connetterti ad una frequenza maggiore di: ' .. HighScriptsConfig.MaxFrequenze,
                            type = 'error'
                        })
                    end
                else
                    lib.notify({
                        title = 'Errore',
                        description = 'Inserisci un numero valido per la frequenza radio',
                        type = 'error'
                    })
                end
            end,
        },
        {
            title = 'Esci dalla frequenza',
            description = 'premi qui per uscire dalla frequenza radio connessa',
            onSelect = function()
                frequenzaradio = 'Non sei connesso'
                exports['pma-voice']:removePlayerFromRadio()
            end,
        },
        {
            title = 'Animazioni Radio',
            description = 'premi qui per aprire il menu delle animazioni radio',
            onSelect = function()
                apriMenuAnimRadio()
            end,
        }
    }

    if tonumber(frequenzaradio) then
        table.insert(options, {
            title = 'Visualizza player connessi',
            description = 'premi qui per visualizzare i player connessi',
            onSelect = function()
                lib.callback('highscripts_radio:CheckPlayers', false, function(players)
                    if players and #players > 0 then
                        local playerOptions = {}
                
                        for _, player in pairs(players) do
                            local fivemName = player.source
                
                            table.insert(playerOptions, {
                                title = player.name,
                                description = ('%s (id) | Sta parlando: %s'):format(fivemName, tostring(player.isTalking))
                            })
                        end
                
                        lib.registerContext({
                            id = 'menu_players_radio',
                            title = 'Giocatori connessi alla radio ' .. frequenzaradio,
                            options = playerOptions
                        })
                
                        lib.showContext('menu_players_radio')
                
                    else
                        lib.notify({
                            title = 'Nessun giocatore',
                            description = 'Nessun giocatore è connesso alla radio.',
                            type = 'error'
                        })
                    end
                end, frequenzaradio)
            end,
        })

        table.insert(options, {
            title = 'Volume Radio',
            description = 'premi qui per settare il volume della radio',
            onSelect = function()
                local input = lib.inputDialog('Volume Radio', {'Volume radio 0%/100%'})
                if not input then return end

                input = tonumber(input[1])
                    
                if input then
                    exports["pma-voice"]:setRadioVolume(input)
                end
            end,
        })
    end
    
    
    lib.registerContext({
        id = 'highScriptsMenuRadio',
        title = 'Radio',
        options = options
    })

    lib.showContext('highScriptsMenuRadio')
end

RegisterNetEvent('highscripts:apriRadio')
AddEventHandler('highscripts:apriRadio', function ()
    openHighScriptsRadio()
end)

-------------------- anim radio --------------------------

local usingRadio = false
local anim1 = false
local anim2 = false
local anim3 = false
local anim4 = false
local anim5 = false
local radioProp = nil

AddEventHandler("pma-voice:radioActive", function(radioTalking)
    usingRadio = radioTalking
    local playerPed = PlayerPedId()

    if usingRadio then
        if anim1 then
            RequestAnimDict('random@arrests')
            while not HasAnimDictLoaded('random@arrests') do
                Wait(10)
            end
            TaskPlayAnim(playerPed, "random@arrests", "generic_radio_chatter", 8.0, -8, -1, 49, 0, 0, 0, 0)
        elseif anim2 then
            RequestAnimDict('random@arrests')
            while not HasAnimDictLoaded('random@arrests') do
                Wait(10)
            end
            TaskPlayAnim(playerPed, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, false, false, false)
        elseif anim3 then
            RequestAnimDict('cellphone@str')
            while not HasAnimDictLoaded('cellphone@str') do
                Wait(10)
            end
            TaskPlayAnim(playerPed, "cellphone@str", "cellphone_call_listen_a", 8.0, 2.0, -1, 50, 2.0, false, false, false)
        elseif anim4 then
            RequestAnimDict('amb@code_human_police_investigate@idle_a')
            while not HasAnimDictLoaded('amb@code_human_police_investigate@idle_a') do
                Wait(10)
            end
            TaskPlayAnim(PlayerPedId(), "amb@code_human_police_investigate@idle_a", "idle_b", 8.0, -8, -1, 49, 0, 0, 0, 0)
        elseif anim5 then
            RequestAnimDict("anim@move_m@security_guard");
            while not HasAnimDictLoaded("anim@move_m@security_guard") do Wait(5) end
            TaskPlayAnim(PlayerPedId(),"anim@move_m@security_guard", "idle_var_02", 2.0, 0.0, -1, 49, 0, 0, 0, 0);
        end

        if radioProp then
            if anim1 then
                SetEntityVisible(radioProp, true, true)
                local boneIndex = GetPedBoneIndex(playerPed, 60309)
                local boneCoords = GetWorldPositionOfEntityBone(playerPed, boneIndex)
                local boneRotation = GetEntityRotation(playerPed, 2)
                SetEntityCoordsNoOffset(radioProp, boneCoords.x, boneCoords.y, boneCoords.z, true, true, true)
                SetEntityRotation(radioProp, boneRotation.x, boneRotation.y, boneRotation.z, 2, true)
                AttachEntityToEntity(radioProp, playerPed, boneIndex, 0.06, 0.05, 0.03, -90.0, 30.0, 0.0, true, true, false, true, 1, true)
            elseif anim2 then
                SetEntityVisible(radioProp, true, true)
                local boneIndex = GetPedBoneIndex(playerPed, 60309)
                local boneCoords = GetWorldPositionOfEntityBone(playerPed, boneIndex)
                local boneRotation = GetEntityRotation(playerPed, 2)
                SetEntityCoordsNoOffset(radioProp, boneCoords.x, boneCoords.y, boneCoords.z, true, true, true)
                SetEntityRotation(radioProp, boneRotation.x, boneRotation.y, boneRotation.z, 2, true)
                AttachEntityToEntity(radioProp, playerPed, boneIndex, 0.06, 0.05, 0.03, -90.0, 30.0, 0.0, true, true, false, true, 1, true)
            elseif anim3 then
                SetEntityVisible(radioProp, true, true)
                local boneIndex = GetPedBoneIndex(playerPed, 28422)
                local boneCoords = GetWorldPositionOfEntityBone(playerPed, boneIndex)
                local boneRotation = GetEntityRotation(playerPed, 2)
                SetEntityCoordsNoOffset(radioProp, boneCoords.x, boneCoords.y, boneCoords.z, true, true, true)
                SetEntityRotation(radioProp, boneRotation.x, boneRotation.y, boneRotation.z, 2, true)
                AttachEntityToEntity(radioProp, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
            elseif anim4 then
                SetEntityVisible(radioProp, false, false)
            end
        end
    else
        usingRadio = false        
        if radioProp then
            SetEntityVisible(radioProp, false, false)
        end

        StopAnimTask(PlayerPedId(), "anim@move_m@security_guard","idle_var_02", -3.0)	
        StopAnimTask(PlayerPedId(), "amb@code_human_police_investigate@idle_a","idle_b", -3.0)	
        StopAnimTask(PlayerPedId(), "cellphone@str","cellphone_call_listen_a", -3.0)	
        StopAnimTask(PlayerPedId(), "random@arrests","generic_radio_enter", -3.0)	
        StopAnimTask(PlayerPedId(), "random@arrests","generic_radio_chatter", -3.0)	

    end
end)

function apriMenuAnimRadio()
    local options = {
        {
            title = 'Spalla veloce',
            onSelect = function()
                anim1 = true
                anim2 = false
                anim3 = false
            end
        },
        {
            title = 'Spalla lenta',
            onSelect = function()
                anim1 = false
                anim2 = true
                anim3 = false
            end
        },
        {
            title = 'Orecchio',
            onSelect = function()
                anim1 = false
                anim2 = false
                anim3 = true
            end
        },
        {
            title = 'Polizia',
            onSelect = function()
                anim1 = false
                anim2 = false
                anim3 = false
                anim4 = true
            end
        },
        {
            title = 'Auricolare',
            onSelect = function()
                anim1 = false
                anim2 = false
                anim3 = false
                anim4 = false
                anim5 = true
            end
        },
        {
            title = 'Attiva/Disattiva Radio Prop',
            onSelect = function()
                if radioProp then
                    DeleteObject(radioProp)
                    radioProp = nil
                else
                    local playerPed = PlayerPedId()
                    local boneIndex = GetPedBoneIndex(playerPed, 57005)
                    local boneCoords = GetWorldPositionOfEntityBone(playerPed, boneIndex)
                    RequestModel('prop_cs_hand_radio')
                    while not HasModelLoaded('prop_cs_hand_radio') do
                        Wait(500)
                    end
                    radioProp = CreateObject(GetHashKey('prop_cs_hand_radio'), boneCoords.x, boneCoords.y, boneCoords.z, true, true, true)
                    SetEntityCollision(radioProp, false, false)
                    PlaceObjectOnGroundProperly(radioProp)
                    SetEntityVisible(radioProp, false, false)
                    SetEntityAlpha(radioProp, 255, false)
                    AttachEntityToEntity(radioProp, playerPed, boneIndex, 0.15, 0.1, -0.05, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                end
            end
        }
    }

    lib.registerContext({
        id = 'animazioni_radio_menu',
        title = 'Menu Animazioni Radio',
        options = options
    })

    lib.showContext('animazioni_radio_menu')
end
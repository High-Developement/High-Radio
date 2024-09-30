ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterUsableItem('radio', function(source)
    TriggerClientEvent('highscripts:apriRadio', source)
end)

lib.callback.register('highscripts_radio:CheckPlayers', function(source, frequenzaradio)
    local players = exports['pma-voice']:getPlayersInRadioChannel(frequenzaradio)
    local playerList = {}

    if next(players) == nil then
        print('Nessun giocatore connesso nel canale radio ' .. frequenzaradio)
    else
        for playerSource, isTalking in pairs(players) do
            table.insert(playerList, {
                name = GetPlayerName(playerSource),
                source = playerSource,
                isTalking = isTalking
            })
            print(('%s è nel canale radio %d, Sta parlando: %s'):format(GetPlayerName(playerSource), frequenzaradio, tostring(isTalking)))
        end
    end

    return playerList
end)

------------------------------------------------------------------------
local lastZone, CurrentAction, hasAlreadyEnteredMarker = nil, nil, false
local ox_target = exports.ox_target
------------------------------------------------------------------------

RegisterNetEvent('jukebox_baspel:createJukeboxMenu', function()
    lib.registerContext({
        id = 'jukebox_menu',
        title = Config.Language['titleMenu'],
        options = {
            {
                title = Config.Language['playSong'],
                description = Config.Language['playSongDesc'],
                arrow = true,
                menu = 'playlist_menu'
            },
            -- {
            --     title = Config.Language['pauseMusic'],
            --     description = Config.Language['pauseMusicDesc'],
            --     arrow = false,
            --     serverEvent = 'jukebox_baspel:pauseSong',
            -- },
            -- {
            --     title = Config.Language['resumeMusic'],
            --     description = Config.Language['resumeMusicDesc'],
            --     arrow = false,
            --     serverEvent = 'jukebox_baspel:resumeSong',
            -- },
            {
                title = Config.Language['changeVolume'],
                description = Config.Language['changeVolumeDesc'],
                arrow = false,
                event = 'jukebox_baspel:changeVolumeOfSongMenu',
            },
            {
                title = Config.Language['stopMusic'],
                description = Config.Language['stopMusicDesc'],
                arrow = false,
                serverEvent = 'jukebox_baspel:stopSong',
            },
        },
        {
            id = 'playlist_menu',
            title = Config.Language['jukeboxPlaylist'],
            options = {
                {
                    title = Config.SongName['first'],
                    description = Config.SongName['desc_first'],
                    args = {music = Config.SongName['music_first_id']},
                    event = 'jukebox_baspel:playSongClient'
                },
                {
                    title = Config.SongName['second'],
                    description = Config.SongName['desc_second'],
                    args = {music = Config.SongName['music_second_id']},
                    event = 'jukebox_baspel:playSongClient'
                },
                {
                    title = Config.SongName['third'],
                    description = Config.SongName['desc_third'],
                    args = {music = Config.SongName['music_third_id']},
                    event = 'jukebox_baspel:playSongClient'
                },
                {
                    title = Config.SongName['fourth'],
                    description = Config.SongName['desc_fourth'],
                    args = {music = Config.SongName['music_fourth_id']},
                    event = 'jukebox_baspel:playSongClient'
                },
                {
                    title = Config.SongName['fifth'],
                    description = Config.SongName['desc_fifth'],
                    args = {music = Config.SongName['music_fifth_id']},
                    event = 'jukebox_baspel:playSongClient'
                },
            }
        }
    })
    lib.showContext('jukebox_menu')
end)

RegisterNetEvent('jukebox_baspel:changeVolumeOfSongMenu', function()
    local input = lib.inputDialog(Config.Language['musicVolume'], {Config.Language['musicVolumeNm']})
    if input then
        local volume = input[1]
        TriggerServerEvent('jukebox_baspel:changeVolumeOfSongServer', volume)
    end
end)

RegisterNetEvent('jukebox_baspel:playSongClient', function(data)
    local song = data.music
    local volume = Config.DefaultVolume
    TriggerServerEvent('jukebox_baspel:playSongServer', song, volume)
    local ped = PlayerPedId()
    local dict = 'mini@sprunk'
    local anim = 'plyr_buy_drink_pt1'
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do 
        Wait(10)
    end
    TaskPlayAnim(ped, dict, anim, 8.0, 5.0, -1, true, 1, 0, 0, 0)
    Citizen.Wait(1000)
    ClearPedTasks(ped)
end)


--- Function for spawning prop of jukebox ---
CreateThread(function()
    for k, v in pairs(Config.Locations) do
        local x, y, z, h = table.unpack(v.coords)
        RequestModel(v.model)
        while not (HasModelLoaded(v.model)) do
            Wait(1)
            if Config.Debug then
                print('Loading model..., please wait!')
            end
        end
        local obj = CreateObject(v.model, x, y, z -1, true, false, false)
        SetEntityHeading(obj, h)
    end
end)

CreateThread(function()
    if not Config.ox_target then
        while true do
            local sleep = 1500
            local playerCoords, inLocation, currentZone = GetEntityCoords(PlayerPedId()), false, false

            for i=1, #Config.Locations do
                local dist = #(playerCoords - Config.Locations[i].coordsPlay)
                if dist <= Config.Distance then
                    sleep = 0
                    if dist <= Config.Locations[i].distance then
                        inLocation, currentZone = true, i
                    end
                end
            end

            if (inLocation and not hasAlreadyEnteredMarker) or (inLocation and LastZone ~= currentZone) then
                hasAlreadyEnteredMarker, LastZone = true, currentZone
                CurrentAction = 'jukeboxMenu'
                lib.showTextUI(Config.Language['openMenu'])
            end

            if not inLocation and hasAlreadyEnteredMarker then
                hasAlreadyEnteredMarker = false
                sleep = 1000
                CurrentAction = nil
                lib.hideTextUI()
            end
            Wait(sleep)
        end
    else
        for k, v in pairs(Config.Locations) do
            local options = {
                {
                    name = 'ox:jukebox',
                    event = 'jukebox_baspel:createJukeboxMenu',
                    icon = 'fa fa-music',
                    label = 'Jukebox',
                }
            }

            local models = { v.model }
            ox_target:addModel(models, options)
        end
    end
end)

CreateThread(function ()
    if not Config.ox_target then
        while true do
            local sleep = 1500
            if CurrentAction ~= nil then
                sleep = 0
                if IsControlPressed(1, 38) then
                    Wait(500)
                    if CurrentAction == 'jukeboxMenu' then
                        TriggerEvent('jukebox_baspel:createJukeboxMenu')
                    end
                end
            end
            Wait(sleep)
        end
    end
end)

ESX = nil
local xSound = exports.xsound
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('jukebox_baspel:playSongServer', function(song, volume)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local item = player.getInventoryItem(Config.Item)
    if item.count > 0 then
        player.removeInventoryItem(Config.Item, 1)
        for k, v in pairs(Config.Locations) do
            local dist = #(coords - v.coordsPlay)
            if dist < 3 then
                xSound:PlayUrlPos(-1, v.name, './sounds/' .. song .. '.' .. Config.interact_sound_file, volume, v.coordsPlay)
                xSound:Distance(-1, v.name, v.radius)
                v.isPlaying = true
            end
        end
    else
        player.showNotification('You need jukebox coin to play a song!')
    end
end)

RegisterNetEvent('jukebox_baspel:stopSong', function()
    for k, v in pairs(Config.Locations) do
        local src = source
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local dist = #(coords - v.coordsPlay)
        if dist < 3 then
            if v.isPlaying then
                v.isPlaying = false
                xSound:Destroy(-1, v.name)
            end
        end
    end
end)

-- RegisterNetEvent('jukebox_baspel:pauseSong', function()
--     for k, v in pairs(Config.Locations) do
--         local src = source
--         local ped = GetPlayerPed(src)
--         local coords = GetEntityCoords(ped)
--         local dist = #(coords - v.coordsPlay)
--         if dist < 3 then
--             if v.isPlaying then
--                 v.isPlaying = false
--                 xSound:Pause(-1, v.name)
--             end
--         end
--     end
-- end)

--- Broken and idk why ---

-- RegisterNetEvent('jukebox_baspel:resumeSong', function()
--     for k, v in pairs(Config.Locations) do
--         local src = source
--         local ped = GetPlayerPed(src)
--         local coords = GetEntityCoords(ped)
--         local dist = #(coords - v.coordsPlay)
--         if dist < 3 then
--             if not v.isPlaying then
--                 v.isPlaying = true
--                 xSound:Resume(-1, v.name)
--             end
--         end
--     end
-- end)

RegisterNetEvent('jukebox_baspel:changeVolumeOfSongServer', function(volume)
    for k, v in pairs(Config.Locations) do
        local src = source
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local dist = #(coords - v.coordsPlay)
        if dist < 3 then
            if not tonumber(volume) then return end
            if v.isPlaying then
                xSound:setVolume(-1, v.name, volume)
            end
        end
    end
end)

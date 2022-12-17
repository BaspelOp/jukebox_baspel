Config = {}

--- Common settings ---
Config.Debug = true -- If you want debug in console
Config.DefaultVolume = 0.1 -- Accepted values are 0.01 - 1
Config.Distance = 5.0 -- Dont touch this
Config.interact_sound_file = 'mp3' -- Only mp3 :D

--- Target system ---
Config.ox_target = true -- If you want to use ox_target

--- Item ---
Config.Item = 'jukebox_coin' -- Name of the item which you need to play music

--- Locations ---
Config.Locations = {
    {
        name = 'tequila_jukebox', -- Name of jukebox zone
        model = `prop_50s_jukebox`, -- Model of jukebox, which you want use
        coords = vec4(-552.9935, 289.6083, 82.1762, 318.0644), -- Coordinates where menu will appear if you are nearby (only work without ox_target)
        coordsPlay = vec3(-552.9935, 289.6083, 82.1762), -- Coordinates same as coords, but wihout heading (last number)
        radius = 30, -- Playing music distance (radius)
        distance = 1, -- Menu appear distance
        isPlaying = false -- Dont touch this
    }
}

--- Language translate ---
Config.Language = {
    ['openMenu'] = '[E] - Open a Jukebox Menu',
    ['titleMenu'] = '💿 | Jukebox',
    ['jukeboxPlaylist'] = '🎵 | Jukebox Playlist',
    ['playSong'] = '🎶 | Play a song',
    ['playSongDesc'] = 'Play a song from playlist',
    -- ['pauseMusic'] = '⏸️ | Pause Music',
    -- ['pauseMusicDesc'] = 'Pause a currently playing music',
    -- ['resumeMusic'] = '▶️ | Resume Music',
    -- ['resumeMusicDesc'] = 'Resume playing paused music',
    ['changeVolume'] = '🔈 | Change Volume',
    ['changeVolumeDesc'] = 'Change volume of song',
    ['stopMusic'] = '❌ | Turn off music',
    ['stopMusicDesc'] = 'Stop the music & choose a new song',
    ['songSel'] = 'Song Selection',
    ['musicVolume'] = 'Music Volume',
    ['musicVolumeNm'] = 'Min: 0.01 - Max: 1' -- Pls dont change numbers (0.01 - 1)
}

--- Song configuration ---
Config.SongName = {
    --- First Song ---
    ['first'] = '💽 | Phao', -- Name of first song
    ['desc_first'] = 'Description of the song', -- Description of the song
    ['music_first_id'] = 'phao', -- ./sounds/name_of_the_song.mp3 without .mp3

    --- Second Song ---
    ['second'] = '💽 | Tokyo', -- Name of second song
    ['desc_second'] = 'Description of the song',
    ['music_second_id'] = 'tokyo',

    --- Third Song ---
    ['third'] = '💽 | Dancin', -- Name of third song
    ['desc_third'] = 'Description of the song',
    ['music_third_id'] = 'dancin',

    --- Fourth Song ---
    ['fourth'] = '💽 | Mess',
    ['desc_fourth'] = 'Description of the song',
    ['music_fourth_id'] = 'mess',

    --- Fifth Song ---
    ['fifth'] = '💽 | Fake ID',
    ['desc_fifth'] = 'Description of the song',
    ['music_fifth_id'] = 'fakeid'

    --- You can add or rewrite any song ---
}
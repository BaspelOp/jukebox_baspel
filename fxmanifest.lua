fx_version "cerulean"
game "gta5"

description 'Baspel'
version '1.0.0'

lua54 'yes'

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

files {
	"sounds/*.mp3",
}

dependencies {
    'es_extended',
    'ox_lib',
    'xsound'
}
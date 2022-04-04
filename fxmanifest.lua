fx_version 'cerulean'
game 'gta5'

author 'ciggies'
description 'Titan Security Job Script'
version '1.0.1'

shared_script 'config.lua'
server_script 'server.lua'
client_script {
	'client.lua',
	'heli.lua'
}

lua54 'yes'
fx_version 'cerulean'
game 'gta5'

author 'ciggies'
description 'Titan Security Job Script'
version '1.0.0'

shared_script 'config.lua'
server_script 'server.lua'
client_script {
	'client.lua',
	'heli.lua'
}

--[[ui_page 'html/index.html'

files {
	'html/*.html',
	'html/*.js',
	'html/*.png',
	'html/*.css',
}]]

lua54 'yes'
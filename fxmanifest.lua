fx_version 'cerulean'
game 'gta5'
version '1.0.0'
desription 'OX LIB CARMENU'
author 'Bandzukáč'
lua54 'yes'

dependencies {
    'ox_lib'
}

shared_scripts {
    '@ox_lib/init.lua',
    'locale/*.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'locale/*.lua'
}
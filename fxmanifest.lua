fx_version 'adamant'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'RSGCore'
description 'Theatre System for RSGCore'
version '1.0.0'

shared_scripts {
    '@rsg-core/shared/locale.lua',
    '@ox_lib/init.lua',
    'shared/config.lua'
}

client_scripts {
    
    'client/main.lua'
}

server_scripts {
    
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

dependencies {
    'rsg-core',
    'ox_lib',
    'oxmysql'
}

lua54 'yes'

fx_version 'cerulean'
game 'gta5'

author 'Pilath'
description 'Système de Baguette et de Sortilèges'
version '1.0.0'
lua54 'yes'

dependencies {
    'ox_inventory',
    'ox_lib',
    -- Autres dépendances
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',  -- Si vous utilisez oxmysql
    'server/spellwheel.lua'
}

client_scripts {
    'client/spellwheel.lua'
}
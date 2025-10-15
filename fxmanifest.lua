lua54 'yes'
fx_version 'cerulean'
game 'gta5'

author 'Cx-Developments <https://github.com/Cx-Developments>'
description 'Cx-RealSync 2.1 Rebuilt from the ground up'
version '2.1'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

client_scripts {
    'client/*.lua',
}

shared_scripts {
    'shared/datastore/*.lua',
    'shared/Functions/*.lua'
}

-- Load the Config.lua and the new modular server scripts.
-- The order is important here.
server_scripts {
    'Config.lua',
    'server/Validation.lua',
    'server/Core.lua',
    'server/Commands.lua',
    'server/Events.lua'
}
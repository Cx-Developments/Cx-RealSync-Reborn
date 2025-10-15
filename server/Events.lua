--[[
    Cx-RealSync-Reborn: Server Events
    This file handles events from the client, such as NUI callbacks.
--]]

-- Listen for players spawning to send them the current weather state
RegisterNetEvent("Cx-RealSync:RetriveData", QueryWeather)

-- NUI Admin Panel Events
RegisterServerEvent("Cx-RealSync:adminSetWeather")
AddEventHandler("Cx-RealSync:adminSetWeather", function(weatherType)
    if IsPlayerAceAllowed(source, "command.setweather") then
        manualWeather.WeatherType = weatherType
        manualOverride = true
        QueryWeather()
    end
end)

RegisterServerEvent("Cx-RealSync:adminSetRain")
AddEventHandler("Cx-RealSync:adminSetRain", function(rainLevel)
    if IsPlayerAceAllowed(source, "command.setweather") then
        manualWeather.Rain = rainLevel
        manualOverride = true
        QueryWeather()
    end
end)

RegisterServerEvent("Cx-RealSync:adminSetWind")
AddEventHandler("Cx-RealSync:adminSetWind", function(windSpeed, windDirection)
    if IsPlayerAceAllowed(source, "command.setweather") then
        manualWeather.WindSpeed = windSpeed
        manualWeather.WindDirection = windDirection
        manualOverride = true
        QueryWeather()
    end
end)
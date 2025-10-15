--[[
    Cx-RealSync-Reborn: Admin Commands
    This file contains all the server-side chat commands for weather control.
--]]

local function hasPermission(source)
    return source == 0 or IsPlayerAceAllowed(source, "command.setweather")
end

local function notifyNoPermission(source)
    TriggerClientEvent("chat:addMessage", source, {
        color = { 255, 0, 0 },
        multiline = true,
        args = { "[Cx-RealSync]", "You do not have permission to use this command." }
    })
end

RegisterCommand("setweather", function(source, args, rawCommand)
    if hasPermission(source) then
        manualWeather.WeatherType = table.concat(args, " ")
        manualOverride = true
        QueryWeather()
    else
        notifyNoPermission(source)
    end
end, false)

RegisterCommand("setrain", function(source, args, rawCommand)
    if hasPermission(source) then
        manualWeather.Rain = tonumber(args[1]) or 0.0
        manualOverride = true
        QueryWeather()
    else
        notifyNoPermission(source)
    end
end, false)

RegisterCommand("setwind", function(source, args, rawCommand)
    if hasPermission(source) then
        manualWeather.WindSpeed = tonumber(args[1]) or 0.0
        manualWeather.WindDirection = tonumber(args[2]) or 0.0
        manualOverride = true
        QueryWeather()
    else
        notifyNoPermission(source)
    end
end, false)

RegisterCommand("clearoverride", function(source)
     if hasPermission(source) then
        manualOverride = false
        QueryWeather()
     else
        notifyNoPermission(source)
     end
end, false)
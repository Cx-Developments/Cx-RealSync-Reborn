local nuiOpen = false
local overrideStatus = false

RegisterNetEvent("Cx-RealSync:updateOverrideStatus")
AddEventHandler("Cx-RealSync:updateOverrideStatus", function(status)
    overrideStatus = status
    SendNUIMessage({
        type = "updateStatus",
        status = overrideStatus
    })
end)

RegisterCommand("weather", function()
    nuiOpen = not nuiOpen
    SetNuiFocus(nuiOpen, nuiOpen)
    SendNUIMessage({
        type = "openNui",
        status = overrideStatus
    })
end, true) -- true for restricted to admins

RegisterNUICallback("setWeather", function(data, cb)
    TriggerServerEvent("Cx-RealSync:adminSetWeather", data.weatherType)
    cb("ok")
end)

RegisterNUICallback("setRain", function(data, cb)
    TriggerServerEvent("Cx-RealSync:adminSetRain", tonumber(data.rainLevel))
    cb("ok")
end)

RegisterNUICallback("setWind", function(data, cb)
    TriggerServerEvent("Cx-RealSync:adminSetWind", tonumber(data.windSpeed), tonumber(data.windDirection))
    cb("ok")
end)

RegisterNUICallback("closeNui", function(data, cb)
    nuiOpen = false
    SetNuiFocus(false, false)
    cb("ok")
end)
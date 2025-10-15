--[[
    Cx-RealSync-Reborn: Core Logic
    This file handles the main weather query loop and API interaction.
--]]

-- =============================================================================
-- Script Globals
-- =============================================================================
-- These are defined here to be accessible by other server modules.
manualOverride = false
manualWeather = {}
apiString = "http://api.weatherapi.com/v1/current.json?key=" .. (TimeWeatherConfiguration.ApiKey or "") .. "&q=" .. (TimeWeatherConfiguration.City or "")

-- =============================================================================
-- Core Weather Logic
-- =============================================================================
function QueryWeather()
    TriggerClientEvent("Cx-RealSync:updateOverrideStatus", -1, manualOverride)
    if not manualOverride then
        PerformHttpRequest(apiString, function (errorCode, resultData, resultHeaders)
            if errorCode == 200 then
                local decodedData = json.decode(resultData)
                if decodedData and decodedData.current then
                    local weatherCode = tonumber(decodedData.current.condition.code)
                    local weatherDef = Datastore.WeatherDefinitions[weatherCode]

                    if not weatherDef then
                        print("[Cx-RealSync-Reborn] Error: No weather definition found for code " .. weatherCode)
                        return
                    end

                    local TimeWeatherArray = {
                        WindSpeed = decodedData.current.wind_mph,
                        WindDirection = decodedData.current.wind_degree,
                        WeatherType = weatherDef.WeatherType,
                        Rain = weatherDef.WeatherRainAmount,
                        CurrentTime = TimeEpochConversion(decodedData.location.localtime_epoch),
                        UseLocalTime = TimeWeatherConfiguration.UseLocalTime
                    }
                    TriggerClientEvent("Cx-RealSync:RetriveData", -1, TimeWeatherArray)
                else
                    print("[Cx-RealSync-Reborn] Error: Invalid or incomplete weather data received from API.")
                end
            else
                print("[Cx-RealSync-Reborn] Error: HTTP request failed with code " .. errorCode .. ". Check your API key and city.")
            end
        end)
    else
        TriggerClientEvent("Cx-RealSync:RetriveData", -1, manualWeather)
    end
end

-- =============================================================================
-- Main Thread
-- =============================================================================
CreateThread(function()
    -- Stop the script if the configuration is invalid
    if not isConfigValid then
        print("[Cx-RealSync-Reborn] Shutting down due to critical configuration errors.")
        return
    end

    print("[Cx-RealSync-Reborn] Started successfully.")
    while true do
        QueryWeather()
        -- Convert refresh time from minutes to milliseconds
        Wait(TimeWeatherConfiguration.RefreshTime * 60000)
    end
end)
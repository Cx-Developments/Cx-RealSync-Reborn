--[[
    Cx-RealSync-Reborn: Configuration Validation
    This file validates the Config.lua settings before the script runs.
--]]

-- Global variable to be accessed by Core.lua
isConfigValid = false

CreateThread(function()
    -- Check if the configuration table exists
    if not TimeWeatherConfiguration or type(TimeWeatherConfiguration) ~= 'table' then
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print("!! ERROR: TimeWeatherConfiguration is missing from Config.lua !!")
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        return
    end

    -- Check for a valid API Key
    if not TimeWeatherConfiguration.ApiKey or TimeWeatherConfiguration.ApiKey == "" then
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print("!! [Cx-RealSync-Reborn] ERROR: API Key is missing from your Config.lua. !!")
        print("!! You can get a free key from https://www.weatherapi.com/signup.aspx   !!")
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        return
    end

    -- Check for a valid City
    if not TimeWeatherConfiguration.City or TimeWeatherConfiguration.City == "" then
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print("!! [Cx-RealSync-Reborn] ERROR: City is missing from your Config.lua. !!")
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        return
    end

    -- Check for a valid RefreshTime, otherwise default to 10 minutes
    if not TimeWeatherConfiguration.RefreshTime or type(TimeWeatherConfiguration.RefreshTime) ~= 'number' or TimeWeatherConfiguration.RefreshTime <= 0 then
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print("!! [Cx-RealSync-Reborn] WARNING: RefreshTime is invalid in Config.lua.      !!")
        print("!! Defaulting to 10 minutes.                                                !!")
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        TimeWeatherConfiguration.RefreshTime = 10 -- Default value
    end

    -- If all checks pass, set the global variable to true
    isConfigValid = true
end)
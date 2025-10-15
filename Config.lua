--[[
    Cx-RealSync-Reborn Configuration File
    --------------------------------------
    This file contains all the settings for the Cx-RealSync-Reborn script.
    Make sure to configure these settings before starting the script.
--]]

TimeWeatherConfiguration = {
    -- API Key from weatherapi.com
    -- You can get a free API key from https://www.weatherapi.com/signup.aspx
    ApiKey = "",

    -- The city to get the weather from.
    -- For example: "London", "New York", "Tokyo"
    City = "Tasmania",

    -- How often the script should refresh the weather and time, in minutes.
    -- The default is 10 minutes.
    RefreshTime = 10,

    -- Whether to use the local time of the server or the time from the API.
    -- If set to true, the script will use the server's local time.
    -- If set to false, it will use the time from the weather API for the specified city.
    UseLocalTime = false
}
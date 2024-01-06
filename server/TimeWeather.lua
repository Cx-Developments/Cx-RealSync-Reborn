local apiString = "http://api.weatherapi.com/v1/current.json?key=" .. TimeWeatherConfiguration.ApiKey .. "&q=" .. TimeWeatherConfiguration.City

function QueryWeather()
    PerformHttpRequest(apiString, function (errorCode, resultData, resultHeaders)
        _source = source or -1
        if errorCode == 200 then
            local decodedData = json.decode(resultData)
            if decodedData and decodedData.current then
                local TimeWeatherArray = { 
                --[[ Definitions
                    WindSpeed, The wind speed recorded.
                    WindDirection, The wind direction recorded (North, East, West, South).
                    WeatherType, Weather Code interger used for interpretation on client to find specific weather data.
                    Rain, Decyphered on client using the Weather Code Integer to find the rain amount.
                    LastWeather, Stores last used weather type definition.
                    CurrentTime, Current time in the city found using the real life Epoch time interger.
                    UseLocalTime, Defines whether or not to disable realistic time and to use GTA time.
                ]]
                    WindSpeed = decodedData.current.wind_mph,
                    WindDirection = decodedData.current.wind_degree,
                    WeatherType = Datastore.WeatherDefinitions[tonumber(decodedData.current.condition.code)].WeatherType,
                    Rain = Datastore.WeatherDefinitions[tonumber(decodedData.current.condition.code)].WeatherRainAmount,
                    CurrentTime = TimeEpochConversion(decodedData.location.localtime_epoch),
                    UseLocalTime = TimeWeatherConfiguration.UseLocalTime
                }
                TriggerClientEvent("Cx-RealSync:RetriveData", _source, TimeWeatherArray)
            else
                print("Error: Invalid or incomplete weather data")
            end
        else
            print("Error: HTTP request failed with code " .. errorCode)
        end
    end)
end


CreateThread(function()
    while true do
        QueryWeather()
        Wait(TimeWeatherConfiguration.RefreshTime)
    end
end)

RegisterNetEvent("Cx-RealSync:RetriveData", QueryWeather)
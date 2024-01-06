local apiString = "http://api.weatherapi.com/v1/current.json?key=" .. TimeWeatherConfiguration.ApiKey .. "&q=" .. TimeWeatherConfiguration.City

function QueryWeather()
    PerformHttpRequest(apiString, function (errorCode, resultData, resultHeaders)
        if errorCode == 200 then
            local decodedData = json.decode(resultData)
            if decodedData and decodedData.current then
                local TimeWeatherArray = {
                    WeatherType = decodedData.current.condition.code,
                    WindSpeed = decodedData.current.wind_mph,
                    WindDirection = decodedData.current.wind_degree
                }
                TriggerClientEvent("Cx-RealSync:RetriveData", -1, TimeWeatherArray)
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
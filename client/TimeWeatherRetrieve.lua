-- Define a set array to utilize within the code

function RetriveData(Data)
    local _Data = Data
    TimeWeatherArray["LastWeather"] = ShallowCopy(TimeWeatherArray["WeatherType"]) -- Makes Copy of the last Weather
    for k,v in pairs(_Data) do 
        TimeWeatherArray[k] = ShallowCopy(v)
    end
end

RegisterNetEvent("Cx-RealSync:RetriveData", RetriveData)

RegisterNetEvent('playerSpawned', function()
    TriggerServerEvent("Cx-RealSync:RetriveData")
end)
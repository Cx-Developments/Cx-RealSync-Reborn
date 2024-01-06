-- Define a set array to utilize within the code

function RetriveData(Data, UseLocalTime)
    TimeWeatherArray.UseLocalTime = ShallowCopy(UseLocalTime)
    local _Data = Data
    TimeWeatherArray["LastWeather"] = ShallowCopy(TimeWeatherArray["WeatherType"]) -- Makes Copy of the last Weather
    for k,v in pairs(_Data) do 
        TimeWeatherArray[k] = ShallowCopy(v)
    end
end

RegisterNetEvent("Cx-RealSync:RetriveData", RetriveData)
CreateThread(function()
	Wait(250)
	while true do
		Wait(33)
		if TimeWeatherArray.UseLocalTime == true then
			local Tick = GetGameTimer()
			if Tickcount <= Tick then
				local LocalYear, LocalMonth, LocalDay, LocalHour, LocalMinute, LocalSecond = GetLocalTime()
				TimeWeatherArray.CurrentTime = {Hour = LocalHour, Minute = LocalMinute, Second = LocalSecond}
				Tickcount = Tick+1500
			end
		end
		NetworkOverrideClockTime(TimeWeatherArray.CurrentTime.Hour, TimeWeatherArray.CurrentTime.Minute, TimeWeatherArray.CurrentTime.Second)
	end
end)

CreateThread(function()
    Wait(1000)
    while true do
        if TimeWeatherArray.LastWeather ~= TimeWeatherArray.WeatherType then
            TimeWeatherArray.LastWeather = TimeWeatherArray.WeatherType
            SetWeatherTypeOverTime(TimeWeatherArray.WeatherType, 15.0)
            SetRainLevel(TimeWeatherArray.Rain)
            Wait(15000)
        end
        Wait(100)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(TimeWeatherArray.LastWeather)
        SetWeatherTypeNow(TimeWeatherArray.LastWeather)
        SetWeatherTypeNowPersist(TimeWeatherArray.LastWeather)
        if TimeWeatherArray.WindSpeed and TimeWeatherArray.WeatherType ~= nil then
            local _WindSpeed, _WindDirection = TimeWeatherArray.WindSpeed, TimeWeatherArray.WindDirection
            SetWindSpeed(_WindSpeed > 0.0 and _WindSpeed or 0.0)
            SetWindDirection(_WindDirection > 0.0 and _WindDirection or 0.0)
            local IsXmasWeather = TimeWeatherArray.WeatherType == 'XMAS' -- Sets christmas trails and footsteps
            SetForceVehicleTrails(IsXmasWeather)
            SetForcePedFootstepsTracks(IsXmasWeather)
        end
    end
end)
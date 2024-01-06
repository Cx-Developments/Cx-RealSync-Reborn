function TimeEpochConversion(Epoch)
    local SplitTime, FormattedTime = {}, os.date("%H:%M:%S", Epoch)
    SplitTime.Hour, SplitTime.Minute, SplitTime.Second = FormattedTime:match("(%d+):(%d+):(%d+)")
    return SplitTime
end
Lib47.IsTimeOut = function(timeout)
    local startTime = GetGameTimer()
    if not timeout or type(timeout) ~= 'number' then
        timeout = 30 * 1000
    end
    return function()
        return (GetGameTimer() - startTime) > timeout
    end
end
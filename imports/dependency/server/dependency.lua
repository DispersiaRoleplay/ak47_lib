Lib47.EnsureDependency = function(name, quiet)
    if type(name) ~= 'string' then return false end
    
    if GetResourceState(name) == 'started' then
        return true
    end

    local state = GetResourceState(name)
    if state ~= 'missing' and state ~= 'started' then
        ExecuteCommand('start ' .. name)
        
        local timeout = 3000
        while GetResourceState(name) ~= 'started' and timeout > 0 do
            Wait(10)
            timeout = timeout - 1
        end

        if GetResourceState(name) == 'started' then
            return true
        end
    end

    if not quiet then
        print('^1[Lib47 Error] Could not find or start the required dependency: ' .. name .. '^0')
    end
    return false
end

Lib47.EnsureAnyDependency = function(resources)
    if type(resources) ~= 'table' then return false end
    local attempted = {}

    for _, name in pairs(resources) do
        if type(name) == 'string' and GetResourceState(name) == 'started' then
            return true 
        end
    end

    for _, name in pairs(resources) do
        if type(name) == 'string' then
            table.insert(attempted, name)
            
            if Lib47.EnsureDependency(name, true) then
                return true
            end
        end
    end

    if #attempted > 0 then
        print('^1[Lib47 Error] Could not find or start ANY of the acceptable dependencies: ' .. table.concat(attempted, ', ') .. '^0')
    end

    return false
end

Lib47.EnsureAllDependencies = function(resources)
    if type(resources) ~= 'table' then return false end
    local failed = {}

    for _, name in pairs(resources) do
        if type(name) == 'string' then
            if not Lib47.EnsureDependency(name, true) then
                table.insert(failed, name)
            end
        end
    end

    if #failed > 0 then
        print('^1[Lib47 Error] Failed to find or start the following required dependencies: ' .. table.concat(failed, ', ') .. '^0')
        return false
    end

    return true
end
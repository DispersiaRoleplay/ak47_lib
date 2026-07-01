Lib47.GetTargetMetaValue = function(targetServerId, metaKey)
    return Lib47.Callback.Await('ak47_lib:callback:server:GetTargetMetaValue', nil, targetServerId, metaKey)
end

Lib47.IsItemTypeWeapon = function(name)
    if not name then return false end
    return name:lower():find('weapon_')
end

exports('GetLibObject', function()
    return Lib47
end)


-- backward compatibility with ak47_bridge

local function oldExport(exportName, func)
    AddEventHandler(('__cfx_export_ak47_bridge_%s'):format(exportName), function(setCB)
        setCB(func)
    end)
end

oldExport('GetBridge', function() 
    return Lib47
end)

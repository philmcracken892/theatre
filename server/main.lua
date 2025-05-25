local RSGCore = exports['rsg-core']:GetCoreObject()


local ActiveShows = {}


local CLEANUP_INTERVAL = 60000 -- 1 minute
local MAX_SHOW_DURATION = 1800 -- 30 minutes

RegisterServerEvent('rdr-theatre:startSelectedShow')
AddEventHandler('rdr-theatre:startSelectedShow', function(selection)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    
    if not Player then return end

    
    
    
    if type(selection) == "table" then
        if not selection.name or not selection.town then
            TriggerClientEvent('ox_lib:notify', src, {
                type = 'error',
                description = 'Invalid movie selection!'
            })
            return
        end

       
        if ActiveShows[selection.town] then
            TriggerClientEvent('ox_lib:notify', src, {
                type = 'error',
                description = 'A movie is already playing in this town!'
            })
            return
        end

       
        TriggerClientEvent("rdr-theatre:startShow", -1, selection)
        ActiveShows[selection.town] = {
            type = "movie",
            name = selection.name,
            startTime = os.time(),
            startedBy = src
        }

    else
        
        if not Config.Shows[selection] then
            TriggerClientEvent('ox_lib:notify', src, {
                type = 'error',
                description = 'Invalid show selection!'
            })
            return
        end

        
        if ActiveShows[selection] then
            TriggerClientEvent('ox_lib:notify', src, {
                type = 'error',
                description = 'This show is already playing!'
            })
            return
        end

        
        TriggerClientEvent("rdr-theatre:startShow", -1, selection)
        ActiveShows[selection] = {
            type = "show",
            name = selection,
            startTime = os.time(),
            startedBy = src
        }
    end

    

    -- Notify player
    TriggerClientEvent('ox_lib:notify', src, {
        type = 'success',
        description = 'Show starting - please enjoy!'
    })
end)


RSGCore.Commands.Add('checkshows', 'Check currently running shows', {}, false, function(source)
    local Player = RSGCore.Functions.GetPlayer(source)
    
    
    if not Player.PlayerData.job.name == "theatre_manager" and not Player.PlayerData.job.name == "admin" then
        return
    end
    
   
    local activeShowCount = 0
    for location, data in pairs(ActiveShows) do
        activeShowCount = activeShowCount + 1
        local runningTime = math.floor((os.time() - data.startTime) / 60)
        
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'info',
            description = string.format('%s: %s (Running: %d mins)', 
                location,
                data.name or data.type,
                runningTime
            )
        })
    end
    
    if activeShowCount == 0 then
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'info',
            description = 'No shows currently running'
        })
    end
end)


CreateThread(function()
    while true do
        Wait(CLEANUP_INTERVAL)
        local currentTime = os.time()
        
        for location, data in pairs(ActiveShows) do
           
            if (currentTime - data.startTime) > MAX_SHOW_DURATION then
                ActiveShows[location] = nil
            end
        end
    end
end)
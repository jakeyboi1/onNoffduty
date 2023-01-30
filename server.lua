local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)


RegisterServerEvent("onduty")
AddEventHandler("onduty", function()
    local _source = source
    local player = VORPcore.getUser(_source).getUsedCharacter
    local job = player.job
    for k, v in pairs(Config.Jobs) do
        if job == v.offdutyjob then
            player.setJob(v.job)
            VORPcore.NotifyBottomRight(_source,"You went on duty",4000)
        elseif job == v.job then
            VORPcore.NotifyBottomRight(_source,"You are already on duty",4000)
        end
    end
end)



RegisterServerEvent("offduty")
AddEventHandler("offduty", function()
    local _source = source
    local player = VORPcore.getUser(_source).getUsedCharacter
    local job = player.job
    for k, v in pairs(Config.Jobs) do
        if job == v.job then
            player.setJob(v.offdutyjob)
            VORPcore.NotifyBottomRight(_source,"You went off duty",4000)
        elseif job ==v.offdutyjob then
            VORPcore.NotifyBottomRight(_source,"You are already off duty",4000)
        end
    end
end)
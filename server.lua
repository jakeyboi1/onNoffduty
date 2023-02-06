local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)


-- @param _src = player server source
-- @param state = true means on duty, false mean off duty
local function ChangeDuty(_src, state)
    local player = VORPcore.getUser(_src).getUsedCharacter
    local currentjob = player.job

    local jobcheck
    local jobswap
    local messages = {
        success = '',
        failure = ''
    }

    for k, v in pairs(Config.Jobs) do
        if state then
            jobcheck = v.offdutyjob
            jobswap = v.job
            messages.success = 'You went on duty'
            messages.failure = 'You are already on duty'
        else
            jobcheck = v.job
            jobswap = v.offdutyjob
            messages.success = 'You went off duty'
            messages.failure = 'You are already off duty'
        end

        if currentjob == jobcheck then
            player.setJob(jobswap)
            VORPcore.NotifyBottomRight(_src, messages.success, 4000)

            break --break out of the loop as you found what you wanted, no need to keep looping as this wastes resources.
        elseif currentjob == v.job then
            VORPcore.NotifyBottomRight(_src, messages.failure, 4000)

            break --break out of the loop as you found what you wanted, no need to keep looping as this wastes resources.
        end
    end
end

RegisterCommand("goingonduty", function(source, args, rawCommand)
    local _source = source
    ChangeDuty(_source, true)
    Text = 'Went on duty'
    Player = _source
    webhook()
end)

RegisterCommand("goingoffduty", function(source, args, rawCommand)
    local _source = source
    ChangeDuty(_source, false)
    Text = 'Went off duty'
    Player = _source
    webhook()
end)


function webhook(source)
    local _source = source --gets the players info
    local Character = VORPcore.getUser(Player).getUsedCharacter --Pulls the character info
    VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, Webhooklink, Text .. " " .. Character.job)
end

local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)





RegisterCommand('goingonduty', function()
    TriggerServerEvent('onduty')
end)




RegisterCommand('goingoffduty', function()
    TriggerServerEvent('offduty')
end)
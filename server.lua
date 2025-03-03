-- Server-side script para verificar permissões de admin
RegisterCommand('checkAdmin', function(source, args, rawCommand)
    local player = source
    local xPlayer = ESX.GetPlayerFromId(player)

    if xPlayer.getGroup() == 'admin' then
        TriggerClientEvent('chat:addMessage', player, {
            args = { 'Server', 'Você tem permissão de admin!' }
        })
    else
        TriggerClientEvent('chat:addMessage', player, {
            args = { 'Server', 'Você NÃO tem permissão de admin!' }
        })
    end
end, false)

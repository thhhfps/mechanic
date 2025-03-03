-- Variáveis
local isAdmin = false

-- Função para verificar se o jogador é administrador
Citizen.CreateThread(function()
    -- Verifique a permissão do jogador (ajuste conforme seu sistema de permissão)
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    ESX.GetPlayerData(function(data)
        if data.group == 'admin' then
            isAdmin = true
        end
    end)
end)

-- Comando para abrir o menu
RegisterCommand('bennys', function()
    if isAdmin then
        SetNuiFocus(true, true)  -- Foca na NUI (abre o menu)
        SendNUIMessage({
            type = 'openMenu',  -- Envia a mensagem para abrir o menu
        })
    else
        TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Você não tem permissão para usar este comando!' })
    end
end, false)

-- Fechar o menu (clicando fora ou pressionando ESC)
RegisterNUICallback('closeMenu', function(data, cb)
    SetNuiFocus(false, false)  -- Remove o foco da NUI
    cb('ok')
end)

-- Evento para aplicar os upgrades no carro
RegisterNUICallback('applyUpgrade', function(data, cb)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle and vehicle ~= 0 then
        if data.upgrade == 'engine' then
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, 11, data.level, false) -- Engine Upgrade
        elseif data.upgrade == 'brakes' then
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, 12, data.level, false) -- Brake Upgrade
        -- Adicione os upgrades de forma semelhante para os outros itens
        end
        TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Upgrades aplicados com sucesso!' })
    else
        TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Você não está em um veículo!' })
    end
    cb('ok')
end)

-- Fechar o menu ao pressionar ESC
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 177) then  -- ESC
            SetNuiFocus(false, false)  -- Remove o foco da NUI
            SendNUIMessage({ type = 'closeMenu' })  -- Fecha o menu
        end
    end
end)

local ox_inventory = exports.ox_inventory

-- Charger la roue de sorts du joueur
function LoadPlayerSpellWheel(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    -- Requête pour récupérer la roue de sorts
    MySQL.Async.fetchAll('SELECT * FROM user_spellwheel WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            TriggerClientEvent('spell:LoadSpellWheel', source, result[1])
        else
            -- Créer une nouvelle entrée si inexistante
            MySQL.Async.execute('INSERT INTO user_spellwheel (identifier) VALUES (@identifier)', {
                ['@identifier'] = identifier
            })
        end
    end)
end

-- Sauvegarder la roue de sorts du joueur
RegisterNetEvent('spell:SaveSpellWheel')
AddEventHandler('spell:SaveSpellWheel', function(spellWheel)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.execute([[
        UPDATE user_spellwheel 
        SET slot1 = @slot1, slot2 = @slot2, slot3 = @slot3, 
            slot4 = @slot4, slot5 = @slot5, slot6 = @slot6 
        WHERE identifier = @identifier
    ]], {
        ['@identifier'] = identifier,
        ['@slot1'] = spellWheel.slot1,
        ['@slot2'] = spellWheel.slot2,
        ['@slot3'] = spellWheel.slot3,
        ['@slot4'] = spellWheel.slot4,
        ['@slot5'] = spellWheel.slot5,
        ['@slot6'] = spellWheel.slot6
    })
end)

-- Charger la roue de sorts au spawn du joueur
AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    LoadPlayerSpellWheel(source)
end)
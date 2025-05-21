-- Adaptez selon votre framework
function LoadPlayerSpellWheel(source)
    local identifier = GetPlayerIdentifier(source)
    MySQL.Async.fetchAll('SELECT * FROM user_spellwheel WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            TriggerClientEvent('spell:LoadSpellWheel', source, result[1])
        else
            MySQL.Async.execute('INSERT INTO user_spellwheel (identifier) VALUES (@identifier)', {
                ['@identifier'] = identifier
            })
        end
    end)
end

RegisterNetEvent('spell:SaveSpellWheel')
AddEventHandler('spell:SaveSpellWheel', function(spellWheel)
    local identifier = GetPlayerIdentifier(source)
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
local spellWheel = {
    slot1 = nil,
    slot2 = nil,
    slot3 = nil,
    slot4 = nil,
    slot5 = nil,
    slot6 = nil
}

-- Fonction pour vérifier si la baguette est équipée
function IsWandEquipped()
    local playerPed = PlayerPedId()
    local currentWeapon = GetSelectedPedWeapon(playerPed)
    local wandHash = GetHashKey("weapon_magic_wand")  -- Assurez-vous que ce hash correspond à votre baguette
    
    return currentWeapon == wandHash
end

-- Fonction pour ouvrir l'interface de configuration de la roue
function OpenSpellWheelConfiguration()
    local menuElements = {}
    local inventory = exports.ox_inventory:GetInventory()

    -- Récupérer les sorts disponibles dans l'inventaire
    for _, item in ipairs(inventory) do
        local itemData = exports.ox_inventory:GetItemData(item.name)
        local spellData = itemData and itemData.client and itemData.client.spellData
        
        if spellData then
            table.insert(menuElements, {
                label = spellData.name,
                value = item.name,
                spellData = spellData
            })
        end
    end

    -- Créer l'interface de configuration
    local spellWheelMenu = {
        title = "Configuration Roue de Sorts",
        menu = 'spell_wheel_config'
    }

    -- Ajouter les emplacements de la roue
    for i = 1, 6 do
        table.insert(spellWheelMenu, {
            title = "Emplacement " .. i .. (spellWheel['slot'..i] and ": " .. spellWheel['slot'..i] or ""),
            description = "Cliquez pour assigner un sort",
            onSelect = function()
                -- Ouvrir un sous-menu pour sélectionner le sort
                local spellSelection = {}
                for _, element in ipairs(menuElements) do
                    table.insert(spellSelection, {
                        title = element.label,
                        description = "Assigner ce sort à l'emplacement " .. i,
                        onSelect = function()
                            spellWheel['slot'..i] = element.value
                            -- Sauvegarder immédiatement
                            TriggerServerEvent('spell:SaveSpellWheel', spellWheel)
                            OpenSpellWheelConfiguration() -- Rafraîchir le menu
                        end
                    })
                end

                lib.registerMenu({
                    id = 'spell_selection',
                    title = 'Sélection de Sort',
                    options = spellSelection
                })
                lib.showMenu('spell_selection')
            end
        })
    end

    -- Bouton de sauvegarde
    table.insert(spellWheelMenu, {
        title = "Sauvegarder",
        onSelect = function()
            TriggerServerEvent('spell:SaveSpellWheel', spellWheel)
            lib.notify({
                title = 'Roue de Sorts',
                description = 'Configuration sauvegardée',
                type = 'success'
            })
        end
    })

    lib.registerMenu({
        id = 'spell_wheel_config',
        title = "Configuration Roue de Sorts",
        options = spellWheelMenu
    })
    lib.showMenu('spell_wheel_config')
end

-- Charger la roue de sorts
RegisterNetEvent('spell:LoadSpellWheel')
AddEventHandler('spell:LoadSpellWheel', function(savedWheel)
    spellWheel = savedWheel
end)

-- Commande pour ouvrir la configuration
RegisterCommand('configspellwheel', function()
    OpenSpellWheelConfiguration()
end)

-- Fonction pour utiliser un sort de la roue
function UseSpellFromWheel(slotNumber)
    local spellItemName = spellWheel['slot'..slotNumber]
    if spellItemName then
        local itemData = exports.ox_inventory:GetItemData(spellItemName)
        local spellData = itemData and itemData.client and itemData.client.spellData
        
        if spellData then
            -- Logique de lancement de sort
            -- À adapter selon votre système de sorts
            print("Utilisation du sort : " .. spellItemName)
        end
    end
end

-- Gestion des raccourcis pour utiliser les sorts
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsWandEquipped() then
            -- Exemple de raccourcis (à adapter)
            if IsControlJustPressed(0, 157) then UseSpellFromWheel(1) end -- Touche 1
            if IsControlJustPressed(0, 158) then UseSpellFromWheel(2) end -- Touche 2
            -- Continuez pour les autres emplacements
        end
    end
end)
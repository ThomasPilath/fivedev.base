local currentSpell = nil
local lastSpellTime = 0

-- Initialisation des armes personnalisées
local function initializeCustomWeapons()
    for _, spell in ipairs(Config.Spells) do
        RegisterWeaponAsset(spell.weaponHash)
    end
    RegisterWeaponAsset(Config.WandWeaponHash)
end

-- Sélection du sort via roue
local function openSpellWheel()
    local spellOptions = {}
    
    for _, spell in ipairs(Config.Spells) do
        local count = exports.ox_inventory:Search('count', spell.item)
        if count > 0 then
            table.insert(spellOptions, {
                name = spell.name,
                label = spell.label,
                description = string.format("%s (Disponible: %d)", spell.label, count),
                icon = 'magic', -- Icône optionnelle
                onSelect = function()
                    currentSpell = spell
                    TriggerEvent('chat:addMessage', {
                        args = { "Sort sélectionné : " .. spell.label }
                    })
                end
            })
        end
    end

    exports.ox_lib:openMenu(spellOptions)
end

-- Lancer un sort
local function castSpell(spell)
    local playerPed = PlayerPedId()
    local currentTime = GetGameTimer()

    -- Vérification du cooldown
    if currentTime - lastSpellTime < spell.cooldown then
        return
    end

    -- Obtenir les coordonnées de départ et la direction
    local startCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 1.0, 0.5)
    local aimCoords = GetGameplayCamCoord() + GetGameplayCamRot(2) * 100.0

    -- Créer le projectile
    local spellProjectile = CreateObject(spell.weaponHash, startCoords, true, true, false)
    local spellObject = spellProjectile
    
    -- Application de la force et de la direction
    local force = GetGameplayCamRot(2)
    ApplyForceToEntityWorldSpace(spellObject, force.x, force.y, force.z)

    -- FX de traînée
    StartParticleFxLoopedAtCoord(
        spell.fx.trail, 
        startCoords.x, 
        startCoords.y, 
        startCoords.z, 
        0.0, 0.0, 0.0, 
        1.0, false, false, false
    )

    -- Dernier temps de lancement
    lastSpellTime = currentTime

    -- Événement de suivi du projectile
    Citizen.CreateThread(function()
        local timeout = 10000  -- 10 secondes max
        local startTime = GetGameTimer()

        while DoesEntityExist(spellObject) and GetGameTimer() - startTime < timeout do
            Citizen.Wait(100)
            
            -- Vérifier collision
            local hasCollided, hitCoords = GetEntityHasCollided(spellObject)
            if hasCollided then
                -- FX d'impact
                StartParticleFxLoopedAtCoord(
                    spell.fx.impact, 
                    hitCoords.x, 
                    hitCoords.y, 
                    hitCoords.z, 
                    0.0, 0.0, 0.0, 
                    1.0, false, false, false
                )
                
                -- Suppression du projectile
                DeleteObject(spellObject)
                break
            end
        end

        -- Suppression forcée si timeout
        if DoesEntityExist(spellObject) then
            DeleteObject(spellObject)
        end
    end)
end

-- Boucle principale
Citizen.CreateThread(function()
    initializeCustomWeapons()
    
    while true do
        Citizen.Wait(0)
        
        local playerPed = PlayerPedId()
        local currentWeapon = GetSelectedPedWeapon(playerPed)

        -- Vérifier si la baguette est équipée
        if currentWeapon == Config.WandWeaponHash then
            -- Touche F pour roue des sorts
            if IsControlJustPressed(0, 23) then  -- F
                openSpellWheel()
            end

            -- Tirer avec le sort sélectionné
            if IsControlJustPressed(0, 24) and currentSpell then  -- Clic gauche
                castSpell(currentSpell)
            end
        end
    end
end)

-- Gestion de l'utilisation de la baguette
AddEventHandler('ox_inventory:useItem', function(data)
    if data.item == 'wand' then
        -- Donner la baguette comme arme
        GiveWeaponToPed(PlayerPedId(), Config.WandWeaponHash, 0, false, true)
        SetCurrentPedWeapon(PlayerPedId(), Config.WandWeaponHash, true)
    end
end)
-- Aucune suppression d'item lors de l'utilisation
AddEventHandler('ox_inventory:usedItem', function(source, item)
    -- Optionnel : Logs ou vérifications supplémentaires
    print(string.format("Item utilisé : %s par %s", item.name, source))
end)
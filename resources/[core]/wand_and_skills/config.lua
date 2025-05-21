Config = {
    WandWeaponHash = `weapon_wand`, -- Hash personnalisé pour la baguette
    Spells = {
        {
            name = "fireball",
            label = "Boule de Feu",
            item = "fireball_spell",
            weaponHash = `weapon_fireball`, -- Hash unique pour chaque sort
            damage = 25,
            range = 100.0,
            cooldown = 5000,
            fx = {
                trail = "scr_fbi3_fire",
                impact = "scr_exp_grnd"
            }
        },
        {
            name = "icebolt",
            label = "Éclair de Glace", 
            item = "icebolt_spell",
            weaponHash = `weapon_icebolt`,
            damage = 20,
            range = 80.0,
            cooldown = 3000,
            fx = {
                trail = "scr_mg_blast",
                impact = "scr_exp_water"
            }
        }
    }
}
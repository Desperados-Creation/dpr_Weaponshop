------------------------------------------------------------------------------------------------
-- Script par Desperados#0001                                                                 -- 
-- Lien du discord pour toute mes créations: https://discord.gg/dkHFBkBBPZ                    --
-- Lien du github pour télécharger le script: https://github.com/Desperados-Creation/dpr_Shop --
------------------------------------------------------------------------------------------------

Config = {
    blip = true, -- Affichage du blip (true = oui, false = non)

    BlipId = 110, -- Id du blip voir: https://wiki.gtanet.work/index.php?title=Blips
    BlipTaille = 0.7, -- Taille du blip
    BlipCouleur = 17, -- Couleur du blip voir: https://wiki.gtanet.work/index.php?title=Blips
    BlipRange = true, -- Garder le blip sur la map (true = désactiver, false = activé)

    Text = "Appuyer sur ~o~[E] ~s~pour accèder à ~o~l'armurie ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 

    ArmeBlanche = {
        {Label = 'Couteau', Weapon = 'WEAPON_KNIFE', Price = 900},
        {Label = 'Machette', Weapon = 'WEAPON_MACHETE', Price = 1250},
        {Label = 'Lampe Torche', Weapon = 'WEAPON_FLASHLIGHT', Price = 200},
        {Label = 'Batte de baseball', Weapon = 'WEAPON_BAT', Price = 800},
        {Label = 'Poing américain', Weapon = 'WEAPON_KNUCKLE', Price = 900},
    },

    Accessoire = {
        {Label = 'Lampe', Item = 'flashlight', Price = 100},
        {Label = 'Silencieux', Item = 'silencieux', Price = 900},
        {Label = 'Poignée', Item = 'grip', Price = 700},
        {Label = 'Skin de luxe', Item = 'yusuf', Price = 3000},
    },

    Divers = {
        {Label = 'Jerrican d\'essence', Weapon = 'WEAPON_PETROLCAN', Price = 600},
        {Label = 'Parachute', Weapon = 'gadget_parachute', Price = 1000},
    },


    positionWeaponshop = { -- Position des shop sur la map
        InteractZone = {
            vector3(-3171.70, 1087.66, 19.83),
            vector3(2567.6, 294.3, 108.7),
            vector3(22.0, -1107.2, 29.8),
            vector3(252.3, -50.0, 69.9),
            vector3(-330.2, 6083.8, 31.4),
            vector3(1693.4, 3759.5, 34.7),
            vector3(-662.1, -935.3, 21.8)
        }
    }
}
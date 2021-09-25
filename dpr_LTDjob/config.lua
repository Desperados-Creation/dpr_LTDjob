Config = {
    BlipLTD = true, -- Affichage du blip (true = oui, false = non)

    BlipLTDId = 52, -- Id du blip voir: https://wiki.gtanet.work/index.php?title=Blips
    BlipLTDTaille = 0.9, -- Taille du blip
    BlipLTDCouleur = 5, -- Couleur du blip voir: https://wiki.gtanet.work/index.php?title=Blips
    BlipLTDRange = true, -- Garder le blip sur la map (true = désactiver, false = activé)
    BlipLTDName = "LTD",

    MarkerType = 21, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
    MarkerSizeLargeur = 0.7, -- Largeur du marker
    MarkerSizeEpaisseur = 0.7, -- Épaisseur du marker
    MarkerSizeHauteur = 0.7, -- Hauteur du marker
    MarkerDistance = 6.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)
    MarkerColorR = 88, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerColorG = 201, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerColorB = 26, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerOpacite = 180, -- Opacité du marker (min: 0, max: 255)
    MarkerSaute = true, -- Si le marker saute (true = oui, false = non)
    MarkerTourne = true, -- Si le marker tourne (true = oui, false = non)

    Text = "Appuyer sur ~g~[E] ~s~pour accèder au ~g~stock ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 
    TextCoffre = "Appuyer sur ~g~[E] ~s~pour accèder au ~g~coffre ~s~!",
    TextBoss = "Appuyer sur ~g~[E] ~s~pour accèder au action ~g~patron ~s~!",

    StockItem = {
        {Name = "Pain", Item = "bread", Price = 3},
        {Name = "Sandwitch", Item = "sandwitch", Price = 3},
        {Name = "PastaBox", Item = "pastabox", Price = 3},

        {Name = 'Bouteille d\'eau', Item = 'water', Price = 3},
        {Name = 'Jus d\'orange', Item = 'jusdorange', Price = 3},
        {Name = 'Fruit shoot', Item = 'fruitshoot', Price = 3}, 
        {Name = 'Capri Sun', Item = 'carpisun', Price = 3}, 
    },

    Positions = {
        Stock = {vector3(24.36, -1346.72, 29.49)},
        Coffre = {vector3(25.63, -1339.31, 29.49)},
        Boss = {vector3(29.04, -1339.71, 29.49)}
    }
}
Config = {}

Config.RandomTransitions = false

Config.Shows = Globals.Shows
Config.Projections = Globals.Projections
Config.Movies = Globals.Movies

Config.Curtains = {
	["SAINTDENIS"] = vector3(2546.522, -1307.835, 48.26664)
}

Config.Soundsets = {
	["Curtain_Open_Music"] = "3160317806_action",
	["Curtain_Opens_Music"] = "2245181467_action",
	["Escape_Noose_Curtain_Music"] = "4224921010_action"
}



Config.Prompts = {
    {
        id = "open_curtain",
        label = "Open Curtain or /theatre for a show",
        control = 0xF3830D8E, -- j key
        time = 1000
    },
    {
        id = "close_curtain",
        label = "Close Curtain",
        control = 0xF3830D8E, -- j key
        time = 1000
    }
}


Config.CreatedEntries = {}
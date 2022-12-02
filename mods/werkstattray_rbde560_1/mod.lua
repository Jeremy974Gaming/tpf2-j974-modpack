function data()
return {
	info = {
		minorVersion = 0.1, -- minor version, count up from 0
		severityAdd = "NONE", -- OPTIONAL "NONE", "WARNING" or "CRITICAL"
		severityRemove = "WARNING", -- OPTIONAL "NONE", "WARNING" or "CRITICAL"
		name = _("name_mod_560"), -- OPTIONAL mod name
		description = _("desc_mod_560"), -- OPTIONAL description
		authors = { -- OPTIONAL one or multiple authors
		{
            name = "Werkstatt",
            role = "CREATOR",
            text = "Mapping, Script, Textures",
            steamProfile = "",
            tfnetId = 23787,
        },
        {
            name = "MaikC",
            role = "CO_CREATOR",
            text = "3D Model",
	        steamProfile = "",
            tfnetId = 21205,
        },
		{
            name = "Ray",
            role = "BASED_ON",
            text = "3D Model, Original Creator",
	        steamProfile = "",
            tfnetId = 19685,
        },
		{
            name = "Mark_86",
            role = "CO_CREATOR",
            text = "3D Model",
	        steamProfile = "",
            tfnetId = 28341,
        },
	},
		tags = { "train", "passenger", "waggon", "switzerland", "rbde560", "NPZ", "Domino", "sbb", "mthb", "inova", "rbde 4/4" }, -- OPTIONAL "vehicle", "bus", "tram", "train", "steam", "diesel", "electric", "railcar", "wagon", "passenger", "goods", "building", "station", "deco", "town", "depot", "signal", "tool", "pack" or similar tags
		tfnetId = 0, -- OPTIONAL transport-fever-net download id
		minGameVersion = 1.0
	},
}
end
local modId = "sd70m_autorack" -- eindeutige modID vergeben.
local hiddenFiles = {}
local function filterDoHideFiles(fileName, data)
	for i = 1, #hiddenFiles do
		if (string.ends(fileName, hiddenFiles[i])) then
			return false
		end
	end
	return true
end

local noStartYearFiles = {}
local noEndYearFiles = {}
local function modifierDoYears(fileName, data)
	for i = 1, #noStartYearFiles do
		if (string.ends(fileName, noStartYearFiles[i])) then
			data.metadata.availability.yearFrom = 0
		end
	end
	for i = 1, #noEndYearFiles do
		if (string.ends(fileName, noEndYearFiles[i])) then
			data.metadata.availability.yearTo = 0
		end
	end
	
	return data
end

local yearFiles = {
			"vehicle/waggon/autorack.mdl", 	
			"vehicle/waggon/autorack_rev.mdl",
}

local modData = {
	defaultSettings = {	},	
	general = {
		hideFiles = { 
						"vehicle/waggon/sd70m_autorack_group.mdl", 
					},
		},
}			

function data()
return {
info = {
  minorVersion = 2,
  severityAdd = "NONE",
  severityRemove = "CRITICAL",
  name = _("mod_name"),
  description = _("mod_desc"),
  authors = {
    {
		name = 'SD70M',
		role = 'CREATOR',
		text = "Model",
		tfnetId = 29228,
    },
  },
  tags = {"usa","Wagon","Autorack","Vehicle","Carrier"},
  		visible = true,
		
-- Parameter für User-Ingame-Selection
					params = {
						-- Startjahr ab 1850
						{
							key = "sd70m_autorack_startyear", -- eindeutigen key vergeben
							name = _("desc_sd70m_startyear"), -- wird in der strings.lua auch übersetzt
							values = { _("Default"), _("desc_sd70m_startyear_1850"), }, -- Default bedeutet das die in der mdl eingetragenen Wert verwendet werden
							tooltip = _(""),
							defaultIndex = 0, -- Es wird standardmäßig der in der mdl eingetragene Wert verwendet
						},
 
						-- unendlich verfügbar
						{
							key = "sd70m_autorack_endyear", -- eindeutigen key vergeben
							name = _("desc_sd70m_endyear"),
							values = { _("Default"), _("desc_sd70m_endyear_infinite"), },
							tooltip = _(""),
							defaultIndex = 0,
						}, 
						{
							key = "sd70m_autorack",
							name = _("Bi-Level Autorack"),
							values = { _("desc_sd70m_show"), _("desc_sd70m_hide"), },
							tooltip = _("desc_sd70m_options"),
							defaultIndex = 0,
						},
						{
							key = "sd70m_autorack_rev",
							name = _("Bi-Level Autorack reversible"),
							values = { _("desc_sd70m_show"), _("desc_sd70m_hide"), },
							tooltip = _("desc_sd70m_options"),
							defaultIndex = 0,
						},
					}, -- params schliessen
				}, -- info schliessen
				
			runFn = function(settings, modParams)
				-- Mod-Parameter holen
				local params = modParams[getCurrentModId()]
				-- Wenn vorhanden....
				if params then
					if ((params.sd70m_autorack or 0) == 1) then
						table.insert(hiddenFiles, "vehicle/waggon/autorack.mdl")
					end
					if ((params.sd70m_autorack_rev or 0) == 1) then
						table.insert(hiddenFiles, "vehicle/waggon/autorack_rev.mdl")
					end
					
					-- Startjahr setzen
					if (params.sd70m_autorack_startyear or 1) == 1  then
						for i = 1, #yearFiles do
							table.insert(noStartYearFiles, yearFiles[i])
						end
					end
					-- Endjahr setzen
					if (params.sd70m_autorack_endyear or 1) == 1  then 
						for i = 1, #yearFiles do
							table.insert(noEndYearFiles, yearFiles[i])
						end
					end	
				
					-- Wenn Tabelle "hiddenFiles" nicht leer, FileFilter hinzufügen
					if (#hiddenFiles > 0) then
						addFileFilter("model/vehicle", filterDoHideFiles)
					end
				
					-- Modifier laden, falls Tabelle für "kein Endjahr" und/oder "kein Startjahr" nicht leer
					if ((#noEndYearFiles > 0) or (#noStartYearFiles > 0)) then
						addModifier("loadModel", modifierDoYears)
					end
				end

			end
 	}
end			
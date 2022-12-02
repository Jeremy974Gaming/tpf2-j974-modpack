eat1963_track_package_1_debug = false
local devMode = false

local global = require "eatglobal_v1_16"
local utils = global.utils
local transf = global.transf
local modutils = global.modutils
local modMinorVersion = 5
local modPath = utils.getModPath()

local logFn
if eat1963_track_package_1_debug then
	logFn = utils.createLogFn ("[eat1963_track_package - mod.lua]")
else
	logFn = function(...) end
end


local defaultConfig = {
	modMinorVersion = modMinorVersion,
	moduloSpeedFilter = {
		["full"] = 1,
		["extended"] = 10,
		["basic"] = 20,
	},
	speedFilter = {
		{
			value = "full",
			modulo = 1,
			default = false,
			text = "Volles Gleispaket",
		},
		{
			value = "extended",
			modulo = 10,
			default = true,
			text = "Erweitertes Gleispaket",
		},
		{
			value = "basic",
			modulo = 20,
			default = false,
			text = "Einfaches Gleispaket",
		},
		{
			value = "simple",
			modulo = 50,
			default = false,
			text = "Simples Gleispaket",
		},
		{
			value = "spartan",
			modulo = 100,
			default = false,
			text = "Spartanisches Gleispaket (ala MaikC :D )",
		},
	},
	availableTrackWidths = {
		{
			value = 750,
			default = true,
		},
		{
			value = 760,
			default = false,
		},
		{
			value = 1000,
			default = true,
		},
		{
			value = 1435,
			default = false,
		},
		{
			value = 1520,
			default = false,
		},
	},
	catenaryHeights = {
		["default"] = {
			catenaryBase = 5.917,
			catenaryHeight = 1.35,
			catenaryPoleDistance = 25.0,
			catenaryPoleModel = "railroad/eat1963_heigth_default_power_pole_2.mdl",
			catenaryMultiPoleModel = "railroad/eat1963_heigth_default_power_pole_1.mdl",
			catenaryMultiGirderModel = "railroad/eat1963_heigth_default_power_pole_1a.mdl",
			catenaryMultiInnerPoleModel = "railroad/eat1963_heigth_default_power_pole_1b.mdl",
			default = false,
			text = "Oberleitungshöhe Normalspur",
			zFactorUg = 1.02,
			zFactor = 1,
		},
		["tram"] = {
			catenaryBase = 4.787,
			catenaryHeight = 1.18,
			catenaryPoleDistance = 20.0,
			catenaryPoleModel = "railroad/eat1963_heigth_tram_power_pole_2.mdl",
			catenaryMultiPoleModel = "railroad/eat1963_heigth_tram_power_pole_1.mdl",
			catenaryMultiGirderModel = "railroad/eat1963_heigth_tram_power_pole_1a.mdl",
			catenaryMultiInnerPoleModel = "railroad/eat1963_heigth_tram_power_pole_1b.mdl",
			default = true,
			text = "Oberleitungshöhe TRAM",
			zFactorUg = 1.04,
			zFactor = 1.02,
		},
		["rhb"] = {
			catenaryBase = 5.5,
			catenaryHeight = 1.35,
			catenaryPoleDistance = 25.0,
			catenaryPoleModel = "railroad/eat1963_heigth_rhb_power_pole_2.mdl",
			catenaryMultiPoleModel = "railroad/eat1963_heigth_rhb_power_pole_1.mdl",
			catenaryMultiGirderModel = "railroad/eat1963_heigth_rhb_power_pole_1a.mdl",
			catenaryMultiInnerPoleModel = "railroad/eat1963_heigth_rhb_power_pole_1b.mdl",
			default = false,
			text = "Oberleitungshöhe Rhätische Bahn",
			zFactorUg = 1.02,
			zFactor = 1.01,
		},
	},
	powerPoleHandling = {
		ugDefaultLodFile = "ugpowerpoledata.lua",
		userPowerPoleInstalled = false,
		lods = {},
	},
}

local modId = "eat1963_track_package"
local function getConfig ()
	if global.configs.existsConfig (modId) then
		return global.configs.getConfig (modId)
	else
		return global.configs.createConfig(modId, defaultConfig)
	end
end

local function getDefaultUserSettings()
	local config = getConfig()
	local result = {}
	local order = 1
	-- Auswahl Spurweiten
	result.trackPackageWidths = {
		type ="table",
		name = _("name_eat1963_TP_trackPackageWidths"),
		description = _("desc_eat1963_TP_trackPackageWidths"),
		values = {},
		default = {},
		multiSelect = true,
		order = order,
	}
	for i = 1, #config.availableTrackWidths do
		local entry = {
			value = config.availableTrackWidths[i].value,
			text = string.format(_("Spurweite %u mm"), config.availableTrackWidths[i].value),
		}
		table.insert(result.trackPackageWidths.values, entry)
		if config.availableTrackWidths[i].default then
			table.insert(result.trackPackageWidths.default, config.availableTrackWidths[i].value)
		end
	end
	order = order + 1
	
	result.trackPackageType = {
		type ="table",
		name = _("name_eat1963_TP_trackPackageType"),
		description = _("desc_eat1963_TP_trackPackageType"),
		values = {},
		default = {},
		multiSelect = false,
		order = order,
	}
	for i = 1, #config.speedFilter do
		local entry = {
			value = config.speedFilter[i].value,
			text = _(config.speedFilter[i].text),
		}
		table.insert(result.trackPackageType.values, entry)
		if config.speedFilter[i].default then
			table.insert(result.trackPackageType.default, config.speedFilter[i].value)
		end
	end
	order = order + 1
	
	result.catenaryHeights = {
		type ="table",
		name = _("name_eat1963_TP_catenaryHeights"),
		description = _("desc_eat1963_TP_catenaryHeights"),
		values = {},
		default = {},
		multiSelect = false,
		order = order,
	}
	for k, v in pairs(config.catenaryHeights) do
		local entry = {
			value = k,
			text = _(v.text),
		}
		table.insert(result.catenaryHeights.values, entry)
		if v.default then
			table.insert(result.catenaryHeights.default, k)
		end
	end
	order = order + 1
	
	-- Alle Normal-Gleise (1435 mm) in eigene Kategorie verschieben.
	result.enable1435mmTransfer = {
			type ="boolean",
			name = _("name_eat1963_TP_enable1435mmTransfer"),
			description = _("desc_eat1963_TP_enable1435mmTransfer"),
			default = true,
			--image = "res/textures/ui/tpfmm/1435 mm.tga",
			order = order,
		}
	order = order + 1
	
	-- Alle Gleise, welche nicht zum Mod gehören und deren Spurweite im Mod aktiv ist ausblenden?!
	result.disableOtherTracksWithSameWidth = {
			type ="boolean",
			name = _("name_eat1963_TP_disableOtherTracksWithSameWidth"),
			description = _("desc_eat1963_TP_disableOtherTracksWithSameWidth"),
			default = true,
			--image = "res/textures/ui/tpfmm/1435 mm.tga",
			order = order,
		}
	order = order + 1
		
	-- Die Weichenlaternen von @Jansch aktvieren
	result.enableJanschLaterne = {
			type ="boolean",
			name = _("name_eat1963_TP_enableJanschLaterne"),
			description = _("desc_eat1963_TP_enableJanschLaterne"),
			default = true,
			--image = "res/textures/ui/tpfmm/1435 mm.tga",
			order = order,
		}
	order = order + 1
		
	-- Bahnhöfe und Depot aktivieren
	result.enableStations = {
			type ="boolean",
			name = _("name_eat1963_TP_enableStations"),
			description = _("desc_eat1963_TP_enableStations"),
			default = false,
			--image = "res/textures/ui/tpfmm/1435 mm.tga",
			order = order,
		}
	order = order + 1
		
	-- Bahnhöfe und Depot aktivieren
	result.disableUGStations = {
			type ="boolean",
			name = _("name_eat1963_TP_disableUGStations"),
			description = _("desc_eat1963_TP_disableUGStations"),
			default = false,
			--image = "res/textures/ui/tpfmm/1435 mm.tga",
			order = order,
		}
	order = order + 1
		
	return result
end

local function getSettings ()
	if global.userSettings.existsSettings (modId) then
		return global.userSettings.getSettings (modId)
	else
		return global.userSettings.create(modId, getDefaultUserSettings())
	end
end

local trackData = {
	tracks = {
	},
	trackWidths = {
	},
}

local function initTrackData()
	if (type(trackData) ~= 'table') then
		trackData = {}
	end
	if (type(trackData.tracks) ~= 'table') then
		trackData.tracks = {}
	end
	if (type(trackData.trackWidths) ~= 'table') then
		trackData.trackWidths = {}
	end
end

--- globale Gleis-API
if not devMode then
	-- sozusagen die Filterabteilung :D
	local trackFilters = {
	}
	local trackWidthsFilters = {
	}
	local function initFilters()
		local config = getConfig()
		local userSettings = getSettings()
		-- Gleisfilter (Geschwindigkeiten)
		local function getModuloSpeedFilter(packageType)
			for i = 1, #config.speedFilter do
				if (packageType == config.speedFilter[i].value) then
					return config.speedFilter[i].modulo
				end
			end
			return config.speedFilter[1].modulo
		end
		
		config.moduloSpeedFilterSelected = getModuloSpeedFilter(userSettings.trackPackageType[1])
		table.insert(trackFilters, function (tbl, key, data) return ((data.speedLimitCalculated % config.moduloSpeedFilterSelected) == 0) end)
		
		-- Spurweitenfilter
		local function checkTrackPackageWidths()
			config.trackPackageWidthsSelected = {}
			for i = 1, #config.availableTrackWidths do
				if utils.indexOf(userSettings.trackPackageWidths, config.availableTrackWidths[i].value) > 0 then
					table.insert(config.trackPackageWidthsSelected, config.availableTrackWidths[i].value)
				end
			end
			if #config.trackPackageWidthsSelected == 0 then
				table.insert(config.trackPackageWidthsSelected, config.availableTrackWidths[1].value)
			end
		end
		checkTrackPackageWidths()
		
		table.insert(trackFilters,
			function (tbl, key, data)
				return (utils.indexOf(config.trackPackageWidthsSelected, data.railTrackWidthCalculated) > 0)
			end
		)
		table.insert(trackWidthsFilters,
			function (tbl, key, value)
				return (utils.indexOf(config.trackPackageWidthsSelected, value) > 0)
			end
		)
	end
	initFilters()
	
	local function pairsTableTracks(filterFn, sortFn)
		local filter = utils.copyTable(trackFilters)
		if (type(filterFn) == "function") then
			table.insert(filter, filterFn)
		end
		
		return utils.sortPairs(trackData.tracks, sortFn, filter)
	end

	local function pairsTableTrackWidths()
		local function doSort(t, a, b)
			return t[a] < t[b]
		end
		return utils.sortPairs(trackData.trackWidths, doSort, trackWidthsFilters)
	end
	
	local function pairsTableSameTracksPerWidth(trackWidth)
		local function doSort(t, a, b)
			return trackData.tracks[t[a]].speedLimitCalculated < trackData.tracks[t[b]].speedLimitCalculated
		end
		local function doFilter(tbl, key, value)
			for i = 1, #trackFilters do
				if not trackFilters[i](tbl, key, trackData.tracks[value]) then
					return false
				end
			end
			return true
		end
		return utils.sortPairs(trackData.sameTracksPerWidth[trackWidth], doSort, doFilter)
	end
	
	-- öffentliche API
	eat1963_track_api = {
	}

	function eat1963_track_api.getTrackWidths()
		local result = {}
		for k, v in pairsTableTrackWidths() do
			result[#result + 1] = v
		end
		return result
	end

	function eat1963_track_api.getTrackSpeeds (trackWidth)
		local function doFilter(k, v)
			return v.railTrackWidthCalculated == trackWidth
		end
		local function doSort(t, a, b)
			return t[a].speedLimitCalculated < t[b].speedLimitCalculated
		end
		local result = {}
		for k, v in pairsTableTracks(doFilter, doSort) do
			result[#result + 1] = v.speedLimitCalculated
		end
		return result
	end

	function eat1963_track_api.getTrackFiles (filterFn, sortFn)
		local function doStandardSort(t, a, b)
			return (a.railTrackWidth < b.railTrackWidth) or ((a.railTrackWidth == b.railTrackWidth) and (a.speedLimitCalculated < b.speedLimitCalculated))
		end
		local function doSort(t, a, b)
			if (type(sortFn) == "function") then
				return sortFn(t, trackData.tracks[a], trackData.tracks[b])
			else
				return doStandardSort(t, trackData.tracks[a], trackData.tracks[b])
			end
		end
		
		local result = {}
		for k in pairsTableTracks(filterFn, doSort) do
			result[#result + 1] = k
		end
		return result
	end

	function eat1963_track_api.getTrackFilesWidthsSameTrackSpeeds()
		return trackData.sameTracksPerWidth
	end

	function eat1963_track_api.getTrackData(fileName)
		return trackData.tracks[fileName]
	end

	local function getParamsEntryIndex(paramsResult, key)
		for i = 1, #paramsResult do
			if (paramsResult[i].key == key) then
				return i
			end
		end
		return #paramsResult + 1
	end

	local function setParamsEntry(paramsResult, entry, insertIndex)
		if (type(paramsResult) == "table") then
			for i = 1, #paramsResult do
				if (paramsResult[i].key == entry.key) then
					paramsResult[i] = entry
					return
				end
			end
			if (insertIndex ~= nil) then
				table.insert(paramsResult, insertIndex, entry)
			else
				paramsResult[#paramsResult + 1] = entry
			end
		end
	end

	function eat1963_track_api.modifyTrackCatenary ( paramsResult, trackFileList, filterFn)
		local trackWidths = {}
		local function getCaption(data)
			local sWidth = tostring(math.round(data.railTrackWidth * 1000))
			local sSpeed = tostring(math.round(data.speedLimit * 3.6))
			if (trackWidths[sWidth] == nil) then
				trackWidths[sWidth] = true
				return sWidth.." mm .."..sSpeed
			else
				return ".."..sSpeed
			end
		end
		----
		local function fillTrackFiles(trackFiles)
			for i = 1, #trackFileList do
				trackFileList[i] = nil
			end
			for i = 1, #trackFiles do
				trackFileList[#trackFileList + 1] = trackFiles[i]
			end
		end
		----
		local function buildTrackEntry(trackFiles)
			local result = {
				key = "trackType",
				name = _("Track type"),
				values = { },
				yearFrom = 0,
				yearTo = 0,
			}
			for i = 1, #trackFiles do
				local data = trackData.tracks[trackFiles[i]]
				
				result.values[#result.values + 1] = getCaption(data)
			end
			
			return result
		end
		----
		
		if (type(paramsResult) == "table") and (type(trackFileList) == "table") then
			-- caternary
			setParamsEntry(paramsResult, 
				{
					key = "catenary",
					name = _("Catenary"),
					values = { _("No"), _("Yes") },
					defaultIndex = 1,
					yearFrom = 1910,
					yearTo = 0
				}
			)
			
			-- tracks
			local trackFiles = eat1963_track_api.getTrackFiles(filterFn)
			fillTrackFiles(trackFiles)
			setParamsEntry(paramsResult, buildTrackEntry(trackFiles), getParamsEntryIndex(paramsResult, "catenary"))
		end
	end

	function eat1963_track_api.modifyTrackCatenaryEx ( paramsResult )
		local trackWidths = {}
		for k, v in pairsTableTrackWidths() do
			trackWidths[#trackWidths + 1] = k
		end

		local speedLimits = {}
		for k, v in pairsTableSameTracksPerWidth(trackWidths[1]) do
			speedLimits[#speedLimits + 1] = trackData.tracks[v].speedLimitCalculated
		end
		
		local function buildTrackEntry()
			local result = {
				key = "trackType",
				name = _("Track type"),
				values = { },
				yearFrom = 0,
				yearTo = 0,
			}
			for i = 1, #speedLimits do
				result.values[#result.values + 1] = tostring(speedLimits[i])
			end
			
			return result
		end
		----
		local function buildTrackWidthEntry()
			return {
				key = "eat1963_trackWidth",
				name = _("Spurweite"),
				values = trackWidths,
				yearFrom = 0,
				yearTo = 0,
			}
		end
		----
		-- caternary
		setParamsEntry(paramsResult, 
			{
				key = "catenary",
				name = _("Catenary"),
				values = { _("No"), _("Yes") },
				defaultIndex = 0,
				yearFrom = 1910,
				yearTo = 0
			}
		)
			
		-- tracks
		setParamsEntry(paramsResult, buildTrackEntry(), getParamsEntryIndex(paramsResult, "catenary"))
			
		-- trackWidths
		setParamsEntry(paramsResult, buildTrackWidthEntry(), getParamsEntryIndex(paramsResult, "trackType"))
		
		local result = {}
		local function getTrackWidth(params)
			return trackWidths[(params.eat1963_trackWidth or 0) + 1]
		end
		function result.getTrackTypes(params)
			local result = {}
			for k, v in pairsTableSameTracksPerWidth(getTrackWidth(params)) do
				result[#result + 1] = v
			end
			return result
		end
		function result.getTrackFile(params)	
			local trackTypes = {}
			for k, v in pairsTableSameTracksPerWidth(getTrackWidth(params)) do
				trackTypes[#trackTypes + 1] = v
			end
			return trackTypes[(params.trackType or 0) + 1]
		end
		function result.getCatenary(params)
			return ((params.catenary or 0) == 1)
		end
		result.getTrackWidth = getTrackWidth
		
		return result
	end
end
---------------

local function ixFile(files, fileName)
	for i = 1, #files do
		if string.ends(fileName, files[i]) then
			return i
		end
	end
		
	return 0
end

local function isFile(files, fileName)
	return (ixFile(files, fileName) > 0)
end

local function isEATTrack(fileName)
	return string.find(fileName, modPath.."res/config/track/eat1963_")
end

local function trackHandlerDisableTracks(fileName, data, key)
	local userSettings = getSettings()
	if (key == "loadTrack") then
		local railTrackWidth = data.railTrackWidth * 1000
		if ((utils.indexOf(userSettings.trackPackageWidths, railTrackWidth) > 0) and (not isEATTrack(fileName))) then
			data.yearTo = 1800
		end
	end
	
	return data
end

local function trackHandler1435(fileName, data)
	local files = {
		"res/config/track/standard.lua",
		"res/config/track/high_speed.lua",
	}
	--[[
	local userSettings = getSettings()
	if (utils.indexOf(userSettings.trackPackageWidths, 1435) > 0) and isFile(files, fileName) then
		data.yearTo = 1800
	end
	]]

	if ((data.railTrackWidth * 1000) == 1435) then
		data.categories = { string.format("%u mm",  1435) }
	end
	
	return data
end

local function trackHandlerJanschLaterne(fileName, data)
	if isEATTrack(fileName) then
		if ((data.yearTo == nil) or (data.yearTo == 0) or (data.yearTo >= 1850)) then
			if (math.round(data.speedLimit * 3.6) < 160) then
				data.switchSignalModel = "railroad/eat_jansch_switchbox_old.mdl"
			else
				data.switchSignalModel = "railroad/eat_jansch_switchbox_new.mdl"
			end
		end
	end
	
	return data
end

local function trackFilterSpeed(fileName, data)
	local files = {
		"res/config/track/standard.lua",
		"res/config/track/high_speed.lua",
	}
	--[[
	local userSettings = getSettings()
	if (utils.indexOf(userSettings.trackPackageWidths, 1435) > 0) and isFile(files, fileName) then
		data.yearTo = 1800
	end
	]]
	if string.find(fileName, modPath.."res/config/track/eat1963_") then
		local config = getConfig()
		return ((math.round(data.speedLimit * 3.6) % config.moduloSpeedFilterSelected) == 0) and 
			(utils.indexOf(config.trackPackageWidthsSelected, data.railTrackWidth * 1000) > 0)
	end
	
	return true
end

local function stationFilter(fileName, data)
	local files = {
		"res/construction/station/rail/eat1963_railstation_cargo_multispur.con",
		"res/construction/station/rail/eat1963_railstation_passenger_multilspur.con",
		"res/construction/depot/eat1963_traindepot_multispur.con",
	}
	
	return not isFile(files, fileName)
end

local ugCatenaryLods = {}
local catenaryFiles = {
	"res/models/model/railroad/power_pole_1.mdl",
	"res/models/model/railroad/power_pole_1a.mdl",
	"res/models/model/railroad/power_pole_1b.mdl",
	"res/models/model/railroad/power_pole_2.mdl",
}

local function trackHandlerDevMode(fileName, data)
	local config = getConfig()
	----
	local function isValidFile()
		local validFiles = {
			modPath.."res/config/track/eat1963_",
		}
		for i = 1, #validFiles do
			if string.find(fileName, validFiles[i]) then
				return ((data.yearTo == nil) or (data.yearTo == 0) or (data.yearTo >= 1850))
			end
		end
		return false
	end
	----
	if isValidFile() then
		data.speedLimitCalculated = math.round(data.speedLimit * 3.6)
		data.railTrackWidthCalculated = math.round(data.railTrackWidth * 1000)
		trackData.tracks[utils.getFileName(fileName)] = data
		trackData.trackWidths[tostring(data.railTrackWidthCalculated)] = data.railTrackWidthCalculated
		
		utils.saveData(trackData, modPath.."trackdata.lua")
	else
		---	Datei mit den Standard-Lods der UG-Oberleitungs-mdl erstellen.
		--		Zum Erstellen KEINE Oberleitungsmod installieren!!!
		local ix = ixFile(catenaryFiles, fileName)
		if (ix > 0) then
			ugCatenaryLods[catenaryFiles[ix]] = data.lods
			utils.saveData(ugCatenaryLods, modPath..config.powerPoleHandling.ugDefaultLodFile)
		end
	end
	
	return data
end

local function stationModifier(fileName, data)
	local files = {
		-- Stations
		"res/construction/station/rail/cargo_1850_head.con",
		"res/construction/station/rail/cargo_1850_through.con",
		"res/construction/station/rail/passenger_1850_head.con",
		"res/construction/station/rail/passenger_1850_through.con",
		"res/construction/station/rail/passenger_1920_head.con",
		"res/construction/station/rail/passenger_1920_through.con",
		"res/construction/station/rail/passenger_1990_head.con",
		"res/construction/station/rail/passenger_1990_through.con",
		-- Depot(s)
		"res/construction/depot/train_small_old.con",
	}
	
	if isFile(files, fileName) then
		data.availability.yearFrom = 1800
		data.availability.yearTo = 1800
	end
	
	return data
end

-----------------
local function getCatenaryLods(params)
--fileId, catenaryId, ugScale, modScale
	logFn("getCatenaryLods | params = ", params)
	local config = getConfig()
	local lods = utils.copyTable(config.powerPoleHandling.lods["installed"][params.fileId])
	if (type(lods) ~= "table") then
		lods = {
			{
				animations = { },
				children = { },
				events = { },
				matConfigs = { },
				static = false,
				visibleFrom = 0,
				visibleTo = 5,
			}, 
		}
	end
	--logFn("getCatenaryLods | lods = ", lods)
	local scale
	if config.powerPoleHandling.userPowerPoleInstalled then
		scale = params.modScale
	else
		scale = params.ugScale
	end
	logFn("getCatenaryLods | config.powerPoleHandling.userPowerPoleInstalled = ", config.powerPoleHandling.userPowerPoleInstalled)
	logFn("getCatenaryLods | scale = ", scale)
	
	for i = 1, #lods do
		for j = 1, #lods[i].children do
			lods[i].children[j].transf = transf.setScale(lods[i].children[j].transf, scale)
		end
	end

	return lods
end

local function dataHandlerCatenary(fileName, data, key)
	local ugDefaultMeshFiles = {
		["res/models/model/railroad/power_pole_1.mdl"] = {
			"railroad/lod_2_power_pole_1_pole.msh",
			"railroad/lod_2_power_pole_1_start.msh",
			"railroad/lod_1_power_pole_1_pole.msh",
			"railroad/lod_1_power_pole_1_start.msh",
			"railroad/lod_0_power_pole_1_pole.msh",
			"railroad/lod_0_power_pole_1_start.msh",
		},
		["res/models/model/railroad/power_pole_1a.mdl"] = {
			"railroad/lod_2_power_pole_1a_repeat.msh",
			"railroad/lod_1_power_pole_1a_repeat.msh",
			"railroad/lod_0_power_pole_1a_repeat.msh",
		},
		["res/models/model/railroad/power_pole_1b.mdl"] = {
			"railroad/lod_2_power_pole_1b_pole2.msh",
			"railroad/lod_1_power_pole_1b_pole2.msh",
			"railroad/lod_0_power_pole_1b_pole2.msh",
		},
		["res/models/model/railroad/power_pole_2.mdl"] = {
			"railroad/lod_2_power_pole_2.msh",
			"railroad/lod_1_power_pole_2.msh",
			"railroad/lod_0_power_pole_2.msh",
		},
	}
	---	Daten sammeln und feststellen, ob ein Oberleitungsmod installiert ist.
	local function isChanged(meshList)
		local countFounded = 0
		for i = 1, #data.lods do
			for j = 1, #data.lods[i].children do
				if isFile(meshList, data.lods[i].children[j].id) then
					countFounded = countFounded + 1
				end
			end
		end
		
		return (countFounded ~= #meshList)
	end

	local ix = ixFile(catenaryFiles, fileName)
	if (ix > 0) and isChanged(ugDefaultMeshFiles[catenaryFiles[ix]]) then
		local config = getConfig()
		config.powerPoleHandling.userPowerPoleInstalled = true
		config.powerPoleHandling.lods["installed"][catenaryFiles[ix]] = data.lods
	end
	
	return data
end

local function trackHandlerRepair(fileName, data)
	if string.find(fileName, modPath.."res/config/track/eat1963_") then
		local fileName = utils.getFileName(fileName)
		
		local railTrackWidth = math.round(data.railTrackWidth * 1000)
		if (railTrackWidth == 750) or (railTrackWidth == 760) then
			-- Gleisabstand 750 mm und 760 mm
			--data.trackDistance = 4.55
			data.trackDistance = 5.0
			
			-- Schotterbett 750 mm und 760 mm
			data.shapeWidth = 4.0
			data.shapeStep = 4.0
			
			-- Standardprellbock durch skalierten Prellbock ersetzen
			data.bumperModel = "railroad/eat1963_bumper_750.mdl"
			
			-- Tabelle "trackData" aktualisieren
			if (type(trackData.tracks[fileName]) == "table") then
				trackData.tracks[fileName].trackDistance = data.trackDistance
				trackData.tracks[fileName].shapeWidth = data.shapeWidth
				trackData.tracks[fileName].shapeStep = data.shapeStep
				trackData.tracks[fileName].bumperModel = data.bumperModel
			end
		end
		if (railTrackWidth == 1000) then
			-- Standardprellbock durch skalierten Prellbock ersetzen
			data.bumperModel = "railroad/eat1963_bumper_1000.mdl"
			
			-- Tabelle "trackData" aktualisieren
			if (type(trackData.tracks[fileName]) == "table") then
				trackData.tracks[fileName].bumperModel = data.bumperModel
			end
		end
		if (railTrackWidth == 1520) then
			-- Standardprellbock durch skalierten Prellbock ersetzen
			data.bumperModel = "railroad/eat1963_bumper_1520.mdl"
			
			-- Tabelle "trackData" aktualisieren
			if (type(trackData.tracks[fileName]) == "table") then
				trackData.tracks[fileName].bumperModel = data.bumperModel
			end
		end
		
		--- Anpassungen Oberleitungen
		local userSettings = getSettings()
		local config = getConfig()
		local entry
		if (railTrackWidth == 750) or (railTrackWidth == 760) or (railTrackWidth == 1000) then
			entry = config.catenaryHeights[userSettings.catenaryHeights[1]]
		else
			entry = config.catenaryHeights["default"]
		end
		if (type(entry) == "table") then
			data.catenaryBase = entry.catenaryBase + data.railBase + data.railHeight
			data.catenaryHeight = entry.catenaryHeight
			data.catenaryPoleDistance = entry.catenaryPoleDistance
			data.catenaryPoleModel = entry.catenaryPoleModel
			data.catenaryMultiPoleModel = entry.catenaryMultiPoleModel
			data.catenaryMultiGirderModel = entry.catenaryMultiGirderModel
			data.catenaryMultiInnerPoleModel = entry.catenaryMultiInnerPoleModel
			
			-- Tabelle "trackData" aktualisieren
			if (type(trackData.tracks[fileName]) == "table") then
				trackData.tracks[fileName].catenaryBase = data.catenaryBase
				trackData.tracks[fileName].catenaryHeight = data.catenaryHeight
				trackData.tracks[fileName].catenaryPoleDistance = data.catenaryPoleDistance
				trackData.tracks[fileName].catenaryPoleModel = data.catenaryPoleModel
				trackData.tracks[fileName].catenaryMultiPoleModel = data.catenaryMultiPoleModel
				trackData.tracks[fileName].catenaryMultiGirderModel = data.catenaryMultiGirderModel
				trackData.tracks[fileName].catenaryMultiInnerPoleModel = data.catenaryMultiInnerPoleModel
			end
		end

	end

	return data
end

function data()
	return {
		info = {
			minorVersion = modMinorVersion,
			severityAdd = "NONE",
			severityRemove = "CRITICAL",
			name = _("name_eat1963_TP"),
			description = _("dest_eat1963_TP"),
			authors = {
				{
						name = "EAT1963",
						role = "CREATOR",
						text = "Modell, Idee",
						steamProfile = "http://steamcommunity.com/profiles/76561198052411779",
						tfnetId = 19725,
				},
			},
			tags = { "Tracks", "Gleise" },
			tfnetId = 4663,
			--steamId = 0,
			url = "https://www.transportfever.net/filebase/index.php/Entry/4663-Multispur-Gleispaket/",
		},
		settings = getDefaultUserSettings(),
		
		runFn = function(settings)
			local config = getConfig()
			if (devMode == true) then
				addModifier("loadTrack", trackHandlerDevMode)
			else
				trackData = utils.readData(modPath.."trackdata.lua")
				
				if not trackData.buildTables then
					--- Tabelle "trackData.trackWidthsBlank" erstellen
					trackData.trackWidthsBlank = {}
					for k in utils.sortPairs(trackData.trackWidths, function(t, a, b) return trackData.trackWidths[a] < trackData.trackWidths[b] end) do
						trackData.trackWidthsBlank[#trackData.trackWidthsBlank + 1] = k
					end
					
					--- Tabelle "trackData.tracksPerWidth" erstellen
					trackData.tracksPerWidth = {}
					for k in pairs(trackData.trackWidths) do
						trackData.tracksPerWidth[k] = {}
					end
					
					for k, v in pairs(trackData.tracks) do
						local sTrackWidth = tostring(v.railTrackWidthCalculated)
						table.insert(trackData.tracksPerWidth[sTrackWidth], k)
					end
					for k, v in pairs(trackData.tracksPerWidth) do
						table.sort(v, function (a, b) return math.round(trackData.tracks[a].speedLimit * 3.6) < math.round(trackData.tracks[b].speedLimit * 3.6) end)
					end
					
					--- Tabelle "trackData.sameTracksPerWidth" erstellen
					trackData.sameTracksPerWidth = {}
					for k in pairs(trackData.trackWidths) do
						trackData.sameTracksPerWidth[k] = {}
					end
					local temp = {}
					for k, v in pairs(trackData.tracksPerWidth) do
						table.insert(temp, v)
					end
					
					local maxIx = #temp[1]
					
					for i = 1, #temp do
						maxIx = math.min(maxIx, #temp[i])
					end
					for i = 1, maxIx do
						local testResult = true
						local testValue = trackData.tracks[temp[1][i]].speedLimitCalculated
						for j = 1, #temp do
							testResult = trackData.tracks[temp[j][i]].speedLimitCalculated == testValue
						end
						if testResult then
							for j = 1, #temp do
								local sTrackWidth = tostring(trackData.tracks[temp[j][i]].railTrackWidthCalculated)
								table.insert(trackData.sameTracksPerWidth[sTrackWidth], temp[j][i])
							end
						end
					
					end
					
					--- Tabelle "trackData.yearsFrom" erstellen
					local function insertYear(year)
						for i = 1, #trackData.yearsFrom do
							if (trackData.yearsFrom[i] == year) then
								return
							end
						end
						table.insert(trackData.yearsFrom, year)
					end
					trackData.yearsFrom = {}
					for k, v in pairs(trackData.tracks) do
						insertYear(v.yearFrom or 0)
					end
					table.sort(trackData.yearsFrom)
					---
					trackData.buildTables = true
					utils.saveData(trackData, modPath.."trackdata.lua")
				end
				addFileFilter("track", trackFilterSpeed)
				
				--- "Reparatur"-Handler
				addModifier("loadTrack", trackHandlerRepair)

				--- Catenary-Handling
				-- Modifier registrieren, welcher am Ende aller anderen Modifier ausgeführt wird
				modutils.registerGlobalModifier("loadModel", dataHandlerCatenary, false)
				
				-- Im Dev-Mode erstellte UG-Catenary-Lods einlesen
				local lods = utils.readData(modPath..config.powerPoleHandling.ugDefaultLodFile)
				config.powerPoleHandling.lods["ug"] = utils.copyTable(lods)
				config.powerPoleHandling.lods["installed"] = utils.copyTable(lods)
				
				-- Lod-Funktion für eigene power_pole_xxx.mdl zuweisen
				config.powerPoleHandling.getCatenaryLods = getCatenaryLods
			end
			
			------
			local userSettings = getSettings()
			if userSettings.enable1435mmTransfer then
				addModifier("loadTrack", trackHandler1435)
			end
			
			if userSettings.disableOtherTracksWithSameWidth then
				modutils.addCommonApiSavedModifier(trackHandlerDisableTracks)
			end
			
			if userSettings.enableJanschLaterne then
				addModifier("loadTrack", trackHandlerJanschLaterne)
			end
			if (not userSettings.enableStations) then
				addFileFilter("construction", stationFilter)
			elseif (userSettings.disableUGStations and (utils.indexOf(userSettings.trackPackageWidths, 1435) > 0)) then
				--	Vanille Bahnhöfe und Depot(s) ausblenden, wenn:
				--		Bahnhöfe und Depots des Mod's vom User aktiviert wurden
				--		der User die Option zum Ausblenden gewählt hat
				--		der User Normalspurgleise aktiviert hat
				modutils.registerGlobalModifier("loadConstruction", stationModifier, false)
			end
		end
	}
end

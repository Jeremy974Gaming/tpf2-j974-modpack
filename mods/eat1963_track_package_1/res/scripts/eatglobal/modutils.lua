--- File-Filter
-- @author Enno Sylvester
-- @copyright 2019
-- @module eatglobal.modutils

local modutils = {
	version = "1.2",
}

local function init ()
	-- globale Daten
	if type(eat1963_global_data) ~= "table" then
		eat1963_global_data = {}
	end
	-- modutils
	if type(eat1963_global_data.modutils) ~= "table" then
		eat1963_global_data.modutils = {}
	end
	-- globale Filter und Modifier
	if type(eat1963_global_data.modutils.filefilter) ~= "table" then
		eat1963_global_data.modutils.filefilter = {}
		eat1963_global_data.modutils.filefilter.origApplyModifiers = nil
		eat1963_global_data.modutils.filefilter.origApplyFileFilters = nil
	end
	if type(eat1963_global_data.modutils.filefilter.globalModifier) ~= "table" then
		eat1963_global_data.modutils.filefilter.globalModifier = {}
	end
	if type(eat1963_global_data.modutils.filefilter.globalFileFilter) ~= "table" then
		eat1963_global_data.modutils.filefilter.globalFileFilter = {}
	end
	
	-- Filterobjects
	if type(eat1963_global_data.modutils.filterObjects) ~= "table" then
		eat1963_global_data.modutils.filterObjects = {
			filterRegistered = false,
		}
	end
	if type(eat1963_global_data.modutils.filterObjects.data) ~= "table" then
		eat1963_global_data.modutils.filterObjects.data = {}
	end
	
	--	Modifier-Objects
	if type(eat1963_global_data.modutils.modifierObjects) ~= "table" then
		eat1963_global_data.modutils.modifierObjects = {
			handlerRegistered = false,
		}
	end
	if type(eat1963_global_data.modutils.modifierObjects.data) ~= "table" then
		eat1963_global_data.modutils.modifierObjects.data = {}
	end
end

---	Registriert einen Modifier, welcher VOR (runBeforeAllModifiers == true) oder
---	NACH (runBeforeAllModifiers == false) allen anderen Modifiern ausgeführt wird.
--		@modutils.registerGlobalModifier
--		@param key
--		@param runFn
--		@param runBeforeAllModifiers
--		@return ./.
--
--		Gültige Werte für key:
--			loadModel, loadMultipleUnit, loadStreet, loadTrack, loadBridge, loadTunnel, loadRailroadCrossing,
--			loadConstruction, loadSoundSet
--
--		Parameter für runFn:
--			fileName, data, key
--		runFn MUSS gülige "data" zurückgeben!!!
function modutils.registerGlobalModifier (key, runFn, runBeforeAllModifiers)
	local function myApplyModifiers(key, fileName, data)
		local function _doIt(data, runBefore)
			local modifiers = eat1963_global_data.modutils.filefilter.globalModifier[key] or {}
			for i = 1, #modifiers do
				local entry = modifiers[i]
				if ((type(entry) == "table") and (entry.runBefore == runBefore)) then
					data = entry.runFn(fileName, data, key)
				end
			end
			
			return data
		end
		
		data = _doIt(data, true)
		data = eat1963_global_data.modutils.filefilter.origApplyModifiers(key, fileName, data)
		data = _doIt(data, false)
		
		return data
	end
	--------
	
	init()
	
	if (eat1963_global_data.modutils.filefilter.origApplyModifiers == nil) then
		eat1963_global_data.modutils.filefilter.origApplyModifiers = applyModifiers
		applyModifiers = myApplyModifiers
	end
	
	if (type(eat1963_global_data.modutils.filefilter.globalModifier[key]) ~= "table") then
		eat1963_global_data.modutils.filefilter.globalModifier[key] = {}
	end
	eat1963_global_data.modutils.filefilter.globalModifier[key][#eat1963_global_data.modutils.filefilter.globalModifier[key] + 1] = {
		runFn = runFn,
		runBefore = runBeforeAllModifiers or false,
	}
end

---	Registriert eine Funktion, welcher VOR (runBeforeAllModifiers == true) oder
---	NACH (runBeforeAllModifiers == false) allen anderen File-Filtern ausgeführt wird.
---	Kann verwendet werden um z.B. Daten zu sammeln, welche Dateien durch Filter
---	aussortiert wurden.
--		@modutils.registerGlobalFileFilter
--		@param key
--		@param runFn
--		@param runBeforeAllModifiers
--		@return ./.
--
--		Gültige Werte für key:
--			model/vehicle, model/tree, model/industry, model/other, 
--			multipleUnit, street, track, bridge, tunnel, railroadCrossing, construction, autoGroundTex
--
--		Parameter für runFn:
--			fileName, data, result, key
--		Keine Rückgabe für runFn.


function modutils.registerGlobalFileFilter (key, runFn, runBeforeAllFileFilters)
	local function myApplyFileFilters(key, fileName, data)
		local function _doIt(runBefore, result)
			local filters = eat1963_global_data.modutils.filefilter.globalFileFilter[key] or {}
			for i = 1, #filters do
				local entry = filters[i]
				if ((type(entry) == "table") and (entry.runBefore == runBefore)) then
					entry.runFn(fileName, data, result, key) 
				end
			end
		end

		local result = true
		_doIt(true, result)
		result = eat1963_global_data.modutils.filefilter.origApplyFileFilters(key, fileName, data)
		_doIt(false, result)

		return result
	end
	--------
	
	init()
	
	if (eat1963_global_data.modutils.filefilter.origApplyFileFilters == nil) then
		eat1963_global_data.modutils.filefilter.origApplyFileFilters = applyFileFilters
		applyFileFilters = myApplyFileFilters
	end
	
	if (type(eat1963_global_data.modutils.filefilter.globalFileFilter[key]) ~= "table") then
		eat1963_global_data.modutils.filefilter.globalFileFilter[key] = {}
	end
	eat1963_global_data.modutils.filefilter.globalFileFilter[key][#eat1963_global_data.modutils.filefilter.globalFileFilter[key] + 1] = {
		runFn = runFn,
		runBeforeAllFileFilters = runBeforeAllModifiers or false,
	}
end

---	Filterobjects
local function filterHideObjects(fileName, data, key)
	local result = true
	for i = 1, #eat1963_global_data.modutils.filterObjects.data do
		if (type(eat1963_global_data.modutils.filterObjects.data[i].runFn) == "function") then
			result = eat1963_global_data.modutils.filterObjects.data[i].runFn(fileName, data, key)
		end
	end
	
	return result
end

local function filterModel(fileName, data)
	return filterHideObjects(fileName, data, "loadModel")
end
local function filterMultipleUnit(fileName, data)
	return filterHideObjects(fileName, data, "loadMultipleUnit")
end
local function filterStreet(fileName, data)
	return filterHideObjects(fileName, data, "loadStreet")
end
local function filterTrack(fileName, data)
	return filterHideObjects(fileName, data, "loadTrack")
end
local function filterBridge(fileName, data)
	return filterHideObjects(fileName, data, "loadBridge")
end
local function filterTunnel(fileName, data)
	return filterHideObjects(fileName, data, "loadTunnel")
end
local function filterRailroadCrossing(fileName, data)
	return filterHideObjects(fileName, data, "loadRailroadCrossing")
end
local function filterConstruction(fileName, data)
	return filterHideObjects(fileName, data, "loadConstruction")
end
local function filterAutoGroundTex(fileName, data)
	return filterHideObjects(fileName, data, "loadAutoGroundTex")
end

local function registerHideFilters()
	if (not eat1963_global_data.modutils.filterObjects.filterRegistered) then
		addFileFilter("model/vehicle", filterModel)
		addFileFilter("model/tree", filterModel)
		addFileFilter("model/industry", filterModel)
		addFileFilter("model/other", filterModel)
		addFileFilter("multipleUnit", filterMultipleUnit)
		addFileFilter("street", filterStreet)
		addFileFilter("track", filterTrack)
		addFileFilter("bridge", filterBridge)
		addFileFilter("tunnel", filterTunnel)
		addFileFilter("railroadCrossing", filterRailroadCrossing)
		addFileFilter("construction", filterConstruction)
		addFileFilter("autoGroundTex", filterAutoGroundTex)
		
		eat1963_global_data.modutils.filterObjects.filterRegistered = true
	end
end

function modutils.addFileFilter(runFn)
	init()
	registerHideFilters()
	eat1963_global_data.modutils.filterObjects.data[#eat1963_global_data.modutils.filterObjects.data + 1] = {
		runFn = runFn,
	}
end

---	Modifier-Objects
local function modelHandler(fileName, data, key)
	for i = 1, #eat1963_global_data.modutils.modifierObjects.data do
		if (type(eat1963_global_data.modutils.modifierObjects.data[i].runFn) == "function") then
			data = eat1963_global_data.modutils.modifierObjects.data[i].runFn(fileName, data, key)
		end
	end
	
	return data
end

local function modelsHandler(fileName, data)
	return modelHandler(fileName, data, "loadModel")
end
local function multipleUnitHandler(fileName, data)
	return modelHandler(fileName, data, "loadMultipleUnit")
end
local function streetHandler(fileName, data)
	return modelHandler(fileName, data, "Street")
end
local function trackHandler(fileName, data)
	return modelHandler(fileName, data, "loadTrack")
end
local function bridgeHandler(fileName, data)
	return modelHandler(fileName, data, "loadBridge")
end
local function tunnelHandler(fileName, data)
	return modelHandler(fileName, data, "loadTunnel")
end
local function railroadCrossingHandler(fileName, data)
	return modelHandler(fileName, data, "loadRailroadCrossing")
end
local function constructionHandler(fileName, data)
	return modelHandler(fileName, data, "loadConstruction")
end
local function soundSetHandler(fileName, data)
	return modelHandler(fileName, data, "loadSoundSet")
end

local function registerModelHandler()
	if (not eat1963_global_data.modutils.modifierObjects.handlerRegistered) then
		modutils.registerGlobalModifier("loadModel", modelsHandler)
		modutils.registerGlobalModifier("loadMultipleUnit", multipleUnitHandler)
		modutils.registerGlobalModifier("loadStreet", streetHandler)
		modutils.registerGlobalModifier("loadTrack", trackHandler)
		modutils.registerGlobalModifier("loadBridge", bridgeHandler)
		modutils.registerGlobalModifier("loadTunnel", tunnelHandler)
		modutils.registerGlobalModifier("loadRailroadCrossing", railroadCrossingHandler)
		modutils.registerGlobalModifier("loadConstruction", constructionHandler)
		modutils.registerGlobalModifier("loadSoundSet", soundSetHandler)
		
		eat1963_global_data.modutils.modifierObjects.handlerRegistered = true
	end
end

function modutils.addLastModifier(runFn)
	init()
	registerModelHandler()
	eat1963_global_data.modutils.modifierObjects.data[#eat1963_global_data.modutils.modifierObjects.data + 1] = {
		runFn = runFn,
	}
end

function modutils.addCommonApiSavedModifier(runFn)
	local function doFilter(fileName, data, key)
		runFn(fileName, data, key)
		return true
	end
	
	modutils.addFileFilter(doFilter)
	modutils.addLastModifier(runFn)
end

return modutils
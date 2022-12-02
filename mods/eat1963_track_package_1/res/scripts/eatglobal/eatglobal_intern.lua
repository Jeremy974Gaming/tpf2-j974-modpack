--- eatglobal_intern
-- @author Enno Sylvester
-- @copyright 2017, 2018, 2019
-- @module eatglobal.eatglobal_intern

--- Laden benötigter Module, damit weitere require in den Modulen nicht nötig sind.
require "stringutil"

local eatglobal_intern = {
	version = "1.7",
}

-- math eine Round-Funktion "unterjubeln"
local function round (var)
	return math.floor (var + 0.5)
end

local function floorX (var, decimals)
	local factor = 1
	for i = 1, decimals do
		factor = factor * 10
	end
	return round(var * factor) / factor
end

local function randomDeg (Deg)
	return math.random(Deg) - (Deg / 2)
end

local function addPercent(arg, percent)
	return arg + ((arg * percent) / 100)
end
math.round = round
math.floorX = floorX
math.randomDeg = randomDeg
math.addPercent = addPercent

return eatglobal_intern


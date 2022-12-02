--- mathutils
-- @author Enno Sylvester
-- @copyright 2018
-- @module eatglobal.mathutils

local mathutils = {
	version = "1.1",
}

function mathutils.calcScale(dist, angle)
	if (angle < .001) then
		return dist
	end
			
	pi = math.pi
	pi2 = pi / 2	
	sqrt2 = math.sqrt(2)
			
	scale = 1.0
	if (angle >= pi2) then 
		scale = 1.0 + (sqrt2 - 1.0) * ((angle - pi2) / pi2)
	end

	return .5 * dist / math.cos(.5 * pi - .5 * angle) * angle * scale
end

return mathutils
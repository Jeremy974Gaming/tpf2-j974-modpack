local speed = 10
local trackWidth = 1520

function data()
	local t = { }
	
	t.categories = { string.format("%u mm",  trackWidth) }
	t.name = _(string.format("%u mm | %u km/h", trackWidth, speed))
	t.desc = string.format(_("%u mm Gleis mit Geschwindigkeitsbeschränkung auf %u km/h."), trackWidth, speed)

	t.yearFrom = 0
	t.yearTo = 0

	t.shapeWidth = 4.0
	t.shapeStep = 4.0
	t.shapeSleeperStep = 8.0 / 12.0

	-- Höhe Ballast
	t.ballastHeight = 0.3
	t.ballastCutOff = .1

	t.sleeperBase = t.ballastHeight
	t.sleeperLength = .26
	-- Schwellenlänge
	t.sleeperWidth = 2.685
	t.sleeperHeight = .08
	t.sleeperCutOff = .02

	-- Spurbreite
	t.railTrackWidth = trackWidth / 1000
	t.railBase = t.sleeperBase + t.sleeperHeight
	t.railHeight = .15
	t.railWidth = .07
	t.railCutOff = .02
    
	t.embankmentSlopeLow = 0.75
	t.embankmentSlopeHigh = 2.5

	t.catenaryBase = 5.917 + t.railBase + t.railHeight
	t.catenaryHeight = 1.35
	t.catenaryPoleDistance = 25.0

	t.trackDistance = 5.0

	t.speedLimit = speed / 3.6
	t.speedCoeffs = { .85, 30.0, .6 }		-- curve speed limit = a * (radius + b) ^ c

	t.ballastMaterial = "track/ballast.mtl"
	t.sleeperMaterial = "track/sleeper.mtl"
	t.railMaterial = "track/rail.mtl"
	t.catenaryMaterial = "track/catenary.mtl"
	t.trackMaterial = "track/track_standard.mtl"
	t.tunnelWallMaterial = "track/tunnel_rail_ug.mtl"
	t.tunnelHullMaterial = "track/tunnel_hull.mtl"

	t.catenaryPoleModel = "railroad/power_pole_2.mdl"
	t.catenaryMultiPoleModel = "railroad/power_pole_1.mdl"
	t.catenaryMultiGirderModel = "railroad/power_pole_1a.mdl"
	t.catenaryMultiInnerPoleModel = "railroad/power_pole_1b.mdl"

	t.bumperModel = "railroad/bumper.mdl"
	t.switchSignalModel = "railroad/switch_box.mdl"

	t.fillGroundTex = "ballast_fill"
	t.borderGroundTex = "ballast"

	t.cost = 50.0

	return t
end

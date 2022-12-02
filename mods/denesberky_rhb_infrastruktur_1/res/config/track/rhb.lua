function data()
	local t = { }

	t.name = _("RhB Gleise Holz")
	t.desc = _("Rhätische Bahn 1000mm Gleise mit Holzschwellen")

	t.yearFrom = 0
	t.yearTo = 0

	t.shapeWidth = 4.0
	t.shapeStep = 4.0
	t.shapeSleeperStep = 8.0 / 12.0

	t.ballastHeight = .3
	t.ballastCutOff = .1

	t.sleeperBase = t.ballastHeight
	t.sleeperLength = .26
	t.sleeperWidth = 2.0
	t.sleeperHeight = .08
	t.sleeperCutOff = .02

	t.railTrackWidth = 1.000
	t.railBase = t.sleeperBase + t.sleeperHeight
	t.railHeight = .15
	t.railWidth = .07
	t.railCutOff = .02
    
    t.embankmentSlopeLow = 0.75
    t.embankmentSlopeHigh = 2.5

	t.catenaryBase = 5.5 + t.railBase + t.railHeight
	t.catenaryHeight = 1.35
	t.catenaryPoleDistance = 25.0

	t.trackDistance = 5.0

	t.speedLimit = 120.0 / 3.6
	t.speedCoeffs = { .85, 30.0, .6 }		-- curve speed limit = a * (radius + b) ^ c

	t.ballastMaterial = "track/ballast.mtl"
	t.sleeperMaterial = "track/sleeper.mtl"
	t.railMaterial = "track/rail.mtl"
	t.catenaryMaterial = "track/catenary.mtl"
	t.trackMaterial = "track/track_standard.mtl"
	t.tunnelWallMaterial = "track/tunnel_rail_ug.mtl"
	t.tunnelHullMaterial = "track/tunnel_hull.mtl"

	t.catenaryPoleModel = "railroad/power_pole_2_rhb.mdl"
	t.catenaryMultiPoleModel = "railroad/power_pole_1_rhb.mdl"
	t.catenaryMultiGirderModel = "railroad/power_pole_1a_rhb.mdl"
	t.catenaryMultiInnerPoleModel = "railroad/power_pole_1b_rhb.mdl"

	t.bumperModel = "railroad/bumper.mdl"
	t.switchSignalModel = "railroad/switch_box.mdl"

	t.fillGroundTex = "ballast_fill"
	t.borderGroundTex = "ballast"

	t.cost = 35.0

	return t
end

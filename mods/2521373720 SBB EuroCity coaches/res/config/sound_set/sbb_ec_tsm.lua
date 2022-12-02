local soundeffectsutil = require "soundeffectsutil"


function data()
return {
	tracks = {
		{ name = "vehicle/waggon_modern/start.wav", refDist = 3.0 },
		{ name = "vehicle/waggon_modern/normal.wav", refDist = 3.0 },
		{ name = "vehicle/waggon_modern/fast.wav", refDist = 3.0 },
		{ name = "vehicle/waggon_modern/kurve.wav", refDist = 5.0 },
		{ name = "vehicle/waggon_modern/bremse_mix.wav", refDist = 6.0 }
	},
	events = {
		clacks = {
		    -- Klackern	
		names = {
			"vehicle/sfx/clack_person/clack1.wav",
			"vehicle/sfx/clack_person/clack2.wav",
			"vehicle/sfx/clack_person/clack3.wav",
			"vehicle/sfx/clack_person/clack4.wav",
			"vehicle/sfx/clack_person/clack5.wav",
			"vehicle/sfx/clack_person/clack6.wav"


				}, refDist = 2.0
			},
		-- Tüeren öffenen/schließen
		openDoors = { names =  { "vehicle/waggon/sbb_ec_door_open.wav" }, refDist = 5.0 },	
		closeDoors = { names = { "vehicle/waggon/sbb_ec_door_close.wav" }, refDist = 5.0 }
	},

	--bis
	
	updateFn = function (input)
		return {	
			tracks = {
				{ 
					gain = soundeffectsutil.sampleCurve({ { 0.0, 0.00 }, { 0.05, 0.0 }, { 0.2, 4.0 }, { 0.3, 3.0 }, { 0.4, 0.0 } }, input.speed01),
					pitch = soundeffectsutil.sampleCurve({ { 0.0, 1.0 }, { 0.041, 1.0 }, { 0.075, 1.0 }, { 1.0, 1.0 } }, input.speed01)
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { 0.0, 0.00 }, {0.2, 1.0}, { 0.3, 2.0 }, {0.5, 3.0}, {0.7, 2.0}, { 0.8, 1.0 } }, input.speed01),
					pitch = soundeffectsutil.sampleCurve({ { 0.0, 1.0 }, { 0.041, 1.0 }, { 0.075, 1.0 }, { 1.0, 1.0 } }, input.speed01)
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { 0.0, 0.00 }, {0.5, 0.5},  { 0.8, 3.0 }, { 0.9, 4.0 } }, input.speed01),
					pitch = soundeffectsutil.sampleCurve({ { 0.0, 0.8 }, { 0.041, 0.8 }, { 0.075, 0.8 }, { 1.0, 0.8 } }, input.speed01)
				},
				soundeffectsutil.squeal(input.speed, input.sideForce, input.maxSideForce),
				soundeffectsutil.brake(input.speed01, input.brakeDecel, 1.6)
			},
			events = 
			{
				clacks = {gain = 4.0, pitch = 1},
				-- Doors
				openDoors = { gain = 1.0, pitch = 1 },
				closeDoors = { gain = 1.0, pitch = 1 }
			}
		}
	end
}
end
local audioutil = require "audioutil"
local soundeffectsutil = require "soundeffectsutil"

function data()
return {
	tracks = {
		{ name = "vehicle/StadlerGiruno/stillstand.wav", refDist = 10.0 },
		{ name = "vehicle/StadlerGiruno/fahren.wav", refDist = 25.0 },
		{ name = "vehicle/StadlerGiruno/schnellfahren.wav", refDist = 25.0 },
		{ name = "vehicle/StadlerGiruno/bremse.wav", refDist = 25.0 }
	},
	events = {
		clacks = {
			names = {
				"vehicle/StadlerGiruno/klack2.wav",
				"vehicle/StadlerGiruno/klack1.wav",
				"vehicle/StadlerGiruno/klack2.wav",
			},
			refDist = 15.0
		},
		openDoors = { names = { "vehicle/StadlerGiruno/tuerauf.wav" }, refDist = 5.0 },	
		closeDoors = { names = { "vehicle/StadlerGiruno/tuerzu.wav" }, refDist = 5.0 }
	},

	updateFn = function (input)
		local axleRefWeight = 12.0
		
		return {
			tracks = {
				{ 
					gain = soundeffectsutil.sampleCurve({ { 0.0, 1.0 }, { 0.040, 0.5 }, { 0.040, 0.5 }, { 1.0, 0.5 } }, input.speed01),
					pitch = 1.0
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { 0.0, 0.0 }, { 0.020, 0.0 }, { 0.64, 0.55 }, { 1.0, 0.5 } }, input.speed01),
					pitch = soundeffectsutil.sampleCurve({ { 0.0, 0.0 }, { 1.0, 1.4 } }, input.speed01)
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { 0.0, 0.0 }, { 0.64, 0.0 }, { 0.8, 0.5 }, { 1.0, 0.95 } }, input.speed01),
					pitch = soundeffectsutil.sampleCurve({ { 0.0, .0 }, { 0.64, 0.90 }, { 1.0, 1.0 } }, input.speed01)
				},
				soundeffectsutil.brake(input.speed, input.brakeDecel, 0.3)
			},
			events = {
				clacks = soundeffectsutil.clacks(input.speed, input.weight, input.numAxles, axleRefWeight, input.gameSpeedUp),
				openDoors = { gain = 1.0, pitch = 1.0 },
				closeDoors = { gain = 1.0, pitch = 1.0 }
			}
		}
	end
}
end

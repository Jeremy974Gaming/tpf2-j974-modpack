local audioutil = require "audioutil"
local soundeffectsutil = require "soundeffectsutil"

function data()
return {
	tracks = {
		{ name = "vehicle/StadlerGiruno/stadlergmotor.wav", refDist = 20.0 },
		{ name = "vehicle/StadlerGiruno/umrichter.wav", refDist = 25.0 },
		{ name = "vehicle/StadlerGiruno/umrichter2.wav", refDist = 25.0 },
		{ name = "vehicle/StadlerGiruno/fahren.wav", refDist = 25.0 },
		{ name = "vehicle/StadlerGiruno/schnellfahren.wav", refDist = 25.0 }
	},
	events = {
		clacks = {
			names = {
				"vehicle/StadlerGiruno/klack1.wav",
				"vehicle/StadlerGiruno/klack2.wav",
				"vehicle/StadlerGiruno/klack1.wav",
			},
			refDist = 15.0
		},
		horn = { names = { "vehicle/StadlerGiruno/horn.wav" }, refDist = 50.0 },
		openDoors = { names = { "vehicle/StadlerGiruno/tuerauf.wav" }, refDist = 5.0 },	
		closeDoors = { names = { "vehicle/StadlerGiruno/tuerzu.wav" }, refDist = 5.0 }
	},

	updateFn = function (input)
		local axleRefWeight = 12.0
		
		return {
			tracks = {
				{ 
					gain = soundeffectsutil.sampleCurve({ { 0.0, 0.0 }, { 0.12, 1.0 }, { 1.0, 1.0 } }, input.speed01),
					pitch = soundeffectsutil.sampleCurve({ { 0.0, 0.9 }, { 1.0, 1.6 } }, input.speed01)
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { 0.0, 0.0 }, { 0.020, 0.65 }, { 0.163, 0.65 }, { 0.164, 0.0 }, { 1.0, 0.0 } }, input.speed01),
					pitch = 1.0
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { 0.0, 0.0 }, { 0.163, 0.0 }, { 0.164, 0.6 }, { 0.62, 0.0 }, { 1.0, 0.0 } }, input.speed01),
					pitch = 1.0
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { 0.0, 0.0 }, { 0.020, 0.0 }, { 0.64, 0.55 }, { 1.0, 0.5 } }, input.speed01),
					pitch = soundeffectsutil.sampleCurve({ { 0.0, 0.0 }, { 1.0, 1.4 } }, input.speed01)
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { 0.0, 0.0 }, { 0.64, 0.0 }, { 0.8, 0.5 }, { 1.0, 0.95 } }, input.speed01),
					pitch = soundeffectsutil.sampleCurve({ { 0.0, .0 }, { 0.64, 0.90 }, { 1.0, 1.0 } }, input.speed01)
				}
			},
			events = {
				clacks = soundeffectsutil.clacks(input.speed, input.weight, input.numAxles, axleRefWeight, input.gameSpeedUp),
				horn = { gain = 0.95, pitch = 1.0 },
				openDoors = { gain = 1.0, pitch = 1.0 },
				closeDoors = { gain = 1.0, pitch = 1.0 }
			}
		}
	end
}
end

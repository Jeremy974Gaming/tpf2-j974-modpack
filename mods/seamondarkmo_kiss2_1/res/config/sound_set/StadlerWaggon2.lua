local audioutil = require "audioutil"
local soundeffectsutil = require "soundeffectsutil"

function data()
return {
	tracks = {
		{ name = "vehicle/waggon_freight_modern/_waggon_freight_modern.wav", refDist = 30.0 },
		{ name = "vehicle/StadlerKiss/kiss_igbt.wav", refDist = 30.0 },
		{ name = "vehicle/StadlerKiss/drive.wav", refDist = 25.0 },
		{ name = "vehicle/train/wheels_ringing1.wav", refDist = 25.0 },
		{ name = "vehicle/train_electric_modern/_brakes.wav", refDist = 25.0 }
	},
	events = {
		clacks = {
			names = {
				"vehicle/StadlerKiss/clack.wav",
			},
			refDist = 15.0
		},
		openDoors = { names = { "vehicle/StadlerKiss/open2.wav" }, refDist = 5.0 },	
		closeDoors = { names = { "vehicle/StadlerKiss/close2.wav" }, refDist = 5.0 }
	},

	updateFn = function (input)
		local speed01 = input.speed / input.topSpeed
		local axleRefWeight = 10.6
		
		return {
			tracks = {
				{ 
					gain = soundeffectsutil.sampleCurve({ { .0, .0 }, { .32, 0.1 }, { .52, 0.3 }, { .64, 0.2 }, { 1.0, 0.2 } }, input.speed01),
					pitch = 1.0
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { .0, .0 }, { .01, 0.1 }, { .02, 0.15 }, { 0.08, 0.25 }, { .62, 0.1 }, { .75, 0.0 }, { 1.0, 0.0 } }, input.speed01),
					pitch = 1.0
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { .0, .0 }, { .30, .0 }, { .50, 0.2 }, { 1.0, 0.7 } }, input.speed01),
					pitch = soundeffectsutil.sampleCurve({ { .0, .0 }, { .32, 0.95 }, { 1.0, 1.3 } }, input.speed01)
				},
				soundeffectsutil.squeal(input.speed, input.sideForce, input.maxSideForce),
				soundeffectsutil.brake(input.speed, input.brakeDecel, 0.5)
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

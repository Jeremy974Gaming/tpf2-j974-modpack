local audioutil = require "audioutil"
local soundeffectsutil = require "soundeffectsutil"

function data()
return {
	tracks = {
		{ name = "vehicle/StadlerKiss/idle_k.wav", refDist = 15.0 },
		{ name = "vehicle/StadlerKiss/stadler_motor_v.wav", refDist = 25.0 },
		{ name = "vehicle/StadlerKiss/kiss_igbt.wav", refDist = 30.0 },
		{ name = "vehicle/StadlerKiss/drive.wav", refDist = 25.0 },
		{ name = "vehicle/waggon_freight_modern/_waggon_freight_modern.wav", refDist = 30.0 },
		{ name = "vehicle/train/wheels_ringing1.wav", refDist = 25.0 },
		{ name = "silence.wav", refDist = 1.0 }
	},
	events = {
		clacks = {
			names = {
				"vehicle/StadlerKiss/clack.wav",
			},
			refDist = 15.0
		},
		horn = { names = { "vehicle/StadlerKiss/horn.wav" }, refDist = 50.0 },
		openDoors = { names = { "vehicle/StadlerKiss/open2.wav" }, refDist = 5.0 },	
		closeDoors = { names = { "vehicle/StadlerKiss/close2.wav" }, refDist = 5.0 }
	},

	updateFn = function (input)
		local axleRefWeight = 15.9
		
		return {
			tracks = {
				{ 
					gain = soundeffectsutil.sampleCurve({ { .0, 1.0 }, { .25, 0.5 }, { .50, .0 }, { 1.0, .0 } }, input.speed01),
					pitch = 1.0
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { .0, .0 }, { .03, 0.0}, { .04, 0.1 }, { .18, 1.0 }, { .93, 1.0 }, { 1.00, 0.0 } }, input.speed01),
					pitch = soundeffectsutil.sampleCurve({ { 0.0, 0.1 }, { .03, 0.2 }, { 0.90, 1.0 }, { 1.00, 1.0 } }, input.speed01)
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { .0, .0 }, { .01, 0.2 }, { .02, 0.5 }, { 0.08, 1.0 }, { .62, 0.2 }, { .75, 0.0 }, { 1.0, 0.0 } }, input.speed01),
					pitch = 1.0
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { .0, .0 }, { .30, .0 }, { .50, 0.2 }, { 1.0, 0.7 } }, input.speed01),
					pitch = soundeffectsutil.sampleCurve({ { .0, .0 }, { .32, 0.95 }, { 1.0, 1.3 } }, input.speed01)
				},
				{ 
					gain = soundeffectsutil.sampleCurve({ { .0, .0 }, { .32, 0.1 }, { .52, 0.3 }, { .64, 0.2 }, { 1.0, 0.2 } }, input.speed01),
					pitch = 1.0
				},
				soundeffectsutil.squeal(input.speed, input.sideForce, input.maxSideForce),
				soundeffectsutil.brake(input.speed, input.brakeDecel, 0.5)
			},
			events = {
				clacks = soundeffectsutil.clacks(input.speed, input.weight, input.numAxles, axleRefWeight, input.gameSpeedUp),
				horn = { gain = 1.0, pitch = 1.0 },
				openDoors = { gain = 1.0, pitch = 1.0 },
				closeDoors = { gain = 1.0, pitch = 1.0 }
			}
		}
	end
}
end

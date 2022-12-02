local audioutil = require "audioutil"
local soundeffectsutil = require "soundeffectsutil"

function data()
return {
	tracks = {
		{ name = "vehicle/train_electric_modern/drive.wav", refDist = 25.0 },
		{ name = "vehicle/train/wheels_ringing1.wav", refDist = 25.0 },
		{ name = "vehicle/train_electric_modern/_brakes.wav", refDist = 25.0 }
	},
	events = {
		clacks = {
			names = {
				"vehicle/clack/modern/part_1.wav",
				"vehicle/clack/modern/part_2.wav",
				"vehicle/clack/modern/part_3.wav",
				"vehicle/clack/modern/part_4.wav",
				"vehicle/clack/modern/part_5.wav",
				"vehicle/clack/modern/part_6.wav",
				"vehicle/clack/modern/part_7.wav",
				"vehicle/clack/modern/part_8.wav",
				"vehicle/clack/modern/part_9.wav",
				"vehicle/clack/modern/part_10.wav"
			},
			refDist = 15.0
		},
		horn = { names = { "vehicle/train_electric_modern/horn_rhb.wav" }, refDist = 50.0 }
	},

	updateFn = function (input)
		local axleRefWeight = 10.0
		
		return {
			tracks = {
				{ 
					gain = soundeffectsutil.sampleCurve(audioutil.plotSqrt(.0, .1, 1.0, 1.0, 10), input.speed01),
					pitch = soundeffectsutil.sampleCurve({ { .0, 1.0 }, { 1.0, 1.33 } }, input.speed01)
				},
				soundeffectsutil.squeal(input.speed, input.sideForce, input.maxSideForce),
				soundeffectsutil.brake(input.speed, input.brakeDecel, 0.5)
			},
			events = {
				clacks = soundeffectsutil.clacks(input.speed, input.weight, input.numAxles, axleRefWeight, input.gameSpeedUp),
				horn = { gain = 1.0, pitch = 1.0 }
			}
		}
	end
}
end

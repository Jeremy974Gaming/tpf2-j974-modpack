local soundsetutil = require "soundsetutil"

local clackNames = {
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
}

function data()

local data = soundsetutil.makeSoundSet()

soundsetutil.addTrackParam01(data, "vehicle/waggon_modern/_waggon_modern.wav", 20.0,
		{ { .0, .0 },	{ 1.0, 1.0 } }, { { .0, 1.0 }, { 1.0, 1.15 } }, "speed01")

soundsetutil.addTrackSqueal(data, "vehicle/train/wheels_ringing2.wav", 20.0)
soundsetutil.addTrackBrake(data, "vehicle/train/brakes.wav", 20.0, 0.5)

soundsetutil.addEventClacks(data, clackNames, 15.0, 10.0)
soundsetutil.addEvent(data, "openDoors", { "vehicle/waggon/sbb_ec_door_open.wav" }, 5.0)
soundsetutil.addEvent(data, "closeDoors", { "vehicle/waggon/sbb_ec_door_close.wav" }, 5.0)

return data

end

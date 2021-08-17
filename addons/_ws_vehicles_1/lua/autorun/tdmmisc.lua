if SERVER then return end

sound.Add( {
	name = "tdmcars_engine_off",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 75,
	pitch = { 95, 110 },
	sound =	{ "vehicles/tdmcars/miscsounds/engine_off.mp3", "vehicles/tdmcars/miscsounds/engine_off2.mp3", "vehicles/tdmcars/miscsounds/engine_off2.mp3", "vehicles/tdmcars/miscsounds/engine_off2.mp3" },
} )
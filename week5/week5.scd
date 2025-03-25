s.boot;

s.kill;
b = Buffer.read(s, "/Volumes/Samsung 870 QVO/SAMPLES/DRUMS/BREAKS/Amen Breaks Compilation/Amen Breaks Volume 1/WAV/cw_amen20_164.wav");

b.play;
b.query;
b.free;

thisProcess.nowExecutingPath;

~audiopath = PathName(thisProcess.nowExecutingPath).parentPath ++ "/week5/audio/breaks/";

(
~b1 = Buffer.read(s, ~audiopath ++ "cw_amen01_175.wav");
~b2 = Buffer.read(s, ~audiopath ++ "cw_amen14_175.wav");
)

(
~b1.play;
~b2.play;
)

//Array for breaks

Buffer.freeAll;
(
b = [
	Buffer.read(s, ~audiopath ++ "cw_amen01_175.wav"),
	Buffer.read(s, ~audiopath ++ "cw_amen17_175.wav")
];
)

(
b[0].play;
b[1].play;
)

//Use Event
Buffer.freeAll;
(
b = (
	break0: Buffer.read(s, ~audiopath ++ "cw_amen01_175.wav"),
	break1: Buffer.read(s, ~audiopath ++ "cw_amen02_165.wav"),
);
)

b[\break0].play;
b[\break1].numChannels;

//Make a SynthDef

(
SynthDef(\play, {
	var sig;
	sig = PlayBuf.ar(2, b[\break]);
	Out.ar(0, sig);
}).add;
)

Synth(\play;)


(
SynthDef(\play, {
	|buf = 0, rate=1, t_trig = 0, start=0|
	var sig;
	sig = PlayBuf.ar(2, buf, rate, t_trig, start);
	Out.ar(0, sig);
}).add;
)
x = Synth(\play, [\buf, b[\break1], \rate, rrand(1.0, 1.5)]);
x.set(\t_trig, 1, \start, rrand(0, b[\break1].numFrames));


MIDIClient.init;

m = MIDIIn(7);
m.postln;











































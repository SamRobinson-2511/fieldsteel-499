s.boot;

s.kill;
b = Buffer.read(s, "/Volumes/Samsung 870 QVO/SAMPLES/DRUMS/BREAKS/Amen Breaks Compilation/Amen Breaks Volume 1/WAV/cw_amen20_164.wav");

b.play;
b.query;
b.free;

thisProcess.nowExecutingPath;

~audiopathBreaks = PathName(thisProcess.nowExecutingPath).parentPath ++ "week5/audio/breaks/";
~audiopathSynths = PathName(thisProcess.nowExecutingPath).parentPath ++ "week5/audio/synths/";
~audiopathVoices = PathName(thisProcess.nowExecutingPath).parentPath ++ "week5/audio/voice/";

(
~b1 = Buffer.read(s, ~audiopathBreaks ++ "cw_amen01_175.wav");
~b2 = Buffer.read(s, ~audiopathBreaks ++ "cw_amen14_175.wav");
)

(
~b1.play;
~b2.play;
)

//Array for breaks

Buffer.freeAll;
(
b = [
	Buffer.read(s, ~audiopathBreaks ++ "cw_amen01_175.wav"),
	Buffer.read(s, ~audiopathBreaks ++ "cw_amen17_175.wav")
];
)

//Array for Synths

(
b = [
	Buffer.read(s, ~audiopathSynths ++ "TG77_96bpm.wav")
];
)

(
b = Buffer.read(s, ~audiopathVoices ++ "241101_0345.wav" )
)

(
~bs1 = Buffer.read(s, ~audiopathSynths ++ "TG77_96bpm.wav");
)
~bs1.play;

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
	synth0: Buffer.read(s, ~audiopathSynths ++ "TG77_96bpm.wav"),
	talk0: Buffer.read(s, ~audiopathVoices ++ "praat+vocoder.wav")
);
)

b[\break0].play;
b[\break1].numChannels;
b[\break1].numFrames;
b[\synth0].play;
b[\talk0].play;

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
x = Synth(\play, [\buf, b[\break2], \rate, rrand(1.0, 1.5)]);
x.set(\t_trig, 1, \start, rrand(0, b[\break2].numFrames-1));

(
SynthDef(\play2, {
	|buf = 0, rate=1, start=0|
	var sig, trig;
	trig = Impulse.kr(2);
	//trig = LFNoise1.kr(6);
	sig = PlayBuf.ar(2, buf, rate, trig, start);
	Out.ar(0, sig);
}).add;
)

x = Synth(\play2, [\buf, b[\break2], \rate, 1.5, \start, rrand(0, 48000)]);

(
SynthDef(\play3, {
	|buf = 0, rate=1, imphz=4, amp=0.5, pan = 0|
	var sig, trig, env, start;
	//trig = Impulse.kr(imphz);
	trig = LFNoise1.kr(imphz);
	start = TIRand.kr(0, BufFrames.kr(buf)-1, trig);
	env = EnvGen.kr(Env([0, 1, 0], [0.1, (1/imphz) - 0.1], [1, -2]), trig);
	sig = PlayBuf.ar(2, buf, rate, trig, start);
	sig = sig * env;
	sig = Pan2.ar(sig, pan);
	sig = sig * amp;
	Out.ar(0, sig);
}).add;
)

x = Synth(\play3, [\buf, b[\break2], \rate, 1, \imphz, 0.5]);
x.set(\buf, b[\break2], \rate, rrand(0.01, 2.5), \imphz, rrand(0.1, 5.0));

//Array of playback rates
(
Array.rand(128, -120.0, 12.0).do({
	|n|
	Synth(\play3,
		[
			\buf, b[\talk0],
			\rate, n.midiratio,
			\imphz, n.midiratio.rrand(0.125, 12.0),
			\amp, n.midiratio.rrand(0.75, 1.0),
			\pan, n.midiratio.rrand(-1.0, 1.0)
		]
	);
})
)


//loop
(
SynthDef(\play_simple, {
	|buf=0, loop=1, rate=1|
	var sig;
	sig = PlayBuf.ar(1, buf, rate, loop: loop,  doneAction: 2);
	Out.ar(0, sig);
}).add;
)

x = Synth(\play_simple, [\buf, b[\talk0], \rate, -1]);
x.set(\loop, 0);







































//https://www.youtube.com/watch?v=ztVLMS15n1c&list=PLPYzvS8A_rTbTAn-ZExGuVFZgVMwYi1kJ

s.boot;
(
SynthDef(\beep, {
	var sig, env;
	sig = SinOsc.ar(\freq.ir(1000));
	env = Env(
		[0,1,1,0],
		[\atk.ir(0), \sus.ir(0.03), \rel.ir(0)],
		[\atkcrv.ir(2),0,\relcrv.ir(-2)]
	).ar(2);
	sig = sig * env;
	sig = Pan2.ar(sig, \pan.ir(0), \amp.ir(0.3));
	Out.ar(\out.ir(0), sig);
	Out.ar(\outfx.ir(0), sig * \send.ir(-30).dbamp);
}).add;
)

Synth(\beep, [\freq, 1200]);
Synth(\beep, [\freq, 2000, \rel, 0.5]);

(
SynthDef(\samp, {
	var sig, env;
	sig = PlayBuf.ar(1, \buf.ir(0), BufRateScale.ir(\buf.ir(0)) * \rate.ir(1), 1, \spos.ir(0));
	env = Env(
		[0, 1, 1, 0],
		[\atk.ir(0), \sus.ir(0.1), \rel.ir(0)],
		\lin
	).ar(2);
	sig = sig * env;
	sig = Pan2.ar(sig, \pan.ir(0), \amp.kr(0.3));
	Out.ar(\out.ir(0), sig);
	Out.ar(\outfx.ir(0), sig * \send.ir(-30).dbamp);
}).add;
)

~b0 = Buffer.read(s,"/Users/robinson.will.sam/Desktop/SAMPLES copy/KORG MONOPOLY/ARP-AlienMazines.wav" );
~b1 = Buffer.read(s, "/Users/robinson.will.sam/Desktop/SAMPLES copy/KORG MONOPOLY/ARP-GetHyper.wav");
~b2 = Buffer.read(s,"/Users/robinson.will.sam/Desktop/SAMPLES copy/KORG MONOPOLY/BASS-1VCOacidic2.wav" );
~b3 = Buffer.read(s,"/Users/robinson.will.sam/Desktop/SAMPLES copy/KORG MONOPOLY/BASS-1VCOmoogey.wav" );

Synth(\samp, [\buf, ~b0, \pan, 0]);

(
SynthDef(\reverb, {
	var sig, wet;
	sig = In.ar(\in.ir(0), 2);
	sig = FreeVerb2.ar(sig[0], sig[1], mix: 1, room: 0.99, damp: 0.99);
	sig = LPF.ar(sig, 900);
	Out.ar(\out.ir(0), sig);
}).add;
)

s.newBusAllocators;
~reverbBus = Bus.audio(s, 2);

~fxGroup = Group.new;
~reverb = Synth(\reverb, [\in, ~reverbBus], ~fxGroup);


Synth(\beep, [\freq, 1200, \out, 0, \outfx, ~reverbBus, \send, -20]);
Synth(\samp, [\buf, ~b3, \out, 0]);
Synth(\samp, [\buf, ~b3, \out, 0, \outfx,  ~reverbBus, \send, 0]);


(
~sampPat = Pbind(
	\instrument, \samp,
	\dur, 1/8,
	\type, Pwrand([\note, \rest], [0.6, 0.4], inf),
	\buf, Prand([~b0, ~b1, ~b2, ~b3], inf),
	\rate, Pwhite(-12, 12, inf).midiratio,
	\amp, Pexprand(0.02, 0.5, inf),
	\atk, 0,
	\sus, 0,
	\rel, Pexprand(0.02, 0.5, inf),
	\out, 0,
	\outfx, ~reverbBus,
	\send, Pwhite(-40, -10, inf)
);
)


~sampPlayer = ~sampPat.play;
~sampPlayer.stop;


(
~beepPat = Pbind(
	\instrument, \beep,
	\dur, 2,
	\atk, 0,
	\sus, 0.02,
	\rel, 0.02,
	\freq, 1000,
	\amp, Pexprand(0.02, 0.2, inf),
	\pan, Pseq([-1, 0, 1, 0], inf),
	\out, 0,
	\outfx, ~reverbBus,
	\send, -10
);
)

~beepPlayer = ~beepPat.play;
~beepPlayer.stop;


(
~dronesPat = Pbind(
	\instrument, \beep,
	\dur, 5,
	\atk, 4,
	\sus, 0,
	\rel, 4,
	\freq, Pexprand(150, 300, inf) * Pfuncn({Array.rand(16, -1.0, 1.0).midiratio}, inf),
	\amp, 0.02,
	\out, 0,
	\outfx, ~reverbBus,
	\send, -10
);
)

~dronesPlayer = ~dronesPat.play;
~dronesPlayer.stop;


//event 0
~sampPlayer = ~sampPat.play(quant: 1);
//event 1
~beepPlayer = ~beepPat.play(quant: 1);
//event 2
~dronesPlayer = ~dronesPat.play;
//event 3
(
~sampPlayer.stop;
~dronesPlayer.stop;
)
//event 4
~beepPlayer.stop;










































//https://www.youtube.com/watch?v=jfak2umWzFA
s.boot;



(
SynthDef(\pulse, {
	var sig, env, freq, cf;
	freq = \freq.kr(100);
	freq = freq * { Rand(-0.1, 0.1).midiratio }.dup(4);
	cf = freq * \harm.ir(4);
	sig = Pulse.ar(freq, \width.ir(0.5)).sum * 0.1;
	sig = LPF.ar(sig, cf.clip(20, 20000));
	env = Env.perc(\atk.ir(0.02), \rel.ir(0.5)).kr(2);
	sig = Pan2.ar(sig, \pan.kr(0), \amp.kr(0.2));
	sig = sig * env;
	Out.ar(\out.kr(0), sig);
}).add;
)

Synth(\pulse, [freq: rrand(50, 100).midicps, amp: 0.4]);

(
p = Pbind(
	\instrument, \pulse,
	\midinote, Pwhite(40.0, 108.0),
	\dur, Pexprand(0.05, 0.5),
	\db, Pwhite(-25.0, -10.0),
	\rel, Pexprand(0.07, 0.3)
);
q = p.play;
)
q.stop;


//CUMBERSOME, AVOID, GONNA FRY THE SERVER
(
SynthDef(\fx, {
	var sig;
	Line.kr(0, 0, 8, doneAction: 2);
	sig = SinOsc.ar(800!2) * 0.5;
	sig = sig * Env.perc(0.01, 0.1).kr(0);
	sig = FreeVerb2.ar(sig[0], sig[1], 0.3, 0.99);
	Out.ar(0, sig);
}).add;
)

Synth(\fx);


//BUSSES
s.options.numAudioBusChannels;
s.options.numControlBusChannels;
s.options.numPrivateAudioBusChannels;
s.options.numOutputBusChannels = 8;
s.options.numInputBusChannels = 8;
s.reboot;
s.meter;



(
{
	var sig;
	sig = PinkNoise.ar(0.2!2);
	Out.ar(19, sig);
}.play;
)


(
{
	var sig;
	sig = LFNoise0.kr(9);
	Out.kr(47, sig);
}.play;
)

(
{
	var sig;
	sig = In.ar(19, 2);
	sig = FreeVerb2.ar(sig[0], sig[1], 0.3, 0.99);
	Out.ar(0, sig);
}.play;
)

Synth(\pulse, [freq: rrand(50, 100).midicps, amp: 0.4, \out, 19]);


s.scope;





























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




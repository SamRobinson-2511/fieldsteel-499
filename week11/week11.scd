//https://www.youtube.com/watch?v=Ng2OSh8bqJE

MIDIClient.init;
MIDIIn.connectAll;
//debug
MIDIFunc.trace(false);

(
MIDIdef.noteOn(\on, {
	|val, num, chan, src|
	[val, num].postln;
}).permanent_(true);
)

MIDIdef(\on).disable;
MIDIdef(\on).enable;
MIDIdef(\on).free;
MIDIdef.freeAll;


(
SynthDef(\saw, {
	var sig, env;
	sig = Saw.ar(\freq.kr(440) * { Rand(-0.2, 0.2).midiratio }.dup(4));
	sig = Splay.ar(sig);
	sig = RLPF.ar(sig, \cf.kr(2000), \rq.kr(0.4));
	env = Env.adsr().kr(2, \gate.kr(1));
	sig = sig * env * \amp.kr(0.25);
	Out.ar(\out.kr(0), sig)
}).add;
)

x = Synth(\saw, [freq: 50]);
x.set(\gate, 0);




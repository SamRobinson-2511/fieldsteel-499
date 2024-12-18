//https://www.youtube.com/watch?v=Ng2OSh8bqJE
s.boot;
MIDIClient.init;
MIDIIn.connectAll;
//debug
MIDIFunc.trace(false);
m = MIDIOut(2);
m = MIDIOut.newByName("Micro Express USB", "Port 1");
MIDIClient.destinations;
m.latency = 0;

m.noteOn(0, rrand(40, 60), 127);
m.noteOff(0, 40);

(
~panic = {
	(0..127).do({|note| m.noteOff(0, note) });
};
)

CmdPeriod.add(~panic);





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
~ar = nil ! 128;

MIDIdef.noteOn(\on, {
	|val, num, channel, src|
	~ar.put(num, Synth(\saw, [
		freq: num.midicps,
		cfbus: ~cfbus,
/*		amp: (val / 127) * 0.2*/
		amp: val.linexp(0, 127, 0.02, 0.2)
	]));
});

MIDIdef.noteOff(\off, {
	|val, num, channel, src|
	~ar.at(num).set(\gate, 0);
});

MIDIdef.cc(\cf, {
	|val, num, chan, src|
	~cfbus.value_(val.linexp(0, 127, 50, 5000));
}, ccNum: 74);
)

~cfbus = Bus.control(s, 1);
~cfbus.value_(0);
~cfbus.getSynchronous;

s.scope;
(
SynthDef(\saw, {
	var sig, env, cf;
	cf = In.kr(\cfbus.kr(0), 1);
	sig = Saw.ar(\freq.kr(440) * { Rand(-0.2, 0.2).midiratio }.dup(4));
	sig = Splay.ar(sig);
	sig = RLPF.ar(sig, cf, \rq.kr(0.4));
	env = Env.adsr().kr(2, \gate.kr(1));
	sig = sig * env * \amp.kr(0.25);
	Out.ar(\out.kr(0), sig)
}).add;
)

x = Synth(\saw, [freq: 50]);
x.set(\gate, 0);




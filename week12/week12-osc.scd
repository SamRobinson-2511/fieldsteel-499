s.boot;

{PinkNoise.ar(0.1!2)}.play;

//OSCdef and OSCfunc
OSCFunc.trace(false);

(
OSCdef(\test, {
	|msg|
	msg.postln[1];
	if(msg[2].isNumber){
		Synth(\tone, [freq: msg[2].clip(80, 12000)]);
		Synth(\tone, [freq: msg[2].clip(80, 12000)/2]);
	}
}, '/test');
)

~sam_lang = NetAddr("192.168.12.177", 57121);
NetAddr.langPort;

~sam_lang.sendMsg('/test', rrand(10, 99), rrand(0, 12000));

(
SynthDef(\tone, {
	var sig;
	sig = SinOsc.ar(\freq.ir(440)) * 0.1!2;
	sig = sig * Env.perc.ar;
	Out.ar(0, sig);
}).add;
)

Synth(\tone);
s.freeAll;


//TouchOSC

(
SynthDef(\tone2, {
	var sig;
	sig = SinOsc.ar(\freq.ir(440)) * 0.3!2;
	sig = sig * \amp.kr(1, 0.02);
	sig = sig * Env.adsr().ar(0, \gate.kr(0));
	Out.ar(0, sig);
}).add;
)

x = Synth(\tone2);
x.set(\gate, 1);
x.set(\amp, 0.02);
x.set(\gate, 0);

(
OSCdef(\on_off, {
	|msg|
	msg.postln;
	x.set(\gate, msg[1])
}, '/button1');

OSCdef(\amp, {
	|msg|
	x.set(\amp, msg[1])
}, '/fader1');
)

MIDIdef(\k_ch1, {
	|chan, note, vel|
	note.postln;
})



















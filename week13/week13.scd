//https://www.youtube.com/watch?v=HzaS5kcAXiE


b = Buffer.read(s, "/Users/robinson.will.sam/Desktop/Praat Samples/praat+vocoder3.wav".resolveRelative);


(
SynthDef(\play, {
	var sig, buf;
	buf = \buf.ir(0);
	sig = PlayBuf.ar(2!2, buf, BufRateScale.ir(buf) * \rate.ir(1), doneAction: 2);
	sig = sig * \amp.ir(0.7);
	Out.ar(\out.ir(0), sig);
}).add;
)

Synth(\play, [buf: b, rate: 0.midiratio]);

x = Synth(\default);
x.set(\freq, 990);
x.free;



//OSC
s.sendMsg('/s_new', 'default', 3456, 0, 1);
s.sendMsg('/n_set', 3456, 'freq', 700);
s.sendMsg('/n_set', 3456, 'gate', 0);
s.sendMsg('/n_free', 3456);


//NetAddr
NetAddr.langPort;

~sam = NetAddr("192.168.12.228", 57120);
~sam.sendMsg('/test', 24);

(
OSCdef(\receiver, {
	|msg|
	msg.postln;
}, '/test');
)
s.boot;
(
OSCdef(\receiver, {
	|msg|
	msg.postln;
	Synth(\play, [buf: b, amp: 0.2, rate: msg[1].midiratio])

}, '/test');
)


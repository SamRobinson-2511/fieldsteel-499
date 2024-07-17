//https://www.youtube.com/watch?v=ztVLMS15n1c&list=PLPYzvS8A_rTbTAn-ZExGuVFZgVMwYi1kJ

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


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



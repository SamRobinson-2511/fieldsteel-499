//https://www.youtube.com/watch?v=5vltzRNQnbo&list=PLPYzvS8A_rTbTAn-ZExGuVFZgVMwYi1kJ&index=2


//tutorial 21: https://www.youtube.com/watch?v=UoXMUQIqFk4
//tutorial 22: https://www.youtube.com/watch?v=dLMSR2Kjq6Y

(
SynthDef(\fm, {
	var sig, env;
	env = Env([0, 1, 0], [\atk.ir(0.01), \rel.ir(3)], [1, -1]).ar(2);
	sig = SinOsc.ar(\freq.kr(400));
	sig = Pan2.ar(sig, \pan.kr(0), \amp.kr(0.2));
	sig = sig * env;
	Out.ar(\out.ir(0), sig);
}).add;
)

(
p = Routine({
	loop{
		Synth(\fm);
		3.wait;
	};
}).play;
)

p.stop;

/////////////////////////////////////////
(
SynthDef(\fm, {
	var sig, mod, env;
/*	env = Env([0, 1, 0], [\atk.ir(0.01), \rel.ir(3)], [1, -1]).ar(2);*/
/*	mod = SinOsc.ar(MouseX.kr(1, 2000, 1).poll, mul: 300);*/
	mod = SinOsc.ar(\modfreq.kr(100), mul:MouseX.kr(1, 10000, 1));
	sig = SinOsc.ar(\freq.kr(400) + mod);
	sig = Pan2.ar(sig, \pan.kr(0), \amp.kr(0.2));
/*	sig = sig * env; */
	Out.ar(\out.ir(0), sig);
}).add;
)

(
p = Routine({
	loop{
		Synth(\fm);
		3.wait;
	};
}).play;
s.scope;
FreqScope.new;
)
p.stop;
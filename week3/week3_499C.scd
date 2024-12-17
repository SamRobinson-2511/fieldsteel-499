//https://www.youtube.com/watch?v=5krJVMxCr8s&list=PLPYzvS8A_rTbTAn-ZExGuVFZgVMwYi1kJ&index=3

s.boot;

//1. Create the Shape
//2. Convert to WaveTable Format
//3. Load to Buffer
//4. Use wt Oscillator UGen to read taht Buffer @ some Hz

(
Window.closeAll;
~sig = Signal.sineFill(4096, [1, 0.3, 0.5, 0.15, 0.2], [0, 0, pi, 0, pi]);
~sig.plot;
)


~buf = Buffer.alloc(s, 4096);
~buf.sendCollection(~sig);
~buf.plot;

(
{
	var sig;
	sig = Osc.ar(~buf, MouseX.kr(1, 500, 1).poll) * 0.03!2;
}.play;
s.scope;
FreqScope.new;
)


s.boot




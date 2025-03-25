s.boot;

s.kill;
b = Buffer.read(s, "/Volumes/Samsung 870 QVO/SAMPLES/DRUMS/BREAKS/Amen Breaks Compilation/Amen Breaks Volume 1/WAV/cw_amen20_164.wav");

b.play;
b.query;
b.free;

thisProcess.nowExecutingPath;

~audiopath = PathName(thisProcess.nowExecutingPath).parentPath ++ "audio/breaks"; 
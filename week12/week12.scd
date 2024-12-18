//https://www.youtube.com/watch?v=EcDU2MXT1uE

(
Window.closeAll;
w = Window.new("title", Rect(200, 300, 400, 500));
w.alwaysOnTop_(true);
w.front;
)

Window.screenBounds;
(
Window.closeAll;
w = Window.new("title", Rect(
	(Window.screenBounds.width - 500) / 2,
	(Window.screenBounds.height - 500) / 2,
	500,
	500
));
w.alwaysOnTop_(true);
w.front;
)

(
var win, slider, knob;
Window.closeAll;
win = Window().front;
win.alwaysOnTop_(true);
slider = Slider(win, Rect(20, 20, 40, 200));
knob = Knob(win, Rect(100, 20, 60, 60));
)

//HLayout
(
var win, slider, knob;
Window.closeAll;
win = Window().front;
win.alwaysOnTop_(true);
slider = 8.collect({ Slider() });
win.layout_(HLayout(*slider));
)


//GridLayout
(
var win, slider, button;
Window.closeAll;
win = Window().front;
win.alwaysOnTop_(true);
slider = 8.collect({ Slider() });
button = 8.collect({ Button() });
win.layout_(GridLayout.rows(slider, button));
)

(
Window.closeAll;
w = Window(bounds: Rect(100, 100, 100, 400)).front;
~s1 = Slider();
w.layout_(HLayout(~s1));
w.alwaysOnTop_(true);
)

//GET and SET
~s1.visible;
~s1.visible_(true);
~s1.enabled;
~s1.enabled_(true);
~s1.background;
~s1.background_(Color(1, 0.5, 0.25, 0.5));
~s1.background_(Color.new255(171, 21, 30));
~s1.orientation_(\horizontal);
~s1.orientation_(\vertical);

Slider.browse;


//Values and Actions
(
Window.closeAll;
w = Window(bounds: Rect(100, 100, 100, 400)).front;
~s1 = Slider();
~s1.action_({ |v| v.value.postln });
~js1 = Slider2D();
~js1.action_({ |v| v.x.postln; v.y.postln; });
~k1 = Knob();
~k1.action_({ |v| v.value.postln});

w.layout_(HLayout(~s1, ~js1, ~k1));
w.alwaysOnTop_(true);
)

~s1.value;
~s1.value_(0.2);
~s1.valueAction_(0.8);


//List of GUI Classes



(
Window.closeAll;
g = Group();

x = {
	var sig;
	sig = SinOsc.ar(\freq.kr(300).lag(0.1), mul: 0.1!2); //Lag
}.play(target: g);

w = Window(bounds: Rect(100, 100, 100, 400)).front;

~s1 = Slider();
~s1.action_({
	|v|
	x.set(\freq, v.value.linexp(0, 1, 200, 1000).postln)
});
w.layout_(HLayout(~s1, ~js1, ~k1));
w.alwaysOnTop_(true);
w.onClose_({g.freeAll});
)
x.free;

//NodeWatcher



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














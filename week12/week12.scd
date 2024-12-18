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
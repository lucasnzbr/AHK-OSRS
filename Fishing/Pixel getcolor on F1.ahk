#SingleInstance, force
f1::
mousegetpos, x, y
Pixelgetcolor, colorvar, %x%, %y%
Msgbox, the color of current position is %colorvar%¨, at coords x %x% and y %y%



f2::Reload
f3::ExitApp
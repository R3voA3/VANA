/*
	Author: Revo

	Description:
	Displays current fps of client. Colour depends on number of FPS.

	Parameter(s):
	-
	Returns:
	-
*/


showFps = true;

while {showFps} do 
{
	if (diag_fps >= 59)	then
	{
		hintSilent parseText format["<t size ='1.5' color='#003CFF'>FPS: %1</t>", round diag_fps];
	}
	else
	{
		if (diag_fps >= 29) then
		{
			hintSilent parseText format["<t size ='1.5' color='#00D60E'>FPS: %1</t>", round diag_fps];
		}
		else
		{
			hintSilent parseText format["<t size ='1.5' color='#FF2F00'>FPS: %1</t>", round diag_fps];
		};
	};
	sleep 1;
};

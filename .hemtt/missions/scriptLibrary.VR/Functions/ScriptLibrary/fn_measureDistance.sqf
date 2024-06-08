/*
   Author: Revo

   Description:
   Measures the distance between two positions.

   Parameter(s):
   -

   Returns:
   true
*/

if (isNil "Enh_measureDistance_var") then
{
	Enh_measureDistance_var = (uiNamespace getVariable "bis_fnc_3DENEntityMenu_data") select 0;
	["First point registered!"] call BIS_fnc_3DENNotification;
}
else
{
	private _distance3D = Enh_measureDistance_var distance ((uiNamespace getVariable "bis_fnc_3DENEntityMenu_data") select 0);
	private _distance2D = Enh_measureDistance_var distance2D ((uiNamespace getVariable "bis_fnc_3DENEntityMenu_data") select 0);
	private _travelTime = _distance3D / 1000 / 14.15 * 60;//Travel time in minuts, 14.15 is the average speed of a infantry unit
	[format ["Distance 2D: %1 Distance 3D: %2 Travel Time (on foot): %3 min",_distance2D,_distance3D,_travelTime],20] call BIS_fnc_3DENNotification;
	Enh_measureDistance_var = nil;
};

true

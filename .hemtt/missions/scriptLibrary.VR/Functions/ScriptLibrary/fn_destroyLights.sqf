/*
	Author: Revo

	Description:
	Destorys lamps in given area

	Parameter(s):
		0: OBJECT - Object used as center position
		1: OBJECT - Street Light
		2: NUMBER - Distance which when exeeded will end the flickering

	Returns:
	true
*/

private _center = [0,objNull,[objNull]];
private _lamp = [1,objNull,[objNull]];
private _distance = [2,200,[0]];

while {_center distance _lamp < 200} do
{
	[
		_lamp,
		selectRandom [true,false]
	] call BIS_fnc_switchLamp;

	sleep 0.1 + random 0.5;
};

true
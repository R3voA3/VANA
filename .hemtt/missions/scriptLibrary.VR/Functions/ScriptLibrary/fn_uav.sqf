/*
	Author: Revo

	Description:
	Reveals units in a defined area temporarily.

	Parameter(s):
	See defines below
	Returns:
	BOOLEAN - true
*/

//Replace here
#define CENTER player 
#define RADIUS 100	  
#define DELETE_TIME 5
#define TOLERANCE 5
//Replace end

[CENTER,RADIUS,DELETE_TIME,TOLERANCE] spawn 
{
	params ["_center","_radius","_deleteTime","_tolerance"];
	_nearestUnits = nearestObjects [_center, ["man"], _radius];

	systemChat "Scanning in progress...";

	createMarker ["areaBorderTemp", _center];
	"areaBorderTemp" setMarkerShape "ELLIPSE";
	"areaBorderTemp" setMarkerSize [_radius,_radius];
	"areaBorderTemp" setMarkerBrush "Border";

	{
		_marker = createMarker [format ["tempMarker_%1",_forEachIndex],_x getPos [_tolerance,random 360]];
		_marker setMarkerType "o_unknown"; 
		_marker setMarkerColor "ColorUNKNOWN"; 
		_marker setMarkerSize [0.5,0.5];
		sleep 1;
	} forEach _nearestUnits;

	systemChat format ["%1 entities found.",count _nearestUnits];
	systemChat format ["Position tolerance: %1 m",_tolerance];

	sleep _deleteTime;

	for "_i" from 0 to (count _nearestUnits) - 1 do
	{
		deleteMarker format ["tempMarker_%1",_i];
		sleep 1;
	};

	deleteMarker "areaBorderTemp";
};

true
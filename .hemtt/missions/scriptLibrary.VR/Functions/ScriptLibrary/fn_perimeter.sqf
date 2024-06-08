/*
	Author: Revo

	Description:
	Orders units in player's group to set up a perimeter defense

	Parameter(s):
	-
	Returns:
	-
*/

if(count units group player == 1) exitWith {};
_units = units group player;
_count = (count _units) - 1; 								//All units except the player will build a perimeter
_angle = 360/_count; 										//incremental angle

player groupChat "Quick, set up a perimeter";				//Short group message

for "_i" from 1 to _count do 								//starts at 1 in order to ignore the player
{
	_distance = [5,15] call BIS_fnc_randomNum; 				//small distance variations for the visual appearance
	_dir = _i * _angle; 									//direction the unit should watch
	_pos = [player, _distance, _dir] call BIS_fnc_relPos;	//waypoint position
	_posWatch = [player, 50, _dir] call BIS_fnc_relPos; 	//workaround, position to make unit watch proper direction
	_units select _i doMove _pos;
	_units select _i doWatch _posWatch;
	_units select _i setUnitPos "MIDDLE";
};
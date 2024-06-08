/*
   Author: R3vo

   Date: 2019-08-18

   Description:
   Returns the center position of given coordinates or objects.

   Parameter(s):
   0: ARRAY -  Array of position sor objects.

   Returns:
   ARRAY - Array of center in form [x,y,z]
*/

params [["_positions"],[[]]];

private _sumPositions = [0,0,0];

{
	_sumPositions = _sumPositions vectorAdd (_x call BIS_fnc_position);
} forEach _positions;

//Return center position
_sumPositions vectorMultiply 1 / count _positions
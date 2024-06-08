/*
	Author: Revo

	Description:
	Tries to unstuck player's group members by teleporting them to the player's position and rejoining his group.

	Player's initialisation:
	this addAction ["Unstuck group members","unstuckGroup.sqf"];
	Parameter(s):
		-

	Returns:
	-
*/

_unit = param [0,player];
_groupArray = [];

for "_i" from 1 to (count (units group _unit) - 1) do
{
	_offset = [-1,1] call BIS_fnc_selectRandom;
	_pos = getPos ((units group _unit) select _i); 
	((units group _unit) select _i) setPos [((_pos select 0) + _offset),((_pos select 1) + _offset),_pos select 2];
};
sleep 0.1;
_groupArray joinSilent grpNull;
sleep 0.1;
_groupArray joinSilent group _unit;




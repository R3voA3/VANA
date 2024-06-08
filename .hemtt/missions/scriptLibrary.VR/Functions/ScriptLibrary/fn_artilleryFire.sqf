/*
	Author: Revo

	Description:
	Let an artillery fire on the given position

	Parameter(s):
		0: object  - artillery vehicle
		1: array   - position of target, default [0,0,0]
		2: string  - ammunition type, if empty then random one is selected, default ""
		3: number  - number of rounds, default 5
		4: boolean - debug on/off, default false
		5: boolean - unlimited ammunition, default true

	Returns:
	-
*/

_artillery 	= param [0,objNull];
_pos 	    = param [1,[0,0,0]];
_ammoClass  = param [2,nil];
_numRounds	= param [3,1];
_debug 		= param [4,false];
_unlimitedAmmo = param [5,true];


//select a valid ammunition type if none was given
if (isNil "_ammoClass") then
{
	_ammoClass = selectRandom (getArtilleryAmmo [_artillery]);
};
//check if target is in range, if not, displays an error message
_inRange = _pos inRangeOfArtillery [[_artillery],_ammoClass];

if (_inRange) then
{
	_artillery doArtilleryFire [_pos,_ammoClass ,_numRounds];
}
else
{
	["Target is not in range"] call BIS_fnc_error;
};
//display important information
if (_debug) then
{
	_eta  = _artillery getArtilleryETA [_pos,_ammoClass];
	_distance = _artillery distance2D _pos;
	hint format ["ETA: %1 seconds\nDistance %2 meters\n In Range: %3\nAmmunition Type: %4\nUnlimited Ammo: %5",_eta,_distance,_inRange,_ammoClass,_unlimitedAmmo];
};
//fills ammunition of given artillery once fired (would actually need to wait until fire mission is completed in order to completely rearm it)
if (_unlimitedAmmo) then
{
	_artillery setVehicleAmmo 1;
};



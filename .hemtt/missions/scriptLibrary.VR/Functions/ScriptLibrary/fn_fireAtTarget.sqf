/*
	Author: Laxemann edited by Revo

	Description:
	Makes a unit, preferable armour shoot on predefined targets randomly.

	Parameter(s):
		0: - OBJECT - Vehicle
		1: - NUMBER - Min time between attacks
		2: - NUMBER - Max time between attacks
		3: - ARRAY - Number of rounds in format [min, avg, max]
		4: - BOOLEAN - Unlimited ammo
		5: - ARRAY  - Targets, if empty an random position will be choosen


	Returns:
	-
*/

_this spawn
{
	params
	[
		["_vehicle", objNull, [objNull]],
		["_minTime", 20, [1]],
		["_maxTime", 120, [1]],
		["_numRounds", [2, 5, 8], [[]]],
		["_unlimitedAmmo", true, [true]],
		["_targets", [], [[]]]
	];

	private _weapon = weapons _vehicle param [0, ""];
	private _magazine = magazines _vehicle param [0, ""];

	if (_weapon == "" || _magazine == "") exitWith {};

	while {alive _vehicle} do
	{
		// Get a random position
		private _rndPos = if (_targets isEqualTo []) then
		{
			_rndPos = _vehicle getPos [500 +  random worldSize, random 360];
			_rndPos set [2, 150 + random 10000];
		}
		else
		{
			getPos selectRandom _targets;
		};

		_vehicle doWatch _rndPos;

		// Give vehicle time to aim at it
		sleep 10;

		// Fire number of rounds
		private _roundsFinal = round random _numRounds;

		for "_i" from 1 to _roundsFinal do
		{
			private _firedEH = _vehicle addEventHandler ["Fired",
			{
				params ["_vehicle"];
				_vehicle setVariable ["Shot", true];
			}];

			_vehicle fire [_weapon, "", _magazine];

			waitUntil
			{
				sleep 1;
				!isNil {_vehicle getVariable "Shot"}
			};

			_vehicle removeEventHandler ["Fired", _firedEH];
			_vehicle setVariable ["Shot", nil];
		};

		// Wait a random time
		sleep linearConversion [0, 1, random 1, _minTime min _maxTime, _maxTime max _minTime + 1];
	};
};

true
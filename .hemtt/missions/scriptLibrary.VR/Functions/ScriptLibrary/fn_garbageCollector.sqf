/*
	Author: Revo

	Description:
	Delete all obsolete mission objects every 300 seconds.
	Delete objects are: dead units, ruins, craters, items and empty groups

	Parameter(s):
	0: boolean - debug on/off
	Returns:
	-
*/

private _debug  = param [0,false,[false]];

_debug spawn
{
	private _emptyGroups = 0;
	while {true} do
	{
		if (_this) then
		{
			//Collects data for debug
			private _numDead = count allDead;
			private _numRuins = count allMissionObjects "Ruins";
			private _numCraters = count allMissionObjects "CraterLong";
			private _numWeaponHolders  = count allMissionObjects "GroundWeaponHolder";
			//Writes debug data to log file
			diag_log "Garbage Collector Debug Data";
			diag_log format ["Dead Units: %1",_numDead];
			diag_log format ["Ruins: %1",_numRuins];
			diag_log format ["Craters: %1",_numCraters];
			diag_log format ["Weapon Holders: %1",_numWeaponHolders];
		};
			//delete all dead units
			{deleteVehicle _x; false} count allDead;
			//delete all objects in this area
			{deleteVehicle _x; false} count allMissionObjects "GroundWeaponHolder";
			//delete all ruins
			{deleteVehicle _x; false} count allMissionObjects "Ruins";
			//delete all crater objects
			{deleteVehicle _x; false} count allMissionObjects "CraterLong";
			//delete all empty groups
			{
				if (count units _x == 0) then
				{
					deleteGroup _x;
					//Debug for empty groups
					if (_this) then
					{
						private _emptyGroups = _emptyGroups + 1;
						diag_log format ["Empty Groups: %1",_emptyGroups];
					};
					false;
				};
			} count allGroups;
		sleep 300;
	};
};

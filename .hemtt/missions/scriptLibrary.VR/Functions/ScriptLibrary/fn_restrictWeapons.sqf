/*
	Author: Revo

	Description:
	Checks every 10 seconds if a player uses a forbidden weapon defined in _blacklist

	Parameter(s):
	0: array - classnames of forbidden weapons

	Returns:
	-
*/
if(isServer)  exitWith {};

_blackListCustom = param [0,[]]; 
_blacklist = ["launch_B_Titan_short_F","launch_I_Titan_short_F","launch_O_Titan_short_F","launch_Titan_short_F","launch_Titan_short_base"] + _blackListCustom;

while {true} do
{			
	for "_i" from 0 to ((count (weapons player) - 1)) do
	{
		if ((weapons player select _i) in _blacklist) then 
		{
			player removeWeapon ((weapons _x) select _i);
			hintSilent "You were using a restricted weapon. Weapon has been removed.";
		};
	};
	sleep 10;
};

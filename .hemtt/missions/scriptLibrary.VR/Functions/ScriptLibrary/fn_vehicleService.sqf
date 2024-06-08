/*
	Author: Revo

	Description:
	Simple repair/heal script for SINGLEPLAYER. Simply call this script in a trigger to repair the vehicle of the player.
	The triggers need to be prepared beforehand.

	The trigger description needs to be named as follows:

	vehService  - This enables vehicle service in the trigger area
	hospital    - This enables healing for units in the trigger area

	If empty, a error message will be displayed

	Player's initialisation:
	_nil = [thisTrigger] execVM "fn_vehicleService.sqf";
	Parameter(s):
		0: thisTrigger - The trigger which executes the script

	Returns:
	-
*/

_veh = vehicle player;
_trigger = param [0];
_text = triggerText _trigger;

if (_text == "vehService" && ((vehicle player ) != player)) then
{
	 titleText ["Your vehicle is being repaired", "BLACK OUT", 2];
	_veh engineOn false;
	while {fuel _veh < 1} do
	{
		_veh setFuel (fuel _veh + 0.02);
		sleep 0.1;
	};
	waitUntil {fuel _veh >= 1};
	_veh setVehicleAmmo 1;
	_veh setDamage 0;
	titleText ["", "BLACK IN", 2];
};

if (_text == "hospital" && ((vehicle player) == player)) then
{
    titleText ["Your wounds are being treated", "BLACK OUT", 1];
	player setDamage 0;
	player setFatigue 0;
	sleep 3;
	titleText ["", "BLACK IN", 1];
};

if (_text == "") then
{
	hintSilent "Service type has not been defined, please set a trigger description e.g. 'vehService' or 'hospital'.";
};




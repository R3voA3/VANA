/*
	Author: Revo

	Description:
	Adds an eventhandler to all target objects. (SP only)
	- A sound will play if target was hit
	- A hint will display
		- bullet velocity
		- shooter's name
		- distance of target
		- multiplier for points
		- current score

	The points gained by each hit depend on two factors. The distance between shooter and target, and the type of target, or better said, the size. Small targets will give more points than big ones.
	Todo: Add another parameter for the amount of points gained (weapon type) and multiplayer compatibility

	Parameter(s):
	-

	Returns:
	-
*/
//fR stands for firingRange
private ["_targets", "_shooter", "_nameShooter", "_distance", "_velocity", "_multiplier", "_pressure", "_oldScore", "_newScore", "_gainedPoints"];

Revo_fR_swivelTargets 	= allMissionObjects "Target_Swivel_01_base_F";
Revo_fR_steelPlates    	= allMissionObjects "Land_Target_Oval_F";
Revo_fR_balloonsAir 	   = allMissionObjects "Land_Balloon_01_air_F";
Revo_fR_balloonsWater 	= allMissionObjects "Land_Balloon_01_water_F";
Revo_fR_skeets 		   = allMissionObjects "Metal_Pole_Skeet_F" + allMissionObjects "Skeet_Clay_F";
Revo_fR_normalTargets 	= allMissionObjects "targetBase";
_targets = Revo_fR_swivelTargets + Revo_fR_steelPlates + Revo_fR_balloonsAir + Revo_fR_balloonsWater + Revo_fR_skeets + Revo_fR_normalTargets;

{
	_x addEventHandler ["hitPart",
		{
			playSound (selectRandom (getarray (configfile >> "cfgCurator" >> "soundsPing")));
			_target 	    = (_this select 0) select 0;
		   _shooter 	 = (_this select 0) select 1;
		   _nameShooter = name _shooter;
		   _distance 	 = [_target distance _shooter,2] call BIS_fnc_cutDecimals;
		   _velocity 	 = vectorMagnitude ((_this select 0) select 4);
			_velocity 	 = [_velocity,2] call BIS_fnc_cutDecimals;
			_multiplier  = 0.17;
			_pressure    = 1013.25 * exp(((getPos _shooter) select 2)/7990);

			if (isNil {_shooter getVariable "Revo_fR_score"}) then
			{
				_shooter setVariable ["Revo_fR_score",0];
			};

			if (_target in Revo_fR_swivelTargets) then {_multiplier = 0.22};
			if (_target in Revo_fR_steelPlates)   then {_multiplier = 0.28};
			if (_target in Revo_fR_balloonsAir)   then {_multiplier = 0.33};
			if (_target in Revo_fR_balloonsWater) then {_multiplier = 0.33};
			if (_target in Revo_fR_skeets )       then {_multiplier = 0.57};
			if (typeOf _target isEqualTo "Land_Target_Dueling_01_F") then {_multiplier = 0.51};

			_oldScore = _shooter getVariable "Revo_fR_score";
			_shooter setVariable ["Revo_fR_score",((_shooter getVariable "Revo_fR_score") + ((_distance ^ 1.12) * _multiplier))];
			_newScore = _shooter getVariable "Revo_fR_score";
			_newScore = [_newScore,2] call BIS_fnc_cutDecimals;
			_gainedPoints = [_newScore - _oldScore,2] call BIS_fnc_cutDecimals;
		    hintSilent format ["Shooter: %1\nTarget's distance: %2m\nBullet's velocity: %3m/s\nHumidity: %4%5\nBarometic Pressure: %6hPa\nWind direction: %7\n\n---------------------------------------\n\nScore: %8P\nGained Points: +%9\nMultiplier: %10",_nameShooter,_distance,_velocity,humidity,"%",_pressure,[windDir,2] call BIS_fnc_cutDecimals,_newScore,_gainedPoints,_multiplier];
		}];
		false;
} count _targets;

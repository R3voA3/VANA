  /*
	Author: Revo

	Description:
	Creates flares and an alarm sound in given interval.

	Parameter(s):
		0: object - Loudspeaker
		1: side   - Side the alarm belongs to default: east
		2: number - Interval in which the sound is repeated default: 10
		3: string - Name of the alarm sound default: air_raid
		4: bool   - Flares, yes, no? - default: true
	Returns:
	true
*/
private ["_speaker","_side","_soundInterval","_sound","_pos1","_pos2","_pos3"];

//defines all variables and gives them default values to prevent script erros
_speaker = param [0,objNull,[objNull]];
_side = param [1,east];
_soundInterval = param [2,10];
_sound = param [3,"air_raid"];
_flares = param [4,true];
missionNamespace setVariable ["Revo_playAlarm",true];

//add an action to turn of the alarm sound
_speaker addAction ["Turn off Alarm",{missionNamespace setVariable ["Revo_playAlarm",false]; (_this select 0) removeAction (_this select 2); hint "Alarm has been turned off!";}];

//set all units of the given side to COMBAT mode
{
	if (side _x == _side) then
	{
		 _x setBehaviour "COMBAT"
	};
	false;
} count allUnits;

//play the given alarm sound, or play the vanilla one, if none was given
[_speaker,_soundInterval,_sound] spawn
{
	while {missionNamespace getVariable ["Revo_playAlarm",true]} do
	{
		{_x say3D (_this select 2); false} count [_this select 0];
		sleep (_this select 1);
	};
};

if (_flares) then
{
	[_speaker] spawn
	{
		while {true} do
		{
			//create 3 random positions around the _speaker object
			_pos1 = (_this select 0) getPos [random 100,random 360];
			_pos2 = (_this select 0) getPos [random 100,random 360];
			_pos3 = (_this select 0) getPos [random 100,random 360];

			//create 3 flares at the random positions
			_flare1 = createVehicle ["F_20mm_Red", _pos1, [], 0, "NONE"];
			_flare2 = createVehicle ["F_20mm_Red", _pos2, [], 0, "NONE"];
			_flare3 = createVehicle ["F_20mm_Red", _pos3, [], 0, "NONE"];

			//create a light for each flare
			_light1 = "#lightpoint" createVehicle (getPosATL _flare1);
			_light2 = "#lightpoint" createVehicle (getPosATL _flare2);
			_light3 = "#lightpoint" createVehicle (getPosATL _flare3);

			//set the lights properties
			{
				_x setLightBrightness 15;
				_x setLightUseFlare true;
				_x setLightFlareSize 10;
				_x setLightFlareMaxDistance 400;
				_x setLightColor [0, 0, 0];
				false;
			} count [_light1,_light2,_light3];

			//attach the lights to the flares
			_light1 lightAttachObject [_flare1, [0,0,0]];
			_light2 lightAttachObject [_flare2, [0,0,0]];
			_light3 lightAttachObject [_flare3, [0,0,0]];

			//set the kinetics of the flares
			{
				_x setPosATL [getPosATL _x select 0, getPosATL _x select 1, 150 + random 150];
				_x setVelocity [0,0,-0.01];
				false;
			} count [_flare1,_flare2,_flare3];
			sleep (35 + random 50);
		};
	};
};

true;

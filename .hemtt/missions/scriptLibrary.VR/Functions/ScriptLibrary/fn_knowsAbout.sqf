/*
	Author: Revo

	Description:
	Shows a hint which displays how much the defined side knows about the player (Singleplayer only)

	Parameter(s):
		0: side - side which should be tracked
	Returns:
	-
*/
disableSerialization;

if (isMultiplayer) exitWith {};

_sideEnemy = param [0,east];
findDisplay 46 ctrlCreate ["RscStructuredText", 500];
_control = findDisplay 46 displayCtrl 500;
_control ctrlSetPosition [0.5 * safezoneW + safezoneX,0 * safezoneH + safezoneY,0.5 * safezoneW,0.05 * safezoneH];
_control ctrlCommit 0; 


while {alive player} do
{
	_knowsAboutPerc = [(_sideEnemy knowsAbout player) * 100/4,2] call BIS_fnc_cutDecimals; 
	if(_knowsAboutPerc <= 25) then
	{
		_control ctrlSetStructuredText parseText format ["Enemy Awareness: <t size ='1.5' color='#00D60E'>%1%2</t>",_knowsAboutPerc,"%"];
	};
	if(_knowsAboutPerc > 25 && _knowsAboutPerc < 75) then
	{
		_control ctrlSetStructuredText parseText format ["Enemy Awareness: <t size ='1.2' color='#d68100'>%1%2</t>",_knowsAboutPerc,"%"];
	};
	if(_knowsAboutPerc >= 75) then
	{
		_control ctrlSetStructuredText parseText format ["Enemy Awareness: <t size ='1.2' color='#d6000b'>%1%2</t>",_knowsAboutPerc,"%"];
		sleep 2 ;
		_control ctrlSetStructuredText parseText "<t size ='1.2' color='#d6000b'>You've been detected!</t>";
	};
	sleep 1;
}; 
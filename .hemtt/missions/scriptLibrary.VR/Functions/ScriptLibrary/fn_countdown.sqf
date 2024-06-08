/*
	Author: Revo

	Description:
	Shows a global countdown.

	Parameter(s): - number (Countdown in seconds)

	Returns:
	Revo_countdownFinished/true in missionNamespace, false on clients
*/

if (!isServer) exitWith {false};

_countdown = param [0,120,[0]];
_format = param [1,nil,[""]];

missionNamespace setVariable ["Revo_countdownFinished",false];

for "_i" from 1 to _countDown do
{
	_timeleft = format ["Time left: %1",[(_countdown - _i),_format] call BIS_fnc_secondsToString];
	_timeLeft remoteExec ['hintSilent',0];
	sleep 1;
};

missionNamespace setVariable ["Revo_countdownFinished",true];

true;

/*
	Author: Revo

	Description:
	Writes a list with all active scripts into the log file and separates them.

	Parameter(s):
		0: NUMBER - Interval in seconds between each log
		1: NUMBER - Duration of logging in seconds

	Returns:
	BOOLEAN: true / false
*/

if (!canSuspend) exitWith {false};

params [["_interval",5],["_duration",120]];

private _timeStart = diag_tickTime;
private _timeEnd = diag_tickTime + _duration;

while {diag_tickTime - _timeStart < _timeEnd} do
{
	diag_log "************************************************************ACTIVE SQF SCRIPTS************************************************************";
	{
		diag_log str _x;
	}forEach diag_activeSQFScripts;
	diag_log "************************************************************ACTIVE SQS SCRIPTS************************************************************";
	{
		diag_log str _x;
	}forEach diag_activeSQSScripts;
	diag_log "************************************************************ACTIVE FSMs************************************************************";
	{
		diag_log str _x;
	}forEach diag_activeMissionFSMs;

	diag_log "************************************************************ACTIVE SCRIPTS************************************************************";

	diag_activeScripts params ["_spawn","_execVM","_exec","_execFSM"];
	diag_log format ["Number of spawned scripts: %1",_spawn];
	diag_log format ["Number of spawned scripts: %1",_execVM];
	diag_log format ["Number of spawned scripts: %1",_exec];
	diag_log format ["Number of spawned scripts: %1",_execFSM];
	sleep _interval;
};

true
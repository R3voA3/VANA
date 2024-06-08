ENH_SPR_RespawnTime = 10;
ENH_SPR_Tickets = 50;
ENH_SPR_RespawnType = 0;
ENH_SPR_CanDie = false;
ENH_SPR_BleedOutTime = 100;

//Fix rare cases where player is not revived (Call medic doesn't always seem to work, check variables on units)
//Fix issues with incorrect formation of group
//Improve dmg handling, see BIS Revive
//Test what happens if only one medic is in team

//Get all respawn markers and convert them into respawn positions
ENH_SPR_Positions_West = allMapMarkers select {'respawn_west' in _x} apply {getMarkerPos _x};
ENH_SPR_Positions_East = allMapMarkers select {'respawn_east' in _x} apply {getMarkerPos _x};
ENH_SPR_Positions_Guerilla = allMapMarkers select {'respawn_guerilla' in _x} apply {getMarkerPos _x};
ENH_SPR_Positions_Civilian = allMapMarkers select {'respawn_civlian' in _x} apply {getMarkerPos _x};

{
	_x setVariable ['ENH_SPR_OriginalSide',side _x];
	_x removeAllEventHandlers "HandleDamage";
	_x addEventHandler ['handleDamage',
	{
		params ["_unit","_selection","_handleDamage","","","_hitIndex"];
		if (_handleDamage < 0.1) exitWith {0};//From BIS Revive
		if (!alive _unit) exitWith {0};//From BIS Revive
		if (lifeState _unit isEqualTo "INCAPACITATED") exitWith {0};

		//If tickets are used, let the unit die
		if (_unit getVariable ['ENH_SPR_UsedTickets',0] >= ENH_SPR_Tickets) exitWith {_unit removeEventHandler ['handleDamage',_thisEventHandler]};
	
 		//If damage received to head, neck or face is greater 1, unit can die instantly.
		if (ENH_SPR_CanDie && {_hitIndex in [0,1,2] && {_handleDamage > 1}}) exitWith {1};

		if(_selection == "" && _handleDamage >= 0.95) then
		{
			_unit call ENH_fnc_SPR_setUpUnconcious;
			_unit spawn ENH_fnc_SPR_startTimer;
			_unit spawn ENH_fnc_SPR_callMedic;
			_handleDamage = 0;		
		};
		
		_handleDamage min 0.95
	}];
} forEach units player;

ENH_fnc_SPR_callMedic =
{
	sleep 2;
	params ["_unconsciousUnit"];
	private _medic = _unconsciousUnit call ENH_fnc_SPR_findMedic;
	if (call ENH_fnc_SPR_needsMedic && {isNull _medic}) exitWith
	{
		_unconsciousUnit call ENH_fnc_SPR_callMedic;
	};
	
	[_medic,_unconsciousUnit] call ENH_fnc_SPR_setUpMedic;
	systemChat "Medic is on the way!";
	waitUntil {_medic distance _unconsciousUnit <= 5 || !(_unconsciousUnit call ENH_fnc_SPR_needsMedic)};

	if !(call ENH_fnc_SPR_needsMedic) exitWith
	{
		_medic call ENH_fnc_SPR_resetMedic;
	};
	_medic attachTo [_unconsciousUnit, [0.5,0,0]];
	_medic setDir 270;
	_medic call ENH_fnc_SPR_dropSmoke;
	_medic switchMove "Acts_TreatingWounded05";
	_medic disableAI "ANIM";
	_medic call ENH_fnc_SPR_createClutter;
	sleep random [5,10,20];
	_unconsciousUnit call ENH_fnc_SPR_resetUnconcious;
	_medic call ENH_fnc_SPR_resetMedic;
};

ENH_fnc_SPR_startTimer =
{
	params ['_unit'];
	_unit setDamage (0.1 max damage _unit);
	_unit setBleedingRemaining ENH_SPR_BleedOutTime;
	if (isPlayer _unit) then
	{
		private _ctrlCounter = (call BIS_fnc_displayMission) displayCtrl 1337;
		if (isNull _ctrlCounter) then
		{
			_ctrlCounter = (call BIS_fnc_displayMission) ctrlCreate ['RscStructuredText',1337];
		};
		_ctrlCounter ctrlSetPosition [0.25,0,0.5,0.06];
		_ctrlCounter ctrlCommit 0;

		while {getBleedingRemaining _unit > 0 && {(lifeState _unit isEqualTo "INCAPACITATED")}} do
		{
			_ctrlCounter ctrlSetStructuredText parseText format ['<t size=''1.25'' color=''#218a36'' align=''center''>Time until bleedout: %1 s.</t>',[getBleedingRemaining _unit,'HH:MM'] call BIS_fnc_timeToString];
			sleep 0.1;
		};
		if !(lifeState _unit isEqualTo "INCAPACITATED") exitWith {ctrlDelete _ctrlCounter};
		
		//Respawn
	 	0 cutText ['','BLACK OUT',0.3];
		0.3 fadeMusic 0;
		0.3 fadeRadio 0;
		0.3 fadeSpeech 0;
		showChat false;

		private _respawnTime = time + ENH_SPR_RespawnTime;
		while {time <= _respawnTime}  do
		{
			_ctrlCounter ctrlSetStructuredText parseText format ['<t size=''1.25'' color=''#218a36'' align=''center''>Respawn in %1 seconds.</t>',[(_respawnTime - time),'HH:MM'] call BIS_fnc_timeToString];
			sleep 0.1;
		};

		ctrlDelete _ctrlCounter;
		_unit call ENH_fnc_SPR_respawn;

 		0 cutText ['','BLACK IN',8];
		8 fadeMusic 1;
		8 fadeRadio 1;
		8 fadeSpeech 1;
		showChat true;
		
 		[
			['Respawned'],
			[format ['GRID:%1',mapGridPosition _unit]],
			[format ['Tickets used: %1/%2',_unit getVariable ['ENH_SPR_UsedTickets',0],ENH_SPR_Tickets]]
		] spawn BIS_fnc_EXP_camp_SITREP;
	}
	else
	{
		waitUntil {getBleedingRemaining _unit == 0 || {!(lifeState _unit isEqualTo "INCAPACITATED")}};
		if !(lifeState _unit isEqualTo "INCAPACITATED") exitWith {false};
		sleep ENH_SPR_RespawnTime;
		_unit call ENH_fnc_SPR_respawn;
	};
};

ENH_fnc_SPR_respawn =
{
	params ['_unit'];
	if (ENH_SPR_RespawnType > 0) then
	{  
		private _sideID = (_unit getVariable ['ENH_SPR_OriginalSide',west]) call BIS_fnc_sideID;
		private _positions = [ENH_SPR_Positions_East,ENH_SPR_Positions_West,ENH_SPR_Positions_Guerilla,ENH_SPR_Positions_Civilian] select _sideID;
		if !(_positions isEqualTo []) then
		{
			private _respawnPos = if (ENH_SPR_RespawnType == 1) then
			{
				selectRandom _positions;
			}
			else
			{
				([_positions,[],{_unit distance _x},'ASCEND'] call BIS_fnc_sortBy) select 0;
			};
			_unit setPos _respawnPos;
		};
	};
	_unit call ENH_fnc_SPR_resetUnconcious;
	_unit setVariable ['ENH_SPR_UsedTickets',(_unit getVariable ['ENH_SPR_UsedTickets',0]) + 1];
};

ENH_fnc_SPR_canBeMedic =
{
	params ["_unit","_unconsciousUnit"];
	if (isPlayer _unit) exitWith {false; systemChat "Is Player"};
	if !(alive _unit) exitWith {false; systemChat "isDead"};
	if !((_unconsciousUnit getVariable "ENH_SPR_OriginalSide") in (_unit call BIS_fnc_friendlySides)) exitWith {false; systemChat "Wrong side"};
	if (_unit isEqualTo _unconsciousUnit) exitWith {false; systemChat "Is uncon. unit"};
	if !(_unit distance _unconsciousUnit < 200) exitWith {false;};
	if !(("Medikit" in items _unit) || ("FirstAidKit" in items _unit)) exitWith {false; systemChat "No Medikits"};
	if !(_unit getVariable ["ENH_SPR_isAvailable",true]) exitWith {false;};
	if (lifeState _unit isEqualTo "INCAPACITATED") exitWith {false;  systemChat "Unit is unconcious"};
	if !(vehicle _unit isEqualTo _unit) exitWith {false; systemChat "unit is in vehicle"};
	true
};

ENH_fnc_SPR_createClutter =
{
	params ["_medic"];
	private _clutterPool =
	[
		"MedicalGarbage_01_3x3_v1_F",
		"MedicalGarbage_01_3x3_v2_F"
	];
	private _pos = AGLtoASL (_medic getRelPos [0.4,random 360]);
	private _clutter = createSimpleObject [selectRandom _clutterPool,_pos];
	_clutter setDir random 360;
	_clutter setVectorUp surfaceNormal _pos;
	true
};

ENH_fnc_SPR_setUpUnconcious =
{
	params ["_unit"];
	moveOut _unit;
	_unit allowDamage false;
	_unit setCaptive true;
	_unit setUnconscious true;
	_unit disableConversation true;
	private _actionID =
	[
		_unit,												// Object the action is attached to
		localize "STR_A3_REVIVETITLE",						// Title of the action
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",	// Idle icon shown on screen
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",	// Progress icon shown on screen
		"_this distance _target < 2",						// Condition for the action to be shown
		"getBleedingRemaining _target != 0",						// Condition for the action to progress
		{
			params ["_target"];
			_target setVariable ["ENH_SPR_IsBeingTreated",true];
			_target call ENH_fnc_SPR_createClutter;
		},													// Code executed when action starts
		{},													// Code executed on every progress tick
		{
			params ["_target"];
			_target call ENH_fnc_SPR_resetUnconcious;
			_medic = _target getVariable ["ENH_SPR_PersonalMedic",objNull];
			_medic call ENH_fnc_SPR_resetMedic;
		 },													// Code executed on completion
		{},													// Code executed on interrupted
		[],													// Arguments passed to the scripts as _this select 3
		random [5,10,20],													// Action duration [s]
		10000,													// Priority
		true,												// Remove on completion
		false												// Show in unconscious state 
	] call BIS_fnc_holdActionAdd;

	_unit setVariable ["ENH_SPR_ActionID",_actionID];

	[
		str _unit,"onEachFrame",
		{
			params ["_unconsciousUnit"];
			drawIcon3D ["\a3\ui_f\data\igui\cfg\actions\Heal_ca.paa",[1,0,0,0.8],ASLToAGL getPosASL _unconsciousUnit,0.5,0.5,0,format ["(%1)",round getBleedingRemaining _unconsciousUnit]];
		},
		[_unit]
	] call BIS_fnc_addStackedEventHandler;
};

ENH_fnc_SPR_resetUnconcious =
{
	params ["_unit"];
	_unit setUnconscious false;
	_unit setCaptive false;
	_unit allowDamage true;
	_unit setDamage 0;
	_unit doFollow leader group _unit;
	_unit disableConversation false;
	[str _unit,"onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	[
		_unit,
		_unit getVariable ["ENH_SPR_ActionID",-1]
	] call BIS_fnc_holdActionRemove;
};

ENH_fnc_SPR_setUpMedic =
{
	params ["_medic","_unconsciousUnit"];
	_medic setVariable ["ENH_SPR_originalGroup",group _medic];
	_medic setVariable ["ENH_SPR_isAvailable",false];
	_medic allowDamage false;
	_medic setCaptive true;
	// AI instructions
	_medic setBehaviour "AWARE";
	_medic allowFleeing 0;
	{
		_medic disableAI _x;
	} forEach ["AUTOCOMBAT","AUTOTARGET","SUPPRESSION","COVER","TARGET"];

 	private _medicGRP = createGroup (side _medic);
	[_medic] joinSilent _medicGRP;
	if (currentCommand _medic != "MOVE") then 
	{
		_medic stop false;
		_medic doMove (position (vehicle _unconsciousUnit));
	};
	//_medicGRP move position player;
	[
		str _medic,"onEachFrame",
		{
			params ["_medic"];
			drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",[1,0,0,0.8],ASLToAGL (_medic modelToWorldVisualWorld [0,0,2]),0.5,0.5,0,"Medic"];
		},
		[_medic]
	] call BIS_fnc_addStackedEventHandler;
};

ENH_fnc_SPR_resetMedic =
{
	params ["_medic"];
	detach _medic;
	_medic switchMove "";
	{
		_medic enableAI _x;
	} forEach ["AUTOCOMBAT","AUTOTARGET","SUPPRESSION","FSM","CHECKVISIBLE","CHECKVISIBLE","COVER","TARGET","ANIM"];
		
	_medic allowDamage true;
	_medic setCaptive false;
	
	[_medic] joinSilent (_medic getVariable "ENH_SPR_originalGroup");
	_medic doFollow leader group _medic;
	[str _medic,"onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	_medic setVariable ["ENH_SPR_isAvailable",true];
};

ENH_fnc_SPR_dropSmoke =
{
	params ["_medic"];
	private _grenades = magazines _medic select {"SmokeShell" in _x};
	if (_grenades isEqualTo []) exitWith {false};
	private _grenade = selectRandom _grenades; 
	_grenade createVehicle (_medic getRelPos [random 3,random 360]); 
	_medic removeItem  _grenade;
};

ENH_fnc_SPR_findMedic =
{
	params ["_unconsciousUnit"];
	private _medicPool = [];
	{
		if ([_x,_unconsciousUnit] call ENH_fnc_SPR_canBeMedic) then {_medicPool pushBack _x};
	} forEach units player;
	if !(_medicPool isEqualTo []) then 
	{
		selectRandom _medicPool
	} 
	else 
	{
		objNull;
	};
};

ENH_fnc_SPR_needsMedic =
{
	params ["_unconsciousUnit"];
	!(_unconsciousUnit getVariable ["ENH_SPR_IsBeingTreated",false]) && {(lifeState _unconsciousUnit isEqualTo "INCAPACITATED") || {(getBleedingRemaining _unconsciousUnit > 0)}}
};

true
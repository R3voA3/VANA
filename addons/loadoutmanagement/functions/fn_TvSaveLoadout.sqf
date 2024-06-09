disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_loadoutName", "", [""]]
];

//Check if loadout is duplicate
private _duplicateLoadout = _loadoutName in (profileNamespace getVariable ["BIS_fnc_saveInventory_Data", []] select {_x isEqualType ""});

//Normal Save function (Has to be run in order to acctuly save the loadout)
private _center = missionNamespace getVariable ["BIS_fnc_arsenal_center", player];

[
	_center,
	[profileNamespace, _loadoutName],
	[
		_center getVariable ["BIS_fnc_arsenal_face", face _center],
		speaker _center,
		_center call BIS_fnc_getUnitInsignia
	]
] call BIS_fnc_saveInventory;

//Find and Validate Updated Loadout
if _duplicateLoadout exitWith
{
	[_ctrlTV, [[_ctrlTV, [[-1], _loadoutName], "TvLoadout"] Call VANA_fnc_tvGetPosition, _loadoutName]] call VANA_fnc_tvValidateLoadout;

	["showMessage", [(ctrlparent _ctrlTV), format [localize "STR_VANA_LOADOUT_REPLACED", _loadoutName]]] spawn BIS_fnc_arsenal;

	[[-1], _loadoutName]
};

//Create Subtv for loadout
private _selectedPath = tvCurSel _ctrlTV;
private _tvData = toLower (_ctrlTV tvData _selectedPath);

if (_tvData isEqualto "tvloadout") then
{
	_selectedPath resize (count _selectedPath-1);
};

private _returnValue = [_ctrlTV, [_selectedPath, _loadoutName]] call VANA_fnc_tvCreateLoadout;

[_ctrlTV, _returnValue] call VANA_fnc_tvValidateLoadout;

["showMessage", [ctrlparent _ctrlTV, format [localize "STR_VANA_LOADOUT_SAVED", _loadoutName]]] spawn BIS_fnc_arsenal;

_returnValue
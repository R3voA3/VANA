disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_loadoutName", "", [""]],
	"_center",
	"_duplicateLoadout",
	"_targetTV",
	"_tvData",
	"_returnValue"
];

//Check if loadout is duplicate
_duplicateLoadout = _loadoutName in (profileNamespace getVariable ["BIS_fnc_saveInventory_Data",[]] select {_x isEqualType ""});

//Normal Save function (Has to be run in order to acctuly save the loadout)
_center = (missionNamespace getVariable ["BIS_fnc_arsenal_center",player]);
[
	_center,
	[profileNamespace,_loadoutName],
	[
		_center getVariable ["BIS_fnc_arsenal_face",face _center],
		speaker _center,
		_center call BIS_fnc_getUnitInsignia
	]
] call BIS_fnc_saveInventory;

//Find and Validate Updated Loadout
if _duplicateLoadout exitWith
{
	[_ctrlTV, [([_ctrlTV, [[-1], _loadoutName], "TvLoadout"] Call VANA_fnc_tvGetPosition), _loadoutName]] call VANA_fnc_tvValidateLoadout;
	["showMessage",[(ctrlparent _ctrlTV), (format ["Replaced existing loadout: ""%1""", _loadoutName])]] spawn BIS_fnc_arsenal;

	[[-1], _loadoutName]
};

//Create Subtv for loadout
_targetTV = tvCurSel _ctrlTV;
_tvData = toLower (_ctrlTV tvData _targetTV);

if (_tvData isEqualto "tvloadout") then
{
	_targetTV resize (count _targetTV-1);
};

_returnValue = [_ctrlTV, [_targetTV, _loadoutName]] call VANA_fnc_tvCreateLoadout;

[_ctrlTV, _returnValue] call VANA_fnc_tvValidateLoadout;
["showMessage",[(ctrlparent _ctrlTV), (format ["Loadout: ""%1"" Saved", _loadoutName])]] spawn BIS_fnc_arsenal;

_returnValue
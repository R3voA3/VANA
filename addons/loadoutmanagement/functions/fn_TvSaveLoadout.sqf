disableserialization;

params
[
	["_ctrlTV", controlnull, [controlnull]],
	["_LoadoutName", "", [""]],
  "_center",
  "_DuplicateLoadout",
	"_targetTV",
	"_tvData",
	"_ReturnValue"
];

//Check if loadout is duplicate
_duplicateLoadout = _LoadoutName in (profilenamespace getVariable ["bis_fnc_saveInventory_Data",[]] select {_x isequaltype ""});

//Normal Save function (Has to be run in order to acctuly save the loadout)
_center = (missionnamespace getVariable ["BIS_fnc_arsenal_center",player]);
[
  _center,
  [profilenamespace,_LoadoutName],
  [
    _center getVariable ["BIS_fnc_arsenal_face",face _center],
    speaker _center,
    _center call bis_fnc_getUnitInsignia
  ]
] call bis_fnc_saveInventory;

//Find and Validate Updated Loadout
if _DuplicateLoadout exitwith
{
	[_ctrlTV, [([_ctrlTV, [[-1], _LoadoutName], "TvLoadout"] Call VANA_fnc_tvGetPosition), _LoadoutName]] call VANA_fnc_tvValidateLoadout;
	["showMessage",[(ctrlparent _ctrlTV), (format ["Replaced existing loadout: ""%1""", _LoadoutName])]] spawn BIS_fnc_arsenal;

 	[[-1], _LoadoutName]
};

//Create Subtv for loadout
_targetTV = tvCurSel _ctrlTV;
_tvData = toLower (_ctrlTV tvData _targetTV);

if (_tvData isEqualto "tvloadout") then
{
  _targetTV resize (count _targetTV-1);
};

_returnValue = [_ctrlTV, [_targetTV, _LoadoutName]] call VANA_fnc_tvCreateLoadout;

[_ctrlTV, _ReturnValue] call VANA_fnc_tvValidateLoadout;
["showMessage",[(ctrlparent _ctrlTV), (format ["Loadout: ""%1"" Saved", _LoadoutName])]] spawn BIS_fnc_arsenal;

_returnValue
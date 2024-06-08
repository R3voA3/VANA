disableserialization;

params
[
	["_ctrlTV", controlnull, [controlnull]],
	["_arguments", [], [[]]],
	["_behavior", "", [""]],
	"_loadoutData",
	"_loadoutPath",
	"_loadoutAdd"
];

_arguments params
[
	["_targetTV", tvCurSel _ctrlTV, [[]]],
	["_loadoutName", "", [""]]
];

_behavior = toLower _behavior;
_loadoutData = profileNamespace getVariable ["BIS_fnc_saveInventory_data",[]];

If !(_loadoutName in _loadoutData) exitwith {[[-1], ""]};

//Create Loadout in treeview
_loadoutPath = +_targetTV;

_loadoutAdd = _ctrlTV tvAdd [_targetTV,_loadoutName];
_loadoutPath pushBack _loadoutAdd;

//Visualy/Technical classify Tab
_ctrlTV tvSetData [_loadoutPath, "tvloadout"];

if !(_behavior in ["firsttimesetup", "dragdrop"]) then
{
	_ctrlTV tvExpand _targetTV;
	_ctrlTV tvSetCurSel ([_ctrlTV, [_targetTV, _loadoutName], "tvloadout"] call VANA_fnc_tvGetPosition);
};

[_loadoutPath, _loadoutName]
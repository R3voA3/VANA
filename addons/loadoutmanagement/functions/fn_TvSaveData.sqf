disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]]
];

private _savedData = profileNamespace getVariable ["VANA_fnc_treeViewSave_data", []];
private _VANAData = [_ctrlTV] call VANA_fnc_tvGetData;

if (_savedData isNotEqualTo _VANAData) exitWith
{
	profileNamespace setVariable ["VANA_fnc_treeViewSave_Data", _VANAData];
	saveProfileNamespace;

	true
};

false
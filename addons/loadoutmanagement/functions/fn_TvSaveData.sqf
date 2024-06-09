disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	"_SavedData",
	"_VANAData"
];

_savedData = (profileNamespace getVariable ["VANA_fnc_treeViewSave_Data",[]]);
_vANAData = [_ctrlTV] call VANA_fnc_tvGetData;

if !(_SavedData isEqualTo _VANAData) exitwith
{
	profileNamespace setVariable ["VANA_fnc_treeViewSave_Data", _VANAData];
	saveProfileNamespace;

	true
};

false
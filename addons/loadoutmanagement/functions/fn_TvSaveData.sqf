disableserialization;

params
[
	["_ctrlTV", controlnull, [controlnull]],
	"_SavedData",
	"_VANAData"
];

_savedData = (profilenamespace getVariable ["VANA_fnc_treeViewSave_Data",[]]);
_vANAData = [_ctrlTV] call VANA_fnc_tvGetData;

if !(_SavedData isequalto _VANAData) exitwith
{
	profilenamespace setvariable ["VANA_fnc_treeViewSave_Data", _VANAData];
	saveProfileNamespace;

	true
};

false
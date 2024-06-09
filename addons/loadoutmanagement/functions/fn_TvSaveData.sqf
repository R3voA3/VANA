disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	"_savedData",
	"_vANAData"
];

_savedData = (profileNamespace getVariable ["VANA_fnc_treeViewSave_Data",[]]);
_vANAData = [_ctrlTV] call VANA_fnc_tvGetData;

if !(_savedData isEqualTo _vANAData) exitwith
{
	profileNamespace setVariable ["VANA_fnc_treeViewSave_Data", _vANAData];
	saveProfileNamespace;

	true
};

false
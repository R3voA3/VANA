disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_VANAData", profileNamespace getVariable ["VANA_fnc_treeViewSave_data", []], [[]]] //Form in which data is saved in is [["Name", [Position], "DataType", Value], ["Name", [Position], "DataType", Value], ["Name", [Position], "DataType", Value]] ect.
];

_VANAData = +_VANAData;
private _loadoutData = profileNamespace getVariable ["BIS_fnc_saveInventory_Data", []];
private _loadoutNames = [];

//Create all loadouts if there is no saved data
if (_VANAData isEqualTo []) exitWith
{
	{
		[_ctrlTV, [[], _x], "FirstTimeSetup"] call VANA_fnc_tvCreateLoadout;
	} foreach (_loadoutData select {_x isEqualType ""});

	[_ctrlTV, [_ctrlTV, [[], "TvLoadout"]] call VANA_fnc_tvGetData] call VANA_fnc_tvValidateLoadouts;
	false;
};

//Send data to co responding create functions
{
	_x params ["_tvName", "_tvPosition", "_tvData"];

	_tvData = toLower _tvData;
	_tvPosition resize (count _tvPosition - 1);

	if (_tvData == "tvtab") then
	{
		[_ctrlTV, [_tvPosition, _tvName], "FirstTimeSetup"] call VANA_fnc_tvCreateTab;
	};

	if (_tvData == "tvloadout") then
	{
		_loadoutNames pushBack _tvName;
		[_ctrlTV, [_tvPosition, _tvName], "FirstTimeSetup"] call VANA_fnc_tvCreateLoadout;
	};
} foreach _VANAData;

//Create loadouts that weren't created
{
	[_ctrlTV, [[], _x]] call VANA_fnc_tvCreateLoadout;
} foreach (_loadoutData select {_x isEqualType "" && !(_x in _loadoutNames)});

[_ctrlTV, [_ctrlTV, [[], "TvLoadout"]] call VANA_fnc_tvGetData] call VANA_fnc_tvValidateLoadouts;

true
disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_arguments", [], [[]]]
];

_arguments params
[
	["_path", [], [[]]],
	["_name", "", [""]]
];

private _tvData = toLower (_ctrlTV tvData _path);
private _tvName = _ctrlTV tvText _path;

_ctrlTV tvSetText [_path, _name];

if (_tvData == "tvloadout") then
{
	//rename loadout in profile data
	private _loadoutData = profileNamespace getVariable ["BIS_fnc_saveInventory_data", []];
	private _index = _loadoutData find _tvName;

	_loadoutData set [_index, _name];
	saveProfileNamespace;
};

true
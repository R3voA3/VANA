disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_arguments", [], [[]]],
	"_tvData",
	"_tvName",
	"_loadoutData",
	"_dataPosistion"
];

_arguments params
[
	["_targetTV", (tvCurSel _ctrlTV), [[]]],
	["_name", "", [""]]
];

_tvData = toLower (_ctrlTV tvData _targetTV);
_tvName = _ctrlTV tvText _targetTV;

_ctrlTV tvSetText [_targetTV, _name];
if (_tvData == "tvloadout") then
{
	//rename loadout in profile data
	_loadoutData = profileNamespace getVariable ["BIS_fnc_saveInventory_Data",[]];
	_dataPosistion = _loadoutData find _tvName;

	_loadoutData set [_dataPosistion, _name];
	saveProfileNamespace;
};

true
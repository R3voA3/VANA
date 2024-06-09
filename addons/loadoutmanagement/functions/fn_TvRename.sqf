disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_arguments", [], [[]]],
	"_tvData",
	"_tvName",
	"_LoadoutData",
	"_DataPosistion"
];

_arguments params
[
	["_targetTV", (tvCurSel _ctrlTV), [[]]],
	["_Name", "", [""]]
];

_tvData = toLower (_ctrlTV tvData _targetTV);
_tvName = _ctrlTV tvText _targetTV;

_ctrlTV tvSetText [_targetTV, _Name];
if (_tvData == "tvloadout") then
{
	//rename loadout in profile data
	_LoadoutData = profileNamespace getVariable ["BIS_fnc_saveInventory_Data",[]];
	_DataPosistion = _LoadoutData find _tvName;

	_LoadoutData set [_DataPosistion, _Name];
	saveProfileNamespace;
};

true
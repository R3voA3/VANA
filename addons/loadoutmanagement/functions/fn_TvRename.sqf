disableserialization;

params
[
	["_ctrlTV", controlnull, [controlnull]],
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
if (_tvData isequalto "tvloadout") then
{
	//rename loadout in profile data
	_LoadoutData = profilenamespace getVariable ["bis_fnc_saveInventory_Data",[]];
	_DataPosistion = _LoadoutData find _tvName;

	_LoadoutData set [_DataPosistion, _Name];
	saveProfileNamespace;
};

true
disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_targetTV", tvCurSel (_this select 0), [[]]],
	"_tvName",
	"_tvData",
	"_targetTvParent",
	"_targetTVChildren",
	"_center",
	"_tvDataString",
	"_aboveTab",
	"_lastNumber"
];

_tvName = _ctrlTV tvText _targetTV;
_tvData = toLower (_ctrlTV tvData _targetTV);
_targetTvParent = _targetTV call VANA_fnc_tvGetParent;

switch _tvData do
{
	case "tvtab":
	{
		//Recreates all loadouts under tab
		_targetTVChildren = [_ctrlTV, [_targetTV]] call VANA_fnc_tvGetData;

		{
			if (toLower (_x select 2) == "tvloadout") then
			{
				[_ctrlTV, [_targetTvParent, _x]] call VANA_fnc_tvCreateLoadout;
			};
		} foreach _targetTVChildren;
	};

	case "tvloadout":
	{
		//Delete loadout from profiledata
		_center = (missionNamespace getVariable ["BIS_fnc_arsenal_center", player]);
		[_center, [profileNamespace, _tvName], nil, true] call BIS_fnc_saveInventory;
	};
};

_tvDataString = ["Tab", "Loadout"] select (_tvData == "tvloadout");
["showMessage", [(ctrlparent _ctrlTV), (format ["%1: ""%2"" Deleted", _tvDataString, _tvName])]] spawn BIS_fnc_arsenal;

_ctrlTV tvDelete _targetTV;

//Select next subtv
_aboveTab = +_targetTV;
_lastNumber = _aboveTab select (count _aboveTab - 1);

if (_lastNumber != 0) then
{
	_aboveTab set [count _aboveTab - 1, _lastNumber - 1];
};

if ([_ctrlTV, _targetTV] call VANA_fnc_tvExists) then
{
	_ctrlTV tvSetCurSel _targetTV;
}
else
{
	if ([_ctrlTV, _aboveTab] call VANA_fnc_tvExists) then
	{
		_ctrlTV tvSetCurSel _aboveTab;
	}
	else
	{
		if (_targetTvParent isNotEqualTo []) then
		{
			_ctrlTV tvSetCurSel _targetTvParent;
		};
	};
};

_targetTV
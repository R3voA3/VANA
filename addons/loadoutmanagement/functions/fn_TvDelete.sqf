disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_selectedPath", [], [[]]]
];

private _tvText = _ctrlTV tvText _selectedPath;
private _tvData = toLower (_ctrlTV tvData _selectedPath);
private _targetTVParent = _selectedPath call VANA_fnc_tvGetParent;

switch _tvData do
{
	case "tvtab":
	{
		//Recreates all loadouts under tab
		private _targetTVChildren = [_ctrlTV, [_selectedPath]] call VANA_fnc_tvGetData;

		{
			if (toLower (_x select 2) == "tvloadout") then
			{
				[_ctrlTV, [_targetTVParent, _x]] call VANA_fnc_tvCreateLoadout;
			};
		} foreach _targetTVChildren;
	};

	case "tvloadout":
	{
		//Delete loadout from profile data
		private _center = missionNamespace getVariable ["BIS_fnc_arsenal_center", player];
		[_center, [profileNamespace, _tvText], nil, true] call BIS_fnc_saveInventory;
	};
};

//Show message
private _tvDataString = ["STR_VANA_TAB_DELETED", "STR_VANA_LOADOUT_DELETED"] select (_tvData == "tvloadout");
["showMessage", [ctrlparent _ctrlTV, format [localize _tvDataString, _tvText]]] spawn BIS_fnc_arsenal;

_ctrlTV tvDelete _selectedPath;

//Select next sub item
private _aboveTab = +_selectedPath;
private _lastNumber = _aboveTab select (count _aboveTab - 1);

if (_lastNumber != 0) then
{
	_aboveTab set [count _aboveTab - 1, _lastNumber - 1];
};

if ([_ctrlTV, _selectedPath] call VANA_fnc_tvExists) then
{
	_ctrlTV tvSetCurSel _selectedPath;
}
else
{
	if ([_ctrlTV, _aboveTab] call VANA_fnc_tvExists) then
	{
		_ctrlTV tvSetCurSel _aboveTab;
	}
	else
	{
		if (_targetTVParent isNotEqualTo []) then
		{
			_ctrlTV tvSetCurSel _targetTVParent;
		};
	};
};

_selectedPath
disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_parentTv", [], [[]]],
	["_checkSubTv", true, [true]]
];

if (_parentTv isEqualTo [-1]) exitWith {false};

//Add !!!!!!!!!! to all loadouts
private _targetTvLoadouts = [_ctrlTV, [_parentTv, "Tvloadout"], [], false] call VANA_fnc_tvGetData;

{
	_ctrlTV tvSetText [_x select 1, format ["!!!!!!!!!!%1", _x select 0]];
} foreach _targetTvLoadouts;

//Sort tree view so that all loadouts are at the top
_ctrlTV tvSort [_parentTv, true];
_ctrlTV tvSort [_parentTv, false];

private _targetTVChildren = [_ctrlTV, [_parentTv, "All"], [], false] call VANA_fnc_tvGetData;

{
	_x params ["_tvName", "_tvPosition", "_type"];

	switch (toLower _type) do
	{
		case "tvloadout":
		{
			//Remove !!!!!!!!!! in front of loadout name
			_ctrlTV tvSetText [_tvPosition, (_tvName select [10, count _tvName - 10])];
		};
		case "tvtab":
		{
			if (_checkSubTv && _ctrlTV tvCount _tvPosition > 0) then
			{
				[_ctrlTV, _tvPosition] call VANA_fnc_tvSorting;
			};
		};
	};
} foreach _targetTVChildren;

true
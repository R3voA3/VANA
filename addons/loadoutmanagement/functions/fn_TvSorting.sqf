disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_parentTv", [], [[]]],
	["_checkSubTv", true, [true]],
	"_targetTVChildren",
	"_targetTvLoadouts"
];

if (_parentTv isEqualTo [-1]) exitWith {false};

//Add ! to all loadouts
_targetTvLoadouts = [_ctrlTV, [_parentTv, "Tvloadout"], [], false] call VANA_fnc_tvGetData;
{
	_ctrlTV tvSetText [_x select 1, (format ["!!!!!!!!!!%1", _x select 0])];
} foreach _targetTvLoadouts;

//Sort treeview (All loadouts will be above)
_ctrlTV tvSort [_parentTv, true];
_ctrlTV tvSort [_parentTv, false];

_targetTVChildren = [_ctrlTV, [_parentTv, "All"], [], false] call VANA_fnc_tvGetData;
{
	params ["_tvName","_tvPosition"];

	_tvName = _x select 0;
	_tvPosition = _x select 1;

	switch (toLower (_x select 2)) do
	{
		case "tvloadout":
		{
			_ctrlTV tvSetText [_tvPosition, (_tvName select [10, (count _tvName-10)])];
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
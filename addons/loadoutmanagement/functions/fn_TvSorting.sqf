disableserialization;

params
[
  ["_ctrlTV", controlnull, [controlnull]],
  ["_ParentTv", [], [[]]],
  ["_CheckSubTv", true, [true]],
  "_targetTVChildren",
  "_targetTvLoadouts"
];

if (_ParentTv isequalto [-1]) exitwith {false};

//Add ! to all loadouts
_targetTvLoadouts = [_ctrlTV, [_ParentTv, "Tvloadout"], [], false] call VANA_fnc_tvGetData;
{
  _ctrlTV tvsettext [_x select 1, (Format ["!!!!!!!!!!%1", _x select 0])];
} foreach _targetTvLoadouts;

//Sort treeview (All loadouts will be above)
_ctrlTV tvsort [_ParentTv, true];
_ctrlTV tvsort [_ParentTv, false];

_targetTVChildren = [_ctrlTV, [_ParentTv, "All"], [], false] call VANA_fnc_tvGetData;
{
  params ["_tvName","_TvPosition"];

  _tvName = _x select 0;
  _TvPosition = _x select 1;

  switch (toLower (_x select 2)) do
  {
    case "tvloadout":
    {
      _ctrlTV tvsettext [_TvPosition, (_tvName select [10, (count _tvName-10)])];
    };
    case "tvtab":
    {
      if (_CheckSubTv && _ctrlTV tvCount _TvPosition > 0) then
      {
        [_ctrlTV, _TvPosition] call VANA_fnc_tvSorting;
      };
    };
  };
} foreach _targetTVChildren;

true
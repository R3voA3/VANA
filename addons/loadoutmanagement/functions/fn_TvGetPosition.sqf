disableserialization;

params
[
  ["_ctrlTV", controlnull, [controlnull]],
  ["_arguments", [], [[]]],
  ["_typeData", "All", [""]],
  "_Name",
  "_TvParent",
  "_FncArguments",
  "_Target"
];

_arguments params
[
  ["_TvParent", [-1], [[]]],
  ["_Name", "", [""]]
];

//Find Correct SubTv
_fncArguments = [[_ctrlTV, [_TvParent, (toLower _typeData)], [], false], [_ctrlTV, [[], (toLower _typeData)]]] select (_TvParent isequalto [-1]);
_target = (_FncArguments call VANA_fnc_tvGetData) select {(_x select 0) isequalto _Name};

if (_Target isequalto []) exitwith {[-1]};

(_Target select 0) select 1
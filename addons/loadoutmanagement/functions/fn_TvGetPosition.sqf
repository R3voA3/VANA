disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
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
_fncArguments = [[_ctrlTV, [_TvParent, (toLower _typeData)], [], false], [_ctrlTV, [[], (toLower _typeData)]]] select (_TvParent isEqualTo [-1]);
_target = (_FncArguments call VANA_fnc_tvGetData) select {(_x select 0) isEqualTo _Name};

if (_Target isEqualTo []) exitwith {[-1]};

(_Target select 0) select 1
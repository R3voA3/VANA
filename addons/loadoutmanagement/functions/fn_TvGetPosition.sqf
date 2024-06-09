disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_arguments", [], [[]]],
	["_typeData", "All", [""]],
	"_name",
	"_tvParent",
	"_fncArguments",
	"_target"
];

_arguments params
[
	["_tvParent", [-1], [[]]],
	["_name", "", [""]]
];

//Find Correct SubTv
_fncArguments = [[_ctrlTV, [_tvParent, (toLower _typeData)], [], false], [_ctrlTV, [[], (toLower _typeData)]]] select (_tvParent isEqualTo [-1]);
_target = (_fncArguments call VANA_fnc_tvGetData) select {(_x select 0) isEqualTo _name};

if (_target isEqualTo []) exitwith {[-1]};

(_target select 0) select 1
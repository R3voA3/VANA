disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_arguments", [], [[]]],
	["_typeData", "All", [""]]
];

_arguments params
[
	["_tvParent", [-1], [[]]],
	["_name", "", [""]]
];

//Find correct sub item
private _fncArguments =
[
	[_ctrlTV, [_tvParent, toLower _typeData], [], false],
	[_ctrlTV, [[], toLower _typeData]]
] select (_tvParent isEqualTo [-1]);

private _target = (_fncArguments call VANA_fnc_tvGetData) select {(_x select 0) isEqualTo _name};

if (_target isEqualTo []) exitWith {[-1]};

(_target select 0) select 1
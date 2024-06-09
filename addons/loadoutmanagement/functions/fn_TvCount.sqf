disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_arguments", [], [[]]],
	["_checkSubTV", true, [true]]
];

_arguments params
[
	["_parentTV", [], [[]]],
	["_typeData", "All", [""]]
];

[_ctrlTV, [_parentTV, _typeData], [], _checkSubTV, true] call VANA_fnc_tvGetData;
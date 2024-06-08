disableserialization;

params
[
	["_ctrlTV", controlnull, [controlnull]],
	["_arguments", [], [[]]],
	["_checkSubTV", true, [true]]
];

_arguments params
[
	["_parentTV", [], [[]]],
	["_typeData", "All", [""]]
];

//Call VANA_fnc_tvGetData in count mode
[_ctrlTV, [_parentTV, _typeData], [], _checkSubTV, true] call VANA_fnc_tvGetData;
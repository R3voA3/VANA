disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_arguments", [], [[]]]
];

_arguments params
[
	["_position", [], [[]]],
	["_loadoutName", "", [""]]
];

[_ctrlTV, [[_loadoutName, _position]]] call VANA_fnc_tvValidateLoadouts;
disableserialization;

params
[
  ["_ctrlTV", controlnull, [controlnull]],
  ["_arguments", [], [[]]]
];

_arguments params
[
  ["_Posistion", [], [[]]],
  ["_LoadoutName", "", [""]]
];


[_ctrlTV, [[_LoadoutName, _Posistion]]] call VANA_fnc_tvValidateLoadouts;
[
 "setCustomLocations",
 [
  ["MHQ No. 0", TPD_0, [random 1, random 1, random 1, 1]],
  ["MHQ No. 1", TPD_1, [random 1, random 1, random 1, 1]],
  ["MHQ No. 2", TPD_2, [random 1, random 1, random 1, 1]],
  ["MHQ No. 3", TPD_3, [random 1, random 1, random 1, 1]],
  ["MHQ No. 4", TPD_4, [random 1, random 1, random 1, 1]]
 ]
] call TPD_fnc_teleport;

["addActions", [TPD_0, TPD_1, TPD_2, TPD_3, TPD_4]] call TPD_fnc_teleport;
/*
  Author: wogz187, modified by R3vo

  Date: 2021-08-18

  Description:
  Applies code to selected layer entities. Need to be run on the server.

  Parameter(s):
  0: ARRAY - Array of strings / numbers. Layer names / Layer IDs
  1: CODE - Code to be applied for each layer entity. Entity is stored in _this variable
  2: NUMBER - Type of entities to select. 0 for objects, 1 for markers, -1 for both

  Returns:
  NOTHING
*/

if !(isServer) exitWith {diag_log "layer manager needs to be run on the server!"};
params [["_layers", []], ["_code", {}], ["_type", 0]];

{
  private _entities = if (_type >= 0 && _type <= 1) then
  {
    _entities = getMissionLayerEntities _x # _type;
  }
  else
  {
    flatten (getMissionLayerEntities _x # 0);
  };
  _entities apply { _x call _code };
} forEach _layers;
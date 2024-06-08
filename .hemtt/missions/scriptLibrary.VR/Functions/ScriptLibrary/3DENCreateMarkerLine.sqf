/*
	Author: R3vo

	Date: 2023-04-08

	Description:
	Creates a line of markers in Eden Editor. Supports undo action.

	Parameter(s):
	0: ARRAY - Start position
	1: ARRAY - End position
	2: STRING - Marker type, optional, default "mil_dot"
	3: NUMBER - Marker count, optional, default 10
	4: BOOLEAN - Align markers to line direction, optional, default false
	5: STRING - Marker name prefix, optional, default "". Prefix should not have underscore at the end. Index of the marker and underscore are added by the script

	Returns:
	-
*/

params
[
	["_start", [0, 0]],
	["_end", [worldSize, worldSize]],
	["_markerType", "mil_dot"],
	["_markerCount", 10],
  ["_alignMarkersWithDir", false],
  ["_prefix", ""]
];

private _dir = _start getDir _end;
private _dis = _start distance2D _end;
private _stepDis = _dis / (_markerCount - 1);

["Create Marker Line"] collect3DENHistory
{
  for "_i" from 0 to _markerCount - 1 do
  {
    private _pos = _start getPos [_i * _stepDis, _dir];

    private _entity = create3DENEntity ["Marker", _markerType, _pos];

    if (_alignMarkersWithDir) then
    {
      _entity set3DENAttribute ["rotation", _dir];
    };

    if (_prefix != "") then
    {
      _entity set3DENAttribute ["markerName", _prefix + "_" + str _i];
    };
  };
};
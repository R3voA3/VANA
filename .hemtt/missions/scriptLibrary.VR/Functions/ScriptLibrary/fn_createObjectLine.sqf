/*
	Author: Revo

	Description:
	Spawns objects in specified direction

	Parameter(s):
		0: number - Number of spawned objects - default 10
		1: string - Object classname - default ""
		2: number - Direction in which the objects will spawn - default 0
		3: number - Object orientation - default 0 
		4: number - Width/Length of the object - default 1
		5: array  - Initial position - default [0,0,0]
		6: number - Time in seconds after which object composition gets deleted - default -1 (disabled)
		7: string - name of missionNamespace variable under which the composition is saved
	Returns:
	-
*/

_num = param [0,10];
_type = param [1,objNull]; 
_dir = param [2,0]; 
_dirObj = param [3,0]; 
_width = param [4,1];
_pos = param [5,[0,0,0]]; 
_time = param [6,-1];
_arrayName = param [7,"spawned_comp_0"];

missionNamespace setVariable [_arrayName,[]];

for "_i" from 1 to _num do
{
    _veh = createVehicle [_type,_pos,[],0,"CAN_COLLIDE"];
    _veh setDir _dirObj;
    _pos = [_veh,_width,_dir] call BIS_fnc_relPos;
   (missionNamespace getVariable _arrayName) pushBack _veh;
};

if(_time == -1) exitWith {};
sleep _time;

{
    deleteVehicle _x;
} forEach (missionNamespace getVariable _arrayName)

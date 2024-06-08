/*
	Author: Revo

	Description:
	Copyies selected objects in 3den to the clipboard and formats them to a config format.

	Parameter(s):
	-
	Returns:
	object composition in config format
*/
_go = -1;
_output = [];
["Player unit is used as center for the composition! Make sure it is place approximately in the center of your composition.","Warning!",["Go ahead",{_go = 1}],["Cancel",{_go = 0}],""] spawn BIS_fnc_3DENShowMessage;
sleep 0.1;
waitUntil {_go != -1};
if (go == 0) exitWith {};

if (isNull player) exitWith 
{
	["No player unit found!","Warning!","Ok","Cancel",""] spawn BIS_fnc_3DENShowMessage;
};

{
    if(!(isPlayer _x)) then
    {
        _center = [(position _x select 0) - (position player select 0), (position _x select 1) - (position player select 1), (position _x select 2) - (position player select 2)];
		_xCoord = _center select 0;
		_yCoord = _center select 1;
		_zCoord = _center select 2;
		
        _output = _output + toArray(format["	class Object%1{side=8;vehicle=""%2"";rank="""";position[]={%3,%4,%5};dir=%6;};%7",_forEachIndex,typeOf _x,_xCoord,_yCoord,_zCoord,direction _x,toString [13,10],toString [9]]);
    };
}forEach  get3denSelected "object";

_start = toArray format ["class REPLACE_CLASSNAME%1{%1	name = ""REPLACE_COMP_NAME"";%1    icon = ""\a3\Ui_f\data\Map\VehicleIcons\iconVehicle_ca.paa"";%1    side = 8;%1",toString [13,10]];
_end = toArray format ["};",toString [13,10]];
_final = _start + _output + _end;
copyToClipboard toString _final;
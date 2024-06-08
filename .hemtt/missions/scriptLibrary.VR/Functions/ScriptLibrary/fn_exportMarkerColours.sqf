/*
	Author: Revo

	Description:
	Retrieves all colours from CfgMarkerColors and exports them with their RGBA value. Output can directly be pasted into the media wiki

	Parameter(s):
	0: STRING: Name of first column
	1: STRING: Name of seconds column
	Returns:
	TEXT: The collected data
*/

private _columnDesc_1 = param [0,"",[""]];
private _columnDesc_2 = param [1,"",[""]];
private _lb = toString [0x0D, 0x0A];//[Carriage Return, new line]

private _output = "{|class ='wikitable'" + _lb + format ["|-%1! %2 !! %3",_lb,_columnDesc_1,_columnDesc_2];

{
	private _colour = getArray (_x >> "color") call BIS_fnc_colorConfigToRGBA;
	private _colourName = configName _x;
	_output = _output + format ["%1|-%1|%2 || %3",_lb,_colourName,_colour];

} forEach configProperties [configFile >> "CfgMarkerColors"];

_output = _output + _lb + "|}";

copyToClipboard _output;

_output

/* OUTPUT
{|class ='wikitable'
|-
! Config Name !! RGBA
|-
|Default || [0,0,0,1]
|-
|ColorBlack || [0,0,0,1]
|-
|ColorGrey || [0.5,0.5,0.5,1]
|-
|ColorRed || [0.9,0,0,1]
|-
|ColorBrown || [0.5,0.25,0,1]
|-
|ColorOrange || [0.85,0.4,0,1]
|-
|ColorYellow || [0.85,0.85,0,1]
|-
|ColorKhaki || [0.5,0.6,0.4,1]
|-
|ColorGreen || [0,0.8,0,1]
|-
|ColorBlue || [0,0,1,1]
|-
|ColorPink || [1,0.3,0.4,1]
|-
|ColorWhite || [1,1,1,1]
|-
|ColorWEST || [0,0.3,0.6,1]
|-
|ColorEAST || [0.5,0,0,1]
|-
|ColorGUER || [0,0.5,0,1]
|-
|ColorCIV || [0.4,0,0.5,1]
|-
|ColorUNKNOWN || [0.7,0.6,0,1]
|-
|colorBLUFOR || [0,0.3,0.6,1]
|-
|colorOPFOR || [0.5,0,0,1]
|-
|colorIndependent || [0,0.5,0,1]
|-
|colorCivilian || [0.4,0,0.5,1]
|-
|Color1_FD_F || [0.694118,0.2,0.223529,1]
|-
|Color2_FD_F || [0.678431,0.74902,0.513726,1]
|-
|Color3_FD_F || [0.941176,0.509804,0.192157,1]
|-
|Color4_FD_F || [0.403922,0.545098,0.607843,1]
|-
|Color5_FD_F || [0.690196,0.25098,0.654902,1]
|}
/*
	Author: Revo, _fnc_showTubtitles from Thomas Ryan, edited by Revo
	Last update:  08/21/2016
	- added option for background

	Description:
	Displays a subtitle at the bottom of the screen.

	Parameters:
	_this select 0: ARRAY - Contains all information of every line
		Parameter 1: STRING - Name of the person speaking
		Parameter 1: STRING - Subtitle
		Parameter 2: OBJECT - Character which speaks the subtitle, used to enable lip movement - Default: objNull
	_this select 1: STRING - Chat type - Default: SIDE
						   - SIDE
						   - GLOBAL
						   - VEHICLE
						   - COMMAND
						   - GROUP
						   - DIRECT
						   - CUSTOM
						   - SYSTEM
	_this select 2: NUMBER - Break multiplier - Is used to calculate the time a line is shown - Default: 0.1
	_this select 3: BOOL   - Show background

	Returns:
	true

	Example:

	line1 = ["Sgt. Anderson", "Papa Bear, this is Alpha 1-1, we are under heavy fire, I repeat, we are under heavy fire, how copy?",objNull,{true},{systemChat "Line2"}];
 	line2 = ["PAPA BEAR", "Solid copy Alpha 1-1, we are sending air support, mark the enemy's position with red smoke, Papa Bear out.",objNull,{true},{systemChat "Line2"}];
 	[[line1,line2],"SIDE",0.05,true] spawn Revo_fnc_simpleConv;
*/

#define FADE_DURATION 0.5
#define BACKGROUND_COLOUR [0,0,0,0.4]
#define BACKGROUND_H_COEF 0.0008

if !(isServer) exitWith {false};

waitUntil {isNil "Revo_fnc_simpleConversation_running"};

Revo_fnc_simpleConversation_running = true;

private _lines = param [0,[["",""]],[[]]];
private _colour = param [1,"SIDE",[""]];
private _breakMultiplier = param [2,0.1,[0]];
private _showBackground = param [3,false,[false]];

//Select HEX colour from given string
private _colourHTML = switch (toUpper _colour) do
{
	case "SIDE": 	{"#00ccff"};
	case "GLOBAL": 	{"#d7d7d9"};
	case "VEHICLE": {"#fbd40b"};
	case "COMMAND": {"#e5e760"};
	case "GROUP": 	{"#beee7e"};
	case "DIRECT": 	{"#fffffb"};
	case "CUSTOM":	{"#ec5a29"};
	case "SYSTEM":	{"#8a8a88"};
	case "BLUFOR": 	{([WEST,false] call BIS_fnc_sideColor) call BIS_fnc_colorRGBtoHTML};
	case "OPFOR": 	{([EAST,false] call BIS_fnc_sideColor) call BIS_fnc_colorRGBtoHTML};
	case "GUER": 	{([INDEPENDENT,false] call BIS_fnc_sideColor) call BIS_fnc_colorRGBtoHTML};
	case "CIV": 	{([CIVILIAN,false] call BIS_fnc_sideColor) call BIS_fnc_colorRGBtoHTML};
};

Revo_fnc_showSubtitles =
{
	params ["_lines","_colour","_breakMultiplier","_showBackground"];

	//Create display and control
	disableSerialization;
	titleRsc ["RscDynamicText", "PLAIN"];
	private "_display";
	waitUntil {_display = uiNamespace getVariable "BIS_dynamicText"; !(isNull _display)};
	private _ctrl = _display displayCtrl 9999;
	uiNamespace setVariable ["BIS_dynamicText", displayNull];
	private _ctrlBackground = _display ctrlCreate ["RscText",99999];

	//Set up control
	private _w = 0.4 * safeZoneW;
	private _x = safeZoneX + (0.5 * safeZoneW - (_w / 2));
	private _y = safeZoneY + (0.73 * safeZoneH);
	private _h = safeZoneH;

	_ctrl ctrlSetPosition [_x,_y,_w,_h];
	_ctrl ctrlSetFade 1;
	_ctrl ctrlCommit 0;

	{
		_x params ["_speaker","_text",["_speakerObject",objNull]];
		private _break = count _text * _breakMultiplier;
		waitUntil {isNil "Revo_fnc_simpleConversation_subtitleShowing"};
		Revo_fnc_simpleConversation_subtitleShowing = true;
		
		if !(isNull _speakerObject) then {_speakerObject setRandomLip true};




		if (_showBackground) then
		{
			_ctrlBackground ctrlSetPosition [_x,_y,_w,((count _text) / 2000) max 0.035];
			_ctrlBackground ctrlSetBackgroundColor BACKGROUND_COLOUR;
			_ctrlBackground ctrlSetFade 1;
			_ctrlBackground ctrlCommit 0;
			_ctrlBackground ctrlSetFade 1;
			_ctrlBackground ctrlCommit FADE_DURATION;
		};
		//Show subtitle
		_text = parseText format ["<t align = 'center' shadow = '2' size = '0.52'><t color = '%1'>" + _speaker + ":</t> <t color = '#d0d0d0'>" + _text + "</t></t>",_colour];
		_ctrl ctrlSetStructuredText _text;
		_ctrl ctrlSetFade 0;
		_ctrl ctrlCommit FADE_DURATION;
		if (_showBackground) then
		{
			_ctrlBackground ctrlSetFade 0;
			_ctrlBackground ctrlCommit FADE_DURATION;
		};
		sleep _break;

		if !(isNull _speakerObject) then {_speakerObject setRandomLip false};

		//Hide subtitle
		_ctrl ctrlSetFade 1;
		_ctrl ctrlCommit FADE_DURATION;

		sleep FADE_DURATION + 0.5;

		Revo_fnc_simpleConversation_subtitleShowing = nil;
	} forEach _lines;
};

[_lines,_colourHTML,_breakMultiplier,_showBackground] remoteExec ["Revo_fnc_showSubtitles",0];


Revo_fnc_simpleConversation_running = nil;

true
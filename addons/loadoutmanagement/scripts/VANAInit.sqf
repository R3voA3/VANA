//this sqf is called from ArsenalTreeView.hpp which is just a modified version of the normal RscDisplayArsenal in "ui_f"

params
[
	["_mode", "", [""]],
	["_params", [], [[]]]
];

switch _mode do
{
	case "onLoad":
	{
		if (isnil {missionnamespace getVariable "bis_fnc_arsenal_data"}) then
		{
			startloadingscreen [""];
			["Init", _params] spawn (uinamespace getVariable "VANA_fnc_arsenal");
		}
		else
		{
			["Init", _params] call (uinamespace getVariable "VANA_fnc_arsenal");
		};
	};
	case "onUnload":
	{
		["Exit", _params] call (uinamespace getVariable "VANA_fnc_arsenal");
	};
};
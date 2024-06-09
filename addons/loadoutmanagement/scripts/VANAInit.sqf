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
		if (isnil {missionNamespace getVariable "BIS_fnc_arsenal_data"}) then
		{
			startLoadingScreen [""];
			["Init", _params] spawn (uiNamespace getVariable "VANA_fnc_arsenal");
		}
		else
		{
			["Init", _params] call (uiNamespace getVariable "VANA_fnc_arsenal");
		};
	};
	case "onUnload":
	{
		["Exit", _params] call (uiNamespace getVariable "VANA_fnc_arsenal");
	};
};
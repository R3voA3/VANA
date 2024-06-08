/*
	Author: Revo

	Description:
	Retrieves loadout of unit and formats it for CfgRespawnLoadouts. Content is copied to clipboard and returned by function.

	Parameter(s):
	0: Object - Object to take the loadout from
	1: String - Class name of the respawn loadout
	2: String - Display name of the respawn loadout
	3: String - Icon path displayed next to display name
	4: String - Loadouts are assigned to a role, possible values:
		"Assistant"
		"CombatLifeSaver"
		"Crewman"
		"Default"
		"Grenadier"
		"MachineGunner"
		"Marksman"
		"MissileSpecialist"
		"Rifleman"
		"Sapper"
		"SpecialOperative"
		"Unarmed"
	5: String - Condition for the respawn loadout to be shown. Code inside string has to return boolean. _this refers to the unit inside the respawn screen

	Can also be custom one, needs to be defined in CfgRoles, visit https://community.bistudio.com/wiki/Arma_3_Respawn:_New_Respawn_Screen for more information

	Returns:
	String - Exports formatted loadout
*/

params
[
	["_object",player,[objNull]],
	["_class","REPLACE",[""]],
	["_displayName","REPLACE",[""]],
	["_icon","\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa",[""]],
	["_role","Default",[""]],
	["_conditionShow","true",[""]]
];

private _indent = "    ";
private _class = format ["class %1",_class];
private _displayName = format ["displayName = ""%1"";",_displayName];
private _icon = format ["icon = ""%1"";",_icon];
private _role = format ["role = ""%1"";",_role];
private _conditionShow = format ["show = ""%1"";",_conditionShow];
private _uniformClass = format ["uniformClass = ""%1"";",uniform _object];
private _backpack = format ["backpack = ""%1"";",backpack _object];
private _export = _class + endl + "{" + endl + _indent + _displayName + endl + _indent + _icon + endl + _indent + _role + endl + _indent + _conditionShow + endl + _indent + _uniformClass + endl + _indent + _backpack + endl;
private _weapons = weapons _object;
private _primWeaponItems = primaryWeaponItems _object;
private _secWeaponItems = secondaryWeaponItems _object;
private _assignedItems = assigneditems _object;
//From BIS_fnc_exportLoadout START
private _fnc_addArray =
{
	params ["_name","_array"];
	_export = _export + format [_indent + "%1[] = {",_name];
	{
		if (_foreachindex > 0) then {_export = _export + ",";};
		_export = _export + format ["""%1""",_x];
	} foreach _array;
	_export = _export + "};" + endl;
};

["weapons",_weapons + ["Throw","Put"]] call _fnc_addArray;
["magazines",magazines _object] call _fnc_addArray;
["items",items _object] call _fnc_addArray;
["linkedItems",[vest _object,headgear _object,goggles _object] + _assignedItems - _weapons + _primWeaponItems + _secWeaponItems] call _fnc_addArray;
//From BIS_fnc_exportLoadout END
_export = _export + "};" + endl + "//Visit https://community.bistudio.com/wiki/Arma_3_Respawn for detailed information";

copyToClipboard _export;
_export

/*
class REPLACE
{
    displayName = "REPLACE";
    icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
    role = "Default";
    show = "true";
    uniformClass = "U_B_T_Soldier_SL_F";
    backpack = "B_AssaultPack_tna_F";
    weapons[] = {"arifle_SPAR_03_blk_F","hgun_P07_khk_F","Rangefinder","Throw","Put"};
    magazines[] = {"20Rnd_762x51_Mag","16Rnd_9x21_Mag","MiniGrenade","MiniGrenade","SmokeShell","SmokeShellGreen","SmokeShellBlue","SmokeShellOrange","Chemlight_green","Chemlight_green","20Rnd_762x51_Mag","20Rnd_762x51_Mag"};
    items[] = {"FirstAidKit"};
    linkedItems[] = {"V_Chestrig_rgr","H_MilCap_tna_F","","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","NVGoggles_tna_F","muzzle_snds_B","acc_pointer_IR","optic_Hamr","","","","",""};
};
//Visit https://community.bistudio.com/wiki/Arma_3_Respawn for detailed information
disableserialization;

#define CONDITION(LIST)	(_fullVersion || {"%ALL" in LIST} || {{_item == _x} count LIST > 0})

#define GETVIRTUALCARGO\
	private ["_virtualItemCargo","_virtualWeaponCargo","_virtualMagazineCargo","_virtualBackpackCargo"];\
	_virtualItemCargo =\
		(missionNamespace call BIS_fnc_getVirtualItemCargo) +\
		(_cargo call BIS_fnc_getVirtualItemCargo) +\
		items _center +\
		assigneditems _center +\
		primaryweaponitems _center +\
		secondaryweaponitems _center +\
		handgunitems _center +\
		[uniform _center,vest _center,headgear _center,goggles _center];\
	_virtualWeaponCargo = [];\
	{\
		private ["_weapon"];\
		_weapon = _x call BIS_fnc_baseWeapon;\
		_virtualWeaponCargo set [count _virtualWeaponCargo,_weapon];\
		{\
			private ["_item"];\
			_item = getText (_x >> "item");\
			if !(_item in _virtualItemCargo) then {_virtualItemCargo set [count _virtualItemCargo,_item];};\
		} foreach ((configFile >> "cfgweapons" >> _x >> "linkeditems") call BIS_fnc_returnchildren);\
	} foreach ((missionNamespace call BIS_fnc_getVirtualWeaponCargo) + (_cargo call BIS_fnc_getVirtualWeaponCargo) + weapons _center + [binocular _center]);\
	_virtualMagazineCargo = (missionNamespace call BIS_fnc_getVirtualMagazineCargo) + (_cargo call BIS_fnc_getVirtualMagazineCargo) + magazines _center;\
	_virtualBackpackCargo = (missionNamespace call BIS_fnc_getVirtualBackpackCargo) + (_cargo call BIS_fnc_getVirtualBackpackCargo) + [backpack _center];

#define MarkTv\
	private _loadoutPosistion = _x select 1;\
	_ctrlTV tvSetColor [_loadoutPosistion, [1,1,1,0.25]];\
	_ctrlTV tvSetValue [_loadoutPosistion, -1];

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_targetLoadouts", [], [[]]],
	"_fullVersion",
	"_loadoutData",
	"_center",
	"_cargo"
];

_fullVersion = missionNamespace getVariable ["BIS_fnc_arsenal_fullArsenal",false];
_loadoutData = profileNamespace getVariable ["BIS_fnc_saveInventory_Data",[]];
_center = (missionNamespace getVariable ["BIS_fnc_arsenal_center",player]);
_cargo = (missionNamespace getVariable ["BIS_fnc_arsenal_Cargo",objNull]);

GETVIRTUALCARGO
{
	Params ["_loadoutName","_inventoryData","_inventoryDataWeapons","_inventoryDataMagazines","_inventoryDataItems","_inventoryDataBackpacks"];
	_loadoutName = _x select 0;

	if (_loadoutName in _loadoutData) then
	{
		//First Phase Validation
		_inventoryData = _loadoutData select ((_loadoutData find _loadoutName) + 1);
		_inventoryDataWeapons =
		[
			(_inventoryData select 5), //Binocular
			(_inventoryData select 6 select 0), //Primary weapon
			(_inventoryData select 7 select 0), //Secondary weapon
			(_inventoryData select 8 select 0) //Handgun
		] - [""];

		if ({_item = _x; !CONDITION(_virtualWeaponCargo) || !isClass(configFile >> "cfgweapons" >> _item)} count _inventoryDataWeapons > 0) exitWith {MarkTv};

		//Second Phase Validation
		_inventoryDataMagazines =
		(
			(_inventoryData select 0 select 1) + //Uniform
			(_inventoryData select 1 select 1) + //Vest
			(_inventoryData select 2 select 1) //Backpack items
		) - [""];

		if ({_item = _x; !CONDITION(_virtualItemCargo + _virtualMagazineCargo) || {isClass(configFile >> _x >> _item)} count ["cfgweapons","cfgglasses","cfgmagazines"] == 0} count _inventoryDataMagazines > 0) exitWith {MarkTv};

		//Third Phase Validation
		_inventoryDataItems =
		(
			[_inventoryData select 0 select 0] + (_inventoryData select 0 select 1) + //Uniform
			[_inventoryData select 1 select 0] + (_inventoryData select 1 select 1) + //Vest
			(_inventoryData select 2 select 1) + //Backpack items
			[_inventoryData select 3] + //Headgear
			[_inventoryData select 4] + //Goggles
			(_inventoryData select 6 select 1) + //Primary weapon items
			(_inventoryData select 7 select 1) + //Secondary weapon items
			(_inventoryData select 8 select 1) + //Handgun items
			(_inventoryData select 9) //Assigned items
		) - [""];

		if ({_item = _x; !CONDITION(_virtualItemCargo + _virtualMagazineCargo) || {isClass(configFile >> _x >> _item)} count ["cfgweapons","cfgglasses","cfgmagazines"] == 0} count _inventoryDataItems > 0) exitWith {MarkTv};

		//Forth Phase Validation
		_inventoryDataBackpacks = [_inventoryData select 2 select 0] - [""];

		if ({_item = _x; !CONDITION(_virtualBackpackCargo) || !isClass(configFile >> "cfgvehicles" >> _item)} count _inventoryDataBackpacks > 0) exitWith {MarkTv};
	};
} foreach _targetLoadouts;

[false, true] select (_targetLoadouts isNotEqualTo []);
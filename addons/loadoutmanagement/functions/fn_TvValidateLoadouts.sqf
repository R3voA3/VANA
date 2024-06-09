disableserialization;

#define CONDITION(LIST)	(_FullVersion || {"%ALL" in LIST} || {{_Item == _x} count LIST > 0})

#define GETVIRTUALCARGO\
	private ["_virtualItemCargo","_virtualWeaponCargo","_virtualMagazineCargo","_virtualBackpackCargo"];\
	_virtualItemCargo =\
		(missionNamespace call BIS_fnc_getVirtualItemCargo) +\
		(_Cargo call BIS_fnc_getVirtualItemCargo) +\
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
			private ["_Item"];\
			_Item = getText (_x >> "item");\
			if !(_Item in _virtualItemCargo) then {_virtualItemCargo set [count _virtualItemCargo,_Item];};\
		} foreach ((configFile >> "cfgweapons" >> _x >> "linkeditems") call BIS_fnc_returnchildren);\
	} foreach ((missionNamespace call BIS_fnc_getVirtualWeaponCargo) + (_Cargo call BIS_fnc_getVirtualWeaponCargo) + weapons _center + [binocular _center]);\
	_virtualMagazineCargo = (missionNamespace call BIS_fnc_getVirtualMagazineCargo) + (_Cargo call BIS_fnc_getVirtualMagazineCargo) + magazines _center;\
	_virtualBackpackCargo = (missionNamespace call BIS_fnc_getVirtualBackpackCargo) + (_Cargo call BIS_fnc_getVirtualBackpackCargo) + [backpack _center];

#define MarkTv\
	private _LoadoutPosistion = _x select 1;\
	_ctrlTV tvSetColor [_LoadoutPosistion, [1,1,1,0.25]];\
	_ctrlTV tvSetValue [_LoadoutPosistion, -1];

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_TargetLoadouts", [], [[]]],
	"_FullVersion",
	"_LoadoutData",
	"_center",
	"_Cargo"
];

_fullVersion = missionNamespace getVariable ["BIS_fnc_arsenal_fullArsenal",false];
_loadoutData = profileNamespace getVariable ["BIS_fnc_saveInventory_Data",[]];
_center = (missionNamespace getVariable ["BIS_fnc_arsenal_center",player]);
_cargo = (missionNamespace getVariable ["BIS_fnc_arsenal_Cargo",objNull]);

GETVIRTUALCARGO
{
	Params ["_LoadoutName","_InventoryData","_InventoryDataWeapons","_InventoryDataMagazines","_InventoryDataItems","_InventoryDataBackpacks"];
	_LoadoutName = _x select 0;

	if (_LoadoutName in _LoadoutData) then
	{
		//First Phase Validation
		_InventoryData = _LoadoutData select ((_LoadoutData find _LoadoutName) + 1);
		_InventoryDataWeapons =
		[
			(_InventoryData select 5), //Binocular
			(_InventoryData select 6 select 0), //Primary weapon
			(_InventoryData select 7 select 0), //Secondary weapon
			(_InventoryData select 8 select 0) //Handgun
		] - [""];

		if ({_Item = _x; !CONDITION(_VirtualWeaponCargo) || !isClass(configFile >> "cfgweapons" >> _Item)} count _InventoryDataWeapons > 0) exitwith {MarkTv};

		//Second Phase Validation
		_InventoryDataMagazines =
		(
			(_InventoryData select 0 select 1) + //Uniform
			(_InventoryData select 1 select 1) + //Vest
			(_InventoryData select 2 select 1) //Backpack items
		) - [""];

		if ({_Item = _x; !CONDITION(_VirtualItemCargo + _VirtualMagazineCargo) || {isClass(configFile >> _x >> _Item)} count ["cfgweapons","cfgglasses","cfgmagazines"] == 0} count _InventoryDataMagazines > 0) exitwith {MarkTv};

		//Third Phase Validation
		_InventoryDataItems =
		(
			[_InventoryData select 0 select 0] + (_InventoryData select 0 select 1) + //Uniform
			[_InventoryData select 1 select 0] + (_InventoryData select 1 select 1) + //Vest
			(_InventoryData select 2 select 1) + //Backpack items
			[_InventoryData select 3] + //Headgear
			[_InventoryData select 4] + //Goggles
			(_InventoryData select 6 select 1) + //Primary weapon items
			(_InventoryData select 7 select 1) + //Secondary weapon items
			(_InventoryData select 8 select 1) + //Handgun items
			(_InventoryData select 9) //Assigned items
		) - [""];

		if ({_Item = _x; !CONDITION(_VirtualItemCargo + _VirtualMagazineCargo) || {isClass(configFile >> _x >> _Item)} count ["cfgweapons","cfgglasses","cfgmagazines"] == 0} count _InventoryDataItems > 0) exitwith {MarkTv};

		//Forth Phase Validation
		_InventoryDataBackpacks = [_InventoryData select 2 select 0] - [""];

		if ({_Item = _x; !CONDITION(_VirtualBackpackCargo) || !isClass(configFile >> "cfgvehicles" >> _Item)} count _InventoryDataBackpacks > 0) exitwith {MarkTv};
	};
} foreach _TargetLoadouts;

[false, true] select (_TargetLoadouts isNotEqualTo []);
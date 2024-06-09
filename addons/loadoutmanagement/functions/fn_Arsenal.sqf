//an edited version of BIS_fnc_arsenal - (All Changes marked with "VANA")

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"

disableserialization;

_mode = [_this, 0, "Open", [displayNull, ""]] call BIS_fnc_param;
_this = [_this, 1, []] call BIS_fnc_param;
_fullVersion = missionNamespace getVariable ["BIS_fnc_arsenal_fullArsenal", false];

#define IDCS_LEFT\
	IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,\
	IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,\
	IDC_RSCDISPLAYARSENAL_TAB_HANDGUN,\
	IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,\
	IDC_RSCDISPLAYARSENAL_TAB_VEST,\
	IDC_RSCDISPLAYARSENAL_TAB_BACKPACK,\
	IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR,\
	IDC_RSCDISPLAYARSENAL_TAB_GOGGLES,\
	IDC_RSCDISPLAYARSENAL_TAB_NVGS,\
	IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS,\
	IDC_RSCDISPLAYARSENAL_TAB_MAP,\
	IDC_RSCDISPLAYARSENAL_TAB_GPS,\
	IDC_RSCDISPLAYARSENAL_TAB_RADIO,\
	IDC_RSCDISPLAYARSENAL_TAB_COMPASS,\
	IDC_RSCDISPLAYARSENAL_TAB_WATCH,\
	IDC_RSCDISPLAYARSENAL_TAB_FACE,\
	IDC_RSCDISPLAYARSENAL_TAB_VOICE,\
	IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA

#define IDCS_RIGHT\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC\

#define IDCS	[IDCS_LEFT, IDCS_RIGHT]

#define INITTYPES\
	_types = [];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_UNIFORM, ["Uniform"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_VEST, ["Vest"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_BACKPACK, ["Backpack"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR, ["Headgear"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_GOGGLES, ["Glasses"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_NVGS, ["NVGoggles"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS, ["Binocular", "LaserDesignator"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON, ["AssaultRifle", "MachineGun", "SniperRifle", "Shotgun", "Rifle", "SubmachineGun"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON, ["Launcher", "MissileLauncher", "RocketLauncher"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_HANDGUN, ["Handgun"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_MAP, ["Map"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_GPS, ["GPS", "UAVTerminal"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_RADIO, ["Radio"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_COMPASS, ["Compass"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_WATCH, ["Watch"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_FACE, []];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_VOICE, []];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA, []];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC, []];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMACC, []];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE, []];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD, []];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG, []];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL, []];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW, [/*"Grenade", "SmokeShell"*/]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT, [/*"Mine", "MineBounding", "MineDirectional"*/]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC, ["FirstAidKit", "Medikit", "MineDetector", "Toolkit"]];

#define STATS_WEAPONS\
	["reloadtime", "dispersion", "maxzeroing", "hit", "mass", "initSpeed"],\
	[true, true, false, true, false, false]

#define STATS_EQUIPMENT\
	["passthrough", "armor", "maximumLoad", "mass"],\
	[false, false, false, false]

switch _mode do {

	///////////////////////////////////////////////////////////////////////////////////////////
	Default {[_mode, _this] call BIS_fnc_arsenal;};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Init": {
		["BIS_fnc_arsenal"] call BIS_fnc_startLoadingScreen;
		_display = _this select 0;
		_toggleSpace = uiNamespace getVariable ["BIS_fnc_arsenal_toggleSpace", false];
		_center = (missionNamespace getVariable ["BIS_fnc_arsenal_center", player]);
		BIS_fnc_arsenal_type = 0; //--- 0 - Arsenal, 1 - Garage
		BIS_fnc_arsenal_toggleSpace = nil;

		if !(is3DEN) then {
			if (_fullVersion) then {
				if (missionname == "Arsenal") then {
					moveout player;
					player switchaction "playerstand";
					[player, 0] call BIS_fnc_setheight;
				};

				//--- Default appearance (only at the mission start)
				if (time < 1) then {
					_defaultArray = uiNamespace getVariable ["BIS_fnc_arsenal_defaultClass", []];
					_defaultClass = [_defaultArray, 0, "", [""]] call BIS_fnc_paramin;
					if (isClass (configFile >> "cfgvehicles" >> _defaultClass)) then {

						//--- Load specific class (e.g., when defined by mod browser)
						[player, _defaultClass] call BIS_fnc_loadinventory;

						_defaultItems = [_defaultArray, 1, [], [[]]] call BIS_fnc_paramin;
						_defaultShow = [_defaultArray, 2, -1, [0]] call BIS_fnc_paramin;
						uiNamespace setVariable ["BIS_fnc_arsenal_defaultItems", _defaultItems];
						uiNamespace setVariable ["BIS_fnc_arsenal_defaultShow", _defaultShow];
					} else {
						//--- Randomize default loadout
						_soldiers = [];
						{
							_soldiers pushBack (configname _x);
						} foreach ("isClass _x && getnumber (_x >> 'scope') > 1 && getText (_x >> 'simulation') == 'soldier'" configclasses (configFile >> "cfgvehicles"));
						[player, _soldiers call BIS_fnc_selectrandom] call BIS_fnc_loadinventory;
					};
					player switchMove "";
					uiNamespace setVariable ["BIS_fnc_arsenal_defaultClass", nil];
				};
			};
		};

		INITTYPES
		["InitGUI", [_display, "BIS_fnc_arsenal"]] call VANA_fnc_arsenal; //VANA
		["Preload"] call BIS_fnc_arsenal;
		["ListAdd", [_display]] call BIS_fnc_arsenal;
		["ListSelectCurrent", [_display]] call BIS_fnc_arsenal;

		//Vana Init
		call
		{
			[_display, "Init"] call VANA_fnc_ArsenalTreeView;
			if !(_display getVariable ["Vana_Initialised", false]) exitwith {};
			[_display, "Init"] call VANA_fnc_UIPopup;
		};

		//--- Save default weapon type
		BIS_fnc_arsenal_selectedWeaponType = switch true do {
			case (currentweapon _center == primaryweapon _center): {0};
			case (currentweapon _center == secondaryweapon _center): {1};
			case (currentweapon _center == handgunweapon _center): {2};
			default {-1};
		};

		//--- Load stats
		if (isnil {uiNamespace getVariable "BIS_fnc_arsenal_weaponStats"}) then {
			uiNamespace setVariable [
				"BIS_fnc_arsenal_weaponStats",
				[
					("isClass _x && getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'type') < 5") configclasses (configFile >> "cfgweapons"),
					STATS_WEAPONS
				] call BIS_fnc_configExtremes
			];
		};
		if (isnil {uiNamespace getVariable "BIS_fnc_arsenal_equipmentStats"}) then {
			_statsEquipment = [
				("isClass _x && getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'itemInfo' >> 'type') in [605, 701, 801]") configclasses (configFile >> "cfgweapons"),
				STATS_EQUIPMENT
			] call BIS_fnc_configExtremes;
			_statsBackpacks = [
				("isClass _x && getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'isBackpack') == 1") configclasses (configFile >> "cfgvehicles"),
				STATS_EQUIPMENT
			] call BIS_fnc_configExtremes;

			_statsEquipmentMin = _statsEquipment select 0;
			_statsEquipmentMax = _statsEquipment select 1;
			_statsBackpacksMin = _statsBackpacks select 0;
			_statsBackpacksMax = _statsBackpacks select 1;
			for "_i" from 2 to 3 do { //--- Ignore backpack armor and passThrough, has no effect
				_statsEquipmentMin set [_i, (_statsEquipmentMin select _i) min (_statsBackpacksMin select _i)];
				_statsEquipmentMax set [_i, (_statsEquipmentMax select _i) max (_statsBackpacksMax select _i)];
			};

			uiNamespace setVariable ["BIS_fnc_arsenal_equipmentStats", [_statsEquipmentMin, _statsEquipmentMax]];
		};

		with missionNamespace do {
			[missionNamespace, "arsenalOpened", [_display, _toggleSpace]] call BIS_fnc_callscriptedeventhandler;
		};
		["BIS_fnc_arsenal"] call BIS_fnc_endloadingscreen;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "InitGUI": {
		_display = _this select 0;
		_function = _this select 1;
		BIS_fnc_arsenal_display = _display;
		BIS_fnc_arsenal_mouse = [0, 0];
		BIS_fnc_arsenal_buttons = [[], []];
		BIS_fnc_arsenal_action = "";
		_center = (missionNamespace getVariable ["BIS_fnc_arsenal_center", player]);
		_center hideobject false;
		cuttext ["", "plain"];
		showcommandingmenu "";
		//["#(argb, 8, 8, 3)color(0, 0, 0, 1)", false, nil, 0.1, [0, 0.5]] spawn BIS_fnc_textTiles;

		//--- Force internal view to enable consistent screen blurring. Restore the original view after closing Arsenal.
		BIS_fnc_arsenal_cameraview = cameraview;
		player switchcamera "internal";

		showhud false;

		if (is3DEN) then {
			_centerOrig = _center;
			_centerPos = position _centerOrig;
			_centerPos set [2, 500];
			_sphere = createvehicle ["Sphere_3DEN", _centerPos, [], 0, "none"];
			_sphere setposatl _centerPos;
			_sphere setdir 0;
			_sphere setobjecttexture [0, "#(argb, 8, 8, 3)color(0.93, 1.0, 0.98, 0.028, co)"];
			_sphere setobjecttexture [1, "#(argb, 8, 8, 3)color(0.93, 1.0, 0.98, 0.01, co)"];
			_center = if (_function == "BIS_fnc_arsenal") then {
				createagent [typeof _centerOrig, position _centerOrig, [], 0, "none"]
			} else {
				createvehicle [typeof _centerOrig, position _centerOrig, [], 0, "none"]
			};
			_center setposatl getposatl _sphere;//[getposatl _sphere select 0, getposatl _sphere select 1, (getposatl _sphere select 2) - 4];
			_center setdir 0;
			_center switchmove animationstate _centerOrig;
			_center switchaction "playerstand";
			if (_function == "BIS_fnc_arsenal") then {
				_inventory = [_centerOrig, [_center, "arsenal"]] call BIS_fnc_saveInventory;
				[_center, [_center, "arsenal"]] call BIS_fnc_loadInventory;
				_face = face _centerOrig;
				_center setface _face;
			} else {
				{
					_center setobjecttexture [_foreachindex, _x];
				} foreach getobjecttextures _centerOrig;
				{
					_configname = configname _x;
					_center animate [_configname, _centerOrig animationphase _configname, true];
					[_center, _centerOrig animationphase _configname] call compile (getText(configFile >> "CfgVehicles" >> typeOf _center >> "AnimationSources" >> _configname >> "onPhaseChanged"));
				} foreach configproperties [configFile >> "cfgvehicles" >> typeof _center >> "animationsources", "isClass _x"];
			};
			_center enablesimulation false;

			//--- Create light for night editing (code based on BIS_fnc_3DENFlashlight)
			_intensity = 20;
			_light = "#lightpoint" createvehicle _centerPos;
			_light setlightbrightness _intensity;
			_light setlightambient [1, 1, 1];
			_light setlightcolor [0, 0, 0];
			_light lightattachobject [_sphere, [0, 0, -_intensity * 7]];

			//--- Save to global variables, so it can be deleted latger
			missionNamespace setVariable ["BIS_fnc_arsenal_light", _light];
			missionNamespace setVariable ["BIS_fnc_arsenal_centerOrig", _centerOrig];
			missionNamespace setVariable ["BIS_fnc_arsenal_center", _center];
			missionNamespace setVariable ["BIS_fnc_arsenal_sphere", _sphere];

			//--- Use the same vision mode as in Eden
			missionNamespace setVariable ["BIS_fnc_arsenal_visionMode", -2 call BIS_fnc_3DENVisionMode];
			["ShowInterface", false] spawn BIS_fnc_3DENInterface;
			if (get3denactionstate "togglemap" > 0) then {do3DENAction "togglemap";};
		};

		_display displayaddeventhandler ["mousebuttondown", "with uiNamespace do {['MouseButtonDown', _this] call BIS_fnc_arsenal;};"];
		_display displayaddeventhandler ["mousebuttonup", "with uiNamespace do {['MouseButtonUp', _this] call BIS_fnc_arsenal;};"];
		//_display displayaddeventhandler ["mousezchanged", "with uiNamespace do {['MouseZChanged', _this] call BIS_fnc_arsenal;};"];
		//_display displayaddeventhandler ["keydown", "with (uiNamespace) do {['KeyDown', _this] call BIS_fnc_arsenal;};"]; //VANA - Disabled this
		//_display displayaddeventhandler ["mousemoving", "with (uiNamespace) do {['Loop', _this] call BIS_fnc_arsenal;};"];
		//_display displayaddeventhandler ["mouseholding", "with (uiNamespace) do {['Loop', _this] call BIS_fnc_arsenal;};"];

		_ctrlMouseArea = _display displayCtrl IDC_RSCDISPLAYARSENAL_MOUSEAREA;
		_ctrlMouseArea ctrlAddeventHandler ["mousemoving", "with uiNamespace do {['Mouse', _this] call BIS_fnc_arsenal;};"];
		_ctrlMouseArea ctrlAddeventHandler ["mouseholding", "with uiNamespace do {['Mouse', _this] call BIS_fnc_arsenal;};"];
		_ctrlMouseArea ctrlAddeventHandler ["mousebuttonclick", "with uiNamespace do {['TabDeselect', [ctrlparent (_this select 0), _this select 1]] call BIS_fnc_arsenal;};"];
		_ctrlMouseArea ctrlAddeventHandler ["mousezchanged", "with uiNamespace do {['MouseZChanged', _this] call BIS_fnc_arsenal;};"];
		ctrlSetFocus _ctrlMouseArea;

		_ctrlMouseBlock = _display displayCtrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
		_ctrlMouseBlock ctrlEnable false;
		_ctrlMouseBlock ctrlAddeventHandler ["setfocus", {_this spawn {disableserialization; (_this select 0) ctrlEnable false; (_this select 0) ctrlEnable true;};}];

		_ctrlMessage = _display displayCtrl IDC_RSCDISPLAYARSENAL_MESSAGE;
		_ctrlMessage ctrlsetfade 1;
		_ctrlMessage ctrlcommit 0;

		_ctrlInfo = _display displayCtrl IDC_RSCDISPLAYARSENAL_INFO_INFO;
		_ctrlInfo ctrlsetfade 1;
		_ctrlInfo ctrlcommit 0;

		_ctrlStats = _display displayCtrl IDC_RSCDISPLAYARSENAL_STATS_STATS;
		_ctrlStats ctrlsetfade 1;
		_ctrlStats ctrlEnable false;
		_ctrlStats ctrlcommit 0;

		//--- UI event handlers
		_ctrlButtonInterface = _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONINTERFACE;
		_ctrlButtonInterface ctrlAddeventHandler ["buttonclick", "with uiNamespace do {['buttonInterface', [ctrlparent (_this select 0)]] call BIS_fnc_arsenal;};"];

		_ctrlButtonRandom = _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONRANDOM;
		_ctrlButtonRandom ctrlAddeventHandler ["buttonclick", format ["with uiNamespace do {['buttonRandom', [ctrlparent (_this select 0)]] call %1;};", _function]];

		_ctrlButtonSave = _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE;
		//_ctrlButtonSave ctrlAddeventHandler ["buttonclick", "with uiNamespace do {['buttonSave', [ctrlparent (_this select 0)]] call BIS_fnc_arsenal;};"]; VANA - Disabled this

		_ctrlButtonLoad = _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
		//_ctrlButtonLoad ctrlAddeventHandler ["buttonclick", "with uiNamespace do {['buttonLoad', [ctrlparent (_this select 0)]] call BIS_fnc_arsenal;};"]; VANA - Disabled this

		_ctrlButtonExport = _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONEXPORT;
		_ctrlButtonExport ctrlAddeventHandler ["buttonclick", format ["with uiNamespace do {['buttonExport', [ctrlparent (_this select 0), 'init']] call %1;};", _function]];
		_ctrlButtonExport ctrlEnable !ismultiplayer;

		_ctrlButtonImport = _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONIMPORT;
		_ctrlButtonImport ctrlAddeventHandler ["buttonclick", format ["with uiNamespace do {['buttonImport', [ctrlparent (_this select 0), 'init']] call %1;};", _function]];

		_ctrlButtonOK = _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONOK;
		_ctrlButtonOK ctrlAddeventHandler ["buttonclick", format ["with uiNamespace do {['buttonOK', [ctrlparent (_this select 0), 'init']] call %1;};", _function]];

		_ctrlButtonTry = _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONTRY;
		_ctrlButtonTry ctrlAddeventHandler ["buttonclick", "with uiNamespace do {['buttonTry', [ctrlparent (_this select 0)]] call BIS_fnc_garage;};"];

		_ctrlArrowLeft = _display displayCtrl IDC_RSCDISPLAYARSENAL_ARROWLEFT;
		_ctrlArrowLeft ctrlAddeventHandler ["buttonclick", "with uiNamespace do {['buttonCargo', [ctrlparent (_this select 0), -1]] call BIS_fnc_arsenal;};"];

		_ctrlArrowRight = _display displayCtrl IDC_RSCDISPLAYARSENAL_ARROWRIGHT;
		_ctrlArrowRight ctrlAddeventHandler ["buttonclick", "with uiNamespace do {['buttonCargo', [ctrlparent (_this select 0), +1]] call BIS_fnc_arsenal;};"];


		_ctrlTemplateButtonOK = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		// _ctrlTemplateButtonOK ctrlAddeventHandler ["buttonclick", format ["with uiNamespace do {['buttonTemplateOK', [ctrlparent (_this select 0)]] call %1;};", _function]]; VANA - Disabled this


		_ctrlTemplateButtonCancel = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONCANCEL;
		_ctrlTemplateButtonCancel ctrlAddeventHandler ["buttonclick", "with uiNamespace do {['buttonTemplateCancel', [ctrlparent (_this select 0)]] call BIS_fnc_arsenal;};"];


		_ctrlTemplateButtonDelete = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
		//_ctrlTemplateButtonDelete ctrlAddeventHandler ["buttonclick", "with uiNamespace do {['buttonTemplateDelete', [ctrlparent (_this select 0)]] call BIS_fnc_arsenal;};"]; VANA - Disabled this

		_ctrlTemplateValue = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		/* VANA - Disabled this
		_ctrlTemplateValue ctrlAddeventHandler ["lbselchanged", "with uiNamespace do {['templateSelChanged', [ctrlparent (_this select 0)]] call BIS_fnc_arsenal;};"];
		_ctrlTemplateValue ctrlAddeventHandler ["lbdblclick", format ["with uiNamespace do {['buttonTemplateOK', [ctrlparent (_this select 0)]] call %1;};", _function]];
		*/

		//--- Menus
		_ctrlIcon = _display displayCtrl IDC_RSCDISPLAYARSENAL_TAB;
		_sortValues = uiNamespace getVariable ["BIS_fnc_arsenal_sort", []];
		if !(isnull _ctrlIcon) then {
			_ctrlIconPos = ctrlposition _ctrlIcon;
			_ctrlTabs = _display displayCtrl IDC_RSCDISPLAYARSENAL_TABS;
			_ctrlTabsPos = ctrlposition _ctrlTabs;
			_ctrlTabsPosX = _ctrlTabsPos select 0;
			_ctrlTabsPosY = _ctrlTabsPos select 1;
			_ctrlIconPosW = _ctrlIconPos select 2;
			_ctrlIconPosH = _ctrlIconPos select 3;
			_columns = (_ctrlTabsPos select 2) / _ctrlIconPosW;
			_rows = (_ctrlTabsPos select 3) / _ctrlIconPosH;
			_gridH = ctrlposition _ctrlTemplateButtonOK select 3;

			{
				_idc = _x;
				_ctrlIcon = _display displayCtrl (IDC_RSCDISPLAYARSENAL_ICON + _idc);
				_ctrlTab = _display displayCtrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
				_mode = ["TabSelectRight", "TabSelectLeft"] select (_idc in [IDCS_LEFT]);
				{
					_x ctrlAddeventHandler ["buttonclick", format ["with uiNamespace do {['%2', [ctrlparent (_this select 0), %1]] call %3;};", _idc, _mode, _function]];
					_x ctrlAddeventHandler ["mousezchanged", "with uiNamespace do {['MouseZChanged', _this] call BIS_fnc_arsenal;};"];
				} foreach [_ctrlIcon, _ctrlTab];

				_sort = _sortValues param [_idc, 0];
				_ctrlSort = _display displayCtrl (IDC_RSCDISPLAYARSENAL_SORT + _idc);
				_ctrlSort ctrlAddeventHandler ["lbselchanged", format ["with uiNamespace do {['lbSort', [_this, %1]] call BIS_fnc_arsenal;};", _idc]];
				_ctrlSort lbsetcursel _sort;
				_sortValues set [_idc, _sort];

				_ctrlList = _display displayCtrl (IDC_RSCDISPLAYARSENAL_LIST + _idc);
				_ctrlList ctrlEnable false;
				_ctrlList ctrlsetfade 1;
				_ctrlList ctrlsetfontheight (_gridH * 0.8);
				_ctrlList ctrlcommit 0;

				_ctrlList ctrlAddeventHandler ["lbselchanged", format ["with uiNamespace do {['SelectItem', [ctrlparent (_this select 0), (_this select 0), %1]] call %2;};", _idc, _function]];
				_ctrlList ctrlAddeventHandler ["lbdblclick", format ["with uiNamespace do {['ShowItem', [ctrlparent (_this select 0), (_this select 0), %1]] spawn BIS_fnc_arsenal;};", _idc]];

				_ctrlListDisabled = _display displayCtrl (IDC_RSCDISPLAYARSENAL_LISTDISABLED + _idc);
				_ctrlListDisabled ctrlEnable false;

				_ctrlSort ctrlsetfade 1;
				_ctrlSort ctrlcommit 0;
			} foreach IDCS;
		};
		uiNamespace setVariable ["BIS_fnc_arsenal_sort", _sortValues];
		['TabDeselect', [_display, -1]] call BIS_fnc_arsenal;
		['SelectItem', [_display, controlNull, -1]] call (uiNamespace getVariable _function);

		_ctrlButtonClose = _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONCLOSE;
		_ctrlButtonClose ctrlAddeventHandler ["buttonclick", "with uiNamespace do {['buttonClose', [ctrlparent (_this select 0)]] spawn BIS_fnc_arsenal;}; true"];

		if (is3DEN) then {
			_ctrlButtonClose ctrlSetText localize "STR_DISP_CANCEL";
			_ctrlButtonClose ctrlsettooltip "";
			_ctrlButtonOK ctrlSetText localize "STR_DISP_OK";
			_ctrlButtonOK ctrlsettooltip "";
		} else {
			if (missionname == "Arsenal") then {
				_ctrlButtonClose ctrlSetText localize "STR_DISP_ARCMAP_EXIT";
			};
			if (missionname != "arsenal") then {
				_ctrlButtonOK ctrlSetText "";
				_ctrlButtonOK ctrlEnable false;
				_ctrlButtonOK ctrlsettooltip "";
				_ctrlButtonTry ctrlSetText "";
				_ctrlButtonTry ctrlEnable false;
				_ctrlButtonTry ctrlsettooltip "";
			};
		};
		{
			_ctrl = _display displayCtrl _x;
			_ctrl ctrlEnable false;
			_ctrl ctrlsetfade 1;
			_ctrl ctrlcommit 0;
		} foreach [
			IDC_RSCDISPLAYARSENAL_FRAMELEFT,
			IDC_RSCDISPLAYARSENAL_FRAMERIGHT,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDLEFT,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDRIGHT,
			IDC_RSCDISPLAYARSENAL_LINEICON,
			IDC_RSCDISPLAYARSENAL_LINETABLEFT,
			IDC_RSCDISPLAYARSENAL_LINETABRIGHT,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE
		];

		if (_fullVersion && !is3DEN) then {
			if (missionname == "Arsenal") then {
				_ctrlSpace = _display displayCtrl IDC_RSCDISPLAYARSENAL_SPACE_SPACE;
				_ctrlSpace ctrlShow true;
				{
					_ctrl = _display displayCtrl (_x select 0);
					_ctrlBackground = _display displayCtrl (_x select 1);
					_ctrl ctrlAddeventHandler ["buttonclick", "with uiNamespace do {['buttonSpace', _this] spawn BIS_fnc_arsenal;}; true"];
					if (_foreachindex == BIS_fnc_arsenal_type) then {
						_ctrl ctrlEnable false;
						_ctrl ctrlSetTextcolor [1, 1, 1, 1];
						_ctrlBackground ctrlsetbackgroundcolor [0, 0, 0, 1];
					};
				} foreach [
					[IDC_RSCDISPLAYARSENAL_SPACE_SPACEARSENAL, IDC_RSCDISPLAYARSENAL_SPACE_SPACEARSENALBACKGROUND],
					[IDC_RSCDISPLAYARSENAL_SPACE_SPACEGARAGE, IDC_RSCDISPLAYARSENAL_SPACE_SPACEGARAGEBACKGROUND]
				];
			} else {
				_ctrlSpace = _display displayCtrl IDC_RSCDISPLAYARSENAL_SPACE_SPACE;
				_ctrlSpace ctrlsetposition [-1, -1, 0, 0];
				_ctrlSpace ctrlcommit 0;
			};
		} else {
			{
				_tab = _x;
				{
					_ctrl = _display displayCtrl (_tab + _x);
					_ctrl ctrlShow false;
					_ctrl ctrlEnable false;
					_ctrl ctrlremovealleventhandlers "buttonclick";
					_ctrl ctrlremovealleventhandlers "mousezchanged";
					_ctrl ctrlremovealleventhandlers "lbselchanged";
					_ctrl ctrlremovealleventhandlers "lbdblclick";
					_ctrl ctrlsetposition [0, 0, 0, 0];
					_ctrl ctrlcommit 0;
				} foreach [IDC_RSCDISPLAYARSENAL_TAB, IDC_RSCDISPLAYARSENAL_ICON, IDC_RSCDISPLAYARSENAL_ICONBACKGROUND];
			} foreach [
				IDC_RSCDISPLAYARSENAL_TAB_FACE,
				IDC_RSCDISPLAYARSENAL_TAB_VOICE,
				IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA
			];
			_ctrlSpace = _display displayCtrl IDC_RSCDISPLAYARSENAL_SPACE_SPACE;
			_ctrlSpace ctrlsetposition [-1, -1, 0, 0];
			_ctrlSpace ctrlcommit 0;
		};

		//--- Camera init
		_camPosVar = format ["BIS_fnc_arsenal_campos_%1", BIS_fnc_arsenal_type];
		BIS_fnc_arsenal_campos = missionNamespace getVariable [
			_camPosVar,
			uiNamespace getVariable [
				_camPosVar,
				if (BIS_fnc_arsenal_type == 0) then {[5, 0, 0, [0, 0, 0.85]]} else {[10, -45, 15, [0, 0, -1]]}
			]
		];
		BIS_fnc_arsenal_campos = +BIS_fnc_arsenal_campos;
		_target = createagent ["Logic", position _center, [], 0, "none"];
		_target attachto [_center, BIS_fnc_arsenal_campos select 3, ""];
		missionNamespace setVariable ["BIS_fnc_arsenal_target", _target];

		_cam = "camera" camcreate position _center;
		_cam cameraeffect ["internal", "back"];
		_cam campreparefocus [-1, -1];
		_cam campreparefov 0.35;
		_cam camcommitprepared 0;
		//cameraEffectEnableHUD true;
		showcinemaborder false;
		BIS_fnc_arsenal_cam = _cam;
		["#(argb, 8, 8, 3)color(0, 0, 0, 1)", false, nil, 0, [0, 0.5]] call BIS_fnc_textTiles;

		//--- Camera reset
		["Mouse", [controlNull, 0, 0]] call BIS_fnc_arsenal;
		BIS_fnc_arsenal_draw3D = addMissionEventHandler ["draw3D", {with (uiNamespace) do {['draw3D', _this] call BIS_fnc_arsenal;};}];

		setacctime (missionNamespace getVariable ["BIS_fnc_arsenal_acctime", 1]);
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "KeyDown": {
		BIS_fnc_arsenal_type = uiNamespace getVariable ["BIS_fnc_arsenal_type", 0]; //VANA

		_display = _this select 0;
		_key = _this select 1;
		_shift = _this select 2;
		_ctrl = _this select 3;
		_alt = _this select 4;
		_center = (missionNamespace getVariable ["BIS_fnc_arsenal_center", player]);
		_return = false;
		_ctrlTemplate = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_inTemplate = ctrlfade _ctrlTemplate == 0;

		switch true do {
			/* VANA - Disabled this
			case (_key == DIK_ESCAPE): {
				if (_inTemplate) then {
					_ctrlTemplate ctrlsetfade 1;
					_ctrlTemplate ctrlcommit 0;
					_ctrlTemplate ctrlEnable false;

					_ctrlMouseBlock = _display displayCtrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
					_ctrlMouseBlock ctrlEnable false;
				} else {
					if (_fullVersion) then {["buttonClose", [_display]] spawn BIS_fnc_arsenal;} else {_display closedisplay 2;};
				};
				_return = true;
			};

			//--- Enter
			case (_key in [DIK_RETURN, DIK_NUMPADENTER]): {
				_ctrlTemplate = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
				if (ctrlfade _ctrlTemplate == 0) then {
					if (BIS_fnc_arsenal_type == 0) then {
						["buttonTemplateOK", [_display]] spawn VANA_fnc_arsenal;
					} else {
						["buttonTemplateOK", [_display]] spawn BIS_fnc_garage;
					};
					_return = true;
				};
			};
			*/

			//--- Prevent opening the commanding menu
			case (_key == DIK_1);
			case (_key == DIK_2);
			case (_key == DIK_3);
			case (_key == DIK_4);
			case (_key == DIK_5);
			case (_key == DIK_1);
			case (_key == DIK_7);
			case (_key == DIK_8);
			case (_key == DIK_9);
			case (_key == DIK_0): {
				_return = true;
			};

			//--- Tab to browse tabs
			case (_key == DIK_TAB): {
				_idc = -1;
				{
					_ctrlTab = _display displayCtrl (IDC_RSCDISPLAYARSENAL_TAB + _x);
					if !(ctrlEnabled _ctrlTab) exitwith {_idc = _x;};
				} foreach [IDCS_LEFT];
				_idcCount = {!isnull (_display displayCtrl (IDC_RSCDISPLAYARSENAL_TAB + _x))} count [IDCS_LEFT];
				_idc = if (_ctrl) then {(_idc - 1 + _idcCount) % _idcCount} else {(_idc + 1) % _idcCount};
				if (BIS_fnc_arsenal_type == 0) then {
					["TabSelectLeft", [_display, _idc]] call BIS_fnc_arsenal;
				} else {
					["TabSelectLeft", [_display, _idc]] call BIS_fnc_garage;
				};
				_return = true;
			};

			//--- Export to script
			case (_key == DIK_C): {
				_mode = ["init", "config"] select _shift;
				if (BIS_fnc_arsenal_type == 0) then {
					if (_ctrl) then {['buttonExport', [_display, _mode]] call BIS_fnc_arsenal;};
				} else {
					if (_ctrl) then {['buttonExport', [_display, _mode]] call BIS_fnc_garage;};
				};
			};
			//--- Export from script
			case (_key == DIK_V): {
				if (BIS_fnc_arsenal_type == 0) then {
					if (_ctrl) then {['buttonImport', [_display]] call BIS_fnc_arsenal;};
				} else {
					if (_ctrl) then {['buttonImport', [_display]] call BIS_fnc_garage;};
				};
			};

			/* VANA - Disabled this
			//--- Save
			case (_key == DIK_S): {
				if (_ctrl) then {['buttonSave', [_display]] call VANA_fnc_arsenal;};
			};
			//--- Open
			case (_key == DIK_O): {
				if (_ctrl) then {['buttonLoad', [_display]] call VANA_fnc_arsenal;};
			};
			*/

			//--- Randomize
			case (_key == DIK_R): {
				if (_ctrl) then {
					if (BIS_fnc_arsenal_type == 0) then {
						if (_shift) then {
							_soldiers = [];
							{
								_soldiers set [count _soldiers, configname _x];
							} foreach ("isClass _x && getnumber (_x >> 'scope') > 1 && getText (_x >> 'simulation') == 'soldier'" configclasses (configFile >> "cfgvehicles"));
							[_center, _soldiers call BIS_fnc_selectrandom] call BIS_fnc_loadinventory;
							_center switchmove "";
							["ListSelectCurrent", [_display]] call BIS_fnc_arsenal;
						}else {
							['buttonRandom', [_display]] call BIS_fnc_arsenal;
						};
					} else {
						['buttonRandom', [_display]] call BIS_fnc_garage;
					};
				};
			};
			//--- Toggle interface
			case (_key == DIK_BACKSPACE && !_inTemplate): {
				['buttonInterface', [_display]] call BIS_fnc_arsenal;
				_return = true;
			};

			//--- Acctime
			case (_key in (actionkeys "timeInc")): {
				if (acctime == 0) then {setacctime 1;};
				_return = true;
			};
			case (_key in (actionkeys "timeDec")): {
				if (acctime != 0) then {setacctime 0;};
				_return = true;

			};

			//--- Vision mode
			case (_key in (actionkeys "nightvision") && !_inTemplate): {
				_mode = missionNamespace getVariable ["BIS_fnc_arsenal_visionMode", -1];
				_mode = (_mode + 1) % 3;
				missionNamespace setVariable ["BIS_fnc_arsenal_visionMode", _mode];
				switch _mode do {
					//--- Normal
					case 0: {
						camusenvg false;
						false setCamUseTi 0;
					};
					//--- NVG
					case 1: {
						camusenvg true;
						false setCamUseTi 0;
					};
					//--- TI
					default {
						camusenvg false;
						true setCamUseTi 0;
					};
				};
				playsound ["RscDisplayCurator_visionMode", true];
				_return = true;

			};
			/*
			//--- Delete template
			case (_key == DIK_DELETE): {
				_ctrlMouseBlock = _display displayCtrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
				if !(ctrlEnabled _ctrlMouseBlock) then {
					['buttonTemplateDelete', [_display]] call VANA_fnc_arsenal;
					_return = true;
				};
			};
			*/
		};
		_return
	};

	//VANA - Disabled These:
	case "buttonTemplateOK": {};
	case "buttonTemplateDelete": {};
	case "templateSelChanged": {};
	case "showTemplates": {};
	case "buttonLoad": {};
	case "buttonSave": {};
};
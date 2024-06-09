disableserialization;

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"
#include "\v\vana\addons\loadoutmanagement\defines.inc"

params
[
	["_arsenalDisplay", displayNull, [displayNull]],
	["_mode", "Open", [""]],
	["_arguments", [], [[]]]
];

switch toLower _mode do
{
	///////////////////////////////////////////////////////////////////////////////////////////
	Case "init":
	{
		params ["_ctrlTV","_ctrlTemplateEdit","_ctrlButtonSave","_ctrlButtonLoad","_ctrlTemplateOKButton","_ctrlButtonTabCreate","_ctrlButtonRename","_ctrlDeleteButton","_ctrlTvUIPopup"];

		_arsenalDisplay setVariable ["Vana_Initialised", true];

		//Add EventHandlers
		_arsenalDisplay displayseteventhandler ["keyDown","[(_this select 0), 'KeyDown', _this] call VANA_fnc_ArsenalTreeView;"];

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_ctrlTV ctrlAddEventHandler ["TreeSelChanged","[ctrlparent (_this select 0), 'TreeViewSelChanged'] call VANA_fnc_ArsenalTreeView;"];
		_ctrlTV ctrlAddEventHandler ["TreeDblClick","[ctrlparent (_this select 0), 'TreeDblClick'] call VANA_fnc_ArsenalTreeView;"];
		_ctrlTV ctrlAddEventHandler ["MouseMoving", "[ctrlparent (_this select 0), 'MouseMove', _this] call VANA_fnc_ArsenalTreeView;"];

		_ctrlTV ctrlAddEventHandler ["TreeExpanded", "[ctrlparent (_this select 0), 'SubTvToggle', (_this + [true])] call VANA_fnc_ArsenalTreeView;"];
		_ctrlTV ctrlAddEventHandler ["TreeCollapsed", "[ctrlparent (_this select 0), 'SubTvToggle', (_this + [false])] call VANA_fnc_ArsenalTreeView;"];

		_ctrlTV ctrlAddEventHandler ["MouseButtonDown","[ctrlparent (_this select 0), 'TvDragDrop', ['MouseDown']] spawn VANA_fnc_ArsenalTreeView;"];
		_ctrlTV ctrlAddEventHandler ["TreeMouseMove","[ctrlparent (_this select 0), 'TvDragDrop', ['MouseMove', _this]] spawn VANA_fnc_ArsenalTreeView;"];
		_ctrlTV ctrlAddEventHandler ["MouseButtonUp","[ctrlparent (_this select 0), 'TvDragDrop', ['MouseUp']] spawn VANA_fnc_ArsenalTreeView;"];

		_ctrlTemplateEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		_ctrlTemplateEdit ctrlAddEventHandler ["KeyDown","[ctrlparent (_this select 0), 'CheckOverWrite'] spawn VANA_fnc_ArsenalTreeView;"];
		_ctrlTemplateEdit ctrlAddEventHandler ["char","[ctrlparent (_this select 0), 'CheckOverWrite'] spawn VANA_fnc_ArsenalTreeView;"];

		_ctrlButtonSave = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE;
		_ctrlButtonSave ctrlAddEventHandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonSave'] call VANA_fnc_ArsenalTreeView;"];

		_ctrlButtonLoad = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
		_ctrlButtonLoad ctrlAddEventHandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonLoad'] call VANA_fnc_ArsenalTreeView;"];

		_ctrlTemplateOKButton = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		_ctrlTemplateOKButton ctrlAddEventHandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonTemplateOK'] call VANA_fnc_ArsenalTreeView;"];

		_ctrlButtonTabCreate = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_ButtonTabCreate;
		_ctrlButtonTabCreate ctrlAddEventHandler ["buttonclick","[ctrlparent (_this select 0), 'Create'] call VANA_fnc_ArsenalTreeView;"];

		_ctrlButtonRename = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_ButtonRename;
		_ctrlButtonRename ctrlAddEventHandler ["buttonclick","[ctrlparent (_this select 0), 'Rename'] spawn VANA_fnc_ArsenalTreeView;"];

		_ctrlDeleteButton = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
		_ctrlDeleteButton ctrlAddEventHandler ["buttonclick","[ctrlparent (_this select 0), 'Delete'] spawn VANA_fnc_ArsenalTreeView;"];

		//Load and Sort treeview
		[_ctrlTV] call VANA_fnc_tvLoadData;
		[_ctrlTV] call VANA_fnc_tvSorting;

		tvCollapseAll _ctrlTV;
		_ctrlTV tvExpand [];
		_ctrlTV tvSetCurSel [0];

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "exit":
	{
		params ["_ctrlTV"];

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

		_ctrlTV setVariable ["TvDragDrop_InAction", nil];
		_ctrlTV setVariable ["TvDragDrop_GetTarget", nil];
		_ctrlTV setVariable ["TvDragDrop_targetTv", nil];
		_ctrlTV setVariable ["TvDragDrop_ReleaseSubTv", nil];

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "savedata":
	{
		params ["_ctrlTV"];

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		[_ctrlTV] call VANA_fnc_tvSaveData;

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "treeviewselchanged":
	{
		params ["_ctrlTV","_selectedTab","_isEnabledLoadout","_ctrlDeleteButton","_ctrlButtonRename","_ctrlTemplateEdit","_ctrlTemplateOKButton"];

		[_arsenalDisplay, "CheckOverWrite"] spawn VANA_fnc_ArsenalTreeView;

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

		_selectedTab = tvCurSel _ctrlTV;
		_isEnabledLoadout = toLower (_ctrlTV tvData _selectedTab) isEqualto "tvloadout" && (_ctrlTV tvValue _selectedTab) >= 0;

		//Make sure something is selected
		_ctrlDeleteButton = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
		_ctrlDeleteButton ctrlEnable !(_selectedTab isEqualTo []);

		_ctrlButtonRename = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_ButtonRename;
		_ctrlButtonRename ctrlEnable !(_selectedTab isEqualTo []);

		//SetText to selected Subtv Text
		_ctrlTemplateEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		_ctrlTemplateEdit ctrlSetText (_ctrlTV tvtext _selectedTab);

		//Disable button if loadout is missing items
		_ctrlTemplateOKButton = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		_ctrlTemplateOKButton ctrlEnable ([_isEnabledLoadout, true] select ctrlEnabled _ctrlTemplateEdit);

		//Temp code WIP
		private _ctrlTempCheckbox = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_DelConfirmToggle;
		if (Profilenamespace getVariable ['TEMP_Popup_Value', false]) then
		{
			_ctrlTempCheckbox cbSetChecked true;
		} else {
			_ctrlTempCheckbox cbSetChecked false;
		};

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "checkoverwrite":
	{
		params ["_ctrlTemplateBUTTONOK","_ctrlTemplateEdit","_loadoutData","_name","_duplicate"];

		_ctrlTemplateBUTTONOK = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		_ctrlTemplateEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		_loadoutData = (profileNamespace getVariable ["BIS_fnc_saveInventory_Data",[]]) select {_x isEqualType ""};

		//Check if name duplicate and change text accordingly
		_name = ctrlText _ctrlTemplateEdit;

		if (ctrlEnabled _ctrlTemplateEdit) then
		{
			_duplicate = _name in _loadoutData;
			_ctrlTemplateBUTTONOK ctrlSetText (["Save", "Replace"] select _duplicate);
			_ctrlTemplateBUTTONOK ctrlEnable ([true, false] select (_name isEqualTo ""));

			_duplicate
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "subtvtoggle":
	{
		_arguments params
		[
			["_ctrlTV", controlNull, [controlNull]],
			["_targetTV", [-1], [[]]],
			["_expanded", false, [false]]
		];

		_ctrlTV tvSetValue [_targetTV, ([COLLAPSED, EXPANDED] select _expanded)];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "treedblclick":
	{
		params ["_selectedTab","_tvData","_ctrlTV","_tvCollapsed"];

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_selectedTab = tvCurSel _ctrlTV;
		_tvData = toLower (_ctrlTV tvData _selectedTab);

		if !(_ctrlTV getVariable ["MouseInTreeView", true]) exitWith {false};

		switch _tvData do
		{
			case "tvloadout":
			{
				[_arsenalDisplay, "ButtonTemplateOK"] call VANA_fnc_ArsenalTreeView;
				true
			};
			case "tvtab":
			{
				//Expand or Collapse Tab
				_tvCollapsed = (_ctrlTV TvValue _selectedTab) isEqualTo COLLAPSED;
				call ([{_ctrlTV TvCollapse _selectedTab}, {_ctrlTV tvExpand _selectedTab}] select _tvCollapsed);

				[_arsenalDisplay, "SubTvToggle", [_ctrlTV, _selectedTab, ([false, true] select _tvCollapsed)]] call VANA_fnc_ArsenalTreeView;
				true
			};
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "keydown":
	{
		_arguments params
		[
			["_arsenalDisplay", Displaynull, [Displaynull]],
			["_key", -1, [-1]],
			["_shift", false, [false]],
			["_ctrl", false, [false]],
			["_alt", false, [false]],
			"_ctrlTemplate",
			"_ctrlTvUIPopup",
			"_ctrlTemplateEdit",
			"_ctrlRenameEdit",
			"_inTemplate",
			"_inPopupUI"
		];

		_ctrlTemplate = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_ctrlTvUIPopup = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
		_ctrlTemplateEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		_ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

		_inTemplate = ctrlFade _ctrlTemplate == 0;
		_inPopupUI = ctrlShown _ctrlTvUIPopup;

		switch true do
		{
			//CreateTab
			case (_key == DIK_N && _ctrl):
			{
				if (_inTemplate && !_inPopupUI) then
				{
					[_arsenalDisplay,"Create"] call VANA_fnc_ArsenalTreeView;
				};
				true
			};

			//Delete
			case ((_key == DIK_DELETE)||(_key == DIK_D && _ctrl)):
			{
				if (_inTemplate && !_inPopupUI) then
				{
					[_arsenalDisplay,"Delete"] spawn VANA_fnc_ArsenalTreeView;
				};
				true
			};

			//Rename
			case (_key == DIK_E && _ctrl):
			{
				if (_inTemplate && !_inPopupUI) then
				{
					[_arsenalDisplay,"Rename"] spawn VANA_fnc_ArsenalTreeView;
				};
				true
			};

			//Save
			Case (_key == DIK_S && _ctrl):
			{
				if !_inPopupUI then
				{
					[_arsenalDisplay,"ButtonSave"] call VANA_fnc_ArsenalTreeView;
				};
				true
			};

			//Open
			Case (_key == DIK_O && _ctrl):
			{
				if !_inPopupUI then
				{
					[_arsenalDisplay,"ButtonLoad"] call VANA_fnc_ArsenalTreeView;
				};
				true
			};

			//Close
			case (_key == DIK_ESCAPE):
			{
				if _inTemplate then
				{
					if _inPopupUI then
					{
						_ctrlTvUIPopup setVariable ["TvUIPopup_Status",false];
					} else {
						SHOW_UI(false)
					};
				} else {
					private _fullVersion = missionNamespace getVariable ["BIS_fnc_arsenal_fullArsenal", false];
					if _fullVersion then {["buttonClose",[_arsenalDisplay]] spawn BIS_fnc_arsenal;} else {_arsenalDisplay closedisplay 2;};
				};
				true
			};

			//Enter
			case (_key in [DIK_RETURN,DIK_NUMPADENTER]):
			{
				if _inTemplate then
				{
					if _inPopupUI then
					{
						private _ctrlPopupButtonOk = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
						if (ctrlEnabled _ctrlPopupButtonOk) then {_ctrlTvUIPopup setVariable ["TvUIPopup_Status",true];};
					} else {
						private _ctrlTemplateBUTTONOK = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
						if (ctrlEnabled _ctrlTemplateBUTTONOK) then {[_arsenalDisplay,"ButtonTemplateOK"] call VANA_fnc_ArsenalTreeView;};
					};
				};
				true
			};

			//Calls BIS Code:
			Default
			{
				//Allow Ctrl + C in edit bars
				if ((_key == DIK_C && _ctrl) && (_inTemplate || _inPopupUI)) exitWith {};

				if ((_inTemplate || _inPopupUI) && _key == DIK_TAB) then
				{
					true
				} else {
					['KeyDown',_arguments] call VANA_fnc_arsenal;
				};
			};
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "mousemove":
	{
		_arguments params
		[
			["_ctrlTV", controlNull, [controlNull]],
			["_xCoord", 0, [0]],
			["_yCoord", 0, [0]]
		];

		_ctrlTV setVariable ["MouseInTreeView", ([true, false] select (_xCoord >= 0.566 || _xCoord <= 0.046))];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "tvdragdrop":
	{
		_arguments params
		[
			["_dragDropMode", "", [""]],
			["_arguments", [], [[]]],
			"_ctrlTV",
			"_cursorTab",
			"_fncReturn",
			"_fncMode",
			"_fncArguments",
			"_tvParent"
		];

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_cursorTab = _arguments param [1, [-1], [[]]];

		_fncReturn = [_ctrlTV, _dragDropMode, _cursorTab] call VANA_fnc_tvDragDrop;

		_fncMode = toLower (_fncReturn select 0);
		_fncArguments = _fncReturn select 1;

		if (!(_fncMode isEqualTo "dragdropfnc") || !(_fncArguments isEqualType [])) exitWith {false};

		_tvParent = _fncArguments call VANA_fnc_tvGetParent;

		[_ctrlTV, _tvParent, false] call VANA_fnc_tvSorting;
		[_ctrlTV] call VANA_fnc_tvSaveData;

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	Case "create":
	{
		params ["_ctrlTV","_fncReturn","_tvParent"];

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_fncReturn = [_ctrlTV] call VANA_fnc_tvCreateTab;

		if (_fncReturn isEqualTo [-1]) exitWith {false};

		_tvParent = _fncReturn call VANA_fnc_tvGetParent;

		[_arsenalDisplay, "TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
		[_ctrlTV, _tvParent, false] call VANA_fnc_tvSorting;
		[_ctrlTV] call VANA_fnc_tvSaveData;

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	Case "delete":
	{
		params ["_ctrlTV","_targetTV","_deleteFnc"];

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

		_targetTV = tvCurSel _ctrlTV;
		_deleteFnc =
		{
			params ["_fncReturn","_tvParent"];

			_fncReturn = [_ctrlTV, _targetTV] call VANA_fnc_tvDelete;

			if !(_fncReturn isEqualType []) exitWith {false};

			_tvParent = _fncReturn call VANA_fnc_tvGetParent;

			[_arsenalDisplay, "TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
			[_ctrlTV, _tvParent, false] call VANA_fnc_tvSorting;
			[_ctrlTV] call VANA_fnc_tvSaveData;

			true
		};

		if (_targetTV isEqualTo []) exitWith {false};

		if !(Profilenamespace getVariable ["TEMP_Popup_Value", false]) then
		{
			if ([_arsenalDisplay,"Delete"] call VANA_fnc_UIPopup) then
			{
				call _deleteFnc;
			};
		} else {
			call _deleteFnc;
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	Case "rename":
	{
		params ["_ctrlTV","_ctrlRenameEdit","_return","_targetTV","_fncReturn","_name","_tvParent"];

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

		_return = [_arsenalDisplay, "Rename"] call VANA_fnc_UIPopup;

		if !_return exitWith {false};

		_targetTV = tvCurSel _ctrlTV;
		_name = ctrlText _ctrlRenameEdit;

		[_ctrlTV, [_targetTV, _name]] call VANA_fnc_tvRename;

		_tvParent = _targetTV call VANA_fnc_tvGetParent;

		[_arsenalDisplay, "TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
		[_ctrlTV, _tvParent, false] call VANA_fnc_tvSorting;
		[_ctrlTV] call VANA_fnc_tvSaveData;

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonload":
	{
		params ["_ctrlTV"];

		SHOW_UI(true)
		SHOW_SAVE_UI_PARTS(false)
		ctrlSetFocus _ctrlMouseBlock;

		//Show "Load"
		{
			(_arsenalDisplay displayCtrl _x) ctrlSetText localize "str_disp_int_load";
		} foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE,IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK];

		//Check if message allready displayed once
		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		if !(_ctrlTV getVariable ["VANA_LoadMessageDisplayed", false]) then
		{
			_ctrlTV setVariable ["VANA_LoadMessageDisplayed", true];
			["showMessage",[_arsenalDisplay,"Note: Loadouts still require unique names, Tabs do not"]] spawn BIS_fnc_arsenal;
		};

		[_arsenalDisplay,"TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonsave":
	{
		params ["_ctrlTemplateTitle","_ctrlTemplateEdit","_ctrlTV"];

		SHOW_UI(true)
		SHOW_SAVE_UI_PARTS(true)

		//Show "Save"
		_ctrlTemplateTitle = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE;
		_ctrlTemplateTitle ctrlSetText localize "str_disp_int_save";

		_ctrlTemplateEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		ctrlSetFocus _ctrlTemplateEdit;

		//Check if message allready displayed once
		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		if !(_ctrlTV getVariable ["VANA_SaveMessageDisplayed", false]) then
		{
			_ctrlTV setVariable ["VANA_SaveMessageDisplayed", true];
			["showMessage",[_arsenalDisplay,localize "STR_A3_RscDisplayArsenal_message_save"]] spawn BIS_fnc_arsenal;
		};

		[_arsenalDisplay,"TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttontemplateok":
	{
		params ["_ctrlTV","_ctrlTemplateEdit","_selectedTab","_hideTemplate","_loadoutName","_fncReturn","_tvParent","_center","_inventory","_loadoutData","_name","_nameID","_inventoryCustom"];

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_ctrlTemplateEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;

		_selectedTab = TvCursel _ctrlTV;
		_hideTemplate = true;

		if (ctrlEnabled _ctrlTemplateEdit) then
		{
			//Save
			_loadoutName = ctrlText _ctrlTemplateEdit;
			_fncReturn = [_ctrlTV, _loadoutName] call VANA_fnc_tvSaveLoadout;

			if (_fncReturn select 0 isEqualTo [-1]) exitWith {};

			_tvParent = (_fncReturn select 0) call VANA_fnc_tvGetParent;

			[_ctrlTV, _tvParent, false] call VANA_fnc_tvSorting;
			[_ctrlTV] call VANA_fnc_tvSaveData;

		} else {
			//Load (Taken Directly from BIS_fnc_Arsenal and modified to work with treeview)
			_center = (missionNamespace getVariable ["BIS_fnc_arsenal_center",player]);
			if ((_ctrlTV TvValue _selectedTab) >= 0 && (_ctrlTV tvData _selectedTab) isEqualTo "tvloadout") then
			{
				_inventory = _ctrlTV tvText _selectedTab;

				[_center,[profileNamespace,_inventory]] call BIS_fnc_loadinventory;
				_center switchmove "";

				//Load custom data
				_loadoutData = profileNamespace getVariable ["BIS_fnc_saveInventory_data",[]];
				_name = _ctrlTV tvText _selectedTab;
				_nameID = _loadoutData find _name;

				if (_nameID >= 0) then
				{
					_inventory = _loadoutData select (_nameID + 1);
					_inventoryCustom = _inventory select 10;

					_center setface (_inventoryCustom select 0);
					_center setVariable ["BIS_fnc_arsenal_face",(_inventoryCustom select 0)];
					_center setspeaker (_inventoryCustom select 1);

					[_center,_inventoryCustom select 2] call BIS_fnc_setUnitInsignia;
				};

				["ListSelectCurrent",[_arsenalDisplay]] spawn BIS_fnc_arsenal;
				["showMessage",[_arsenalDisplay, (format ["Loadout: ""%1"" Loaded", _name])]] spawn BIS_fnc_arsenal;
			} else {
				_hideTemplate = false;
			};
		};

		if _hideTemplate then
		{
			SHOW_UI(false)
		};

		true
	};
};
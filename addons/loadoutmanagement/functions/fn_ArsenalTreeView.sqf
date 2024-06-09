disableserialization;

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"
#include "\v\vana\addons\loadoutmanagement\defineResinclDesignVANA.hpp"

#define ShowUI(BOOL)\
	private _ctrlTemplate = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;\
	_ctrlTemplate ctrlsetfade (1 - parseNumber BOOL);\
	_ctrlTemplate ctrlcommit 0;\
	_ctrlTemplate ctrlEnable BOOL;\
	private _ctrlMouseBlock = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;\
	_ctrlMouseBlock ctrlEnable BOOL;

#define ShowSaveUIParts(BOOL)\
	{\
		private _ctrl = _ArsenalDisplay displayCtrl _x;\
		_ctrl ctrlShow BOOL;\
		_ctrl ctrlEnable BOOL;\
	} foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TEXTNAME,IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME,IDC_RSCDISPLAYARSENAL_VANA_DecorativeBar];

#define Expanded 1
#define Collapsed 0

params
[
	["_ArsenalDisplay", displayNull, [displayNull]],
	["_mode", "Open", [""]],
	["_arguments", [], [[]]]
];

switch toLower _mode do
{
	///////////////////////////////////////////////////////////////////////////////////////////
	Case "init":
	{
		params ["_ctrlTV","_CtrlTemplateEdit","_CtrlButtonSave","_CtrlButtonLoad","_CtrlTemplateOKButton","_CtrlButtonTabCreate","_CtrlButtonRename","_CtrlDeleteButton","_CtrlTvUIPopup"];

		_ArsenalDisplay setVariable ["Vana_Initialised", true];

		//Add EventHandlers
		_ArsenalDisplay displayseteventhandler ["keyDown","[(_this select 0), 'KeyDown', _this] call VANA_fnc_ArsenalTreeView;"];

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_ctrlTV ctrlAddeventHandler ["TreeSelChanged","[ctrlparent (_this select 0), 'TreeViewSelChanged'] call VANA_fnc_ArsenalTreeView;"];
		_ctrlTV ctrlAddeventHandler ["TreeDblClick","[ctrlparent (_this select 0), 'TreeDblClick'] call VANA_fnc_ArsenalTreeView;"];
		_ctrlTV ctrlAddeventHandler ["MouseMoving", "[ctrlparent (_this select 0), 'MouseMove', _this] call VANA_fnc_ArsenalTreeView;"];

		_ctrlTV ctrlAddeventHandler ["TreeExpanded", "[ctrlparent (_this select 0), 'SubTvToggle', (_this + [true])] call VANA_fnc_ArsenalTreeView;"];
		_ctrlTV ctrlAddeventHandler ["TreeCollapsed", "[ctrlparent (_this select 0), 'SubTvToggle', (_this + [false])] call VANA_fnc_ArsenalTreeView;"];

		_ctrlTV ctrlAddeventHandler ["MouseButtonDown","[ctrlparent (_this select 0), 'TvDragDrop', ['MouseDown']] spawn VANA_fnc_ArsenalTreeView;"];
		_ctrlTV ctrlAddeventHandler ["TreeMouseMove","[ctrlparent (_this select 0), 'TvDragDrop', ['MouseMove', _This]] spawn VANA_fnc_ArsenalTreeView;"];
		_ctrlTV ctrlAddeventHandler ["MouseButtonUp","[ctrlparent (_this select 0), 'TvDragDrop', ['MouseUp']] spawn VANA_fnc_ArsenalTreeView;"];

		_ctrlTemplateEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		_ctrlTemplateEdit ctrlAddeventHandler ["KeyDown","[ctrlparent (_this select 0), 'CheckOverWrite'] spawn VANA_fnc_ArsenalTreeView;"];
		_ctrlTemplateEdit ctrlAddeventHandler ["char","[ctrlparent (_this select 0), 'CheckOverWrite'] spawn VANA_fnc_ArsenalTreeView;"];

		_ctrlButtonSave = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE;
		_ctrlButtonSave ctrlAddeventHandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonSave'] call VANA_fnc_ArsenalTreeView;"];

		_ctrlButtonLoad = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
		_ctrlButtonLoad ctrlAddeventHandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonLoad'] call VANA_fnc_ArsenalTreeView;"];

		_ctrlTemplateOKButton = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		_ctrlTemplateOKButton ctrlAddeventHandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonTemplateOK'] call VANA_fnc_ArsenalTreeView;"];

		_ctrlButtonTabCreate = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_ButtonTabCreate;
		_ctrlButtonTabCreate ctrlAddeventHandler ["buttonclick","[ctrlparent (_this select 0), 'Create'] call VANA_fnc_ArsenalTreeView;"];

		_ctrlButtonRename = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_ButtonRename;
		_ctrlButtonRename ctrlAddeventHandler ["buttonclick","[ctrlparent (_this select 0), 'Rename'] spawn VANA_fnc_ArsenalTreeView;"];

		_ctrlDeleteButton = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
		_ctrlDeleteButton ctrlAddeventHandler ["buttonclick","[ctrlparent (_this select 0), 'Delete'] spawn VANA_fnc_ArsenalTreeView;"];

		//Load and Sort treeview
		[_ctrlTV] call VANA_fnc_tvLoadData;
		[_ctrlTV] call VANA_fnc_tvSorting;

		TvCollapseAll _ctrlTV;
		_ctrlTV TvExpand [];
		_ctrlTV tvSetCurSel [0];

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "exit":
	{
		params ["_ctrlTV"];

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

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

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		[_ctrlTV] call VANA_fnc_tvSaveData;

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "treeviewselchanged":
	{
		params ["_ctrlTV","_SelectedTab","_IsEnabledLoadout","_CtrlDeleteButton","_CtrlButtonRename","_CtrlTemplateEdit","_CtrlTemplateOKButton"];

		[_ArsenalDisplay, "CheckOverWrite"] spawn VANA_fnc_ArsenalTreeView;

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

		_SelectedTab = tvCurSel _ctrlTV;
		_IsEnabledLoadout = toLower (_ctrlTV tvData _SelectedTab) isEqualto "tvloadout" && (_ctrlTV tvValue _SelectedTab) >= 0;

		//Make sure something is selected
		_ctrlDeleteButton = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
		_ctrlDeleteButton ctrlEnable !(_SelectedTab isEqualTo []);

		_ctrlButtonRename = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_ButtonRename;
		_ctrlButtonRename ctrlEnable !(_SelectedTab isEqualTo []);

		//SetText to selected Subtv Text
		_ctrlTemplateEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		_ctrlTemplateEdit ctrlSetText (_ctrlTV tvtext _SelectedTab);

		//Disable button if loadout is missing items
		_ctrlTemplateOKButton = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		_ctrlTemplateOKButton ctrlEnable ([_IsEnabledLoadout, true] select ctrlEnabled _ctrlTemplateEdit);

		//Temp code WIP
		private _ctrlTempCheckbox = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_DelConfirmToggle;
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
		params ["_CtrlTemplateBUTTONOK","_CtrlTemplateEdit","_LoadoutData","_Name","_Duplicate"];

		_ctrlTemplateBUTTONOK = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		_ctrlTemplateEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		_LoadoutData = (profileNamespace getVariable ["BIS_fnc_saveInventory_Data",[]]) select {_x isEqualType ""};

		//Check if name duplicate and change text accordingly
		_Name = ctrlText _ctrlTemplateEdit;

		if (ctrlEnabled _ctrlTemplateEdit) then
		{
			_Duplicate = _Name in _LoadoutData;
			_ctrlTemplateBUTTONOK Ctrlsettext (["Save", "Replace"] select _Duplicate);
			_ctrlTemplateBUTTONOK Ctrlenable ([true, false] select (_Name isEqualTo ""));

			_Duplicate
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "subtvtoggle":
	{
		_arguments params
		[
			["_ctrlTV", controlNull, [controlNull]],
			["_targetTV", [-1], [[]]],
			["_Expanded", false, [false]]
		];

		_ctrlTV TvSetValue [_targetTV, ([Collapsed, Expanded] Select _Expanded)];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "treedblclick":
	{
		params ["_SelectedTab","_tvData","_ctrlTV","_TvCollapsed"];

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_SelectedTab = tvCurSel _ctrlTV;
		_tvData = toLower (_ctrlTV tvData _SelectedTab);

		if !(_ctrlTV getVariable ["MouseInTreeView", true]) exitwith {false};

		switch _tvData do
		{
			case "tvloadout":
			{
				[_ArsenalDisplay, "ButtonTemplateOK"] call VANA_fnc_ArsenalTreeView;
				true
			};
			case "tvtab":
			{
				//Expand or Collapse Tab
				_TvCollapsed = (_ctrlTV TvValue _SelectedTab) isEqualTo Collapsed;
				call ([{_ctrlTV TvCollapse _SelectedTab}, {_ctrlTV TvExpand _SelectedTab}] select _TvCollapsed);

				[_ArsenalDisplay, "SubTvToggle", [_ctrlTV, _SelectedTab, ([false, true] select _TvCollapsed)]] call VANA_fnc_ArsenalTreeView;
				true
			};
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "keydown":
	{
		_arguments params
		[
			["_ArsenalDisplay", Displaynull, [Displaynull]],
			["_Key", -1, [-1]],
			["_Shift", false, [false]],
			["_Ctrl", false, [false]],
			["_Alt", false, [false]],
			"_CtrlTemplate",
			"_CtrlTvUIPopup",
			"_CtrlTemplateEdit",
			"_CtrlRenameEdit",
			"_inTemplate",
			"_InPopupUI"
		];

		_ctrlTemplate = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_ctrlTvUIPopup = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
		_ctrlTemplateEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		_ctrlRenameEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

		_InTemplate = ctrlFade _ctrlTemplate == 0;
		_InPopupUI = ctrlShown _ctrlTvUIPopup;

		switch true do
		{
			//CreateTab
			case (_key == DIK_N && _ctrl):
			{
				if (_InTemplate && !_InPopupUI) then
				{
					[_ArsenalDisplay,"Create"] call VANA_fnc_ArsenalTreeView;
				};
				true
			};

			//Delete
			case ((_key == DIK_DELETE)||(_key == DIK_D && _ctrl)):
			{
				if (_InTemplate && !_InPopupUI) then
				{
					[_ArsenalDisplay,"Delete"] spawn VANA_fnc_ArsenalTreeView;
				};
				true
			};

			//Rename
			case (_key == DIK_E && _ctrl):
			{
				if (_InTemplate && !_InPopupUI) then
				{
					[_ArsenalDisplay,"Rename"] spawn VANA_fnc_ArsenalTreeView;
				};
				true
			};

			//Save
			Case (_key == DIK_S && _ctrl):
			{
				if !_InPopupUI then
				{
					[_ArsenalDisplay,"ButtonSave"] call VANA_fnc_ArsenalTreeView;
				};
				true
			};

			//Open
			Case (_key == DIK_O && _ctrl):
			{
				if !_InPopupUI then
				{
					[_ArsenalDisplay,"ButtonLoad"] call VANA_fnc_ArsenalTreeView;
				};
				true
			};

			//Close
			case (_key == DIK_ESCAPE):
			{
				if _inTemplate then
				{
					if _InPopupUI then
					{
						_ctrlTvUIPopup setVariable ["TvUIPopup_Status",false];
					} else {
						ShowUI(false)
					};
				} else {
					private _FullVersion = missionNamespace getVariable ["BIS_fnc_arsenal_fullArsenal", false];
					if _fullVersion then {["buttonClose",[_ArsenalDisplay]] spawn BIS_fnc_arsenal;} else {_ArsenalDisplay closedisplay 2;};
				};
				true
			};

			//Enter
			case (_key in [DIK_RETURN,DIK_NUMPADENTER]):
			{
				if _InTemplate then
				{
					if _InPopupUI then
					{
						private _ctrlPopupButtonOk = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
						if (ctrlEnabled _ctrlPopupButtonOk) then {_CtrlTvUIPopup setVariable ["TvUIPopup_Status",true];};
					} else {
						private _ctrlTemplateBUTTONOK = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
						if (ctrlEnabled _ctrlTemplateBUTTONOK) then {[_ArsenalDisplay,"ButtonTemplateOK"] call VANA_fnc_ArsenalTreeView;};
					};
				};
				true
			};

			//Calls BIS Code:
			Default
			{
				//Allow Ctrl + C in edit bars
				if ((_key == DIK_C && _ctrl) && (_InTemplate || _InPopupUI)) exitwith {};

				if ((_InTemplate || _InPopupUI) && _key == DIK_TAB) then
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
			["_XCoord", 0, [0]],
			["_YCoord", 0, [0]]
		];

		_ctrlTV setVariable ["MouseInTreeView", ([true, false] select (_XCoord >= 0.566 || _XCoord <= 0.046))];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "tvdragdrop":
	{
		_arguments params
		[
			["_DragDropMode", "", [""]],
			["_arguments", [], [[]]],
			"_ctrlTV",
			"_CursorTab",
			"_FncReturn",
			"_FncMode",
			"_FncArguments",
			"_TvParent"
		];

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_CursorTab = _arguments param [1, [-1], [[]]];

		_FncReturn = [_ctrlTV, _DragDropMode, _CursorTab] call VANA_fnc_tvDragDrop;

		_FncMode = toLower (_FncReturn select 0);
		_FncArguments = _FncReturn select 1;

		if (!(_FncMode isEqualTo "dragdropfnc") || !(_FncArguments isEqualType [])) exitwith {false};

		_TvParent = _FncArguments call VANA_fnc_tvGetParent;

		[_ctrlTV, _TvParent, false] call VANA_fnc_tvSorting;
		[_ctrlTV] call VANA_fnc_tvSaveData;

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	Case "create":
	{
		params ["_ctrlTV","_FncReturn","_TvParent"];

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_FncReturn = [_ctrlTV] call VANA_fnc_tvCreateTab;

		if (_FncReturn isEqualTo [-1]) exitwith {false};

		_TvParent = _FncReturn call VANA_fnc_tvGetParent;

		[_ArsenalDisplay, "TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
		[_ctrlTV, _TvParent, false] call VANA_fnc_tvSorting;
		[_ctrlTV] call VANA_fnc_tvSaveData;

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	Case "delete":
	{
		params ["_ctrlTV","_targetTV","_DeleteFnc"];

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

		_targetTV = tvCurSel _ctrlTV;
		_DeleteFnc =
		{
			params ["_FncReturn","_TvParent"];

			_FncReturn = [_ctrlTV, _targetTV] call VANA_fnc_tvDelete;

			if !(_FncReturn isEqualType []) exitwith {false};

			_TvParent = _FncReturn call VANA_fnc_tvGetParent;

			[_ArsenalDisplay, "TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
			[_ctrlTV, _TvParent, false] call VANA_fnc_tvSorting;
			[_ctrlTV] call VANA_fnc_tvSaveData;

			true
		};

		if (_targetTV isEqualTo []) exitwith {false};

		if !(Profilenamespace getVariable ["TEMP_Popup_Value", false]) then
		{
			if ([_ArsenalDisplay,"Delete"] call VANA_fnc_UIPopup) then
			{
				call _DeleteFnc;
			};
		} else {
			call _DeleteFnc;
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	Case "rename":
	{
		params ["_ctrlTV","_CtrlRenameEdit","_Return","_targetTV","_FncReturn","_Name","_TvParent"];

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_ctrlRenameEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

		_Return = [_ArsenalDisplay, "Rename"] call VANA_fnc_UIPopup;

		if !_Return exitwith {false};

		_targetTV = tvCurSel _ctrlTV;
		_Name = ctrlText _ctrlRenameEdit;

		[_ctrlTV, [_targetTV, _Name]] call VANA_fnc_tvRename;

		_TvParent = _targetTV call VANA_fnc_tvGetParent;

		[_ArsenalDisplay, "TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
		[_ctrlTV, _TvParent, false] call VANA_fnc_tvSorting;
		[_ctrlTV] call VANA_fnc_tvSaveData;

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonload":
	{
		params ["_ctrlTV"];

		ShowUI(true)
		ShowSaveUIParts(false)
		ctrlSetFocus _ctrlMouseBlock;

		//Show "Load"
		{
			(_ArsenalDisplay displayCtrl _x) ctrlSetText localize "str_disp_int_load";
		} foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE,IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK];

		//Check if message allready displayed once
		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		if !(_ctrlTV getVariable ["VANA_LoadMessageDisplayed", false]) then
		{
			_ctrlTV setVariable ["VANA_LoadMessageDisplayed", true];
			["showMessage",[_ArsenalDisplay,"Note: Loadouts still require unique names, Tabs do not"]] spawn BIS_fnc_arsenal;
		};

		[_ArsenalDisplay,"TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonsave":
	{
		params ["_CtrlTemplateTitle","_CtrlTemplateEdit","_ctrlTV"];

		ShowUI(true)
		ShowSaveUIParts(true)

		//Show "Save"
		_ctrlTemplateTitle = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE;
		_ctrlTemplateTitle ctrlSetText localize "str_disp_int_save";

		_ctrlTemplateEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		ctrlSetFocus _ctrlTemplateEdit;

		//Check if message allready displayed once
		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		if !(_ctrlTV getVariable ["VANA_SaveMessageDisplayed", false]) then
		{
			_ctrlTV setVariable ["VANA_SaveMessageDisplayed", true];
			["showMessage",[_ArsenalDisplay,localize "STR_A3_RscDisplayArsenal_message_save"]] spawn BIS_fnc_arsenal;
		};

		[_ArsenalDisplay,"TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;

		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttontemplateok":
	{
		params ["_ctrlTV","_CtrlTemplateEdit","_SelectedTab","_HideTemplate","_LoadoutName","_FncReturn","_TvParent","_center","_Inventory","_LoadoutData","_Name","_NameID","_InventoryCustom"];

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_ctrlTemplateEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;

		_SelectedTab = TvCursel _ctrlTV;
		_HideTemplate = true;

		if (ctrlEnabled _ctrlTemplateEdit) then
		{
			//Save
			_LoadoutName = ctrlText _ctrlTemplateEdit;
			_FncReturn = [_ctrlTV, _LoadoutName] call VANA_fnc_tvSaveLoadout;

			if (_FncReturn select 0 isEqualTo [-1]) exitwith {};

			_TvParent = (_FncReturn select 0) call VANA_fnc_tvGetParent;

			[_ctrlTV, _TvParent, false] call VANA_fnc_tvSorting;
			[_ctrlTV] call VANA_fnc_tvSaveData;

		} else {
			//Load (Taken Directly from BIS_fnc_Arsenal and modified to work with treeview)
			_center = (missionNamespace getVariable ["BIS_fnc_arsenal_center",player]);
			if ((_ctrlTV TvValue _SelectedTab) >= 0 && (_ctrlTV TvData _SelectedTab) isEqualTo "tvloadout") then
			{
				_Inventory = _ctrlTV tvText _SelectedTab;

				[_center,[profileNamespace,_Inventory]] call BIS_fnc_loadinventory;
				_center switchmove "";

				//Load custom data
				_LoadoutData = profileNamespace getVariable ["BIS_fnc_saveInventory_data",[]];
				_Name = _ctrlTV tvText _SelectedTab;
				_NameID = _LoadoutData find _Name;

				if (_NameID >= 0) then
				{
					_Inventory = _LoadoutData select (_NameID + 1);
					_InventoryCustom = _Inventory select 10;

					_center setface (_InventoryCustom select 0);
					_center setVariable ["BIS_fnc_arsenal_face",(_InventoryCustom select 0)];
					_center setspeaker (_InventoryCustom select 1);

					[_center,_InventoryCustom select 2] call BIS_fnc_setUnitInsignia;
				};

				["ListSelectCurrent",[_ArsenalDisplay]] spawn BIS_fnc_arsenal;
				["showMessage",[_ArsenalDisplay, (format ["Loadout: ""%1"" Loaded", _Name])]] spawn BIS_fnc_arsenal;
			} else {
				_HideTemplate = false;
			};
		};

		if _HideTemplate then
		{
			ShowUI(false)
		};

		true
	};
};
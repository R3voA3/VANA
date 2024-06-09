disableserialization;

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"
#include "\v\vana\addons\loadoutmanagement\defineResinclDesignVANA.hpp"

#define ShowUI(BOOL)\
	private _ctrlTvUIPopup = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;\
	private _ctrlVanaMouseBlock = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_Mouseblock;\
	{_x ctrlShow BOOL} foreach [_CtrlTvUIPopup,_CtrlVanaMouseBlock];

#define ShowDeleteUI(BOOL)\
	private _ctrlRenameEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;\
	private _ctrlPopupCheckBox = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;\
	private _ctrlPopupCheckBoxText = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_CheckboxText;\
	private _ctrlHintText = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_HintText;\
	_ctrlRenameEdit ctrlShow !BOOL;\
	{_x ctrlShow BOOL;} foreach [_CtrlPopupCheckBox,_CtrlPopupCheckBoxText,_CtrlHintText];

#define TvInfo\
	_targetTV = tvCurSel _ctrlTV;\
	_tvName = _ctrlTV tvtext _targetTV;\
	_tvData = toLower (_ctrlTV tvData _targetTV);\
	_tvDataString = ["Tab", "Loadout"] select (_tvData == "tvloadout");

params
[
	["_ArsenalDisplay", displayNull, [displayNull]],
	["_mode", "", [""]]
];

switch (toLower _mode) do
{
	///////////////////////////////////////////////////////////////////////////////////////////
	case "init":
	{
		params ["_CtrlRenameEdit","_CtrlButtonCancel","_CtrlButtonOk","_CtrlPopupCheckBox","_CtrlTempCheckbox"];

		//Hide Vana dint init popup
		ShowUI(false)

		//Apply Event handlers
		_ctrlRenameEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
		_ctrlRenameEdit ctrlAddeventHandler ["killFocus","[ctrlparent (_this select 0),'KeepFocus'] spawn VANA_fnc_UIPopup;"];
		_ctrlRenameEdit ctrlAddeventHandler ["KeyDown","[ctrlparent (_this select 0),'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];
		_ctrlRenameEdit ctrlAddeventHandler ["char","[ctrlparent (_this select 0),'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];

		_ctrlButtonCancel = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonCancel;
		_ctrlButtonCancel ctrlAddeventHandler ["buttonclick","(ctrlParent (_this select 0) displayCtrl 979000) setVariable ['TvUIPopup_Status', false]"];

		_ctrlButtonOk = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
		_ctrlButtonOk ctrlAddeventHandler ["buttonclick","(ctrlParent (_this select 0) displayCtrl 979000) setVariable ['TvUIPopup_Status', true]"];

		_ctrlPopupCheckBox = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
		_ctrlPopupCheckBox ctrlAddeventHandler ["killFocus","[ctrlparent (_this select 0),'KeepFocus'] spawn VANA_fnc_UIPopup;"];
		_ctrlPopupCheckBox ctrlAddeventHandler ["CheckedChanged","if (Profilenamespace getVariable ['TEMP_Popup_Value', false]) then {Profilenamespace setVariable ['TEMP_Popup_Value', false];} else {Profilenamespace setVariable ['TEMP_Popup_Value', true];}; [ctrlparent (_this select 0),'TreeViewSelChanged'] call VANA_fnc_ArsenalTreeView;"];

		_ctrlTempCheckbox = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_DelConfirmToggle; //Temp
		_ctrlTempCheckbox ctrlAddeventHandler ["CheckedChanged","if (Profilenamespace getVariable ['TEMP_Popup_Value', false]) then {Profilenamespace setVariable ['TEMP_Popup_Value', false];} else {Profilenamespace setVariable ['TEMP_Popup_Value', true];};"];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "waituntilstatus":
	{
		params ["_CtrlTemplate","_CtrlTvUIPopup","_CtrlRenameEdit","_Status"];

		_ctrlTemplate = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_ctrlTvUIPopup = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
		_ctrlRenameEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

		//Waituntil Confirm or cancel button was pressed
		waituntil {!isnil {_CtrlTvUIPopup getVariable "TvUIPopup_Status"}};
		_Status = (_CtrlTvUIPopup getVariable "TvUIPopup_Status");

		ShowUI(false)

		_ctrlTvUIPopup setVariable ["TvUIPopup_Status",nil];
		ctrlSetFocus _ctrlTemplate;

		_Status
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "keepfocus":
	{
		params ["_CtrlTvUIPopup","_CtrlPopupCheckBox","_CtrlRenameEdit"];

		_ctrlTvUIPopup = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
		_ctrlPopupCheckBox = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
		_ctrlRenameEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

		//Keep focus on Popup UI
		if (ctrlShown _ctrlTvUIPopup) exitwith
		{
			ctrlSetFocus ([_CtrlRenameEdit, _ctrlPopupCheckBox] select (ctrlShown _ctrlPopupCheckBox));

			true
		};
		false
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "delete":
	{
		params ["_ctrlTV","_CtrlTitle","_CtrlTextMessage","_CtrlButtonOk","_CtrlPopupCheckBox","_targetTV","_tvName","_tvData","_tvDataString"];

		ShowUI(true)

		//Show Delete UI
		ShowDeleteUI(true)

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		TvInfo

		//Apply header and Message text
		_ctrlTitle = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Title;
		_ctrlTitle ctrlSetText "Delete Confirmation";

		_ctrlTextMessage = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Text;
		_ctrlTextMessage ctrlsetStructuredText parseText format ["Delete %1: '%2'",_tvDataString, _tvName];

		_ctrlButtonOk = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
		_ctrlButtonOk ctrlEnable true;

		//Set checkbox state
		_ctrlPopupCheckBox = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
		if !(Profilenamespace getVariable ['TEMP_Popup_Value', false]) then
		{
			_ctrlPopupCheckBox cbSetChecked false;
		};
		ctrlSetFocus _ctrlPopupCheckBox;

		[_ArsenalDisplay,"WaituntilStatus"] call VANA_fnc_UIPopup;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "rename":
	{
		params ["_ctrlTV","_CtrlTitle","_CtrlRenameEdit","_targetTV","_tvName","_tvData","_tvDataString"];

		ShowUI(true)

		//Show Rename UI
		ShowDeleteUI(false)
		ctrlSetFocus _ctrlRenameEdit;

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		TvInfo

		//Apply header, Message text and clear Rename field
		_ctrlTitle = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Title;
		_ctrlTitle ctrlSetText "Rename Confirmation";

		_ctrlRenameEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
		_ctrlRenameEdit ctrlSetText "";
		_ctrlRenameEdit ctrlSetText _tvName;

		_ctrlTextMessage = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Text;
		_ctrlTextMessage ctrlsetStructuredText parseText format ["Rename %1: '%2'",_tvDataString, _tvName];

		[_ArsenalDisplay,"CheckNameTaken"] call VANA_fnc_UIPopup;
		[_ArsenalDisplay,"WaituntilStatus"] call VANA_fnc_UIPopup;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "checknametaken":
	{
		params ["_ctrlTV","_CtrlRenameEdit","_CtrlButtonOk","_LoadoutData","_Name","_targetTV","_tvName","_tvData","_tvDataString","_Duplicate"];

		_ctrlTV = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_ctrlRenameEdit = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
		_ctrlButtonOk = _ArsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
		_LoadoutData = (profileNamespace getVariable ["BIS_fnc_saveInventory_Data",[]]) select {_x isEqualType ""};

		_Name = ctrlText _ctrlRenameEdit;
		TvInfo

		//Check if name duplicate and color edit field accordingly
		_Duplicate = [false, _Name in _LoadoutData] select (_tvData isEqualTo "tvloadout");
		_ctrlButtonOk ctrlEnable ([true, false] select (_Duplicate || _Name isEqualTo "" || _Name isEqualTo _tvName));

		_Duplicate
	};
};
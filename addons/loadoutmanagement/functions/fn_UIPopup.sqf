disableserialization;

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"
#include "\v\vana\addons\loadoutmanagement\defineResinclDesignVANA.hpp"

#define ShowUI(BOOL)\
	private _ctrlTvUIPopup = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;\
	private _ctrlVanaMouseBlock = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_Mouseblock;\
	{_x ctrlShow BOOL} foreach [_ctrlTvUIPopup,_ctrlVanaMouseBlock];

#define ShowDeleteUI(BOOL)\
	private _ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;\
	private _ctrlPopupCheckBox = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;\
	private _ctrlPopupCheckBoxText = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_CheckboxText;\
	private _ctrlHintText = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_HintText;\
	_ctrlRenameEdit ctrlShow !BOOL;\
	{_x ctrlShow BOOL;} foreach [_ctrlPopupCheckBox,_ctrlPopupCheckBoxText,_ctrlHintText];

#define TvInfo\
	_targetTV = tvCurSel _ctrlTV;\
	_tvName = _ctrlTV tvtext _targetTV;\
	_tvData = toLower (_ctrlTV tvData _targetTV);\
	_tvDataString = ["Tab", "Loadout"] select (_tvData == "tvloadout");

params
[
	["_arsenalDisplay", displayNull, [displayNull]],
	["_mode", "", [""]]
];

switch (toLower _mode) do
{
	///////////////////////////////////////////////////////////////////////////////////////////
	case "init":
	{
		params ["_ctrlRenameEdit","_ctrlButtonCancel","_ctrlButtonOk","_ctrlPopupCheckBox","_ctrlTempCheckbox"];

		//Hide Vana dint init popup
		ShowUI(false)

		//Apply Event handlers
		_ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
		_ctrlRenameEdit ctrlAddeventHandler ["killFocus","[ctrlparent (_this select 0),'KeepFocus'] spawn VANA_fnc_UIPopup;"];
		_ctrlRenameEdit ctrlAddeventHandler ["KeyDown","[ctrlparent (_this select 0),'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];
		_ctrlRenameEdit ctrlAddeventHandler ["char","[ctrlparent (_this select 0),'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];

		_ctrlButtonCancel = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonCancel;
		_ctrlButtonCancel ctrlAddeventHandler ["buttonclick","(ctrlParent (_this select 0) displayCtrl 979000) setVariable ['TvUIPopup_Status', false]"];

		_ctrlButtonOk = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
		_ctrlButtonOk ctrlAddeventHandler ["buttonclick","(ctrlParent (_this select 0) displayCtrl 979000) setVariable ['TvUIPopup_Status', true]"];

		_ctrlPopupCheckBox = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
		_ctrlPopupCheckBox ctrlAddeventHandler ["killFocus","[ctrlparent (_this select 0),'KeepFocus'] spawn VANA_fnc_UIPopup;"];
		_ctrlPopupCheckBox ctrlAddeventHandler ["CheckedChanged","if (Profilenamespace getVariable ['TEMP_Popup_Value', false]) then {Profilenamespace setVariable ['TEMP_Popup_Value', false];} else {Profilenamespace setVariable ['TEMP_Popup_Value', true];}; [ctrlparent (_this select 0),'TreeViewSelChanged'] call VANA_fnc_ArsenalTreeView;"];

		_ctrlTempCheckbox = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_DelConfirmToggle; //Temp
		_ctrlTempCheckbox ctrlAddeventHandler ["CheckedChanged","if (Profilenamespace getVariable ['TEMP_Popup_Value', false]) then {Profilenamespace setVariable ['TEMP_Popup_Value', false];} else {Profilenamespace setVariable ['TEMP_Popup_Value', true];};"];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "waituntilstatus":
	{
		params ["_ctrlTemplate","_ctrlTvUIPopup","_ctrlRenameEdit","_status"];

		_ctrlTemplate = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_ctrlTvUIPopup = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
		_ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

		//Waituntil Confirm or cancel button was pressed
		waituntil {!isnil {_ctrlTvUIPopup getVariable "TvUIPopup_Status"}};
		_status = (_ctrlTvUIPopup getVariable "TvUIPopup_Status");

		ShowUI(false)

		_ctrlTvUIPopup setVariable ["TvUIPopup_Status",nil];
		ctrlSetFocus _ctrlTemplate;

		_status
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "keepfocus":
	{
		params ["_ctrlTvUIPopup","_ctrlPopupCheckBox","_ctrlRenameEdit"];

		_ctrlTvUIPopup = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
		_ctrlPopupCheckBox = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
		_ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

		//Keep focus on Popup UI
		if (ctrlShown _ctrlTvUIPopup) exitwith
		{
			ctrlSetFocus ([_ctrlRenameEdit, _ctrlPopupCheckBox] select (ctrlShown _ctrlPopupCheckBox));

			true
		};
		false
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "delete":
	{
		params ["_ctrlTV","_ctrlTitle","_ctrlTextMessage","_ctrlButtonOk","_ctrlPopupCheckBox","_targetTV","_tvName","_tvData","_tvDataString"];

		ShowUI(true)

		//Show Delete UI
		ShowDeleteUI(true)

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		TvInfo

		//Apply header and Message text
		_ctrlTitle = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Title;
		_ctrlTitle ctrlSetText "Delete Confirmation";

		_ctrlTextMessage = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Text;
		_ctrlTextMessage ctrlsetStructuredText parseText format ["Delete %1: '%2'",_tvDataString, _tvName];

		_ctrlButtonOk = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
		_ctrlButtonOk ctrlEnable true;

		//Set checkbox state
		_ctrlPopupCheckBox = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
		if !(Profilenamespace getVariable ['TEMP_Popup_Value', false]) then
		{
			_ctrlPopupCheckBox cbSetChecked false;
		};
		ctrlSetFocus _ctrlPopupCheckBox;

		[_arsenalDisplay,"WaituntilStatus"] call VANA_fnc_UIPopup;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "rename":
	{
		params ["_ctrlTV","_ctrlTitle","_ctrlRenameEdit","_targetTV","_tvName","_tvData","_tvDataString"];

		ShowUI(true)

		//Show Rename UI
		ShowDeleteUI(false)
		ctrlSetFocus _ctrlRenameEdit;

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		TvInfo

		//Apply header, Message text and clear Rename field
		_ctrlTitle = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Title;
		_ctrlTitle ctrlSetText "Rename Confirmation";

		_ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
		_ctrlRenameEdit ctrlSetText "";
		_ctrlRenameEdit ctrlSetText _tvName;

		_ctrlTextMessage = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Text;
		_ctrlTextMessage ctrlsetStructuredText parseText format ["Rename %1: '%2'",_tvDataString, _tvName];

		[_arsenalDisplay,"CheckNameTaken"] call VANA_fnc_UIPopup;
		[_arsenalDisplay,"WaituntilStatus"] call VANA_fnc_UIPopup;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "checknametaken":
	{
		params ["_ctrlTV","_ctrlRenameEdit","_ctrlButtonOk","_loadoutData","_name","_targetTV","_tvName","_tvData","_tvDataString","_duplicate"];

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
		_ctrlButtonOk = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
		_loadoutData = (profileNamespace getVariable ["BIS_fnc_saveInventory_Data",[]]) select {_x isEqualType ""};

		_name = ctrlText _ctrlRenameEdit;
		TvInfo

		//Check if name duplicate and color edit field accordingly
		_duplicate = [false, _name in _loadoutData] select (_tvData isEqualTo "tvloadout");
		_ctrlButtonOk ctrlEnable ([true, false] select (_duplicate || _name isEqualTo "" || _name isEqualTo _tvName));

		_duplicate
	};
};
disableserialization;

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"
#include "\v\vana\addons\loadoutmanagement\defines.inc"

params
[
	["_arsenalDisplay", displayNull, [displayNull]],
	["_mode", "", [""]]
];

switch (toLower _mode) do
{
	case "init":
	{
		params ["_ctrlRenameEdit","_ctrlButtonCancel","_ctrlButtonOk","_ctrlPopupCheckBox","_ctrlTempCheckbox"];

		//Hide VANA did not init popup
		SHOW_UI_POPUP(false)

		//Apply Event handlers
		_ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
		_ctrlRenameEdit ctrlAddEventHandler ["killFocus","[ctrlparent (_this select 0),'KeepFocus'] spawn VANA_fnc_UIPopup;"];
		_ctrlRenameEdit ctrlAddEventHandler ["KeyDown","[ctrlparent (_this select 0),'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];
		_ctrlRenameEdit ctrlAddEventHandler ["char","[ctrlparent (_this select 0),'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];

		_ctrlButtonCancel = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonCancel;
		_ctrlButtonCancel ctrlAddEventHandler ["buttonclick","(ctrlParent (_this select 0) displayCtrl 979000) setVariable ['TvUIPopup_Status', false]"];

		_ctrlButtonOk = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
		_ctrlButtonOk ctrlAddEventHandler ["buttonclick","(ctrlParent (_this select 0) displayCtrl 979000) setVariable ['TvUIPopup_Status', true]"];

		_ctrlPopupCheckBox = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
		_ctrlPopupCheckBox ctrlAddEventHandler ["killFocus","[ctrlparent (_this select 0),'KeepFocus'] spawn VANA_fnc_UIPopup;"];
		_ctrlPopupCheckBox ctrlAddEventHandler ["CheckedChanged","if (profileNameSpace getVariable ['TEMP_Popup_Value', false]) then {profileNameSpace setVariable ['TEMP_Popup_Value', false];} else {profileNameSpace setVariable ['TEMP_Popup_Value', true];}; [ctrlparent (_this select 0),'TreeViewSelChanged'] call VANA_fnc_ArsenalTreeView;"];

		_ctrlTempCheckbox = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_DelConfirmToggle; //Temp
		_ctrlTempCheckbox ctrlAddEventHandler ["CheckedChanged","if (profileNameSpace getVariable ['TEMP_Popup_Value', false]) then {profileNameSpace setVariable ['TEMP_Popup_Value', false];} else {profileNameSpace setVariable ['TEMP_Popup_Value', true];};"];
	};
	case "waituntilstatus":
	{
		private _ctrlTemplate = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		private _ctrlTvUIPopup = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
		private _ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

		//Waituntil Confirm or cancel button was pressed
		waituntil {!isnil {_ctrlTvUIPopup getVariable "TvUIPopup_Status"}};
		private _status = _ctrlTvUIPopup getVariable "TvUIPopup_Status";

		SHOW_UI_POPUP(false)

		_ctrlTvUIPopup setVariable ["TvUIPopup_Status",nil];
		ctrlSetFocus _ctrlTemplate;

		_status
	};
	case "keepfocus":
	{
		private _ctrlTvUIPopup = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
		private _ctrlPopupCheckBox = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
		private _ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

		//Keep focus on Popup UI
		if (ctrlShown _ctrlTvUIPopup) exitWith
		{
			ctrlSetFocus ([_ctrlRenameEdit, _ctrlPopupCheckBox] select (ctrlShown _ctrlPopupCheckBox));

			true
		};
		false
	};
	case "delete":
	{
		params ["_ctrlTV","_ctrlTitle","_ctrlTextMessage","_ctrlButtonOk","_ctrlPopupCheckBox","_path","_tvName","_tvData","_tvDataString"];

		SHOW_UI_POPUP(true)

		//Show Delete UI
		SHOW_DELETE_UI(true)

		private _ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		TV_INFO

		//Apply header and Message text
		private _ctrlTitle = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Title;
		_ctrlTitle ctrlSetText "Delete Confirmation";

		private _ctrlTextMessage = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Text;
		_ctrlTextMessage ctrlsetStructuredText parseText format ["Delete %1: '%2'",_tvDataString, _tvName];

		private _ctrlButtonOk = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
		_ctrlButtonOk ctrlEnable true;

		//Set checkbox state
		private _ctrlPopupCheckBox = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
		if !(profileNameSpace getVariable ['TEMP_Popup_Value', false]) then
		{
			_ctrlPopupCheckBox cbSetChecked false;
		};
		ctrlSetFocus _ctrlPopupCheckBox;

		[_arsenalDisplay,"WaituntilStatus"] call VANA_fnc_UIPopup;
	};
	case "rename":
	{
		params ["_ctrlTV","_ctrlTitle","_ctrlRenameEdit","_path","_tvName","_tvData","_tvDataString"];

		SHOW_UI_POPUP(true)

		//Show Rename UI
		SHOW_DELETE_UI(false)
		ctrlSetFocus _ctrlRenameEdit;

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		TV_INFO

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
	case "checknametaken":
	{
		params ["_ctrlTV","_ctrlRenameEdit","_ctrlButtonOk","_loadoutData","_name","_path","_tvName","_tvData","_tvDataString","_duplicate"];

		_ctrlTV = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
		_ctrlButtonOk = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
		_loadoutData = (profileNameSpace getVariable ["BIS_fnc_saveInventory_Data",[]]) select {_x isEqualType ""};

		_name = ctrlText _ctrlRenameEdit;
		TV_INFO

		//Check if name duplicate and color edit field accordingly
		_duplicate = [false, _name in _loadoutData] select (_tvData isEqualTo "tvloadout");
		_ctrlButtonOk ctrlEnable ([true, false] select (_duplicate || _name isEqualTo "" || _name isEqualTo _tvName));

		_duplicate
	};
};
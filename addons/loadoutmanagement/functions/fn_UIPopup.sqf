disableserialization;

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"
#include "\v\vana\addons\loadoutmanagement\defineResinclDesignVANA.hpp"

#define ShowUI(BOOL)\
  private _ctrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;\
  private _ctrlVanaMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_Mouseblock;\
  {_x ctrlshow BOOL} foreach [_CtrlTvUIPopup,_CtrlVanaMouseBlock];

#define ShowDeleteUI(BOOL)\
  private _ctrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;\
  private _ctrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;\
  private _ctrlPopupCheckBoxText = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_CheckboxText;\
  private _ctrlHintText = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_HintText;\
  _ctrlRenameEdit ctrlshow !BOOL;\
  {_x ctrlshow BOOL;} foreach [_CtrlPopupCheckBox,_CtrlPopupCheckBoxText,_CtrlHintText];

#define TvInfo\
  _targetTV = tvCurSel _ctrlTV;\
  _tvName = _ctrlTV tvtext _targetTV;\
  _tvData = toLower (_ctrlTV tvData _targetTV);\
  _tvDataString = ["Tab", "Loadout"] select (_tvData isequalto "tvloadout");

params
[
  ["_ArsenalDisplay", displaynull, [displaynull]],
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
    _ctrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
    _ctrlRenameEdit ctrladdeventhandler ["killFocus","[ctrlparent (_this select 0),'KeepFocus'] spawn VANA_fnc_UIPopup;"];
    _ctrlRenameEdit ctrladdeventhandler ["KeyDown","[ctrlparent (_this select 0),'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];
    _ctrlRenameEdit ctrladdeventhandler ["char","[ctrlparent (_this select 0),'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];

    _ctrlButtonCancel = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonCancel;
    _ctrlButtonCancel ctrladdeventhandler ["buttonclick","(ctrlParent (_this select 0) displayctrl 979000) setvariable ['TvUIPopup_Status', false]"];

    _ctrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
    _ctrlButtonOk ctrladdeventhandler ["buttonclick","(ctrlParent (_this select 0) displayctrl 979000) setvariable ['TvUIPopup_Status', true]"];

    _ctrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
    _ctrlPopupCheckBox ctrladdeventhandler ["killFocus","[ctrlparent (_this select 0),'KeepFocus'] spawn VANA_fnc_UIPopup;"];
    _ctrlPopupCheckBox ctrladdeventhandler ["CheckedChanged","if (Profilenamespace getVariable ['TEMP_Popup_Value', false]) then {Profilenamespace setvariable ['TEMP_Popup_Value', false];} else {Profilenamespace setvariable ['TEMP_Popup_Value', true];}; [ctrlparent (_this select 0),'TreeViewSelChanged'] call VANA_fnc_ArsenalTreeView;"];

    _ctrlTempCheckbox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_DelConfirmToggle; //Temp
    _ctrlTempCheckbox ctrladdeventhandler ["CheckedChanged","if (Profilenamespace getVariable ['TEMP_Popup_Value', false]) then {Profilenamespace setvariable ['TEMP_Popup_Value', false];} else {Profilenamespace setvariable ['TEMP_Popup_Value', true];};"];
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "waituntilstatus":
  {
    params ["_CtrlTemplate","_CtrlTvUIPopup","_CtrlRenameEdit","_Status"];

    _ctrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
    _ctrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
    _ctrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

    //Waituntil Confirm or cancel button was pressed
    waituntil {!isnil {_CtrlTvUIPopup getVariable "TvUIPopup_Status"}};
    _Status = (_CtrlTvUIPopup getVariable "TvUIPopup_Status");

    ShowUI(false)

    _ctrlTvUIPopup setvariable ["TvUIPopup_Status",nil];
    ctrlsetfocus _ctrlTemplate;

    _Status
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "keepfocus":
  {
    params ["_CtrlTvUIPopup","_CtrlPopupCheckBox","_CtrlRenameEdit"];

    _ctrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
    _ctrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
    _ctrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

    //Keep focus on Popup UI
    if (ctrlshown _ctrlTvUIPopup) exitwith
    {
      ctrlSetFocus ([_CtrlRenameEdit, _ctrlPopupCheckBox] select (ctrlshown _ctrlPopupCheckBox));

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

    _ctrlTV = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    TvInfo

    //Apply header and Message text
    _ctrlTitle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Title;
    _ctrlTitle ctrlsettext "Delete Confirmation";

    _ctrlTextMessage = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Text;
    _ctrlTextMessage ctrlsetstructuredtext parsetext format ["Delete %1: '%2'",_tvDataString, _tvName];

    _ctrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
    _ctrlButtonOk ctrlenable true;

    //Set checkbox state
    _ctrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
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

    _ctrlTV = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    TvInfo

    //Apply header, Message text and clear Rename field
    _ctrlTitle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Title;
    _ctrlTitle ctrlsettext "Rename Confirmation";

    _ctrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
    _ctrlRenameEdit ctrlsettext "";
    _ctrlRenameEdit ctrlsettext _tvName;

    _ctrlTextMessage = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Text;
    _ctrlTextMessage ctrlsetstructuredtext parsetext format ["Rename %1: '%2'",_tvDataString, _tvName];

    [_ArsenalDisplay,"CheckNameTaken"] call VANA_fnc_UIPopup;
    [_ArsenalDisplay,"WaituntilStatus"] call VANA_fnc_UIPopup;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "checknametaken":
  {
    params ["_ctrlTV","_CtrlRenameEdit","_CtrlButtonOk","_LoadoutData","_Name","_targetTV","_tvName","_tvData","_tvDataString","_Duplicate"];

    _ctrlTV = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _ctrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
    _ctrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
    _LoadoutData = (profilenamespace getVariable ["bis_fnc_saveInventory_Data",[]]) select {_x isequaltype ""};

    _Name = ctrltext _ctrlRenameEdit;
    TvInfo

    //Check if name duplicate and color edit field accordingly
    _Duplicate = [false, _Name in _LoadoutData] select (_tvData isequalto "tvloadout");
    _ctrlButtonOk ctrlenable ([true, false] select (_Duplicate || _Name isequalto "" || _Name isequalto _tvName));

    _Duplicate
  };
};
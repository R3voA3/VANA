//--- VANA: RscArsenalTreeView
#define IDC_RSCDISPLAYARSENAL_VANA_Mouseblock 978090
// #define IDC_RSCDISPLAYARSENAL_VANA_TitlePicture 978000
#define IDC_RSCDISPLAYARSENAL_VANA_DecorativeBar 978001
#define IDC_RSCDISPLAYARSENAL_VANA_ButtonTabCreate 978002
#define IDC_RSCDISPLAYARSENAL_VANA_ButtonRename 978003
#define IDC_RSCDISPLAYARSENAL_VANA_DelConfirmToggle 978004

//--- VANA: TvUIPopup
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup 979000
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_Title 979001
// #define IDC_RSCDISPLAYARSENALPOPUP_VANA_Picture 979002
// #define IDC_RSCDISPLAYARSENALPOPUP_VANA_BackGround 979003
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_Text 979004
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonCancel 979005
// #define IDC_RSCDISPLAYARSENALPOPUP_VANA_BackgroundButtonMiddle 979006
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK 979007
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup 979008
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_CheckboxText 979009
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_HintText 979010
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit 979011

#define SHOW_UI(BOOL)\
	private _ctrlTemplate = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;\
	_ctrlTemplate ctrlsetfade (1 - parseNumber BOOL);\
	_ctrlTemplate ctrlcommit 0;\
	_ctrlTemplate ctrlEnable BOOL;\
	private _ctrlMouseBlock = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;\
	_ctrlMouseBlock ctrlEnable BOOL;

#define SHOW_SAVE_UI_PARTS(BOOL)\
	{\
		private _ctrl = _arsenalDisplay displayCtrl _x;\
		_ctrl ctrlShow BOOL;\
		_ctrl ctrlEnable BOOL;\
	} foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TEXTNAME,IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME,IDC_RSCDISPLAYARSENAL_VANA_DecorativeBar];

#define SHOW_DELETE_UI(BOOL)\
	private _ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;\
	private _ctrlPopupCheckBox = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;\
	private _ctrlPopupCheckBoxText = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_CheckboxText;\
	private _ctrlHintText = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_HintText;\
	_ctrlRenameEdit ctrlShow !BOOL;\
	{_x ctrlShow BOOL;} foreach [_ctrlPopupCheckBox,_ctrlPopupCheckBoxText,_ctrlHintText];

#define SHOW_UI_POPUP(BOOL)\
	private _ctrlTvUIPopup = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;\
	private _ctrlVanaMouseBlock = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_Mouseblock;\
	{_x ctrlShow BOOL} foreach [_ctrlTvUIPopup,_ctrlVanaMouseBlock];

#define TV_INFO\
	private _path = tvCurSel _ctrlTV;\
	private _tvName = _ctrlTV tvtext _path;\
	private _tvData = toLower (_ctrlTV tvData _path);\
	private _tvDataString = ["Tab", "Loadout"] select (_tvData == "tvloadout");

#define EXPANDED 1
#define COLLAPSED 0

#define ACTION_NOT_IN_PROGRESS 0
#define ACTION_IN_PROGRESS 1
#define ACTION_WAITING 2
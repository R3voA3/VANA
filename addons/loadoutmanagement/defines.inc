//--- VANA: RscArsenalTreeView
#define IDC_RSCDISPLAYARSENAL_VANA_MOUSEBLOCK 978090
#define IDC_RSCDISPLAYARSENAL_VANA_DECORATIVEBAR 978001
#define IDC_RSCDISPLAYARSENAL_VANA_BUTTONTABCREATE 978002
#define IDC_RSCDISPLAYARSENAL_VANA_BUTTONRENAME 978003
#define IDC_RSCDISPLAYARSENAL_VANA_DELCONFIRMTOGGLE 978004

//--- VANA: TvUIPopup
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPOPUPCONTROLGROUP 979000
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_TITLE 979001
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_TEXT 979004
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_BUTTONCANCEL 979005
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_BUTTONOK 979007
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_TOGGLEPOPUP 979008
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_CHECKBOXTEXT 979009
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_HINTTEXT 979010
#define IDC_RSCDISPLAYARSENALPOPUP_VANA_RENAMEEDIT 979011

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
	} foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TEXTNAME, IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME, IDC_RSCDISPLAYARSENAL_VANA_DECORATIVEBAR];

#define SHOW_DELETE_UI(BOOL)\
	private _ctrlRenameEdit = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RENAMEEDIT;\
	private _ctrlPopupCheckBox = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TOGGLEPOPUP;\
	private _ctrlPopupCheckBoxText = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_CHECKBOXTEXT;\
	private _ctrlHintText = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_HINTTEXT;\
	_ctrlRenameEdit ctrlShow !BOOL;\
	{_x ctrlShow BOOL;} foreach [_ctrlPopupCheckBox, _ctrlPopupCheckBoxText, _ctrlHintText];

#define SHOW_UI_POPUP(BOOL)\
	private _ctrlTvUIPopup = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPOPUPCONTROLGROUP;\
	private _ctrlVanaMouseBlock = _arsenalDisplay displayCtrl IDC_RSCDISPLAYARSENAL_VANA_MOUSEBLOCK;\
	{_x ctrlShow BOOL} foreach [_ctrlTvUIPopup, _ctrlVanaMouseBlock];

#define TV_INFO\
	private _path = tvCurSel _ctrlTV;\
	private _tvName = _ctrlTV tvtext _path;\
	private _tvData = toLower (_ctrlTV tvData _path);\
	private _tvDataString = ["Tab", "Loadout"] select (_tvData == "tvloadout");

#define EXPANDED 1
#define COLLAPSED 0
#define QUOTE(var1) #var1
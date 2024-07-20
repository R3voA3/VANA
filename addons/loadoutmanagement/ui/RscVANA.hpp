#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\v\vana\addons\loadoutmanagement\defines.inc"

class BackgroundButtonOK;
class RscBackgroundGUI;
class RscBackgroundGUITop;
class RscButtonMenu;
class RscButtonMenuCancel;
class RscButtonMenuOK;
class RscCheckBox;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscEdit;
class RscPictureKeepAspect;
class RscStructuredText;
class RscText;
class RscTree;

class RscTitle;

class RscVANAPictureButton: RscButtonMenu
{
	type = 1;
	style = "0x02 + 0x30 + 0x800";
	colorBackground[] = {0, 0, 0, 0};
	colorBackgroundDisabled[] = {0, 0, 0, 0};
	colorBackgroundActive[] = {1, 1, 1, 0.7};
	colorFocused[] = {1, 1, 1, 0.7};
	borderSize = 0;
	colorBorder[] = {0, 0, 0, 0};
	colorShadow[] = {0, 0, 0, 0};
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = "pixelW";
	offsetPressedY = "pixelH";
};
class RscDisplayArsenal
{
	scriptName = "VANAInit";
	scriptPath = "VANAInit";
	onLoad = "['onLoad', _this, 'VANAInit', 'VANAInit'] call (uiNamespace getVariable 'BIS_fnc_initDisplay')";
	onUnload = "['onUnload', _this, 'VANAInit', 'VANAInit'] call (uiNamespace getVariable 'BIS_fnc_initDisplay')";
	class Controls
	{
		class Template: RscControlsGroup //Save & Load UI
		{
			class Controls
			{
				class ValueName: RscTree
				{
					idc = 35119;
					x = QUOTE(0.5 * GUI_GRID_CENTER_W);
					y = QUOTE(1.6 * GUI_GRID_CENTER_H);
					w = QUOTE(19 * GUI_GRID_CENTER_W);
					h = QUOTE(17.5 * GUI_GRID_CENTER_H);
					sizeEx = QUOTE(0.8 * GUI_GRID_CENTER_H);
					style = 16;
					shadow = 0;
					font = "RobotoCondensed";
					color[] = {0.95, 0.95, 0.95, 1};
					colorText[] = {1, 1, 1, 1};
					colorDisabled[] = {1, 1, 1, 0.25};
					colorPicture[] = {1, 1, 1, 1};
					colorPictureSelected[] = {1, 1, 1, 1};
					colorPictureDisabled[] = {1, 1, 1, 1};
					disableKeyboardSearch = 0;
					multiselectEnabled = 0;
					expandOnDoubleclick = 0;

					class ScrollBar: ScrollBar
					{
						color[] = {0.95, 0.95, 0.95, 1};
					};
				};
				class TextName: RscText //Relocation of vanilla UI
				{
					idc = 34621;
					style = 1;
					text = "$STR_VANA_TEXTNAME_TEXT";
					x = QUOTE(-2 * GUI_GRID_CENTER_W);
					y = QUOTE(19.6 * GUI_GRID_CENTER_H);
					w = QUOTE(5.5 * GUI_GRID_CENTER_W);
					h = QUOTE(GUI_GRID_CENTER_H);
					colorBackground[] = {0, 0, 0, 0.2};
					sizeEx = QUOTE(0.8 * GUI_GRID_CENTER_H);
				};
				class EditName: RscEdit //Relocationg of vanilla UI
				{
					idc = 35020;
					x = QUOTE(3.5 * GUI_GRID_CENTER_W);
					y = QUOTE(19.6 * GUI_GRID_CENTER_H);
					w = QUOTE(13.5 * GUI_GRID_CENTER_W);
					h = QUOTE(GUI_GRID_CENTER_H);
					sizeEx = QUOTE(0.8 * GUI_GRID_CENTER_H);
				};
				class VANA_TitlePicture: RscPictureKeepAspect
				{
					idc = 978000;
					text = "v\vana\addons\loadoutmanagement\data\logoSmall_ca.paa";
					x = QUOTE(18.2 * GUI_GRID_CENTER_W);
					y = QUOTE(0.1 * GUI_GRID_CENTER_H);
					w = QUOTE(1.6 * GUI_GRID_CENTER_W);
					h = QUOTE(0.80 * GUI_GRID_CENTER_H);
				};
				class VANA_DecorativeBar: RscBackgroundGUI
				{
					idc = IDC_RSCDISPLAYARSENAL_VANA_DECORATIVEBAR;
					show = 0;
					x = QUOTE(17 * GUI_GRID_CENTER_W);
					y = QUOTE(19.6 * GUI_GRID_CENTER_H);
					w = QUOTE(3 * GUI_GRID_CENTER_W);
					h = QUOTE(GUI_GRID_CENTER_H);
					colorBackground[] = {0, 0, 0, 0.2};
				};
				class VANA_ButtonCreate: RscVANAPictureButton
				{
					idc = IDC_RSCDISPLAYARSENAL_VANA_BUTTONTABCREATE;
					text = "a3\3den\data\displays\display3den\panelleft\entitylist_layer_ca.paa";
					tooltip = "$STR_VANA_BUTTONCREATE_TOOLTIP";
					x = QUOTE(18.5 * GUI_GRID_CENTER_W);
					y = QUOTE(19.6 * GUI_GRID_CENTER_H);
					w = QUOTE(GUI_GRID_CENTER_W);
					h = QUOTE(GUI_GRID_CENTER_H);
				};
				class VANA_ButtonRename: VANA_ButtonCreate
				{
					idc = IDC_RSCDISPLAYARSENAL_VANA_BUTTONRENAME;
					text = "a3\3den\data\displays\display3den\panelright\customcomposition_edit_ca.paa";
					tooltip = "$STR_VANA_BUTTONRENAME_TOOLTIP";
					x = QUOTE(17.3  * GUI_GRID_CENTER_W);
				};
				class VANA_DelConfirmToggle: RscCheckBox
				{
					idc = IDC_RSCDISPLAYARSENAL_VANA_DELCONFIRMTOGGLE;
					default = 0;
					tooltip = "$STR_VANA_TEMPCHECKBOX_TOOLTIP";
					x = QUOTE(5 * GUI_GRID_CENTER_W);
					y = QUOTE(21.2 * GUI_GRID_CENTER_H);
					w = QUOTE(GUI_GRID_CENTER_W);
					h = QUOTE(GUI_GRID_CENTER_H);
					colorBackground[] = {0, 0, 0, 0.8};
					colorBackgroundFocused[] ={0, 0, 0, 0.8};
					colorBackgroundHover[] ={0, 0, 0, 0.8};
					colorBackgroundPressed[] ={0, 0, 0, 0.8};
					colorBackgroundDisabled[] ={0, 0, 0, 0.8};
				};
			};
		};
		class VANA_UIPopupControlGroup: RscControlsGroupNoScrollbars
		{
			idc = IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPOPUPCONTROLGROUP;
			x = QUOTE(10.6 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = QUOTE(7 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = QUOTE(18.8 * GUI_GRID_CENTER_W);
			h = QUOTE(5.6 * GUI_GRID_CENTER_H);
			class Controls
			{
				class VANA_Title: RscTitle
				{
					idc = IDC_RSCDISPLAYARSENALPOPUP_VANA_TITLE;
					text = "$STR_VANA_TITLE_TEXT";
					x = 0;
					y = 0;
					w = QUOTE(18.8 * GUI_GRID_CENTER_W);
					h = QUOTE(GUI_GRID_CENTER_H);
					colorBackground[] =
					{
						"(profileNamespace getVariable ['GUI_BCG_RGB_R', 0.13])",
						"(profileNamespace getVariable ['GUI_BCG_RGB_G', 0.54])",
						"(profileNamespace getVariable ['GUI_BCG_RGB_B', 0.21])",
						"(profileNamespace getVariable ['GUI_BCG_RGB_A', 0.8])"
					};
				};
				class VANA_Picture: RscPictureKeepAspect
				{
					idc = 979002;
					text = "v\vana\addons\loadoutmanagement\data\logoSmall_ca.paa";
					x = QUOTE(17.0 * GUI_GRID_CENTER_W);
					y = QUOTE(0.GUI_GRID_CENTER_H);
					w = QUOTE(1.6 * GUI_GRID_CENTER_W);
					h = QUOTE(0.80 * GUI_GRID_CENTER_H);
				};
				class VANA_Background: RscBackgroundGUI
				{
					idc = 979003;
					y = QUOTE(GUI_GRID_CENTER_H);
					w = QUOTE(18.8 * GUI_GRID_CENTER_W);
					h = QUOTE(2.6 * GUI_GRID_CENTER_H);
					colorBackground[] = {0, 0, 0, 1};
				};
				class VANA_Text: RscStructuredText
				{
					idc = IDC_RSCDISPLAYARSENALPOPUP_VANA_TEXT;
					text = "$STR_VANA_TEXT_TEXT";
					y = QUOTE(1.3 * GUI_GRID_CENTER_H);
					w = QUOTE(18.8 * GUI_GRID_CENTER_W);
					h = QUOTE(2 * GUI_GRID_CENTER_H);
					sizeEx = QUOTE(0.9 * GUI_GRID_CENTER_H);
				};
				class VANA_ButtonCancel: RscButtonMenuCancel
				{
					idc = IDC_RSCDISPLAYARSENALPOPUP_VANA_BUTTONCANCEL;
					onButtonClick = "_this call VANA_fnc_hidePopup";
					y = QUOTE(3.8 * GUI_GRID_CENTER_H);
					w = QUOTE(6.2 * GUI_GRID_CENTER_W);
					h = QUOTE(GUI_GRID_CENTER_H);
				};
				class VANA_ButtonOK: VANA_ButtonCancel
				{
					idc = IDC_RSCDISPLAYARSENALPOPUP_VANA_BUTTONOK;
					text = "$STR_VANA_BUTTONOK_TEXT";
					x = QUOTE(12.6 * GUI_GRID_CENTER_W);
				};
				class VANA_TogglePopup: RscCheckBox
				{
					idc = IDC_RSCDISPLAYARSENALPOPUP_VANA_TOGGLEPOPUP;
					show = 0;
					default = 0;
					x = QUOTE(0.GUI_GRID_CENTER_W);
					y = QUOTE(2.65 * GUI_GRID_CENTER_H);
					w = QUOTE(GUI_GRID_CENTER_W);
					h = QUOTE(GUI_GRID_CENTER_H);
				};
				class VANA_CheckboxText: RscText
				{
					idc = IDC_RSCDISPLAYARSENALPOPUP_VANA_CHECKBOXTEXT;
					show = 0;
					text = "$STR_VANA_CHECKBOXTEXT_TEXT";
					x = QUOTE(0.8 * GUI_GRID_CENTER_W);
					y = QUOTE(2.66 * GUI_GRID_CENTER_H);
					w = QUOTE(3.8 * GUI_GRID_CENTER_W);
					h = QUOTE(GUI_GRID_CENTER_H);
					sizeEx = QUOTE(0.8 * GUI_GRID_CENTER_H);
				};
				class VANA_HintText: RscText
				{
					idc = IDC_RSCDISPLAYARSENALPOPUP_VANA_HINTTEXT;
					show = 0;
					style = 1;
					text = "$STR_VANA_HINTTEXT_TEXT";
					x = QUOTE(9.25 * GUI_GRID_CENTER_W);
					y = QUOTE(2.66 * GUI_GRID_CENTER_H);
					w = QUOTE(9.55 * GUI_GRID_CENTER_W);
					h = QUOTE(GUI_GRID_CENTER_H);
					sizeEx = QUOTE(0.8 * GUI_GRID_CENTER_H);
				};
				class VANA_RenameEdit: RscEdit
				{
					idc = IDC_RSCDISPLAYARSENALPOPUP_VANA_RENAMEEDIT;
					show = 0;
					x = QUOTE(0.3 * GUI_GRID_CENTER_W);
					y = QUOTE(2.45 * GUI_GRID_CENTER_H);
					w = QUOTE(18.2 * GUI_GRID_CENTER_W);
					h = QUOTE(GUI_GRID_CENTER_H);
					sizeEx = QUOTE(0.9 * GUI_GRID_CENTER_H);
				};
			};
		};
		class VANA_Mouseblock: RscBackgroundGUI
		{
			idc = IDC_RSCDISPLAYARSENAL_VANA_MOUSEBLOCK;
			show = 0;
			style = 16;
			x = QUOTE(safezoneX);
			y = QUOTE(safezoneY);
			w = QUOTE(safezoneW);
			h = QUOTE(safezoneH);
			colorBackground[] = {0, 0, 0, 0.35};
		};
	};
};
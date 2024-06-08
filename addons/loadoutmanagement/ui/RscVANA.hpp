#define BUTTON_CLICK "params ['_display'];\
					 if !(_display getVariable ['Vana_Initialised', 0]) then\
					 {\
					 	_display displayCtrl 979000 ctrlshow 0;\
					 }"

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

class RscVANAPictureButton:	RscButtonMenu
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
class RscVANATitleBar: RscBackgroundGUITop
{
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.30000001;
	style = 0;
	shadow = 0;
	colorShadow[] = {0, 0, 0, 0.5};
	sizeEx = "(GUI_GRID_CENTER_H * 1)";
	colorText[] = {0.94999999, 0.94999999, 0.94999999, 1};
	font = "PuristaMedium";
	colorBackground[] = {0, 0, 0, 0};
	linespacing = 1;
	tooltipColorText[] = {1, 1, 1, 1};
	tooltipColorBox[] = {1, 1, 1, 1};
	tooltipColorShade[] = {0, 0, 0, 0.64999998};
};
class RscDisplayArsenal //Path to add code to allready exsisting Rsc class
{
	scriptName = "VANAInit";
	scriptPath = "VANAInit";
	onLoad = "['onLoad', _this, 'VANAInit', 'VANAInit'] call (uinamespace getvariable 'BIS_fnc_initDisplay')"; // calls VANA Script instead of A3
	onUnload = "['onUnload', _this, 'VANAInit', 'VANAInit'] call (uinamespace getvariable 'BIS_fnc_initDisplay')"; // calls VANA Script instead of A3
	class controls //Path to add code to allready exsisting Rsc class
	{
		class Template: RscControlsGroup //Path to add code to allready exsisting Rsc class
		{
			class Controls //Path to add code to allready exsisting Rsc class
			{
				class ValueName: RscTree //Changing the loadout list to a treeview UI type
				{
					idc = 35119;
					x = "0.5 * GUI_GRID_CENTER_W";
					y = "1.6 * GUI_GRID_CENTER_H";
					w = "19 * GUI_GRID_CENTER_W";
					h = "17.5 * GUI_GRID_CENTER_H";
					sizeEx = "0.8 * GUI_GRID_CENTER_H";
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
				class TextName: RscText //Relocation of Vanila UI
				{
					idc = 34621;
					style = 1;
					text = "$STR_VANA_TextName_Text";
					x = "-2 * GUI_GRID_CENTER_W";
					y = "19.6 * GUI_GRID_CENTER_H";
					w = "5.5 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
					colorBackground[] = {0, 0, 0, 0.2};
					sizeEx = "0.8 * GUI_GRID_CENTER_H";
				};
				class EditName: RscEdit //Relocationg of Vanila UI
				{
					idc = 35020;
					x = "3.5 * GUI_GRID_CENTER_W";
					y = "19.6 * GUI_GRID_CENTER_H";
					w = "13.5 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
					sizeEx = "0.8 * GUI_GRID_CENTER_H";
				};
				class VANA_TitlePicture: RscPictureKeepAspect
				{
					idc = 978000;
					text = "v\vana\addons\loadoutmanagement\data\logoSmall_ca.paa";
					x = "18.2 * GUI_GRID_CENTER_W";
					y = "0.1 * GUI_GRID_CENTER_H";
					w = "1.6 * GUI_GRID_CENTER_W";
					h = "0.80 * GUI_GRID_CENTER_H";
				};
				class VANA_DecorativeBar: RscBackgroundGUI
				{
					idc = 978001;
					show = 0;
					x = "17 * GUI_GRID_CENTER_W";
					y = "19.6 * GUI_GRID_CENTER_H";
					w = "3 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
					colorBackground[] = {0, 0, 0, 0.2};
				};
				class VANA_ButtonCreate: RscVANAPictureButton
				{
					idc = 978002;
					text = "v\vana\addons\loadoutmanagement\data\buttonTabCreate.paa";
					tooltip = "$STR_VANA_ButtonCreate_ToolTip";
					x = "18.5 * GUI_GRID_CENTER_W";
					y = "19.6 * GUI_GRID_CENTER_H";
					w = "1 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
				};
				class VANA_ButtonRename: RscVANAPictureButton
				{
					idc = 978003;
					text = "v\vana\addons\loadoutmanagement\data\buttonRename.paa";
					tooltip = "$STR_VANA_ButtonRename_ToolTip";
					x = "17.3  * GUI_GRID_CENTER_W";
					y = "19.6 * GUI_GRID_CENTER_H";
					w = "1 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
				};
				class VANA_DelConfirmToggle: RscCheckBox
				{
					idc = 978004;
					default = 0;
					tooltip = "$STR_VANA_TempCheckbox_ToolTip";
					x = "5.1 * GUI_GRID_CENTER_W";
					y = "21.2 * GUI_GRID_CENTER_H";
					w = "1 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
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
			idc = 979000;
			x = "10.6 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X";
			y = "7 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y";
			w = "18.8 * GUI_GRID_CENTER_W";
			h = "5.6 * GUI_GRID_CENTER_H";
			class Controls
			{
				class VANA_Title: RscVANATitleBar
				{
					idc = 979001;
					text = "$STR_VANA_Title_Text";
					x = "0 * GUI_GRID_CENTER_W";
					y = "0 * GUI_GRID_CENTER_H";
					w = "18.8 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
					colorBackground[] =
					{
						"(profilenamespace getvariable ['GUI_BCG_RGB_R', 0.13])",
						"(profilenamespace getvariable ['GUI_BCG_RGB_G', 0.54])",
						"(profilenamespace getvariable ['GUI_BCG_RGB_B', 0.21])",
						"(profilenamespace getvariable ['GUI_BCG_RGB_A', 1.21])"
					};
				};
				class VANA_Picture: RscPictureKeepAspect
				{
					idc = 979002;
					text = "v\vana\addons\loadoutmanagement\data\logoSmall_ca.paa";
					x = "17.0 * GUI_GRID_CENTER_W";
					y = "0.1 * GUI_GRID_CENTER_H";
					w = "1.6 * GUI_GRID_CENTER_W";
					h = "0.80 * GUI_GRID_CENTER_H";
				};
				class VANA_BackGround: RscBackgroundGUI
				{
					idc = 979003;
					x = "0 * GUI_GRID_CENTER_W";
					y = "1.1 * GUI_GRID_CENTER_H";
					w = "18.8 * GUI_GRID_CENTER_W";
					h = "2.6 * GUI_GRID_CENTER_H";
					colorBackground[] = {0, 0, 0, 1.21};
				};
				class VANA_Text: RscStructuredText
				{
					idc = 979004;
					text = "$STR_VANA_Text_Text";
					x = "0 * GUI_GRID_CENTER_W";
					y = "1.3 * GUI_GRID_CENTER_H";
					w = "18.8 * GUI_GRID_CENTER_W";
					h = "2 * GUI_GRID_CENTER_H";
					sizeEx = "0.9 * GUI_GRID_CENTER_H";
				};
				class VANA_ButtonCancel: RscButtonMenuCancel
				{
					idc = 979005;
					onButtonClick = BUTTON_CLICK;
					colorBackground[] = {0, 0, 0, 1.21};
					x = "0 * GUI_GRID_CENTER_W";
					y = "3.8 * GUI_GRID_CENTER_H";
					w = "6.2 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
				};
				class VANA_BackgroundButtonMiddle: BackgroundButtonOK
				{
					idc = 979006;
					x = "6.3 * GUI_GRID_CENTER_W";
					y = "3.8 * GUI_GRID_CENTER_H";
					colorBackground[] = {0, 0, 0, 1.21};
				};
				class VANA_ButtonOK: RscButtonMenuOK
				{
					idc = 979007;
					onButtonClick = BUTTON_CLICK;
					text = "$STR_VANA_ButtonOK_Text";
					colorBackground[] = {0, 0, 0, 1.21};
					x = "12.6 * GUI_GRID_CENTER_W";
					y = "3.8 * GUI_GRID_CENTER_H";
					w = "6.2 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
				};
				class VANA_TogglePopup: RscCheckBox
				{
					idc = 979008;
					show = 0;
					default = 0;
					x = "0.1 * GUI_GRID_CENTER_W";
					y = "2.65 * GUI_GRID_CENTER_H";
					w = "1 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
					colorBackground[] = {0, 0, 0, 1.21};
				};
				class VANA_CheckboxText: RscText
				{
					idc = 979009;
					show = 0;
					text = "$STR_VANA_CheckboxText_Text";
					x = "0.8 * GUI_GRID_CENTER_W";
					y = "2.66 * GUI_GRID_CENTER_H";
					w = "3.8 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
					sizeEx = "0.8 * GUI_GRID_CENTER_H";
				};
				class VANA_HintText: RscText
				{
					idc = 979010;
					show = 0;
					style = 1;
					text = "$STR_VANA_HintText_Text";
					x = "9.25 * GUI_GRID_CENTER_W";
					y = "2.66 * GUI_GRID_CENTER_H";
					w = "9.55 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
					sizeEx = "0.8 * GUI_GRID_CENTER_H";
				};
				class VANA_RenameEdit: RscEdit
				{
					idc = 979011;
					show = 0;
					x = "0.3 * GUI_GRID_CENTER_W";
					y = "2.45 * GUI_GRID_CENTER_H";
					w = "18.2 * GUI_GRID_CENTER_W";
					h = "1 * GUI_GRID_CENTER_H";
					sizeEx = "0.9 * GUI_GRID_CENTER_H";
				};
			};
		};
		class VANA_Mouseblock: RscBackgroundGUI
		{
			idc = 978090;
			show = 0;
			style = 16;
			x = "safezoneX";
			y = "safezoneY";
			w = "safezoneW";
			h = "safezoneH";
			colorBackground[] = {0, 0, 0, 0.35};
		};
	};
};
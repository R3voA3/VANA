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
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
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
	scriptName = "fn_Vana_Init";
	scriptPath = "VANAInit";
	onLoad = "['onLoad', _this, 'fn_Vana_Init', 'VANAInit'] call (uinamespace getvariable 'BIS_fnc_initDisplay')"; // calls VANA Script instead of A3
	onUnload = "['onUnload', _this, 'fn_Vana_Init', 'VANAInit'] call (uinamespace getvariable 'BIS_fnc_initDisplay')"; // calls VANA Script instead of A3
	class controls //Path to add code to allready exsisting Rsc class
	{
		class Template: RscControlsGroup //Path to add code to allready exsisting Rsc class
		{
			class Controls //Path to add code to allready exsisting Rsc class
			{
				class ValueName: RscTree //Changing the loadout list to a treeview UI type
				{
					idc = 35119;
					x = "0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
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
					style = 1;
					idc = 34621;
					text = "$STR_VANA_TextName_Text";
					x = "-2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "5.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0, 0, 0, 0.2};
					sizeEx = "0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class EditName: RscEdit //Relocationg of Vanila UI
				{
					idc = 35020;
					x = "3.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "13.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class VANA_TitlePicture: RscPictureKeepAspect
				{
					idc = 978000;
					text = "\loadoutManagement\UI\data\Vana (Small) - WhiteText NoBackground.paa";
					x = "18.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "1.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.80 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class VANA_DecorativeBar: RscBackgroundGUI
				{
					show = 0;
					idc = 978001;
					x = "17 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "3 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0, 0, 0, 0.2};
				};
				class VANA_ButtonCreate: RscVANAPictureButton
				{
					idc = 978002;
					text = "\loadoutManagement\UI\data\ButtonTabCreate.paa";
					tooltip = "$STR_VANA_ButtonCreate_ToolTip";
					x = "18.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class VANA_ButtonRename: RscVANAPictureButton
				{
					idc = 978003;
					text = "\loadoutManagement\UI\data\ButtonRename.paa";
					tooltip = "$STR_VANA_ButtonRename_ToolTip";
					x = "17.3  * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class VANA_DelConfirmToggle: RscCheckBox
				{
					default = 0;
					idc = 978004;
					tooltip = "$STR_VANA_TempCheckbox_ToolTip";
					x = "5.1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "21.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
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
			x = "10.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
			y = "7 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "5.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class Controls
			{
				class VANA_Title: RscVANATitleBar
				{
					idc = 979001;
					text = "$STR_VANA_Title_Text";
					x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
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
					text = "\loadoutManagement\UI\data\Vana (Small) - WhiteText NoBackground.paa";
					x = "17.0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "1.6 *					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.80 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class VANA_BackGround: RscBackgroundGUI
				{
					idc = 979003;
					x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0, 0, 0, 1.21};
				};
				class VANA_Text: RscStructuredText
				{
					text = "$STR_VANA_Text_Text";
					idc = 979004;
					x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.3 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "0.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class VANA_ButtonCancel: RscButtonMenuCancel
				{
					onButtonClick = "Private _Display = ctrlparent (_this select 0); If !(_Display getvariable ['Vana_Initialised', 0]) then {_Display displayctrl 979000 ctrlshow 0;}";
					idc = 979005;
					colorBackground[] = {0, 0, 0, 1.21};
					x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "3.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "6.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class VANA_BackgroundButtonMiddle: BackgroundButtonOK
				{
					idc = 979006;
					x = "6.3 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "3.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0, 0, 0, 1.21};
				};
				class VANA_ButtonOK: RscButtonMenuOK
				{
					onButtonClick = "Private _Display = ctrlparent (_this select 0); If !(_Display getvariable ['Vana_Initialised', 0]) then {_Display displayctrl 979000 ctrlshow 0;}";
					text = "$STR_VANA_ButtonOK_Text";
					idc = 979007;
					colorBackground[] = {0, 0, 0, 1.21};
					x = "12.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "3.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "6.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class VANA_TogglePopup: RscCheckBox
				{
					show = 0;
					default = 0;
					idc = 979008;
					x = "0.1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "2.65 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0, 0, 0, 1.21};
				};
				class VANA_CheckboxText: RscText
				{
					show = 0;
					idc = 979009;
					text = "$STR_VANA_CheckboxText_Text";
					x = "0.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "2.66 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "3.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class VANA_HintText: RscText
				{
					show = 0;
					idc = 979010;
					style = 1;
					text = "$STR_VANA_HintText_Text";
					x = "9.25 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "2.66 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "9.55 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class VANA_RenameEdit: RscEdit
				{
					show = 0;
					idc = 979011;
					x = "0.3 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "2.45 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "18.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "0.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
			};
		};
		class VANA_Mouseblock: RscBackgroundGUI
		{
			show = 0;
			idc = 978090;
			style = 16;
			x = "safezoneX";
			y = "safezoneY";
			w = "safezoneW";
			h = "safezoneH";
			colorBackground[] = {0, 0, 0, 0.35};
		};
	};
};
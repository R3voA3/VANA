params ["_display"];

if !(_display getVariable ['Vana_Initialised', true]) then
{
	_display displayCtrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPOPUPCONTROLGROUP ctrlShow 0;
};
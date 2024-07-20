#include "\v\vana\addons\loadoutmanagement\defines.inc"

params [["_control", controlNull], ["_newText", ""]];

if (ctrlType _control == 1) then //Button, reset search
{
  ctrlParent _control displayCtrl IDC_RSCDISPLAYARSENAL_VANA_EDIT_SEARCH ctrlSetText "";
  _control ctrlSetText "a3\3den\data\displays\display3den\search_start_ca.paa";
};

if (ctrlType _control == 2) then //Edit, update button
{
  if (_newText == "") then
  {
    ctrlParent _control displayCtrl IDC_RSCDISPLAYARSENAL_VANA_BUTTON_SEARCH ctrlSetText "a3\3den\data\displays\display3den\search_start_ca.paa";
  }
  else
  {
    ctrlParent _control displayCtrl IDC_RSCDISPLAYARSENAL_VANA_BUTTON_SEARCH ctrlSetText "a3\3den\data\displays\display3den\search_end_ca.paa";
  };
};
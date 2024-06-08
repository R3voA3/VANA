class VANA
{
  tag="VANA";

  class Altered_BIS_Fnc
  {
    file="loadoutManagement\Functions";

    class Arsenal {};
    class Vana_Init {};
  };

  class TreeView
  {
    file="loadoutManagement\Functions\TreeView";

    class ArsenalTreeView {};

    //Buttons
    class TvCreateTab         {file="loadoutManagement\Functions\TreeView\Button\fn_TvCreateTab.sqf";};
    class TvDelete            {file="loadoutManagement\Functions\TreeView\Button\fn_TvDelete.sqf";};
    class TvRename            {file="loadoutManagement\Functions\TreeView\Button\fn_TvRename.sqf";};

    //Core
    class TvCreateLoadout     {file="loadoutManagement\Functions\TreeView\Core\fn_TvCreateLoadout.sqf";};
    class TvDragDrop          {file="loadoutManagement\Functions\TreeView\Core\fn_TvDragDrop.sqf";};
    class TvLoadData          {file="loadoutManagement\Functions\TreeView\Core\fn_TvLoadData.sqf";};
    class TvSaveData          {file="loadoutManagement\Functions\TreeView\Core\fn_TvSaveData.sqf";};
    class TvSaveLoadout       {file="loadoutManagement\Functions\TreeView\Core\fn_TvSaveLoadout.sqf";};
    class TvValidateLoadouts  {file="loadoutManagement\Functions\TreeView\Core\fn_TvValidateLoadouts.sqf";};

    //Utility
    class TvCount             {file="loadoutManagement\Functions\TreeView\Utility\fn_TvCount.sqf";};
    class TvExists            {file="loadoutManagement\Functions\TreeView\Utility\fn_TvExists.sqf";};
    class TvGetData           {file="loadoutManagement\Functions\TreeView\Utility\fn_TvGetData.sqf";};
    class TvGetParent         {file="loadoutManagement\Functions\TreeView\Utility\fn_TvGetParent.sqf";};
    class TvGetPosition       {file="loadoutManagement\Functions\TreeView\Utility\fn_TvGetPosition.sqf";};
    class TvSorting           {file="loadoutManagement\Functions\TreeView\Utility\fn_TvSorting.sqf";};
    class TvValidateLoadout   {file="loadoutManagement\Functions\TreeView\Utility\fn_TvValidateLoadout.sqf";};
  };

  class UIPopup
  {
    file="loadoutManagement\Functions\UIPopup";

    class UIPopup {};
  };
};
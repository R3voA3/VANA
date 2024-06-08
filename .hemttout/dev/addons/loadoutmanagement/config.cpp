class CfgPatches
{
	class VANA
	{
		name = "VANA - Loadout Management";
		author = "Eathox, modified by R3vo";
		requiredVersion = 2.16;
		requiredAddons[] = {"A3_UI_F", "A3_Functions_F"};
	};
};

class CfgScriptPaths
{
	VANAInit="v\vana\loadoutmanagement\scripts\";
};

#include "cfgFunctions.hpp"
#include "ui\RscVANA.hpp"
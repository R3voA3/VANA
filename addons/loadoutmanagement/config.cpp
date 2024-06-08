class CfgPatches
{
	class VANA
	{
		name = "Vana - Loadout Management";
		author = "Eathox";
		requiredVersion = 2.16;
		units[] = {};
		requiredAddons[] =
		{
			"A3_UI_F",
			"A3_Functions_F"
		};
	};
};

class CfgScriptPaths
{
	VANAInit="\loadoutManagement\functions\";
};

class CfgFunctions
{
	#include "functions\functions.hpp"
};

#include "ui\RscVANA.hpp"
disableserialization;

#define EndSegment(BOOL)\
	[_ctrlTV, ([_ctrlTV, [[], "TvLoadout"]] call VANA_fnc_tvGetData)] call VANA_fnc_tvValidateLoadouts;\
	diag_log text "[VANA_fnc_tvLoadData]: Data loaded.";\
	BOOL

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_vANAData", (profileNamespace getVariable ["VANA_fnc_treeViewSave_Data",[]]), [[]]],
	//Form wich data is saved in is [["Name",[Position],"DataType",Value],["Name",[Position],"DataType",Value],["Name",[Position],"DataType",Value]] ect.
	"_loadoutData",
	"_loadoutNames"
];

_vANAData = +_vANAData;
_loadoutData = profileNamespace getVariable ["BIS_fnc_saveInventory_Data",[]];
_loadoutNames = [];

diag_log text "[VANA_fnc_tvLoadData]: Loading Data...";

//Create all loadouts if there is no saved data
if (_vANAData isEqualTo []) exitwith
{
	{
		[_ctrlTV, [[], _x], "FirstTimeSetup"] call VANA_fnc_tvCreateLoadout;
	} foreach (_loadoutData select {_x isEqualType ""});

	EndSegment(false)
};

//Send data to co responding create fucntions
{
	params ["_tvName","_tvPosition","_tvData"];

	_tvName = _x select 0;
	_tvPosition = +_x select 1;
	_tvData = toLower (_x select 2);

	_tvPosition resize (count _tvPosition-1);

	call
	{
		if (_tvData isEqualTo "tvtab") exitwith {[_ctrlTV, [_tvPosition, _tvName], "FirstTimeSetup"] call VANA_fnc_tvCreateTab;};
		if (_tvData isEqualTo "tvloadout") exitwith
		{
			_loadoutNames pushBack _tvName;
			[_ctrlTV, [_tvPosition, _tvName], "FirstTimeSetup"] call VANA_fnc_tvCreateLoadout;
		};
	};
} foreach _vANAData;

//Create loadouts that werent created
{
	[_ctrlTV, [[], _x]] call VANA_fnc_tvCreateLoadout;
} foreach (_loadoutData select {_x isEqualType "" && !(_x in _loadoutNames)});

EndSegment(true)
disableserialization;

#define EndSegment(BOOL)\
	[_ctrlTV, ([_ctrlTV, [[], "TvLoadout"]] call VANA_fnc_tvGetData)] call VANA_fnc_tvValidateLoadouts;\
	diag_log text "[VANA_fnc_tvLoadData]: Data loaded.";\
	BOOL

params
[
	["_ctrlTV", controlnull, [controlnull]],
	["_VANAData", (profilenamespace getVariable ["VANA_fnc_treeViewSave_Data",[]]), [[]]],
	//Form wich data is saved in is [["Name",[Position],"DataType",Value],["Name",[Position],"DataType",Value],["Name",[Position],"DataType",Value]] ect.
	"_LoadoutData",
	"_LoadoutNames"
];

_vANAData = +_VANAData;
_loadoutData = profilenamespace getVariable ["bis_fnc_saveInventory_Data",[]];
_loadoutNames = [];

diag_log text "[VANA_fnc_tvLoadData]: Loading Data...";

//Create all loadouts if there is no saved data
if (_VANAData isequalto []) exitwith
{
	{
		[_ctrlTV, [[], _x], "FirstTimeSetup"] call VANA_fnc_tvCreateLoadout;
	} foreach (_LoadoutData select {_x isequaltype ""});

	EndSegment(false)
};

//Send data to co responding create fucntions
{
	params ["_tvName","_TvPosition","_tvData"];

	_tvName = _x select 0;
	_TvPosition = +_x select 1;
	_tvData = toLower (_x select 2);

	_TvPosition resize (count _TvPosition-1);

	call
	{
		if (_tvData isequalto "tvtab") exitwith {[_ctrlTV, [_TvPosition, _tvName], "FirstTimeSetup"] call VANA_fnc_tvCreateTab;};
		if (_tvData isequalto "tvloadout") exitwith
		{
			_LoadoutNames pushBack _tvName;
			[_ctrlTV, [_TvPosition, _tvName], "FirstTimeSetup"] call VANA_fnc_tvCreateLoadout;
		};
	};
} foreach _VANAData;

//Create loadouts that werent created
{
	[_ctrlTV, [[], _x]] call VANA_fnc_tvCreateLoadout;
} foreach (_LoadoutData select {_x isequaltype "" && !(_x in _LoadoutNames)});

EndSegment(true)
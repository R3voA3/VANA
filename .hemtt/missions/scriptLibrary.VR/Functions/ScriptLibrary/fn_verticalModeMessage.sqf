[
	"Vertical mode defines how the composition will be placed.<br /><t font='RobotoCondensedBold'>Terrain Level</t> - composition will be snapped to the surface underneath. Please note that objects which are placed on another object may no longer be positioned precisely.<br /><t font='RobotoCondensedBold'>Sea Level</t> - the composition will be placed exactly as it was saved, ignoring the surface slope.",
	"Vertial Mode",
	[
		"Terrain Level",
		{BIS_Message_Confirmed = true}
	],
	[
		"Sea Level",
		{BIS_Message_Confirmed = false}
	],
	"\a3\3den\data\displays\display3den\toolbar\vert_asl_ca.paa",
	findDisplay 313
] call BIS_fnc_3DENShowMessage;// A confirm windows
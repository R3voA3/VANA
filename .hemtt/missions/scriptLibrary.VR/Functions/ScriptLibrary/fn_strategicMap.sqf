/*
	Author: Revo

	Description:
	Creates a Strategic Map 
	Call via addAction like this:
	_unit addAction ["Strategic Map","openStrategicMap.sqf",[_viewPos,_viewNight,_overcast]];

	Parameter(s):
		0: _target -> addAction's owner
		1: _caller -> addAction's caller
		2: _action -> addAction's id
		3: ARRAY - default view position in format [x,y,y] or [x,y]
		4: BOOL - true for night version of strategic map (darker with blue tone)
		5: NUMBER - value in range <0-1> defining weather on strategic map (i.e. density of clouds). If not defined, 0 is used.
		
	Returns:
	-
*/

_target = param [0,objNull];
_caller = param [1,player];
_action = param [2,0];

_viewPos = (_this select 3) param [0,[0,0,0]];
_viewNight = (_this select 3) param [1,false]; 
_overcast = (_this select 3) param [2,0]; 


/*Mission examples 
0: ARRAY - mission position in format [x,y,y] or [x,y]
1: CODE - expression executed when user clicks on mission icon
2: STRING - mission name
3: STRING - short description
4: STRING - name of mission's player
5: STRING - path to overview image
6: NUMBER - size multiplier, 1 means default size
7: ARRAY - parameters for the -on click- code; referenced from the script as (_this select 9)
*/
_m1  = [[1894,5741,0],{player setPos param [0,[0,0,0]];},"Airfield","Move to Airfield","player","images\exampleImage.jpg",1,[]];
_m2  = [[2458,5660,0],{player setPos param [0,[0,0,0]];},"FOB","Move to FOB","player","",1,[]];
_m3  = [[6472,5367,0],{player setPos param [0,[0,0,0]];},"Kamino Firing Range","Move to Kamino","player","",1,[]];
_m4  = [[2982,1876,0],{player setPos param [0,[0,0,0]];},"LZ Connor","Move to LZ Connor","player","",1,[]];;
_m5  = [[3291,2928,0],{player setPos param [0,[0,0,0]];},"Camp Maxwell","Move to Camp Maxwell","player","",1,[]];
_m6  = [[4331,3852,0],{player setPos param [0,[0,0,0]];},"Air Station Mike-26","Move to Air Station Mike-26","player","",1,[]];
_m7  = [[5023,5905,0],{player setPos param [0,[0,0,0]];},"Camp Rogain","Move to Camp Rogain","player","",1,[]];
_m8  = [[2026,3554,0],{player setPos param [0,[0,0,0]];},"Camp Tempest","Move to Camp Tempest","player","",1,[]];
_m9  = [[4488,6786,0],{player setPos param [0,[0,0,0]];},"Kill Farm","Move to Kill Farm","player","",1,[]];
_m10 = [[2623,611,0 ],{player setPos param [0,[0,0,0]];},"The Spartan","Move to The Spartan","player","",1,[]];


/*Marker examples
ARRAY - list of markers revealed in strategic map (will be hidden when map is closed)
*/
_marker1 = "";
_marker2 = "";
_marker3 = "";

/*ORBAT examples
0: ARRAY - group position in format [x,y,y] or [x,y]
1: CONFIG - preview CfgORBAT group
2: CONFIG - topmost displayed CfgORBAT group
3: ARRAY - list of allowed tags
4: NUMBER - maximum number of displayed tiers
*/
_orbat1 = [[2500,600 ],configFile >> "CfgORBAT" >> "BIS" >> "B_1_B_3_3",configFile >> "CfgORBAT" >> "BIS" >> "B_1_B_3_4",["BLUFOR", "USArmy","Kerry"],5];
_orbat2 = [[4000,1000],configFile >> "CfgORBAT" >> "BIS" >> "B_1_B_3_3",configFile >> "CfgORBAT" >> "BIS" >> "B_1_B_3_4",["BLUFOR", "USArmy","Kerry"],5];
_orbat3 = [[1500,4000],configFile >> "CfgORBAT" >> "BIS" >> "B_1_B_3_3",configFile >> "CfgORBAT" >> "BIS" >> "B_1_B_3_4",["BLUFOR", "USArmy","Kerry"],5];

/*Image examples
0: STRING - texture path
1: ARRAY - colour in format [R,G,B,A]
2: ARRAY - image position
3: NUMBER - image width (in metres)
4: NUMBER - image height (in metres)
5: NUMBER - image angle (in degrees)
6: STRING - text displayed next to the image
7: BOOL - true to display shadow
*/
_image1 = ["images\exampleImage.jpg",[1,1,1,1],[50,50,0],7,5,0,"Example Image",true];
_image2 = [];
_image3 = [];

//Function call with above set parameter
[nil,_viewPos,[_m1,_m2,_m3,_m4,_m5,_m6,_m7,_m8,_m9,_m10],[_orbat1,_orbat2,_orbat3],[_marker1,_marker2,_marker3],[_image1,_image2,_image3],_overcast,_viewNight] call BIS_fnc_strategicMapOpen;


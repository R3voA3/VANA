/*
   Author: R3vo

   Date: 2019-08-07

   Description:
   Quick and dirty way of revealing all units on the map.

   Parameter(s):
   -

   Returns:
   BOOLEAN: true
*/

[] spawn 
{
    while {true} do 
    {
        sleep 0.1;
        {
            deleteMarker _x
        } forEach allMapMarkers;

        {  
            _marker = createMarker [str random 5000000,position _x];  
            _marker setMarkerType "hd_flag";                     
            _marker setMarkerColor "ColorGreen"; 
            _marker setMarkerText name _x;  
        } forEach allUnits;
    };
};

true
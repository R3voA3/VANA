/*
   Author: R3vo

   Date: 2019-08-22

   Description:
   Rotates the given object.

   Parameter(s):
   0: OBJECT - Object to rotate
   1: NUMBER - Step in degrees the object will be rotated on every iteration

   Returns:
   BOOLEAN: true
*/

params ["_vehicle","_stepDeg"];

["R3vo_CarShow", "onEachFrame",  
{ 
 params ["_vehicle","_stepDeg"];
 private _dir = getDir _vehicle + _stepDeg; 
 _vehicle setDir _dir; 
}, [_vehicle,_stepDeg]] call BIS_fnc_addStackedEventHandler;

true
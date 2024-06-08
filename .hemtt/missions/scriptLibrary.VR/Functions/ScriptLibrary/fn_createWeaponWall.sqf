/*
   Author: R3vo

   Date: 2020-03-18

   Description:
   Creates walls with all weapons.

   Parameter(s):
   -

   Returns:
   BOOLEAN: true
*/

private _allWeapons = 
  "'Weapon_arifle' in configName _x        ||
  {'Weapon_SMG' in configName _x          ||
  {'Weapon_sgun' in configName _x         ||
  {'Weapon_mmg' in configName _x          ||
  {'Weapon_launch' in configName _x       ||
  {'Weapon_h_gun' in configName _x}}}}}"
 configClasses (configFile >> 'CfgVehicles');

_allWeapons = _allWeapons apply {configName _x};
_allWeapons sort true;

private _wallClass = "Land_Shoot_House_Wall_F";
private _fitOnWall = 6;
private _step = 1;
private _stepWall = -0.9;
private _wall = objNull;

collect3DENHistory
{
  {
    if (_forEachIndex == 0 || {_forEachIndex mod _fitOnWall == 0}) then
    {
      _wall = create3DENEntity ["Object",_wallClass,player modelToWorld [_step,0,0.02]];
      _step = _step + 2;
      _stepWall = -0.9;
    };
    _weapon = create3DENEntity ["Object",_x,_wall modelToWorld [0,-0.12,_stepWall]];
    _weapon set3DENAttribute ["rotation",[270,0,0]];
    _stepWall = _stepWall + 0.5;
  } forEach _allWeapons;
};

true
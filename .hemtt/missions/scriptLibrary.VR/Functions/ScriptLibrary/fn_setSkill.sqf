/*
  Author: R3vo

  Description:
  Sets skill of all units of given side.

  Parameter(s):
  0: ARRAY - Skill range in format [min, avg, max]
  1: SIDE - Affected side

  Returns:
  -
*/

params [["_skillRange", [0.1, 0.5, 1]], ["_side", east]];

units _side apply
{
  private _rndSkill = random _skillRange;
  //_x setSkill ["Endurance", _rndSkill]; Not in Arma 3
  _x setSkill ["aimingShake", _rndSkill];
  _x setSkill ["aimingAccuracy", _rndSkill];
  _x setSkill ["aimingSpeed", _rndSkill];
  _x setSkill ["spotDistance", _rndSkill];
  _x setSkill ["spotTime", _rndSkill];
  _x setSkill ["courage", _rndSkill];
  _x setSkill ["reloadSpeed", _rndSkill];
  _x setSkill ["commanding", _rndSkill];
  _x setSkill ["general", _rndSkill];
};
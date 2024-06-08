/*
	Author: Revo

	Description:
	Removes Night Vision Goggles and/or adds gunlights to the units of the defined side

	Parameter(s):
		0: side - Which side shall not have NVGs?
		1: boolean - Should gunlights be added?

	Returns:
	-
*/
_side = param [0,east];
_gunLights = param [1,true];

{
	if (side _x == _side) then
	{
		_x unlinkItem (hmd _x);
		if (_gunLights) then
		{
			_x addPrimaryWeaponItem "acc_flashLight";
			_x enableGunLights "forceOn";
		};
	};
} forEach allUnits;
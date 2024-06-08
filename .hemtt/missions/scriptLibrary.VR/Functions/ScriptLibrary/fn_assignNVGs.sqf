/*
	Author: davidoss , rewritten by Revo

	Description:
	Assigns or removes night vision goggles depending on the time of day if they match the classnames from _nvgs 

	Parameter(s):
	-
	Returns:
	-
*/


_nvgs = ['rhsusf_ANPVS_14','rhsusf_ANPVS_15','ACE_NVG_Gen1','ACE_NVG_Gen2','NVGoggles','ACE_NVG_Gen4','ACE_NVG_Wide'];
while{true} do
{
	if ((dayTime > 20) || (dayTime >=0 && dayTime <= 4)) then
	{
		{
			_itemsPlayer = items _x;
			_commonItemsArray = _nvgs arrayIntersect _itemsPlayer;
			_nvg = _commonItemsArray select 0;
			if(!isNil "_nvg") then
			{
				_x assignItem _nvg;
			};
		} forEach allPlayers;	
	}
	else
	{
		{
			_itemsPlayer = assignedItems _x;
			_commonItemsArray = _nvgs arrayIntersect _itemsPlayer;
			_nvg = _commonItemsArray select 0;
			if(!isNil "_nvg") then
			{
				_x unassignItem _nvg;
			};
		} forEach allPlayers;	
	};
	sleep 3600;
};
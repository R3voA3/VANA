/*
   Author: Revo

   Description:
   Copies all function names to the clipboard in Biki format. Used to quickly check which functions are missing on the Biki. Ignores mod functions.

   Parameter(s):
   -

   Returns:
   STRING: Formatted list of functions
*/
private _classes= "true" configClasses (configFile >> "CfgFunctions");
private _export= [];
private _version = [format ["Last updated: {{GVI|arma3|%1}}",(productVersion # 2) / 100]];
{
	private _tag = getText (_x >> "tag");

	//Check if tag is a default one, that way this function can even run when mods are loaded
	if (_tag in ["BIN","BIS"]) then
	{
		{
			_export pushBack (format ["*[[%1_fnc_%2]]",_tag,configName _x]);
		} forEach ([ _x,1,false] call BIS_fnc_returnChildren);
	};
} forEach _classes;
//Add version after array was sorted so it stays on top. _version now has the full list.
_export sort true;
_version append _export;
copyToClipboard (_version joinString endl);
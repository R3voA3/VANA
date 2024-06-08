private _classes = "isClass _x" configClasses (configFile >> "CfgUnitInsignia");
private _export = "{|class=""wikitable"" style=""text-align: center;"" cellpadding=""0.25em""
! Image
! Code
! Name
! Introduced with";

{
	private _className = configName _x;
	private _displayName = getText (_x >> "displayName");
	private _dlc = configSourceMod (configFile >> "CfgUnitInsignia" >> _className);
	_export = _export + endl + "|-" + 
	endl + "| " + format ["[[File:%1 ca.png|75px]]",_className] + 
	endl + "| " + format ["<code><noWiki>[</noWiki>[[this]],""%1""] [[call]] [[BIS_fnc_setUnitInsignia]];</code>",_className] + 
	endl + "| " + _displayName +
	endl + "| "  + format ["{{Icon|arma3|%1}}",_dlc];
} forEach _classes;

_export = _export + endl + "|}";

copyToClipboard _export;
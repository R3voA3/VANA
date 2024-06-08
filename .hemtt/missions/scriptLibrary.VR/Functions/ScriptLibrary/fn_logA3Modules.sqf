private _modules = "(configName inheritsFrom _x) == 'Module_F'" configClasses (configFile >> "CfgVehicles");
private _export = "{| class='wikitable sortable' |-
!Module Name !!Category !!Addon
|-" + endl;

{
	private _name = getText (_x >> "displayName");
	private _cat = getText (_x >> "category");
	private _mod = configSourceMod _x;
	if (_mod == "") then {_mod = "A3"};
	private _modName = modParams [_mod,["name"]];
	_modName = _modName select 0;
	_cat = getText (configFile >> "CfgFactionClasses" >> _cat >> "displayName");
	if (_cat isEqualto "") then {_cat = "Undefined"};

	_export = _export + "|" + _name + endl + "||" + _cat + endl + "||" + _modName + endl + "|-" + endl;

} forEach _modules;

_export = _export + "|}";

copyToClipboard _export;
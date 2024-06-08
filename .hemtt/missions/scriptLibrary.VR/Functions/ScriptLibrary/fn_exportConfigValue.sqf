private _classes = "true" configClasses (configFile >> "Display3DEN" >> "ContextMenu" >> "Items");
private _conditions = [];
private _export = "";
private _lb = toString [0x0D, 0x0A];
{
	private _name = configName _x;
	private _text = getText (configFile >> "Display3DEN" >> "ContextMenu" >> "Items" >> _name >> "ConditionShow");
	_conditions pushBackUnique _text;
} forEach _classes;
{
	_export = _export + _x + _lb;
	systemChat _export;
} forEach _conditions;

copyToClipboard _export;
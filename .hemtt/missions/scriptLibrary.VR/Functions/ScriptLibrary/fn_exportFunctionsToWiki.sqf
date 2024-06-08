/*
	Author: Karel Moricky, updated by R3vo (11.10.2020)

	Description:
	Export function descriptions to Community Wiki.
	Exported text will be copied to clipboard.

	Parameter(s):
		0: ARRAY - functions filter in format [<tags>,<categories>,<functions>]
			tags: STRING or ARRAY of STRINGs - CfgFunctions tags (e.g., "BIS"). Use empty string for all of them.
			categories: STRING or ARRAY of STRINGs - categories (e.g., "Debug"). Use empty string for all of them.
			functions: STRING or ARRAY of STRINGs - specific function names (e.g., "BIS_fnc_log"). Use empty string for all of them.
		1: STRING or NUMBER - Game Version, default will be the current one.

	Returns:
	NOTHING

	Example:
	Export all functions:		[] spawn Revo_fnc_exportFunctionsToWiki;
	Export all Array functions:	[["","Arrays"]] spawn Revo_fnc_exportFunctionsToWiki;
	Export specific functions:	[["","",["BIS_fnc_log","BIS_fnc_param"]]] spawn Revo_fnc_exportFunctionsToWiki;
*/

#define PROJECTS ["arma2","arma2oa","tkoh","arma3"]

startloadingscreen [""];

toFixed 2;

private _path = _this param [0,[],[[]]];
private _gameVersion = _this param [2,productVersion # 2 / 100,[0,""]];
private _pathTags = _path param [0,[],[[],""]];
private _pathCategories = _path param [1,[],[[],""]];
private _pathFunctions = _path param [2,[],[[],""]];
private _text = "";
private _indent = 1;

if (_pathTags isEqualType "") then {_pathTags = [_pathTags]};
if (_pathCategories isEqualType "") then {_pathCategories = [_pathCategories]};
if (_pathFunctions isEqualType "") then {_pathFunctions = [_pathFunctions]};

_allTags = {_x != ""} count _pathTags == 0;
_allCategories = {_x != ""} count _pathCategories == 0;
_allFunctions = {_x != ""} count _pathFunctions == 0;

private _fnc_addLine =
{
	for "_t" from 1 to _indent do {_text = _text + "	";};
	_text = _text + _this + endl;
};

private _functionsList = call (uiNamespace getVariable ["BIS_functions_list",{[]}]);
private _functionsListCount = count _functionsList;

{
	_function = _x;
	_meta = _x call BIS_fnc_functionMeta;
	_metaPath = _meta # 0;
	_metaFormat = _meta # 1;
	_metaTag = _meta # 6;
	_metaCategory = _meta # 7;
	_metaName = _meta # 8;

	if (
		(_allTags || {{_metaTag == _x} count _pathTags > 0})
		/* &&
		{_allCategories || {{_metaCategory == _x} count _pathCategories > 0}}
		&&
		{_allFunctions || {{_function == _x} count _pathFunctions > 0}} */
		)
	then
	{
		//Header
		_file = loadFile _metaPath;
		copyToClipboard _file;
		_headerStart = _file find "/*";
		_headerEnd = _file find "*/";
		_headerLength = _headerEnd - _headerStart;
		_fileHeader = _file select [_headerStart,_headerLength + 2];
		_description = if (_fileHeader == "" || _metaFormat != ".sqf") then
	{
		"''N/A''"
	} else
	{
		format ["<pre>%1</pre>{{Informative|Placeholder description extracted from the function header by [[BIS_fnc_exportFunctionsToWiki]]}}",_fileHeader]
	};

		_project = getText (configFile >> "cfgfunctions" >> _metaTag >> "project");
		if (_project == "") then {_project = toLower (productVersion # 1)};

		_indent = 0;

		//Function template
		"{{Function" call _fnc_addLine;
		"" call _fnc_addLine;

		format ["|game1= %1",_project] call _fnc_addLine;
		"" call _fnc_addLine;
		format ["|version1= %1",_gameVersion] call _fnc_addLine;
		"" call _fnc_addLine;

		"<!---|arg= local--->" call _fnc_addLine;
		"" call _fnc_addLine;
		"<!---|eff= local--->" call _fnc_addLine;
		"" call _fnc_addLine;
		"<!---|serverExec= server--->" call _fnc_addLine;
		"" call _fnc_addLine;

		"<!---|exec= spawn--->" call _fnc_addLine;
		"" call _fnc_addLine;

		"<!---|gr1= GROUP1--->" call _fnc_addLine;
		"" call _fnc_addLine;

		format ["|descr= %1",_description] call _fnc_addLine;
		"" call _fnc_addLine;

		"<!---|mp= --->" call _fnc_addLine;
		"" call _fnc_addLine;

		"<!---|pr= --->" call _fnc_addLine;
		"" call _fnc_addLine;

		format ["|s1= [] call [[%1]]",_function] call _fnc_addLine;
		"" call _fnc_addLine;

		"|p1= parameter: [[Datatype]] - (Optional, default defValue) description" call _fnc_addLine;
		"" call _fnc_addLine;

		"|r1= [[Datatype]] - description" call _fnc_addLine;
		"" call _fnc_addLine;

		"|x1= <code></code>" call _fnc_addLine;
		"" call _fnc_addLine;

		"|seealso= " call _fnc_addLine;
		"}}" call _fnc_addLine;
		"" call _fnc_addLine;

		//Categories
		format ["[[Category:Functions|{{uc:%1}}]]",_metaName] call _fnc_addLine;
		private _compatible = false;
		{
			if (_x == _project) then {_compatible = true;};
			if (_compatible) then
			{
				format ["[[Category:{{Name|%2}}: Functions|{{uc:%1}}]]",_metaName,_x] call _fnc_addLine;
			};
		} foreach PROJECTS;
	};
	progressloadingscreen (_foreachindex / _functionsListCount);
} forEach _functionsList;

copyToClipboard _text;

endloadingscreen;
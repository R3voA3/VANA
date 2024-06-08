/*
  Author: R3vo

  Date: 2021-03-28

  Description:
  Collects all commands and formats them for https://github.com/highlightjs/highlight.js/blob/main/src/languages/sqf.js.
  Formatted text is copied to the clipboard

  Parameter(s):
  -

  Returns:
  -
*/

private _allCommands = [];
supportInfo "" apply
{
  _x splitString ":" params ["_t", "_x"];
  if (_t != "t") then
  {
    _x = _x splitString " ";
    _command = switch count _x do
    {
      case 1;
      case 2: { _x # 0 };
      case 3: { _x # 1 };
      default {nil};
    };
    _allCommands pushBackUnique _command;
  };
};

_allCommands = _allCommands apply { (supportInfo format ["i:%1", _x]) select 0 select 2 };

private _keyWords =
[
  "case",
  "catch",
  "default",
  "do",
  "else",
  "exit",
  "exitWith",
  "for",
  "forEach",
  "from",
  "if",
  "private",
  "switch",
  "then",
  "throw",
  "to",
  "try",
  "waitUntil",
  "while",
  "with"
];

private _literals =
[
  "blufor",
  "civilian",
  "configNull",
  "controlNull",
  "displayNull",
  "east",
  "endl",
  "false",
  "grpNull",
  "independent",
  "lineBreak",
  "locationNull",
  "nil",
  "objNull",
  "opfor",
  "pi",
  "resistance",
  "scriptNull",
  "sideAmbientLife",
  "sideEmpty",
  "sideLogic",
  "sideUnknown",
  "taskNull",
  "teamMemberNull",
  "true",
  "west"
];

private _operators =
[
  "!",
  "!=",
  "#",
  "%",
  "&&",
  "*",
  "+",
  "-",
  "/",
  "<",
  "<=",
  "==",
  ">",
  ">=",
  ">>",
  "^",
  "||"
];

_allCommands = _allCommands - _keyWords - _literals - _operators;
_allCommands sort true;

private _export ="";

//KEYWORDS
_export = "  const KEYWORDS = [";

{
  _export = _export + endl + "    " + "'" + _x + "'" + ",";
} forEach _keyWords;

_export = (_export trim [",", 2]) + endl + "  ];";

//LITERALS
_export = _export + endl + endl + "  const LITERAL = [";
{
  _export = _export + endl + "    " + "'" + _x + "'" + ",";
} forEach _literals;

_export = (_export trim [",", 2]) + endl + "  ];";

//BUILD_IN
_export = _export + endl + endl + "  const BUILT_IN = [";
{
  _export = _export + endl + "    " + "'" + _x + "'" + ",";
} forEach _allCommands;

_export = (_export trim [",", 2]) + endl + "  ];";

if (is3DEN) then {["Data copied!"] call BIS_fnc_3DENNotification} else {systemChat "Data copied"};
copyToClipboard _export;
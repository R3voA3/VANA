_bitFlag = findDisplay 313 displayCtrl 120 menuShortcut [0, 1];
_bitFlagArray = _bitFlag call BIS_fnc_bitflagsToArray;

if (_bitFlagArray isEqualTo []) exitWith {""};

_shortCutStr = "";
_rest = 0;

if (512 in _bitFlagArray) then {_shortCutStr = _shortCutStr + "CTRL + "};
if (1024 in _bitFlagArray) then {_shortCutStr = _shortCutStr + "LSHIFT + "};
if (2048 in _bitFlagArray) then {_shortCutStr = _shortCutStr + "ALT + "};

_bitFlagArray apply { if (_x < 512) then {_rest = _rest + _x} };

_shortCutStr = _shortCutStr + (_rest call BIS_fnc_keyCode);

_shortCutStr
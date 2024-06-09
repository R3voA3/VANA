disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_targetTV", (tvCurSel (_this select 0)), [[]]],
	"_hasName",
	"_hasData"
];

//Check if Text and Data are defined
_hasName = !(_ctrlTV tvText _targetTV isEqualTo "");
_hasData = !(_ctrlTV tvdata _targetTV isEqualTo "");

[false, true] select (_hasName && _hasData)
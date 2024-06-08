disableserialization;

params
[
	["_ctrlTV", controlnull, [controlnull]],
	["_targetTV", (tvCurSel (_this select 0)), [[]]],
  "_HasName",
  "_HasData"
];

//Check if Text and Data are defined
_hasName = !(_ctrlTV tvText _targetTV isequalto "");
_hasData = !(_ctrlTV tvdata _targetTV isequalto "");

[false, true] select (_HasName && _HasData)
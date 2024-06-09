disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_path", [], [[]]]
];

//Check if Text and Data are defined
private _hasName = _ctrlTV tvText _path != "";
private _hasData = _ctrlTV tvData _path != "";

_hasName && _hasData
disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_path", [], [[]]]
];

//Check if Text and Data are defined
(_ctrlTV tvText _path != "") && (_ctrlTV tvData _path != "")
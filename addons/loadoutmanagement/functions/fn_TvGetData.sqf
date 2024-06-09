disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_arguments", [], [[]]],
	["_exportDataArray", [], [[],0]],
	["_checkSubTv", true, [true]],
	["_count", false, [false]]
];

_arguments params
[
	["_parentTv", [], [[]]],
	["_typeData", "All", [""]]
];

_typeData = toLower _typeData;
private _exportDataArray = ([+_exportDataArray, 0] select _count);

for "_i" from 0 to (_ctrlTV tvCount _parentTv) - 1 do
{
	params ["_targetTV","_tvData","_dataExport"];

	//Declare current SubTv
	_targetTV = +_parentTv;
	_targetTV Pushback _i;

	_tvData = toLower (_ctrlTV tvData _targetTV);

	//Get currentSubTv Data
	_dataExport =
	[
		(_ctrlTV tvText _targetTV), //"Name"
		_targetTV, //Position
		_tvData, //"Data"
		(_ctrlTV tvValue _targetTV) //"Value"
	];

	//Add data to Export Array/Value
	if (_typeData isEqualTo _tvData || _typeData == "all") then
	{
		call ([{_exportDataArray append [_dataExport]}, {_exportDataArray = _exportDataArray + 1}] select _count);
	};

	//Execute function for all Subtv's
	if (_checkSubTv && _ctrlTV tvCount _targetTV > 0) then
	{
		_exportDataArray = [_ctrlTV, [_targetTV, _typeData], _exportDataArray, true, _count] call VANA_fnc_tvGetData;
	};
};

_exportDataArray
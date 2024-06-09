disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_arguments", [], [[]]],
	["_ExportDataArray", [], [[],0]],
	["_CheckSubTv", true, [true]],
	["_Count", false, [false]],
	"_ExportDataArray"
];

_arguments params
[
	["_ParentTv", [], [[]]],
	["_typeData", "All", [""]]
];

_typeData = toLower _typeData;
_exportDataArray = ([+_ExportDataArray, 0] Select _Count);

for "_i" from 0 to (_ctrlTV tvCount _ParentTv)-1 do
{
	params ["_targetTV","_tvData","_DataExport"];

	//Declare current SubTv
	_targetTV = +_ParentTv;
	_targetTV Pushback _i;

	_tvData = toLower (_ctrlTV tvData _targetTV);

	//Get currentSubTv Data
	_DataExport =
	[
		(_ctrlTV tvText _targetTV), //"Name"
		_targetTV, //Position
		_tvData, //"Data"
		(_ctrlTV tvValue _targetTV) //"Value"
	];

	//Add data to Export Array/Value
	if (_typeData isEqualTo _tvData || _typeData isEqualTo "all") then
	{
		call ([{_ExportDataArray append [_DataExport]}, {_ExportDataArray = _ExportDataArray +1}] select _Count);
	};

	//Execute function for all Subtv's
	if (_CheckSubTv && _ctrlTV tvCount _targetTV > 0) then
	{
		_ExportDataArray = [_ctrlTV, [_targetTV, _typeData], _ExportDataArray, true, _Count] call VANA_fnc_tvGetData;
	};
};

_exportDataArray
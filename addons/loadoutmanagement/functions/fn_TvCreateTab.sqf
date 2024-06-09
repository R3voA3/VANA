disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_arguments", [], [[]]],
	["_behavior", "", [""]]
];

_arguments params
[
	["_path", (tvCurSel _ctrlTV), [[]]],
	["_tabName", "", [""]]
];

private _path = +_path;
_behavior = toLower _behavior;
private _tvData = toLower (_ctrlTV tvData _path);

//Get parent
if ((_tvData != "tvtab") && (_path isNotEqualTo [])) then
{
  _path resize (count _path - 1);
};

//Create Tab in treeview
private _addSubTV = [];
private _tabCount = -1;
private _newSubTvPath = [];

_newSubTvPath = +_path;
if (_tabName != "") then
{
	_addSubTV = _ctrlTV tvAdd [_path, _tabName];
}
else
{
	_tabCount = [_ctrlTV, [_path, "tvtab"], false] call VANA_fnc_tvCount;
	_addSubTV = _ctrlTV tvAdd [_path, format ["New Tab%1", _tabCount + 1]];
};

_newSubTvPath pushBack _addSubTV;

_ctrlTV tvSetData [_newSubTVPath, "tvtab"];
_ctrlTV tvSetPicture [_newSubTVPath, "a3\3den\data\cfg3den\layer\icon_ca.paa"];

if !(_behavior in ["firsttimesetup", "dragdrop"]) then {_ctrlTV tvExpand _path;};

_newSubTvPath
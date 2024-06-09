disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_arguments", [], [[]]],
	["_behavior", "", [""]],
	"_tvData",
	"_newSubTVPath",
	"_tabCount",
	"_addSubTV"
];

_arguments params
[
	["_targetTV", (tvCurSel _ctrlTV), [[]]],
	["_tabName", "", [""]]
];

_targetTV = +_targetTV;
_behavior = toLower _behavior;
_tvData = toLower (_ctrlTV tvData _targetTV);

//Get parent
if ((_tvData isNotEqualTo "tvtab") && (_targetTV isNotEqualTo [])) then
{
  _targetTV resize (count _targetTV - 1);
};

//Create Tab in treeview
_newSubTvPath = +_targetTV;
if (_tabName != "") then
{
	_addSubTV = _ctrlTV tvAdd [_targetTV, _tabName];
}
else
{
	_tabCount = [_ctrlTV, [_targetTV, "tvtab"], false] call VANA_fnc_tvCount;
	_addSubTV = _ctrlTV tvAdd [_targetTV, format ["New Tab%1", _tabCount + 1]];
};
_newSubTvPath pushBack _addSubTV;

//Visualy/Technical classify Tab
_ctrlTV tvSetData [_newSubTVPath, "tvtab"];
_ctrlTV tvSetPicture [_newSubTVPath, "\loadoutManagement\UI\data\Tab_Icon.paa"];

if !(_behavior in ["firsttimesetup", "dragdrop"]) then {_ctrlTV tvExpand _targetTV;};

_newSubTvPath
#include "\v\vana\addons\loadoutmanagement\defines.inc"

disableserialization;

params
[
	["_ctrlTV", controlNull, [controlNull]],
	["_mode", "false", [""]],
	["_arguments", [], [[]]]
];

switch (toLower _mode) do
{
	case "mousedown":
	{
		params ["_inAction"];

		//Check if user is using scroll bar
		If !(_ctrlTV getVariable ["MouseInTreeView", true]) exitWith {["mousedown", false]};

		//Tell script to get Target
		_ctrlTV setVariable ["TvDragDrop_GetTarget", true];

		//Double check user is initiating TvDragDrop action
		_ctrlTV setVariable ["TvDragDrop_InAction", "Double Check"];
		sleep 0.1;

		_inAction = _ctrlTV getVariable ["TvDragDrop_InAction", false];
		_ctrlTV setVariable ["TvDragDrop_InAction", ([false, true] select (_inAction == "Double Check"))];

		["mousedown", (_ctrlTV getVariable ["TvDragDrop_InAction", false])]
	};
	case "mousemove":
	{
		params ["_return", "_getTarget", "_inAction", "_cursorTab"];

		_return = ["mousemove", false];
		_getTarget = _ctrlTV getVariable ["TvDragDrop_GetTarget", false];
		_inAction = _ctrlTV getVariable ["TvDragDrop_InAction", false];
		_cursorTab = _arguments;

		//Get target
		if _getTarget then
		{
			_ctrlTV setVariable ["TvDragDrop_targetTv", _cursorTab];
			_ctrlTV setVariable ["TvDragDrop_GetTarget", nil];

			_return = ["mousemove", true];
		};

		//Get release Subtv
		if (_inAction isEqualType true && {_inAction}) then
		{
			_ctrlTV setVariable ["TvDragDrop_ReleaseTv", _cursorTab];

			_return = ["mousemove", true];
		};

		_return
	};
	case "mouseup":
	{
		params ["_fncReturn", "_targetTV", "_releaseTv"];

		_targetTV = _ctrlTV getVariable ["TvDragDrop_targetTv", [-1]];
		_releaseTv = _ctrlTV getVariable ["TvDragDrop_ReleaseTv", [-1]];

		//Clear Values
		_ctrlTV setVariable ["TvDragDrop_InAction", nil];
		_ctrlTV setVariable ["TvDragDrop_GetTarget", nil];
		_ctrlTV setVariable ["TvDragDrop_targetTv", nil];
		_ctrlTV setVariable ["TvDragDrop_ReleaseTv", nil];

		//Call TvDragDrop function
		if !(_targetTV isEqualTo [-1]) exitWith
		{
			_fncReturn = [_ctrlTV, "DragDropFnc", [_targetTV, _releaseTv]] call VANA_fnc_tvDragDrop;

			["DragDropFnc", _fncReturn]
		};

		["MouseUp", false]
	};
	case "dragdropfnc":
	{
		_arguments params
		[
			["_targetTV", [-1], [[]]],
			["_releaseTv", [-1], [[]]],
			"_targettvData",
			"_targetTvText",
			"_targetTvValue",
			"_targetTvParent",
			"_isParent",
			"_isChild",
			"_movedSubtv",
			"_movedLoadouts",
			"_newSubTVPath",
			"_movedSubtvGrandParent"
		];

		_targettvData = _ctrlTV tvData _targetTV;
		_targetTvText = _ctrlTV tvText _targetTV;
		_targetTvValue = _ctrlTV tvValue _targetTV;

		//Making sure the DragDrop action is valid
		if (_releaseTv isEqualTo [-1] || _targetTV isEqualTo [] || _targetTV isEqualTo _releaseTv) exitWith {false};

		if (_ctrlTV tvData _releaseTv isEqualTo "tvloadout") then
		{
			_releaseTv = _releaseTv call VANA_fnc_tvGetParent;
		};
		_targetTvParent = _targetTV call VANA_fnc_tvGetParent;

		//Making sure the DragDrop action is valid
		_isParent = _targetTvParent isEqualTo _releaseTv;
		_isChild = _releaseTv select [0, (count _targetTV)] isEqualTo _targetTV;

		if (_isParent || _isChild) exitWith {false};

		//Create Moved SubTv
		_movedSubtv = +_releaseTv;
		_newSubTVPath = _ctrlTV tvadd [_releaseTv, _targetTvText];

		_ctrlTV tvExpand _releaseTv;
		_movedSubtv pushBack _newSubTVPath;

		//Visualy/Technical classify Moved SubTv
		_ctrlTV tvSetData [_movedSubtv, _targettvData];
		_ctrlTV tvSetValue [_movedSubtv, _targetTvValue];

		if (_targetTvValue < 0) then {_ctrlTV tvSetColor [_movedSubtv, [1, 1, 1, 0.25]]};
		If (_targetTvValue isEqualTo EXPANDED) then {_ctrlTV tvExpand _movedSubtv};

		if (_targettvData isEqualTo "tvtab") then
		{
			_ctrlTV tvSetPicture [_movedSubtv, "a3\3den\data\cfg3den\layer\icon_ca.paa"];
			_movedLoadouts = [];

			//Move Child SubTv's
			{
				params ["_tvName", "_tvPosition", "_tvNewParent", "_return"];

				_tvName = _x select 0;
				_tvPosition = (_x select 1) select [(count _targetTV), (count (_x select 1) - count _targetTV)]; //Selects [Position] and removes _targetTV array from the front of it

				_tvNewParent = _movedSubtv + _tvPosition;
				_tvNewParent resize (count _tvNewParent)-1;

				switch toLower (_x select 2) do
				{
					case "tvtab":
					{
						private _tab = [_ctrlTV, [_tvNewParent, _tvName], "DragDrop"] call VANA_fnc_tvCreateTab;
						private _EXPANDED = (_x select 3) isEqualTo EXPANDED;

						If _EXPANDED then {_ctrlTV tvExpand _tab};
						_ctrlTV tvSetValue [_tab, ([COLLAPSED, EXPANDED] select _EXPANDED)];
					};
					case "tvloadout":
					{
						_return = [_ctrlTV, [_tvNewParent, _tvName], "DragDrop"] call VANA_fnc_tvCreateLoadout;
						_movedLoadouts pushBack [_tvName, (_return select 0)];
					};
				};
			} foreach ([_ctrlTV, [_targetTV]] call VANA_fnc_tvGetData);

			[_ctrlTV, _movedLoadouts] call VANA_fnc_tvValidateLoadouts;
		};

		_ctrlTV tvSetCurSel _movedSubtv;
		_ctrlTV tvDelete _targetTV;

		//Get _movedSubtv true posistion
		_movedSubtvGrandParent = +_movedSubtv;
		_movedSubtvGrandParent resize (count _targetTvParent);

		if (_targetTvParent isEqualTo _movedSubtvGrandParent) then
		{
			private _number = _movedSubtv select (count _targetTvParent);
			_movedSubtv set [(count _targetTvParent), _number -1];
		};

		_movedSubtv
	};
};
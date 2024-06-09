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

		//Tell script to get target
		_ctrlTV setVariable ["TvDragDrop_GetTarget", true];

		//Double check user is initiating TvDragDrop action
		_ctrlTV setVariable ["TvDragDrop_InAction", "Double Check"];

		sleep 0.1;

		_inAction = _ctrlTV getVariable ["TvDragDrop_InAction", false];

		private _finalActionState = if (_inAction isEqualType "") then
		{
			true
		}
		else
		{
			false
		};

		_ctrlTV setVariable ["TvDragDrop_InAction", _finalActionState];

		["mousedown", _finalActionState]
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

		//Get release sub tv
		if (_inAction isEqualType true && {_inAction}) then
		{
			_ctrlTV setVariable ["TvDragDrop_ReleaseTv", _cursorTab];

			_return = ["mousemove", true];
		};

		_return
	};
	case "mouseup":
	{
		params ["_fncReturn", "_targetTV", "_releaseTV"];

		_targetTV = _ctrlTV getVariable ["TvDragDrop_targetTv", [-1]];
		_releaseTV = _ctrlTV getVariable ["TvDragDrop_ReleaseTv", [-1]];

		//Clear values
		_ctrlTV setVariable ["TvDragDrop_InAction", nil];
		_ctrlTV setVariable ["TvDragDrop_GetTarget", nil];
		_ctrlTV setVariable ["TvDragDrop_targetTv", nil];
		_ctrlTV setVariable ["TvDragDrop_ReleaseTv", nil];

		//Call TvDragDrop function
		if (_targetTV isNotEqualTo [-1]) exitWith
		{
			_fncReturn = [_ctrlTV, "DragDropFnc", [_targetTV, _releaseTV]] call VANA_fnc_tvDragDrop;

			["DragDropFnc", _fncReturn]
		};

		["MouseUp", false]
	};
	case "dragdropfnc":
	{
		_arguments params
		[
			["_targetTV", [-1], [[]]],
			["_releaseTV", [-1], [[]]]
		];

		private _targettvData = _ctrlTV tvData _targetTV;
		private _targetTvText = _ctrlTV tvText _targetTV;
		private _targetTvValue = _ctrlTV tvValue _targetTV;

		//Making sure the DragDrop action is valid
		if (_releaseTV isEqualTo [-1] || _targetTV isEqualTo [] || _targetTV isEqualTo _releaseTV) exitWith {false};

		if (_ctrlTV tvData _releaseTV isEqualTo "tvloadout") then
		{
			_releaseTV = _releaseTV call VANA_fnc_tvGetParent;
		};

		private _targetTvParent = _targetTV call VANA_fnc_tvGetParent;

		//Making sure the Drag & Drop action is valid
		private _isParent = _targetTvParent isEqualTo _releaseTV;
		private _isChild = _releaseTV select [0, count _targetTV] isEqualTo _targetTV;

		if (_isParent || _isChild) exitWith {false};

		//Create moved sub tv
		private _movedSubtv = +_releaseTV;
		private _newSubTVPath = _ctrlTV tvadd [_releaseTV, _targetTvText];

		_ctrlTV tvExpand _releaseTV;
		_movedSubtv pushBack _newSubTVPath;

		//Classify moved sub tv
		_ctrlTV tvSetData [_movedSubtv, _targettvData];
		_ctrlTV tvSetValue [_movedSubtv, _targetTvValue];

		if (_targetTvValue < 0) then {_ctrlTV tvSetColor [_movedSubtv, [1, 1, 1, 0.25]]};
		If (_targetTvValue == EXPANDED) then {_ctrlTV tvExpand _movedSubtv};

		if (_targettvData == "tvtab") then
		{
			_ctrlTV tvSetPicture [_movedSubtv, "a3\3den\data\cfg3den\layer\icon_ca.paa"];
			private _movedLoadouts = [];

			//Move child Sub tv's
			{
				params ["_tvName", "_tvPosition", "_tvNewParent", "_return"];

				_tvName = _x select 0;
				_tvPosition = (_x select 1) select [(count _targetTV), (count (_x select 1) - count _targetTV)]; //Selects [Position] and removes _targetTV array from the front of it

				_tvNewParent = _movedSubtv + _tvPosition;
				_tvNewParent resize (count _tvNewParent) - 1;

				switch toLower (_x select 2) do
				{
					case "tvtab":
					{
						private _tab = [_ctrlTV, [_tvNewParent, _tvName], "DragDrop"] call VANA_fnc_tvCreateTab;
						private _EXPANDED = (_x select 3) == EXPANDED;

						If _EXPANDED then {_ctrlTV tvExpand _tab};
						_ctrlTV tvSetValue [_tab, ([COLLAPSED, EXPANDED] select _EXPANDED)];
					};
					case "tvloadout":
					{
						_return = [_ctrlTV, [_tvNewParent, _tvName], "DragDrop"] call VANA_fnc_tvCreateLoadout;
						_movedLoadouts pushBack [_tvName, _return select 0];
					};
				};
			} foreach ([_ctrlTV, [_targetTV]] call VANA_fnc_tvGetData);

			[_ctrlTV, _movedLoadouts] call VANA_fnc_tvValidateLoadouts;
		};

		_ctrlTV tvSetCurSel _movedSubtv;
		_ctrlTV tvDelete _targetTV;

		//Get _movedSubtv true position
		private _movedSubtvGrandParent = +_movedSubtv;
		_movedSubtvGrandParent resize (count _targetTvParent);

		if (_targetTvParent isEqualTo _movedSubtvGrandParent) then
		{
			private _number = _movedSubtv select (count _targetTvParent);
			_movedSubtv set [count _targetTvParent, _number -1];
		};

		_movedSubtv
	};
};
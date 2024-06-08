disableserialization;

#define Expanded 1
#define Collapsed 0

params
[
  ["_ctrlTV", controlnull, [controlnull]],
  ["_mode", "false", [""]],
  ["_arguments", [], [[]]]
];

switch (toLower _mode) do
{
  ///////////////////////////////////////////////////////////////////////////////////////////
  case "mousedown":
  {
    params ["_InAction"];

    //Check if user is using scroll bar
    If !(_ctrlTV getVariable ["MouseInTreeView", true]) exitwith {["mousedown", false]};

    //Tell script to get Target
    _ctrlTV Setvariable ["TvDragDrop_GetTarget", true];

    //Double check user is initiating TvDragDrop action
    _ctrlTV Setvariable ["TvDragDrop_InAction", "Double Check"];
    sleep 0.1;

    _InAction = _ctrlTV Getvariable ["TvDragDrop_InAction", false];
    _ctrlTV Setvariable ["TvDragDrop_InAction", ([false, true] select (_InAction isequalto "Double Check"))];

    ["mousedown", (_ctrlTV Getvariable ["TvDragDrop_InAction", false])]
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "mousemove":
  {
    params ["_Return","_GetTarget","_InAction","_CursorTab"];

    _Return = ["mousemove", false];
    _GetTarget = _ctrlTV Getvariable ["TvDragDrop_GetTarget", false];
    _InAction = _ctrlTV Getvariable ["TvDragDrop_InAction", false];
    _CursorTab = _arguments;

    //Get Target
    if _GetTarget then
    {
      _ctrlTV Setvariable ["TvDragDrop_targetTv", _CursorTab];
      _ctrlTV Setvariable ["TvDragDrop_GetTarget", nil];

      _Return = ["mousemove", true];
    };

    //Get Release Subtv
    if (_InAction isequalto true) then
    {
      _ctrlTV Setvariable ["TvDragDrop_ReleaseTv", _CursorTab];

      _Return = ["mousemove", true];
    };

    _Return
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "mouseup":
  {
    params ["_FncReturn","_targetTV","_ReleaseTv"];

    _targetTV = _ctrlTV Getvariable ["TvDragDrop_targetTv", [-1]];
    _ReleaseTv = _ctrlTV Getvariable ["TvDragDrop_ReleaseTv", [-1]];

    //Clear Values
    _ctrlTV Setvariable ["TvDragDrop_InAction", nil];
    _ctrlTV Setvariable ["TvDragDrop_GetTarget", nil];
    _ctrlTV Setvariable ["TvDragDrop_targetTv", nil];
    _ctrlTV Setvariable ["TvDragDrop_ReleaseTv", nil];

    //Call TvDragDrop function
    if !(_targetTV isequalto [-1]) exitwith
    {
      _FncReturn = [_ctrlTV, "DragDropFnc", [_targetTV, _ReleaseTv]] call VANA_fnc_tvDragDrop;

      ["DragDropFnc", _FncReturn]
    };

    ["MouseUp", false]
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "dragdropfnc":
  {
    _arguments params
    [
      ["_targetTV", [-1], [[]]],
      ["_ReleaseTv", [-1], [[]]],
      "_targetTvData",
      "_targetTvText",
      "_targetTvValue",
      "_targetTvParent",
      "_IsParent",
      "_IsChild",
      "_MovedSubtv",
      "_MovedLoadouts",
      "_newSubTVPath",
      "_MovedSubtvGrandParent"
    ];

    _targetTvData = _ctrlTV tvData _targetTV;
    _targetTvText = _ctrlTV tvText _targetTV;
    _targetTvValue = _ctrlTV tvValue _targetTV;

    //Making sure the DragDrop action is valid
    if (_ReleaseTv isequalto [-1] || _targetTV isequalto [] || _targetTV isequalto _ReleaseTv) exitwith {false};

    if (_ctrlTV tvData _ReleaseTv isequalto "tvloadout") then
    {
      _ReleaseTv = _ReleaseTv call VANA_fnc_tvGetParent;
    };
    _targetTvParent = _targetTV call VANA_fnc_tvGetParent;

    //Making sure the DragDrop action is valid
    _IsParent = _targetTvParent isequalto _ReleaseTv;
    _IsChild = _ReleaseTv select [0,(count _targetTV)] isequalto _targetTV;

    if (_IsParent || _IsChild) exitwith {false};

    //Create Moved SubTv
    _MovedSubtv = +_ReleaseTv;
    _newSubTVPath = _ctrlTV tvadd [_ReleaseTv, _targetTvText];

    _ctrlTV TvExpand _ReleaseTv;
    _MovedSubtv pushBack _newSubTVPath;

    //Visualy/Technical classify Moved SubTv
    _ctrlTV tvSetData [_MovedSubtv, _targetTvData];
    _ctrlTV TvSetValue [_MovedSubtv, _targetTvValue];

    if (_targetTvValue < 0) then {_ctrlTV tvSetColor [_MovedSubtv, [1,1,1,0.25]]};
    If (_targetTvValue isequalto Expanded) then {_ctrlTV TvExpand _MovedSubtv};

    if (_targetTvData isequalto "tvtab") then
    {
      _ctrlTV tvSetPicture [_MovedSubtv, "\loadoutManagement\UI\data\Tab_Icon.paa"];
      _MovedLoadouts = [];

      //Move Child SubTv's
      {
        params ["_tvName","_TvPosition","_TvNewParent","_Return"];

        _tvName = _x select 0;
        _TvPosition = (_x select 1) select [(count _targetTV), (count (_x select 1) - count _targetTV)]; //Selects [Position] and removes _targetTV array from the front of it

        _TvNewParent = _MovedSubtv + _TvPosition;
        _TvNewParent resize (count _TvNewParent)-1;

        switch toLower (_x select 2) do
        {
          case "tvtab":
          {
            private _Tab = [_ctrlTV, [_TvNewParent, _tvName], "DragDrop"] call VANA_fnc_tvCreateTab;
            private _Expanded = (_x select 3) isequalto Expanded;

            If _Expanded then {_ctrlTV TvExpand _Tab};
            _ctrlTV TvSetValue [_Tab, ([Collapsed, Expanded] select _Expanded)];
          };
          case "tvloadout":
          {
            _Return = [_ctrlTV, [_TvNewParent, _tvName], "DragDrop"] call VANA_fnc_tvCreateLoadout;
            _MovedLoadouts pushBack [_tvName, (_Return select 0)];
          };
        };
      } foreach ([_ctrlTV, [_targetTV]] call VANA_fnc_tvGetData);

      [_ctrlTV, _MovedLoadouts] call VANA_fnc_tvValidateLoadouts;
    };

    _ctrlTV tvSetCurSel _MovedSubtv;
    _ctrlTV tvDelete _targetTV;

    //Get _MovedSubtv true posistion
    _MovedSubtvGrandParent = +_MovedSubtv;
    _MovedSubtvGrandParent resize (count _targetTvParent);

    if (_targetTvParent isequalto _MovedSubtvGrandParent) then
    {
      private _Number = _MovedSubtv select (count _targetTvParent);
      _MovedSubtv set [(count _targetTvParent), _Number -1];
    };

    _MovedSubtv
  };
};
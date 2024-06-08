params ["_ctrlGroup", "_config"];

private _ctrlTitle = _ctrlGroup controlsGroupCtrl 100;
private _ctrlAttributeGroup = _ctrlGroup controlsGroupCtrl 101;
private _ctrlDescription = _ctrlGroup controlsGroupCtrl 102;
private _ctrlDescriptionDeco = _ctrlGroup controlsGroupCtrl 103;

_ctrlDescription ctrlSetStructuredText parseText gettext (_config >> "description");

private _ctrlTextHeight = ctrlTextHeight _ctrlDescription;

_ctrlTitle ctrlSetPositionH _ctrlTextHeight;
_ctrlDescription  ctrlSetPositionH _ctrlTextHeight;
_ctrlDescriptionDeco ctrlSetPositionH _ctrlTextHeight;
_ctrlAttributeGroup ctrlSetPositionH 0.3;

_ctrlAttributeGroup ctrlCommit 0;
_ctrlTitle ctrlCommit 0;
_ctrlDescription ctrlCommit 0;
_ctrlDescriptionDeco ctrlCommit 0;


//AirDrop doesnt display
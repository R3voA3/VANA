_display = findDisplay 313 createDisplay "RscDisplayEmpty";
_tv = _display ctrlCreate ["RscTreeSearch", -1];
_tv ctrlSetFont "EtelkaMonospacePro";
_tv ctrlSetFontHeight 0.03;
_tv ctrlSetPosition [0,0.06,1,0.94];
_tv ctrlSetBackgroundColor [0.2,0.2,0.2,1];
_tv ctrlCommit 0;

private _markerClasses = [];
private _indexClass = -1;
private _indexMarker = -1;

{
  private _name = getText (_x >> "name");
  private _class = configName _x;
  private _icon = getText (_x >> "icon");
  private _color = getArray (_x >> "color");

  //Skip if marker icon file does not exist
  if !(fileExists _icon) then {continue};

  //Fix inconsistencies. Some color are defined weirdly and some markers have no class. Turn black color into white
  if (count _color == 4) then {_color = _color call BIS_fnc_parseNumberSafe} else {_color = [1, 1, 1, 1]};
  if (_color isEqualTo [0, 0, 0, 1]) then {_color = [1, 1, 1, 1]};
  private _markerClass = getText (_x >> "markerClass");
  if (_markerClass == "") then {_markerClass = "System"};
  private _markerClassDisplayName = getText (configfile >> "CfgMarkerClasses" >> _markerClass >> "displayName");
  if (_markerClassDisplayName == "") then {_markerClassDisplayName = _markerClass};

  if (_markerClass in _markerClasses) then
  {
    _indexClass = _markerClasses find _markerClass;
    _indexMarker = _tv tvAdd [[_indexClass], _name];
  }
  else
  {
    _indexClass = _tv tvAdd [[], _markerClassDisplayName];
    _indexMarker = _tv tvAdd [[_indexClass], _name];
    _markerClasses pushBackUnique _markerClass;
  };

  _tv tvSetData [[_indexClass, _indexMarker], _class];
  _tv tvSetPicture [[_indexClass, _indexMarker], _icon];
  _tv tvSetPictureColor [[_indexClass, _indexMarker], _color];
  _tv tvSetTooltip [[_indexClass, _indexMarker], _class];
} forEach ("getNumber (_x >> 'scope') > 0" configClasses (configFile >> "CfgMarkers"));

_index = _tv tvAdd [[], "*Disabled"];
_tv tvSetColor [[_index], [1, 0, 0 ,1]];
_tv tvSetTooltip [[_index], "Disables this attribute."];
_tv tvSetData [[_index], ""];
_tv tvSortAll [[], false];
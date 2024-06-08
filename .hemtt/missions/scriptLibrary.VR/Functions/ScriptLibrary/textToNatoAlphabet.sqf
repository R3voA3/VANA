_natoAlphabetHashmap = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p" , "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"] 
createHashMapFromArray 
["Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliett", "Kilo", "Lima", "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whiskey", "Xray", "Yankee", "Zulu"];

params ["_text"];

private _output = "";
{
  if (_x == " ") then {_output = _output + " -- "; continue};
  _output = _output + (_natoAlphabetHashmap getOrDefault [_x, "INVALID CHARACTER!"]) + " ";
} forEach (toLower _text splitString "");

hint (_output + "\n\n" + _text);

copyToClipboard (_output + endl + _text);
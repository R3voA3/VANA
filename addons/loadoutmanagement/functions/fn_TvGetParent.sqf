disableserialization;

private _targetTV = +_this;

if !(_targetTV isEqualTo []) then
{
	_targetTV resize (count _targetTV-1);

	_targetTV
} else {
	[]
};
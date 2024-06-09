disableserialization;

private _targetTV = +_This;

if !(_targetTV isEqualTo []) then
{
	_targetTV resize (count _targetTV-1);

	_targetTV
} else {
	[]
};
[] spawn
{
	_veh = vehicle player;
	_pos0 = position _veh;
	waitUntil {speed _veh > 0};
	_t0 = diag_tickTime;
	hint "Test started!";

	waitUntil {(speed _veh) >= 60};
	_dt = diag_tickTime - _t0;
	_s = _pos0 distance2D (position _veh);
	_a = (60 * 1000 / 3600) / _dt ;
	_result = format ["Time 0 - 60 km/h: %1 s\nDistance: %2 m\nAcceleration:%3 m/s²",_dt,_s,_a];
	hint _result;
	copyToClipboard _result;
};

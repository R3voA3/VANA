[] spawn
{
   while {alive Revo_Ambient_Turret} do
   {
      private _pos = Revo_Ambient_Turret getRelPos [random [0,10000,20000],random 359];
      _pos set [2,random [0,5000,1000]];
      Revo_Ambient_Turret doWatch _pos;
      sleep 8;
   };
};
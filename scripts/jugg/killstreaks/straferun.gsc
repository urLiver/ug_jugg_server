/*

    INFO:
        - This File Includes the Functions Replacing certain parts of the Helicopter Flock Killstreak

    TODO:
        - Add in a second version using littlebirds for fun time but with a random chance of like 25%

    DONE:
        - Removed the outter two copters so killstreak isnt to overpowered for inf jugg
        
*/

init()
{
    replacefunc( maps\mp\killstreaks\_helicopter_flock::tryuselbflock, ::on_tryuselbflock );
    replacefunc( maps\mp\killstreaks\_helicopter_flock::callstrike, ::on_callstrike );
}

on_tryuselbflock( var_0, var_1 )
{
    if ( !maps\mp\_utility::validateusestreak() )
        return 0;

    var_2 = 5;

    if ( maps\mp\killstreaks\_helicopter_flock::heliflockactive() || maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_2 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"MP_TOO_MANY_VEHICLES" );
        return 0;
    }

    maps\mp\_utility::incrementfauxvehiclecount();
    maps\mp\_utility::incrementfauxvehiclecount();
    maps\mp\_utility::incrementfauxvehiclecount();
    var_3 = maps\mp\killstreaks\_helicopter_flock::selectlbstrikelocation( var_0, "littlebird_flock" );

    if ( !isdefined( var_3 ) || !var_3 )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        maps\mp\_utility::decrementfauxvehiclecount();
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    level thread maps\mp\_utility::teamplayercardsplash( "used_littlebird_flock", self, self.team );
    return 1;
}

on_callstrike( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_3 = maps\mp\killstreaks\_helicopter_flock::getflightpath( var_1, var_2, 0 );
    var_4 = maps\mp\killstreaks\_helicopter_flock::getflightpath( var_1, var_2, -520 );
    var_5 = maps\mp\killstreaks\_helicopter_flock::getflightpath( var_1, var_2, 520 );
    level thread maps\mp\killstreaks\_helicopter_flock::dolbstrike( var_0, self, var_3, 0 );
    wait 0.3;
    level thread maps\mp\killstreaks\_helicopter_flock::dolbstrike( var_0, self, var_4, 1 );
    level thread maps\mp\killstreaks\_helicopter_flock::dolbstrike( var_0, self, var_5, 2 );
    maps\mp\_matchdata::logkillstreakevent( "littlebird_flock", var_1 );
}
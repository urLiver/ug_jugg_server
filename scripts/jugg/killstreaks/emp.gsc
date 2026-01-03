/*

    INFO:
        - This File Includes the Functions Replacing certain parts of the EMP

    TODO:
        - None

    DONE:
        - Added the ability to both emp_jam functions to block the infected rolls
        - Shortend Duration to 20 seconds instead of 60 seconds
        - Removed the vision re-set of the Nuke Vision when a nuke detonated
        
*/

init()
{
    replacefunc( maps\mp\killstreaks\_emp::emp_jamplayers, ::on_emp_jamplayers );
    replacefunc( maps\mp\killstreaks\_emp::emp_jamteam, ::on_emp_jamteam );
}

on_emp_jamteam( var_0 )
{
    level endon( "game_ended" );
    thread maps\mp\_utility::teamplayercardsplash( "used_emp", self );
    level notify( "EMP_JamTeam" + var_0 );
    level endon( "EMP_JamTeam" + var_0 );

    foreach ( var_2 in level.players )
    {
        var_2 playlocalsound( "emp_activate" );

        if ( var_2.team != var_0 )
            continue;

        if ( var_2 maps\mp\_utility::_hasperk( "specialty_localjammer" ) )
            var_2 radarjamoff();
    }

    visionsetnaked( "coup_sunblind", 0.1 );
    thread maps\mp\killstreaks\_emp::empeffects();
    wait 0.1;
    visionsetnaked( "coup_sunblind", 0 );

    /*
    if ( isdefined( level.nukedetonated ) )
        visionsetnaked( level.nukevisionset, 3.0 );
    else
        visionsetnaked( "", 3.0 );
    */

    visionsetnaked( "", 3.0 );

    level.teamemped[var_0] = 1;
    level notify( "emp_update" );
    level maps\mp\killstreaks\_emp::destroyactivevehicles( self, var_0 );
    level thread maps\mp\killstreaks\_emp::keepemptimeremaining();

    level.infected_jammed = 1;
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( level.emptimeout );
    level.infected_jammed = undefined;

    level.teamemped[var_0] = 0;

    foreach ( var_2 in level.players )
    {
        if ( var_2.team != var_0 )
            continue;

        if ( var_2 maps\mp\_utility::_hasperk( "specialty_localjammer" ) )
            var_2 radarjamon();
    }

    level notify( "emp_update" );
}

on_emp_jamplayers( var_0 )
{
    level notify( "EMP_JamPlayers" );
    level endon( "EMP_JamPlayers" );

    foreach ( var_2 in level.players )
    {
        var_2 playlocalsound( "emp_activate" );

        if ( var_2 == var_0 )
            continue;

        if ( var_2 maps\mp\_utility::_hasperk( "specialty_localjammer" ) )
            var_2 radarjamoff();
    }

    visionsetnaked( "coup_sunblind", 0.1 );
    thread maps\mp\killstreaks\_emp::empeffects();
    wait 0.1;
    visionsetnaked( "coup_sunblind", 0 );

    /*
    if ( isdefined( level.nukedetonated ) )
        visionsetnaked( level.nukevisionset, 3.0 );
    else
        visionsetnaked( "", 3.0 );
    */

    visionsetnaked( "", 3.0 );

    level notify( "emp_update" );
    level.empplayer = var_0;
    level.empplayer thread maps\mp\killstreaks\_emp::empplayerffadisconnect();
    level maps\mp\killstreaks\_emp::destroyactivevehicles( var_0 );
    level notify( "emp_update" );
    level thread maps\mp\killstreaks\_emp::keepemptimeremaining();

    level.infected_jammed = 1;
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( level.emptimeout );
    level.infected_jammed = undefined;

    foreach ( var_2 in level.players )
    {
        if ( var_2 == var_0 )
            continue;

        if ( var_2 maps\mp\_utility::_hasperk( "specialty_localjammer" ) )
            var_2 radarjamon();
    }

    level.empplayer = undefined;
    level notify( "emp_update" );
    level notify( "emp_ended" );
}
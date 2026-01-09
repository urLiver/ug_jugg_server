/*

    INFO:
        - This File Includes the Functions Replacing certain parts of the Remote Uav Streak

    TODO:
        - Maybe make it explode on destroy
        - Find out if i can speed up the turret or make it more precised
        . block ah6 usage
        
    DONE:
        - Fully Refactored the tryuseremoteuva, to call in a "littlebird" with a remoteuav model and a ugv turret
        - Duration is 45 and maxhealth 250, uav wont be self controlled and fly like the ah6, but faster
        
*/

init()
{
    level.droneguardsettings = [];
    level.droneguardsettings[ "recondrone_support" ] = spawnstruct();
    level.droneguardsettings[ "recondrone_support" ].timeout = 45.0;
    level.droneguardsettings[ "recondrone_support" ].health = 999999;
    level.droneguardsettings[ "recondrone_support" ].maxhealth = 250;
    level.droneguardsettings[ "recondrone_support" ].vehicletype = "remote_uav_mp";
    level.droneguardsettings[ "recondrone_support" ].weaponinfo = "ugv_turret_mp";
    level.droneguardsettings[ "recondrone_support" ].weaponmodel = "vehicle_ugv_talon_gun_mp";
    level.droneguardsettings[ "recondrone_support" ].weapontag = "tag_origin";
    level.droneguardsettings[ "recondrone_support" ].sentrymode = "auto_nonai";
    level.droneguardsettings[ "recondrone_support" ].modelbase = "vehicle_remote_uav";

    replacefunc( maps\mp\killstreaks\_remoteuav::tryuseremoteuav, ::on_tryuseremoteuav );
}

on_tryuseremoteuav( var_0 )
{
    if ( isdefined( level.civilianjetflyby ) )
    {
        self iprintlnbold( &"MP_CIVILIAN_AIR_TRAFFIC" );
        return 0;
    }
    else if ( maps\mp\_utility::isusingremote() )
    {
        return 0;
    }
    else if ( isdefined( level.recondroneguard ) || maps\mp\killstreaks\_helicopter::exceededmaxlittlebirds( "recondrone_support" ) )
    {
        self iprintlnbold( &"MP_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else if ( ! level.air_node_mesh.size )
    {
        self iprintlnbold( &"MP_UNAVAILABLE_IN_LEVEL" );
        return 0;
    }
    else if ( maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iprintlnbold( &"MP_TOO_MANY_VEHICLES" );
        return 0;
    }

    maps\mp\_utility::incrementfauxvehiclecount();

    var_3 = createlbguard( "recondrone_support" );
    if ( ! isdefined( var_3 ) )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    thread startlbsupport( var_3 );
    level thread maps\mp\_utility::teamplayercardsplash( "used_remote_uav", self, self.team );
    return 1;
}

createlbguard( var_0 )
{
    var_1 = lbsupport_getcloseststartnode( self.origin );
    var_2 = ( 0.0, 0.0, 0.0 );

    if ( isdefined( var_1.angles ) )
    {
        var_2 = var_1.angles;
    }

    var_3 = maps\mp\killstreaks\_airdrop::getflyheightoffset( self.origin );
    var_4 = lbsupport_getclosestnode( self.origin );
    var_4 = lbsupport_tu0_new_incoming_position( var_4 );
    var_5 = anglestoforward( self.angles );
    var_6 = var_4.origin * ( 1.0, 1.0, 0.0 ) + ( 0.0, 0.0, 1.0 ) * var_3 + var_5 * -100;
    var_7 = var_1.origin;
    var_8 = spawnhelicopter( self, var_7, var_2, level.droneguardsettings[var_0].vehicletype, level.droneguardsettings[var_0].modelbase );

    if ( ! isdefined( var_8 ) )
    {
        return;
    }

    var_8 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
    var_8 thread maps\mp\killstreaks\_helicopter::removefromlittlebirdlistondeath();
    var_8.health = level.droneguardsettings[var_0].health;
    var_8.maxhealth = level.droneguardsettings[var_0].maxhealth;
    var_8.damagetaken = 0;
    var_8.speed = 150;
    var_8.followspeed = 60;
    var_8.owner = self;
    var_8.team = self.team;
    var_8 setmaxpitchroll( 60, 60 );
    var_8 vehicle_setspeed( var_8.speed, 100, 40 );
    var_8 setyawspeed( 120, 60 );
    var_8 setneargoalnotifydist( 512 );
    var_8.killcount = 0;
    var_8.helitype = "littlebird";
    var_8.heliguardtype = "recondrone_support";
    var_8.targettingradius = 3300;
    var_8.targetpos = var_6;
    var_8.currentnode = var_4;
    var_9 = spawnturret( "misc_turret", var_8.origin, level.droneguardsettings[var_0].weaponinfo );
    var_9 linkto( var_8, level.droneguardsettings[var_0].weapontag, ( 0.0, 0.0, -20.0 ), ( 0.0, 0.0, 180.0 ) );
    var_9 setmodel( level.droneguardsettings[var_0].weaponmodel );
    var_9.angles = var_8.angles;
    var_9.owner = var_8.owner;
    var_9.team = self.team;
    var_9 maketurretinoperable();
    var_9.vehicle = var_8;
    var_8.mgturret = var_9;
    var_8.mgturret setdefaultdroppitch( 0 );
    var_10 = var_8.origin + ( anglestoforward( var_8.angles ) * -100 ) + ( 0.0, 0.0, 50.0 );
    var_9.killcament = spawn( "script_model", var_10 );
    var_9.killcament setscriptmoverkillcam( "explosive" );
    var_9.killcament linkto( var_8, "tag_origin" );
    
    if ( level.teambased )
    {
        var_8.mgturret setturretteam( self.team );
    }

    var_8.mgturret setmode( level.droneguardsettings[var_0].sentrymode );
    var_8.mgturret setsentryowner( self );
    var_8.mgturret thread lbsupport_attacktargets();
    var_8.attract_strength = 5000;
    var_8.attract_range = 100;
    var_8.attractor = missile_createattractorent( var_8, var_8.attract_strength, var_8.attract_range );
    var_8 thread lbsupport_handledamage();
    var_8 thread lbsupport_watchdeath();
    var_8 thread lbsupport_watchtimeout();
    var_8 thread lbsupport_watchownerloss();
    var_8 thread lbsupport_watchownerdamage();
    var_8 thread lbsupport_watchroundend();
    level.recondroneguard = var_8;
    var_8.owner maps\mp\_matchdata::logkillstreakevent( "remote_uav", var_8.targetpos );
    return var_8;
}

startlbsupport( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );

    var_0 setlookatent( self );
    var_0 setvehgoalpos( var_0.targetpos );

    var_0 waittill( "near_goal" );

    var_0 vehicle_setspeed( var_0.speed, 60, 30 );

    var_0 waittill( "goal" );

    var_0 setvehgoalpos( var_0.currentnode.origin, 1 );

    var_0 waittill( "goal" );

    var_0 thread lbsupport_followplayer();
    var_0 thread maps\mp\killstreaks\_helicopter::handleincomingsam( ::lbsupport_watchsamproximity );
    var_0 thread maps\mp\killstreaks\_helicopter::handleincomingstinger( ::lbsupport_watchstingerproximity );
}

lbsupport_followplayer()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    if ( ! isdefined( self.owner ) )
    {
        thread lbsupport_leave();
        return;
    }

    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    self vehicle_setspeed( self.followspeed, 20, 20 );

    for (;;)
    {
        if ( isdefined( self.owner ) && isalive( self.owner ) )
        {
            var_0 = lbsupport_getclosestlinkednode( self.owner.origin );

            if ( isdefined( var_0 ) && var_0 != self.currentnode )
            {
                self.currentnode = var_0;
                lbsupport_movetoplayer();
                continue;
            }
        }

        wait 1;
    }
}

lbsupport_movetoplayer()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    self notify( "lbSupport_moveToPlayer" );
    self endon( "lbSupport_moveToPlayer" );
    
    self.intransit = 1;
    
    self setvehgoalpos( self.currentnode.origin, 1 );
    
    self waittill( "goal" );
    
    self.intransit = 0;
    
    self notify( "hit_goal" );
}

lbsupport_watchdeath()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death" );

    self playsound( "recondrone_destroyed" );
    playfx( level.remoteuav_fx["explode"], self.origin );

    level.recondroneguard = undefined;

    if ( ! isdefined( self ) )
    {
        return;
    }

    self notify( "explode" );

    removelittlebird();
}

lbsupport_watchtimeout()
{
    level endon( "game_ended" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );

    var_0 = level.droneguardsettings[self.heliguardtype].timeout;

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );

    thread lbsupport_leave();
}

lbsupport_watchownerloss()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    self.owner common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );

    thread lbsupport_leave();
}

lbsupport_watchownerdamage()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );

    for (;;)
    {
        self.owner waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( isplayer( var_1 ) )
        {
            if ( var_1 != self.owner && distance2d( var_1.origin, self.origin ) <= self.targettingradius && !var_1 maps\mp\_utility::_hasperk( "specialty_blindeye" ) && !( level.hardcoremode && level.teambased && var_1.team == self.team ) )
            {
                self setlookatent( var_1 );
                self.mgturret settargetentity( var_1 );
            }
        }
    }
}

lbsupport_watchroundend()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );

    level waittill( "round_end_finished" );

    thread lbsupport_leave();
}

lbsupport_leave()
{
    self endon( "death" );
    self notify( "leaving" );

    level.recondroneguard = undefined;

    self clearlookatent();

    var_0 = maps\mp\killstreaks\_airdrop::getflyheightoffset( self.origin );
    var_1 = self.origin + ( 0, 0, var_0 );

    self vehicle_setspeed( self.speed, 60 );
    self setmaxpitchroll( 45, 180 );
    self setvehgoalpos( var_1 );

    self waittill( "goal" );

    var_1 += anglestoforward( self.angles ) * 15000;
    var_2 = spawn( "script_origin", var_1 );

    if ( isdefined( var_2 ) )
    {
        self setlookatent( var_2 );
        var_2 thread wait_and_delete( 3.0 );
    }

    self setvehgoalpos( var_1 );

    self waittill( "goal" );

    self notify( "gone" );

    removelittlebird();
}

wait_and_delete( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );

    wait(var_0);

    self delete();
}

lbsupport_handledamage()
{
    self endon( "death" );
    level endon( "game_ended" );
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( ! maps\mp\gametypes\_weapons::friendlyfirecheck( self.owner, var_1 ) )
        {
            continue;
        }

        if ( ! isdefined( self ) )
        {
            return;
        }

        if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
        {
            self.wasdamagedfrombulletpenetration = 1;
        }

        self.wasdamaged = 1;
        var_10 = var_0;

        if ( isplayer( var_1 ) )
        {
            if ( var_1 != self.owner && distance2d( var_1.origin, self.origin ) <= self.targettingradius && !var_1 maps\mp\_utility::_hasperk( "specialty_blindeye" ) && !( level.hardcoremode && level.teambased && var_1.team == self.team ) )
            {
                self setlookatent( var_1 );
                self.mgturret settargetentity( var_1 );
            }

            var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "helicopter" );

            if ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" )
            {
                if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                {
                    var_10 += var_0 * level.armorpiercingmod;
                }
            }
        }

        if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
        {
            var_1.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "helicopter" );
        }

        if ( isdefined( var_9 ) )
        {
            switch ( var_9 )
            {
                case "ac130_105mm_mp":
                case "ac130_40mm_mp":
                case "remotemissile_projectile_mp":
                case "remote_mortar_missile_mp":
                case "stinger_mp":
                case "javelin_mp":
                    self.largeprojectiledamage = 1;
                    var_14 = self.maxhealth + 1;
                    break;
                case "emp_grenade_mp":
                case "bomb_site_mp":
                    self.largeprojectiledamage = 0;
                    var_14 = self.maxhealth + 1;
                    break;
            }
        }

        self.damagetaken += var_10;

        if ( self.damagetaken >= self.maxhealth )
        {
            if ( isplayer( var_1 ) && ( ! isdefined( self.owner ) || var_1 != self.owner ) )
            {
                var_1 notify( "destroyed_helicopter" );
                var_1 notify( "destroyed_killstreak", var_9 );
                thread maps\mp\_utility::teamplayercardsplash( "callout_destroyed_remote_uav", var_1 );
                var_1 thread maps\mp\gametypes\_rank::giverankxp( "kill", 50, var_9, var_4 );
                var_1 thread maps\mp\gametypes\_rank::xpeventpopup( &"SPLASHES_DESTROYED_REMOTE_UAV" );
                thread maps\mp\gametypes\_missions::vehiclekilled( self.owner, self, undefined, var_1, var_0, var_4, var_9 );
            }

            self notify( "death" );

            return;
        }
    }
}

removelittlebird()
{
    level.lbstrike = 0;

    if ( isdefined( self.mgturret ) )
    {
        if ( isdefined( self.mgturret.killcament ) )
        {
            self.mgturret.killcament delete();
        }

        self.mgturret delete();
    }

    maps\mp\_utility::decrementfauxvehiclecount();

    self delete();
}

lbsupport_watchsamproximity( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );
    var_2 endon( "death" );

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
    {

    }
}

lbsupport_watchstingerproximity( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    var_2 endon( "death" );
}

lbsupport_getcloseststartnode( var_0 )
{
    var_1 = undefined;
    var_2 = 999999;

    foreach ( var_4 in level.air_start_nodes )
    {
        var_5 = distance( var_4.origin, var_0 );

        if ( var_5 < var_2 )
        {
            var_1 = var_4;
            var_2 = var_5;
        }
    }

    return var_1;
}

lbsupport_getclosestnode( var_0 )
{
    var_1 = undefined;
    var_2 = 999999;

    foreach ( var_4 in level.air_node_mesh )
    {
        var_5 = distance( var_4.origin, var_0 );

        if ( var_5 < var_2 )
        {
            var_1 = var_4;
            var_2 = var_5;
        }
    }

    return var_1;
}

lbsupport_getclosestlinkednode( var_0 )
{
    var_1 = undefined;
    var_2 = distance2d( self.currentnode.origin, var_0 );
    var_3 = var_2;

    foreach ( var_5 in self.currentnode.neighbors )
    {
        var_6 = distance2d( var_5.origin, var_0 );

        if ( var_6 < var_2 && var_6 < var_3 )
        {
            var_1 = var_5;
            var_3 = var_6;
        }
    }

    return var_1;
}

lbsupport_arraycontains( var_0, var_1 )
{
    if ( var_0.size <= 0 )
    {
        return 0;
    }

    foreach ( var_3 in var_0 )
    {
        if ( var_3 == var_1 )
        {
            return 1;
        }
    }

    return 0;
}

lbsupport_getlinkedstructs()
{
    var_0 = [];

    if ( isdefined( self.script_linkto ) )
    {
        var_1 = common_scripts\utility::get_links();

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            var_3 = common_scripts\utility::getstruct( var_1[var_2], "script_linkname" );

            if ( isdefined( var_3 ) )
            {
                var_0[ var_0.size ] = var_3;
            }
        }
    }

    return var_0;
}

lbsupport_tu0_new_incoming_position( var_0 )
{
    switch ( getdvar( "mapname" ) )
    {
        case "mp_interchange":
            var_1 = [];
            var_2 = [];
            var_1[ var_2.size ][ 0 ] = ( 1340.9, 1299.3, 360.0 );
            var_1[ var_2.size ][ 1 ] = ( 2220.9, 115.3, 408.0 );
            var_2[ var_2.size ] = ( 1884.9, 787.3, 312.0 );
            var_1[ var_2.size ][ 0 ] = ( -755.1, -588.7, 728.0 );
            var_1[ var_2.size ][ 1 ] = ( -2563.1, -1580.7, 1192.0 );
            var_2[ var_2.size ] = ( -1363.1, -1164.7, 472.0 );
            var_1[ var_2.size ][ 0 ] = ( -35.1, -2492.7, 488.0 );
            var_1[ var_2.size ][ 1 ] = ( 396.9, -1884.7, 696.0 );
            var_2[ var_2.size ] = ( -755.1, -1788.7, 460.0 );
            var_3 = randomintrange( 0, 100 ) > 50;

            for ( var_4 = 0; var_4 < var_2.size; var_4++ )
            {
                if ( int( var_0.origin[ 0 ] ) == int( var_2[var_4][ 0 ] ) && int( var_0.origin[ 1 ] ) == int( var_2[var_4][ 1 ] ) && int( var_0.origin[ 2 ] ) == int( var_2[var_4][ 2 ] ) )
                {
                    for ( var_5 = 0; var_5 < level.air_node_mesh.size; var_5++ )
                    {
                        if ( int( level.air_node_mesh[var_5].origin[ 0 ] ) == int( var_1[var_4][var_3][ 0 ] ) && int( level.air_node_mesh[var_5].origin[ 1 ] ) == int( var_1[var_4][var_3][ 1 ] ) && int( level.air_node_mesh[var_5].origin[ 2 ] ) == int( var_1[var_4][var_3][ 2 ] ) )
                        {
                            return level.air_node_mesh[var_5];
                        }
                    }
                }
            }

            break;
        default:
            break;
    }

    return var_0;
}

lbsupport_attacktargets()
{
    self.vehicle endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "turretstatechange" );

        if ( self isfiringturret() )
        {
            thread lbsupport_burstfirestart();
            continue;
        }

        thread lbsupport_burstfirestop();
    }
}

lbsupport_burstfirestart()
{
    self.vehicle endon( "death" );
    self.vehicle endon( "leaving" );
    self endon( "stop_shooting" );
    level endon( "game_ended" );

    var_0 = 0.1;
    var_1 = 40;
    var_2 = 80;
    var_3 = 1.0;
    var_4 = 2.0;

    for (;;)
    {
        var_5 = randomintrange( var_1, var_2 + 1 );

        for ( var_6 = 0; var_6 < var_5; var_6++ )
        {
            var_7 = self getturrettarget( 0 );

            if ( isdefined( var_7 ) && ( ! isdefined( var_7.spawntime ) || ( gettime() - var_7.spawntime ) / 1000 > 5 ) && ( isdefined( var_7.team ) && var_7.team != "spectator" ) && maps\mp\_utility::isreallyalive( var_7 ) )
            {
                self.vehicle setlookatent( var_7 );
                self shootturret();
            }

            wait( var_0 );
        }

        wait(randomfloatrange( var_3, var_4 ));
    }
}

lbsupport_burstfirestop()
{
    self notify( "stop_shooting" );

    if ( isdefined( self.vehicle.owner ) )
    {
        self.vehicle setlookatent( self.vehicle.owner );
    }
}
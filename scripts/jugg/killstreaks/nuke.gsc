/*

    INFO:
        - This File Includes the Functions Replacing certain parts of the Nuke

    TODO:
        - Maybe add back slowmo and fully the vision
        - Change timer to OG Timer but unsure for now
        - Give remote on use
        - Something causes that infected cant use airstrikes with a msg of "Moab Fallout 60s" never heard of it

    DONE:
        - Replaces the Nuke fully, calls in two jets and a b2 bomber before going off
        
*/

init()
{
    
}

do_helping_plane_run( runtime, startorigin, endorigin )
{
    plane = spawnplane( self, "script_model", startorigin, "compass_objpoint_airstrike_friendly", "compass_objpoint_airstrike_busy" );
    
    maps\mp\killstreaks\_airstrike::addplanetolist( plane );

    plane playloopsound( "veh_mig29_dist_loop" );

    plane setmodel( "vehicle_mig29_desert" );

    plane.lifeid = -1;
    plane.angles = ( 0, 45, 0 );

    plane moveto( endorigin, runtime, 0, 0 );
    plane endon( "death" );

    wait(runtime);

    maps\mp\killstreaks\_airstrike::removeplanefromlist( plane );
    plane notify( "delete" );
    plane delete();
}

do_main_plane_run( runtime, startorigin, endorigin )
{
    plane = spawnplane( self, "script_model", startorigin, "", "" );
    
    maps\mp\killstreaks\_airstrike::addplanetolist( plane );

    plane playloopsound( "veh_b2_dist_loop" );

    plane setmodel( "vehicle_b2_bomber" );

    plane.lifeid = -1;
    plane.angles = ( 0, 45, 0 );

    plane moveto( endorigin, runtime, 0, 0 );
    plane endon( "death" );

    wait(runtime);

    maps\mp\killstreaks\_airstrike::removeplanefromlist( plane );
    plane notify( "delete" );
    plane delete();
}

do_nuke_run( user )
{   
    offsetposition = ( ( randomfloat( 2 ) - 1 ) * 1000, ( randomfloat( 2 ) - 1 ) * 1000, 0 );
    startorigin = user.origin + ( -15000.0, -15000.0, 3500.0 ) + offsetposition;
    endorigin = user.origin + ( 15000.0, 15000.0, 3500.0 ) + offsetposition;
    var_4 = bullettrace( startorigin, endorigin, 0, undefined );
    
    self thread do_helping_plane_run( 9, startorigin + ( 1000, -1000, 0 ), endorigin );
    self thread do_helping_plane_run( 9, startorigin + ( -1000, 1000, 0 ), endorigin );

    wait 3;

    self thread do_main_plane_run( 11, startorigin, endorigin );
}

do_nuke_ui()
{
    level endon( "nuke_cancelled" );

	if( isdefined( level.nuke_timer_ui ) ) {
		level.nuke_timer_ui destroy();
	}

    level.nuke_timer_ui = maps\mp\gametypes\_hud_util::createservertimer( "bigfixed", 0.8 );
    level.nuke_timer_ui maps\mp\gametypes\_hud_util::setpoint( "CENTER", "TOP", 0, 60 );
    level.nuke_timer_ui.label = &"Impact in: ^1";
    level.nuke_timer_ui settimer( 10 );
    level.nuke_timer_ui.alpha = 0;
    level.nuke_timer_ui fadeovertime( 1.0 );
    level.nuke_timer_ui.alpha = 1;
    level.nuke_timer_ui.archived = 1;
    level.nuke_timer_ui.hidewheninmenu = 1;
}

hide_nuke_ui()
{
    if( isdefined( level.nuke_timer_ui ) )
    {
        level.nuke_timer_ui.alpha = 1;
        level.nuke_timer_ui fadeovertime( 1.0 );
        level.nuke_timer_ui.alpha = 0;
    }
}

build_objects()
{
    level endon( "nuke_cancelled" );
    
    if( !isdefined( level.nuke_soundobject ) )
    {
        level.nuke_soundobject = spawn( "script_origin", ( 0.0, 0.0, 1.0 ) );
        level.nuke_soundobject hide();
    }

    if( !isdefined( level.nuke_clockobject ) )
    {
        level.nuke_clockobject = spawn( "script_origin", ( 0.0, 0.0, 1.0 ) );
        level.nuke_clockobject hide();
    }
}

do_nuke_tiking()
{
    level endon( "game_ended" );
    level endon( "nuke_cancelled" );
    level endon( "end_nuke_tiking" );
    
    for( ;; )
    {
        if( isdefined( level.nuke_soundobject ) )
        {
            level.nuke_clockobject playsound( "ui_mp_nukebomb_timer" );
        }

        wait 1.0;
    }
}

do_nuke_impact()
{
    level endon( "game_ended" );
    level endon( "nuke_cancelled" );
    
    if( isdefined( level.nuke_soundobject ) )
    {
        level.nuke_soundobject playsound( "nuke_explosion" );
        level.nuke_soundobject playsound( "nuke_wave" );
    }
}

do_nuke_effect( var_0 )
{
    level endon( "game_ended" );
    level endon( "nuke_cancelled" );
    
    var_0 endon( "disconnect" );
    common_scripts\utility::waitframe();
    playfxontagforclients( level._effect["nuke_flash"], self, "tag_origin", var_0 );
}

do_nuke_dust()
{
    level endon( "game_ended" );
    level endon( "nuke_cancelled" );
    
    common_scripts\utility::waitframe();

    foreach ( player in level.players )
    {
        var_2 = anglestoforward( player.angles );
        var_2 = ( var_2[0], var_2[1], 0 );
        var_2 = vectornormalize( var_2 );
        var_4 = spawn( "script_model", player.origin + var_2 * 5000 );
        var_4 setmodel( "tag_origin" );
        var_4.angles = ( 0, player.angles[1] + 180, 90 );
        var_4 thread do_nuke_effect( player );
    }
}

do_nuke_effects()
{
    level endon( "game_ended" );
    level endon( "nuke_cancelled" );
    
    // setslowmotion( 1.0, 0.25, 0.5 );
    //visionsetnaked( "mpnuke", 3 );//cobra_sunset2 in theory to make it more of an erie vibe after the first nuke dropped
}

do_nuke_aftermath_effects()
{
    level endon( "game_ended" );
    level endon( "nuke_cancelled" );
    
    level waittill( "nuke_killed" );

    // setslowmotion( 0.25, 1, 2.0 );

    //visionsetnaked( level.nukevisionset, 5 );
    //visionsetpain( level.nukevisionset );
}

do_nuke_aftermath()
{
    level endon( "game_ended" );
    level endon( "nuke_cancelled" );
    
    level waittill( "spawning_intermission" );
 
    var_0 = getentarray( "mp_global_intermission", "classname" );
    var_0 = var_0[0];
    var_1 = anglestoup( var_0.angles );
    var_2 = anglestoright( var_0.angles );
 
    playfx( level._effect["nuke_aftermath"], var_0.origin, var_1, var_2 );
}

do_nuke_earhtquacke()
{
    level endon( "game_ended" );
    level endon( "nuke_cancelled" );
}

do_money_death()
{
    level endon( "game_ended" );

    fx = SpawnFX( level.money, self.origin );
    TriggerFX( fx );

    wait 2;

    fx delete();
}

do_nuke_kill( user )
{
    level endon( "game_ended" );
    level endon( "nuke_cancelled" );

    level.nukeinfo.player endon( "disconnect" );
    
    level notify( "nuke_killed" );

    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    ambientstop( 1 );

    user.player_settings[ "called_in_moabs" ]++;

    foreach ( player in level.players )
    {
        if ( level.teambased )
        {
            if ( isdefined( level.nukeinfo.team ) && player.team == level.nukeinfo.team )
                continue;
        }
        else if ( isdefined( level.nukeinfo.player ) && player == level.nukeinfo.player )
            continue;

        player.nuked = 1;

        if ( isalive( player ) && !isdefined( self.godmode ) )
        {
            // player thread do_money_death();
            player thread maps\mp\gametypes\_damage::finishplayerdamagewrapper( level.nukeinfo.player, level.nukeinfo.player, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", player.origin, player.origin, "none", 0, 0 );
        }
    }
}

cancle_nuke_ondeath( user )
{
    level endon( "game_ended" );
    level endon( "nuke_killed" );
    level endon( "nuke_cancelled" );

    user common_scripts\utility::waittill_any( "death", "disconnect" );

    if( isdefined( user.nukekiller ) ) 
    {
        iPrintLnBold("^2" + user.name + "^7 M.O.A.B got ^3Cancelled^7 by ^1" + user.nukekiller.name);
        user.nukekiller = undefined;
    }
    else
    {
        iPrintLnBold("^2" + user.name + "^7 M.O.A.B got ^3Cancelled");
    }

    if( isdefined( level.nuke_timer_ui ) )
    {
        level.nuke_timer_ui.alpha = 1;
        level.nuke_timer_ui fadeovertime( 1.0 );
        level.nuke_timer_ui.alpha = 0;
    }
    
    level.nukeincoming = undefined;

    //visionsetnaked( getdvar( "mapname" ), 0.1 );
	//visionsetpain( getdvar( "mapname" ) );
    
    level notify( "nuke_cancelled" );
}

do_nuke( user )
{
    level endon( "game_ended" );
    level endon( "nuke_cancelled" );

    level.nukeincoming = 1;

    thread cancle_nuke_ondeath( user );

    thread do_nuke_ui();
    thread do_nuke_tiking();

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 10 );

    level notify( "end_nuke_tiking" );

    thread hide_nuke_ui();
    thread do_nuke_impact();

    thread do_nuke_dust();

    thread do_nuke_effects();

    thread do_nuke_earhtquacke();
    
    wait 1.5;//Nuke Death

    thread do_nuke_aftermath_effects();

    thread do_nuke_kill( user );

    thread do_nuke_aftermath();

    level.nukeincoming = undefined;
}

tryusenuke( var_0, var_1 )
{
    if ( isdefined( level.nukeincoming ) ||  isdefined( level.civilianjetflyby ) )
    {
        self iprintlnbold( "^1This shit is already going done!" );
        return 0;
    }

    if ( maps\mp\_utility::isusingremote() && ( !isdefined( level.gtnw ) || !level.gtnw ) )
        return 0;
    
    level.nukeinfo.player = self;
    level.nukeinfo.team = self.pers["team"];
    
    self.used_moab = 1;

    thread build_objects();
    thread do_nuke_run( self );
    thread do_nuke( self );
    
    maps\mp\_matchdata::logkillstreakevent( "nuke", self.origin );
    
    return 1;
}
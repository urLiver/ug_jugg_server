/*

    INFO:
        - This File Includes the Functions Replacing certain parts of the Predator Missile / Remote Missile

    TODO:
        - None

    DONE:
        - Maybe add cool fx when missile gets destroyed that way
        
*/

init()
{
    replacefunc( maps\mp\killstreaks\_remotemissile::MissileEyes, ::on_MissileEyes );
}

Player_CleanupOnDeath( rocket ) 
{
    rocket endon( "death" );

    self waittill( "death" );

    if( isdefined( rocket ) )
	{
		rocket playsound( "recondrone_destroyed" );
		playfx( level.remoteuav_fx["explode"], rocket.origin );
        rocket delete();
        rocket notify( "death" );
    }
}

on_MissileEyes( player, rocket )
{
	player endon( "joined_team" );
	player endon( "joined_spectators" );

	rocket thread maps\mp\killstreaks\_remotemissile::Rocket_CleanupOnDeath();
	player thread maps\mp\killstreaks\_remotemissile::Player_CleanupOnGameEnded( rocket );
	player thread maps\mp\killstreaks\_remotemissile::Player_CleanupOnTeamChange( rocket );
    player thread Player_CleanupOnDeath( rocket );

	player VisionSetMissilecamForPlayer( "black_bw", 0 );

	player endon("disconnect");

	if( isDefined( rocket ) )
	{
		player VisionSetMissilecamForPlayer( game[ "thermal_vision" ], 1 );
		player thread maps\mp\killstreaks\_remotemissile::delayedFOFOverlay();
		player CameraLinkTo( rocket, "tag_origin" );
		player ControlsLinkTo( rocket );

		rocket waittill( "death" );

		if( isDefined( rocket ) )
		{
			player maps\mp\_matchdata::logKillstreakEvent( "predator_missile", rocket.origin );
		}

		player ControlsUnlink();
		player maps\mp\_utility::freezeControlsWrapper( true );

		if ( ! level.gameEnded || isDefined( player.finalKill ) )
		{
			player thread maps\mp\killstreaks\_remotemissile::staticEffect( 0.5 );
		}

		wait .05;

		player ThermalVisionFOFOverlayOff();
		player CameraUnlink();
	}

	player maps\mp\_utility::clearUsingRemote();
}
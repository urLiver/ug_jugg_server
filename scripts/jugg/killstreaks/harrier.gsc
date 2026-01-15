/*

    INFO:
        - This File Includes the Functions Replacing certain parts of the Harrier Airstrike

    TODO:
        - None

    DONE:
        - None
        
*/

init() 
{
    replacefunc( maps\mp\killstreaks\_airstrike::tryUseAirstrike, ::on_tryUseAirstrike );
    replacefunc( maps\mp\killstreaks\_airstrike::selectAirstrikeLocation, ::on_selectAirstrikeLocation );
    replacefunc( maps\mp\killstreaks\_airstrike::doAirstrike, ::on_doAirstrike );
    replacefunc( maps\mp\killstreaks\_harrier::harrierDestroyed, ::on_harrierDestroyed );
    replacefunc( maps\mp\killstreaks\_harrier::backToDefendLocation, ::on_backToDefendLocation );
    replacefunc( maps\mp\killstreaks\_harrier::harrierTimer, ::on_harrierTimer );
}

on_tryUseAirstrike( lifeId, streakName )
{
    if ( ! maps\mp\_utility::validateusestreak() )
	{
        return 0;
	}

	if ( isDefined( level.civilianJetFlyBy ) )
	{
		self iPrintLnBold( &"MP_CIVILIAN_AIR_TRAFFIC" );
		return false;
	}

    if ( maps\mp\_utility::isusingremote() )
	{
        return 0;
	}

	switch( streakName )
	{
		case "precision_airstrike":
			break;
		case "stealth_airstrike":
			break;
		case "harrier_airstrike":
			if ( level.airstrike_planes > 1 )
			{
				self iPrintLnBold( &"MP_AIR_SPACE_TOO_CROWDED" );
				return false;	
			}
			break;
		case "super_airstrike":
			break;
	}
	
	result = self maps\mp\killstreaks\_airstrike::selectAirstrikeLocation( lifeId, streakName );
	if ( ! isDefined( result ) || ! result )
	{
		return false;
	}

	return true;
}

on_selectAirstrikeLocation( lifeId, streakname )
{
	targetSize = level.mapSize / 6.46875;
	if ( level.splitscreen )
	{
		targetSize *= 1.5;
	}

	chooseDirection = false;
	switch( streakName )
	{
		case "precision_airstrike":
			chooseDirection = true;
			self PlayLocalSound( game[ "voice" ][ self.team ] + "KS_hqr_airstrike" );
			break;
		case "stealth_airstrike":
			chooseDirection = true;
			self PlayLocalSound( game[ "voice" ][ self.team ] + "KS_hqr_bomber" );
			break;
	}

	self maps\mp\_utility::_beginLocationSelection( streakname, "map_artillery_selector", chooseDirection, targetSize );

	self endon( "stop_location_selection" );
	
	self waittill( "confirm_location", location, directionYaw );
	if ( ! chooseDirection )
	{
		directionYaw = randomint( 360 );
	}

	self setblurforplayer( 0, 0.3 );

	if ( streakname == "harrier_airstrike" && level.airstrike_planes > 1 )
	{
		self notify ( "cancel_location" );
		self iPrintLnBold( &"MP_AIR_SPACE_TOO_CROWDED" );
		return false;	
	}

	self thread maps\mp\killstreaks\_airstrike::airstrikeMadeSelectionVO( streakName );
	self maps\mp\_matchdata::logKillstreakEvent( streakName, location );	
	self thread maps\mp\killstreaks\_airstrike::finishAirstrikeUsage( lifeId, location, directionYaw, streakName );
	
	return true;
}

on_doAirstrike( lifeId, origin, yaw, owner, team, streakName )
{	
	assert( isDefined( origin ) );
	assert( isDefined( yaw ) );

	if ( streakName == "harrier_airstrike" )
	{
		level.airstrike_planes++;
	}

	if ( isDefined( level.airstrikeInProgress ) )
	{
		while ( isDefined( level.airstrikeInProgress ) )
		{
			level waittill ( "begin_airstrike" );
		}

		level.airstrikeInProgress = true;

		wait ( 2.0 );
	}

	if ( ! isDefined( owner ) )
	{
		if ( streakName == "harrier_airstrike" )
		{
			level.airstrike_planes--;
		}

		return;
	}

	level.airstrikeInProgress = true;
	
	trace = bullettrace(origin, origin + (0,0,-1000000), false, undefined);
	targetpos = trace[ "position" ];
	
	dangerCenter = spawnstruct();
	dangerCenter.origin = targetpos;
	dangerCenter.forward = anglesToForward( (0,yaw,0) );
	dangerCenter.streakName = streakName;

	level.artilleryDangerCenters[ level.artilleryDangerCenters.size ] = dangerCenter;
	
	harrierEnt = maps\mp\killstreaks\_airstrike::callStrike( lifeId, owner, targetpos, yaw, streakName );
	
	wait( 1.0 );
	level.airstrikeInProgress = undefined;
	owner notify ( "begin_airstrike" );
	level notify ( "begin_airstrike" );
	
	wait 7.5;

	found = false;
	newarray = [];
	for ( i = 0; i < level.artilleryDangerCenters.size; i++ )
	{
		if ( ! found && level.artilleryDangerCenters[i].origin == targetpos )
		{
			found = true;
			continue;
		}
		
		newarray[ newarray.size ] = level.artilleryDangerCenters[i];
	}

	assert( found );
	assert( newarray.size == level.artilleryDangerCenters.size - 1 );
	level.artilleryDangerCenters = newarray;
	
	if ( streakName != "harrier_airstrike" )
	{
		return;
	}

	while ( isDefined( harrierEnt ) )
	{
		wait ( 0.1 );
	}

	level.airstrike_planes--;
}

on_harrierDestroyed()
{
	self endon( "harrier_gone" );
	
	self waittill( "death" );
	
	if ( ! isDefined( self ) )
	{
		return;
	}

	self maps\mp\killstreaks\_helicopter::heli_crash( true );
}

on_backToDefendLocation( forced )
{
	self.defendloc = self.owner.origin + ( randomintrange( -100, 100 ), randomintrange( -100, 100 ), 2000 );
	self setVehGoalPos( self.defendloc, 1 );
	
	if ( isDefined( forced ) && forced )
	{
		self waittill ( "goal" );
	}
}

on_harrierTimer()
{
	self endon( "death" );

	level.harrier_time = 45;

	time = level.harrier_time * 20;

	while( time > 0 && self.owner.team == self.team ) 
	{
		wait 0.05;
		time--;
	}

	self maps\mp\killstreaks\_harrier::harrierLeave();
}

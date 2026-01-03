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
    replacefunc(maps\mp\killstreaks\_airstrike::tryUseAirstrike, ::tryUseAirstrike_replace);
    replacefunc(maps\mp\killstreaks\_airstrike::selectAirstrikeLocation, ::selectAirstrikeLocation_replace);
    replacefunc(maps\mp\killstreaks\_airstrike::doAirstrike, ::doAirstrike_replace);
    replacefunc(maps\mp\killstreaks\_harrier::harrierDestroyed, ::harrierDestroyed_replace);
    replacefunc(maps\mp\killstreaks\_harrier::backToDefendLocation, ::backToDefendLocation_replace);
    replacefunc(maps\mp\killstreaks\_harrier::harrierTimer, ::harrierTimer_replace);
}

tryUseAirstrike_replace( lifeId, streakName )
{
    if ( !maps\mp\_utility::validateusestreak() )
        return 0;
	
	if ( isDefined( level.civilianJetFlyBy ) )
	{
		self iPrintLnBold( &"MP_CIVILIAN_AIR_TRAFFIC" );
		return false;
	}

    if ( maps\mp\_utility::isusingremote() )
        return 0;

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
	
	result = self selectAirstrikeLocation_replace( lifeId, streakName );

	if ( !isDefined( result ) || !result )
		return false;
	
	return true;
}

selectAirstrikeLocation_replace( lifeId, streakname )
{
	targetSize = level.mapSize / 6.46875; // 138 in 720
	if ( level.splitscreen )
		targetSize *= 1.5;
	
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
	
	// wait for the selection. randomize the yaw if we're not doing a precision airstrike.
	self waittill( "confirm_location", location, directionYaw );
	if ( !chooseDirection )
		directionYaw = randomint(360);

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

doAirstrike_replace( lifeId, origin, yaw, owner, team, streakName )
{	
	assert( isDefined( origin ) );
	assert( isDefined( yaw ) );

	if ( streakName == "harrier_airstrike" )
		level.airstrike_planes++;
	
	if ( isDefined( level.airstrikeInProgress ) )
	{
		while ( isDefined( level.airstrikeInProgress ) )
			level waittill ( "begin_airstrike" );

		level.airstrikeInProgress = true;
		wait ( 2.0 );
	}

	if ( !isDefined( owner ) )
	{
		if ( streakName == "harrier_airstrike" )
			level.airstrike_planes--;
			
		return;
	}

	level.airstrikeInProgress = true;
	
	num = 17 + randomint(3);
	trace = bullettrace(origin, origin + (0,0,-1000000), false, undefined);
	targetpos = trace["position"];
	
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
		if ( !found && level.artilleryDangerCenters[i].origin == targetpos )
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
		return;

	while ( isDefined( harrierEnt ) )
		wait ( 0.1 );
		
	level.airstrike_planes--;
}

harrierDestroyed_replace()
{
	self endon( "harrier_gone" );
	
	self waittill( "death" );
	
	if (! isDefined(self) )
		return;

	self scripts\jugg\maps\objects::heli_crash_replace(true);
}

backToDefendLocation_replace( forced )
{
	self.defendloc = self.owner.origin + (randomintrange(-100, 100),randomintrange(-100, 100),2000);
	self setVehGoalPos( self.defendloc, 1 );
	
	if ( isDefined( forced ) && forced )
		self waittill ( "goal" );
}

harrierTimer_replace()
{
	self endon( "death" );
	level.harrier_time = 45;
	time = level.harrier_time * 20;
	while(time > 0 && self.owner.team == self.team) {
		wait 0.05;
		time--;
	}
	self maps\mp\killstreaks\_harrier::harrierLeave();
}

strike_run() {
    self maps\mp\_utility::_giveWeapon("uav_strike_marker_mp");
	self switchToWeapon( "uav_strike_marker_mp" );

	traceData = undefined;
	for(;;)
	{
		self waittill( "weapon_fired", weapname );
		
		if(weapname != "uav_strike_marker_mp")
            continue;

	 	origin = self GetEye();
        angle = self GetPlayerAngles();
		forward = AnglesToForward( angle );
		endpoint = origin + forward * 15000;
		
		traceData = BulletTrace( origin, endpoint, true, self );		
		if ( isDefined(traceData["position"]) )
			break;
	}

	self notify( "uav_strike_used" );
		
	targetPosition = traceData["position"];		

	fxEnt = SpawnFx( level._effect[ "laserTarget" ], targetPosition);
	TriggerFx( fxEnt );
	fxEnt thread waitFxEntDie(4);

    a10 = spawnA10(self, targetPosition, angle);
    a10 thread start_moving();
	a10 thread wait_to_shoot();

	self takeWeapon( "uav_strike_marker_mp" );
	self switchToWeapon( self.last_weapon );
}

waitFxEntDie(time)
{
	wait( time );
	self delete();
}

start_moving() {
    max_speed = 3000;
    distance = 500;
    time_distance = distance/max_speed;
    iprintlnbold("^1"+time_distance);
    for(;;) {
        moveto_pos = self.origin + AnglesToForward(self.angles) * distance;
        self MoveTo(moveto_pos, time_distance);
        wait 0.05;
    }
}

wait_to_shoot(){

    while(Distance(self.origin, self.targetposition) > 9000)
        wait 0.05;

    self thread angle_to_endpos(1.2);
	shots = 0;
    while(Distance(self.origin, self.targetposition) <= 9000){
        pos = self GetTagOrigin("tag_gun");
        startpos = pos + AnglesToForward(self.angles) * 300;
		ang = self.angles + (randomintrange(-2,2),randomintrange(-2,2),0);
        endpos = pos + AnglesToForward(ang) * 1000;
        MagicBullet("ac130_40mm_mp", startpos, endpos, self.owner);
		shots++;
		print(shots);
		if(shots > 35)
			break;
        wait 0.1;
    }
}

angle_to_endpos(delay) {
	clamp_ending = self.ending_angle[0] * -1;
	print("^1"+self.ending_angle[0] * -1);
	print("^3"+self.ending_angle[0]);
    wait(delay);

    for(;;) {
        forward = anglestoforward(self.angles+(-1,0,0));
        check_pos = self.origin + forward * 800;
        self.angles = vectortoangles(check_pos - self.origin);
		clamp_self = AngleClamp180( self.angles[0]);
       
	    wait 0.05;

        if(clamp_self < clamp_ending)
            break;
    }
} 

spawnA10( owner, targetPosition, angle)
{
	start_pitch = 35;
	ending_pitch = 20;

	start_angle_fix = (start_pitch,angle[1], 0);
	ending_angle_fix = (ending_pitch,angle[1], 0);

	start_forward = AnglesToForward( start_angle_fix );
	ending_forward = AnglesToForward( ending_angle_fix );
	

    start_point = (targetPosition + start_forward * -17000);


	a10 = Spawn( "script_model", start_point );

    owner setorigin(start_point);

	a10 SetModel( "vehicle_a10_warthog" );
	a10.health = 999999; 
	a10.maxhealth = 2500;
	a10.damageTaken = 0;
	a10.owner = owner;
	a10.team = owner.team;
	a10.killCount = 0;
	a10.start_point = start_point;
	a10.targetposition = targetPosition;
    a10.ending_angle = ending_angle_fix;
	a10.angles = start_angle_fix;	

	return a10;
}

guardian( )
{
	if(!isalive(self))
		return;

	guardian = self create_guardian();
	
	//	returning from this streak activation seems to strip this?
	//	manually removing and restoring
	//self removePerks();		
	
	result = self setCarryingguardian(guardian);
	
	//self thread waitRestorePerks();
	
	// we're done carrying for sure and sometimes this might not get reset
	// this fixes a bug where you could be carrying and have it in a place where it won't plant, get killed, now you can't scroll through killstreaks
	self.isCarrying = false;

	//guardian sentry_setOwner( owner );
	// guardian thread sentry_handleDamage();
	// guardian thread sentry_handleDeath();
	// guardian thread sentry_timeOut();

	// if we failed to place the sentry, it will have been deleted at this point
	if ( IsDefined( guardian ) )
		return true;
	else
		return false;
}

create_guardian() {
	guardian = spawn( "script_model", self.origin );
	if(!isdefined(guardian))
		print("^1GUARDIAN NOT DEFINED");

	guardian setmodel(level.guardian_settings.basemodel);
	guardian.health = 999999; 
	guardian.maxhealth = 500;
	guardian.damageTaken = 0;
	guardian.owner = self;
	guardian.team = self.team;
	guardian.killCount = 0;
	guardian.angles = (0,self.angles[1],0);
	
	return guardian;
}

setCarryingguardian(guardian)
{
	self endon ( "death" );
	self endon ( "disconnect" );

	
	guardian guardian_setCarried( self );
	
	self common_scripts\utility::_disableWeapon();

	self notifyOnPlayerCommand( "place", "+attack" );
	self notifyOnPlayerCommand( "place", "+attack_akimbo_accessible" ); // support accessibility control scheme
	
	for ( ;; )
	{
		result = common_scripts\utility::waittill_any_return( "place");

		if ( !guardian.canBePlaced )
			continue;
			
		guardian guardian_setPlaced();
		self common_scripts\utility::_enableWeapon();		
		return true;
	}
}

guardian_setCarried( carrier )
{
	assert( isPlayer( carrier ) );

	assertEx( carrier == self.owner, "guardian_setCarried() specified carrier does not own this sentry" );

	self setModel( level.guardian_settings.modelPlacement );

	self setCanDamage( false );

	self.carriedBy = carrier;
	carrier.isCarrying = true;

	carrier thread updateguardianplacement( self );
	
	self thread guardian_onCarrierChecks( carrier );


	//self sentry_setInactive();
	
	self notify ( "carried" );
}

guardian_setPlaced()
{
	self setModel( level.guardian_settings.modelBase );

	self setCanDamage( true );
	
	//	JDS TODO: - turret aligns to ground normal which the player will align to when they mount the turret
	//						- temp fix to keep up vertical

	self.angles = self.carriedBy.angles;
		// show the pickup message
	if( IsAlive( self.owner ) )
		self.owner maps\mp\_utility::setLowerMessage( "pickup_hint", level.guardian_settings.hintString, 3.0, undefined, undefined, undefined, undefined, undefined, true );
		// spawn a trigger so we know if the owner is within range to pick it up
		self.ownerTrigger = Spawn( "trigger_radius", self.origin + ( 0, 0, 1 ), 0, 105, 64 );
		assert( IsDefined( self.ownerTrigger ) );
			self.owner thread guardian_handlePickup( self );

	

	self.carriedBy forceUseHintOff();
	self.carriedBy = undefined;

	self.owner.isCarrying = false;

	//self sentry_setActive();

	self playSound( "sentry_gun_plant" );

	self notify ( "placed" );
}

guardian_handlePickup( guardian ) // self == owner (player)
{
	self endon( "disconnect" );
	level endon( "game_ended" );
	guardian endon( "death" );

	if( !IsDefined( guardian.ownerTrigger ) )
		return;

	buttonTime = 0;
	for ( ;; )
	{
		if( IsAlive( self ) && 
			self IsTouching( guardian.ownerTrigger ) && 
			!IsDefined( guardian.inUseBy ) && 
			!IsDefined( guardian.carriedBy ) &&
			self IsOnGround() )
		{
			if ( self UseButtonPressed() )
			{
				if( IsDefined( self.using_remote_turret ) && self.using_remote_turret )
					continue;

				buttonTime = 0;
				while ( self UseButtonPressed() )
				{
					buttonTime += 0.05;
					wait( 0.05 );
				}

				println( "pressTime1: " + buttonTime );
				if ( buttonTime >= 0.5 )
					continue;

				buttonTime = 0;
				while ( !self UseButtonPressed() && buttonTime < 0.5 )
				{
					buttonTime += 0.05;
					wait( 0.05 );
				}

				println( "delayTime: " + buttonTime );
				if ( buttonTime >= 0.5 )
					continue;

				if ( !maps\mp\_utility::isreallyalive( self ) )
					continue;

				if( IsDefined( self.using_remote_turret ) && self.using_remote_turret )
					continue;

				//disable here
				//turret setMode( level.sentrySettings[ turret.sentryType ].sentryModeOff );
				self thread setCarryingguardian( guardian, false );
				guardian.ownerTrigger delete();
				return;
			}
		}
		wait( 0.05 );
	}
}

guardian_onCarrierChecks( carrier )
{
	self endon ( "placed" );
	self endon ( "death" );

	self thread guardian_onGameEnded(carrier);

	yeet = carrier common_scripts\utility::waittill_any_return( "death","disconnect","joined_team","joined_spectators" );
	
	if(yeet == "death") {
		if ( self.canBePlaced )
			self guardian_setPlaced();
		else
			self delete();
	} else {
		self delete();
	}
}

guardian_onGameEnded( carrier )
{
	self endon ( "placed" );
	self endon ( "death" );

	level waittill ( "game_ended" );
	
	self delete();
}

updateguardianplacement( guardian ) {
	self endon ( "death" );
	self endon ( "disconnect" );
	level endon ( "game_ended" );

	guardian endon ( "placed" );
	guardian endon ( "death" );

	guardian.canBePlaced = 1;
	lastCanPlaceSentry = -1;

	for(;;) {
        placement = self canPlayerPlaceSentry();

        forang = anglestoforward(self getplayerangles());
        position = self.origin + forang * 55;
        trace = bullettrace(position + (0,0,50), position - (0,0,30), 0, self);
        traceer = bullettracepassed(self.origin + (0,0,40), position + (0,0,40), 0, self);

		guardian.origin = placement[ "origin" ];
		guardian.angles = placement[ "angles" ];
		guardian.canBePlaced = self isOnGround()  && ( abs(guardian.origin[2]-self.origin[2]) < 10 ) && placement[ "result" ] && traceer || trace["fraction"] < 1 && traceer;

		if(guardian.canBePlaced != lastCanPlaceSentry) {
			if (guardian.canBePlaced) {
				guardian setModel( level.guardian_settings.modelPlacement);
				self ForceUseHintOn( &"SENTRY_PLACE" );
			}
			else {
				guardian setModel(level.guardian_settings.modelPlacementFailed);
				self ForceUseHintOn( &"SENTRY_CANNOT_PLACE" );
			}
		}

		lastCanPlaceSentry = guardian.canBePlaced;
		wait .05;
	}
}
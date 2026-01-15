/*

    INFO:
        

*/

init()
{
	replacefunc( maps\mp\killstreaks\_helicopter::heli_explode, ::on_heli_explode );
    replacefunc( maps\mp\killstreaks\_helicopter::heli_crash, ::on_heli_crash );
    replacefunc( maps\mp\killstreaks\_helicopter::heli_think, ::on_heli_think );
	replacefunc( maps\mp\killstreaks\_helicopter::heli_fly_well, ::on_heli_fly_well );
    replacefunc( maps\mp\killstreaks\_helicopter::heli_fly_loop_path, ::on_heli_fly_loop_path );
    replacefunc( maps\mp\killstreaks\_helicopter::heli_health, ::on_heli_health );
}

on_heli_explode( altStyle, harrier )
{
	self notify( "death" );
    self.heli_explode_death = 1;
	
	if ( isDefined( altStyle ) && isDefined( level.chopper_fx[ "explode" ][ "air_death" ][ self.heli_type ] ) ) 
    {
		deathAngles = self getTagAngles( "tag_deathfx" );

        self RadiusDamage( self.origin + ( 0, 0, 10 ), 350, 500, 1, self );
	
    	if( isDefined( harrier ) ) 
        {
			deathAngles = self getTagAngles( "tag_deathfx" );		
			playFx( level.harrier_deathfx, self getTagOrigin( "tag_deathfx" ), anglesToForward( deathAngles ), anglesToUp( deathAngles ) );
		} 
        else
        {
			playFx( level.chopper_fx[ "explode" ][ "air_death" ][ self.heli_type ], self getTagOrigin( "tag_deathfx" ), anglesToForward( deathAngles ), anglesToUp( deathAngles ) );
        }
	}
	else 
    {
		org = self.origin;	
		forward = ( self.origin + ( 0, 0, 1 ) ) - self.origin;
	
    	if( isDefined( harrier ) ) 
        {
			deathAngles = self getTagAngles( "tag_deathfx" );		
			playFx( level.harrier_deathfx, self getTagOrigin( "tag_deathfx" ), anglesToForward( deathAngles ), anglesToUp( deathAngles ) );
		} 
        else
        {
    		playFx( level.chopper_fx[ "explode" ][ "death" ][ self.heli_type ], org, forward );
        }
    
        self RadiusDamage( self.origin + ( 0, 0, 10 ), 350, 500, 1, self );
	}

	if( isDefined( harrier ) ) 
    {
		self playSound( "harrier_jet_crash" );
	}
    else
    {
		self playSound( level.heli_sound[ self.team ][ "crash" ] );
    }

	wait ( 0.05 );
	
	if( IsDefined( self.killCamEnt ) )
    {
		self.killCamEnt delete();
    }

	if( ! isDefined( harrier ) ) 
    {
		maps\mp\_utility::decrementFauxVehicleCount();
	}
	else 
    {
		level.airPlane[ level.airPlane.size - 1 ] = undefined; 
		
        self notify( "explode" );
		
        wait 0.05;
	}
	
	self delete();
}

crashed_into_wall( position ) 
{
    self endon ( "death" );
	self endon ( "leaving" );
    self endon ( "near_goal" );

    for( ;; ) 
    {
        ang = anglestoforward( VectortoAngles( position - self.origin ) );
        trace = BulletTrace( self.origin, self.origin + ang * 300, 0, self, 1, 1, self.attractor );

        if( isdefined( trace[ "fraction" ] ) && trace[ "fraction" ] < 0.9 ) 
        {
            self notify( "died_fly_wall" );

            return;
        }

        wait 0.1;
    }
}

heli_fly_simple_path( dying )
{
	self endon ( "death" );
	self endon ( "leaving" );

	self notify( "flying");
	self endon( "flying" );

	maps\mp\killstreaks\_helicopter::heli_reset();

	if( ! isdefined( dying ) )
    {
		dying = false;
    }

    position = undefined;

    if( ! dying ) 
    {
        position = self.owner.origin + ( randomintrange( -2400, 2400 ), randomintrange( -2400, 2400 ), randomintrange( 2500, 2900 ) );

        self setVehGoalPos( position, true );
		self waittill( "near_goal" );
    } 
    else 
    {
        endpos = undefined;
        trace = undefined;

        self Vehicle_SetSpeed( 50, 10, 60);
        self setneargoalnotifydist( 135 );

        for( i = 0; i < 4; i++ ) 
        {
            rndpos = self.owner.origin + ( randomintrange( -1600, 1600 ), randomintrange( -1600, 1600 ), 2000 );
            trace = BulletTrace( rndpos, rndpos + ( 0, 0, -4000 ), 1, self, 1, 1 );

            if( isdefined( trace[ "position" ] ) && isdefined( trace[ "fraction" ] ) && trace[ "fraction" ] < 1 ) 
            {
                position = trace[ "position" ];
                break;
            }
        }
        
        if( ! isdefined( position ) )
        {
            position = level.players[ randomint( level.players.size ) ].origin;
        }

        self setVehGoalPos( position, true );
        self thread crashed_into_wall( position );
		self common_scripts\utility::waittill_any( "near_goal", "died_fly_wall" );
    }
}

on_heli_crash( harrier )
{
	self notify( "crashing" );

	self thread maps\mp\killstreaks\_helicopter::heli_spin( 1028 );
	self thread maps\mp\killstreaks\_helicopter::heli_secondary_explosions();

	self heli_fly_simple_path( true );
	
	self thread maps\mp\killstreaks\_helicopter::heli_explode( undefined, harrier );
}

stock_helicopter_logic( lifeId, owner, startNode, heli_team, heliType ) 
{
    heliOrigin = startNode.origin;
	heliAngles = startNode.angles;

	switch( heliType )
	{
		case "minigun":
			vehicleType = "cobra_minigun_mp";

			if ( owner.team == "allies" )
            {
				vehicleModel = "vehicle_apache_mp";
            }
			else
            {
				vehicleModel = "vehicle_mi-28_mp";
            }

			break;
		case "flares":
			vehicleType = "pavelow_mp";

			if ( owner.team == "allies" )
            {
				vehicleModel = "vehicle_pavelow";
            }
			else
            {
				vehicleModel = "vehicle_pavelow_opfor";
            }

			break;
		default:
			vehicleType = "cobra_mp";

			if ( owner.team == "allies" )
            {
				vehicleModel = "vehicle_cobra_helicopter_fly_low";
            }
			else
            {
				vehicleModel = "vehicle_mi24p_hind_mp";
            }

			break;		
	}

	chopper = maps\mp\killstreaks\_helicopter::spawn_helicopter( owner, heliOrigin, heliAngles, vehicleType, vehicleModel );

	if ( ! isDefined( chopper ) )
    {
		return;
    }

	level.chopper = chopper;
	chopper.heliType = heliType;
	chopper.lifeId = lifeId;
	chopper.team = heli_team;
	chopper.pers[ "team" ] = heli_team;	
	chopper.owner = owner;

	if ( heliType == "flares" )
    {
		chopper.maxhealth = 2500;
    }
	else
    {
		chopper.maxhealth = 1500;
    }

	chopper.targeting_delay = level.heli_targeting_delay;
	chopper.primaryTarget = undefined;
	chopper.secondaryTarget = undefined;
	chopper.attacker = undefined;
	chopper.currentstate = "ok";
	
	chopper.empGrenaded = false;

	if ( heliType == "flares" || heliType == "minigun" )
    {
		chopper thread maps\mp\killstreaks\_helicopter::heli_flares_monitor();
    }

	chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_disconnect( owner );
	chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_changeTeams( owner );
	chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_gameended( owner );
	chopper thread maps\mp\killstreaks\_helicopter::heli_damage_monitor();
	chopper thread maps\mp\killstreaks\_helicopter::heli_health();
	chopper thread maps\mp\killstreaks\_helicopter::heli_existance();

	chopper endon ( "helicopter_done" );
	chopper endon ( "crashing" );
	chopper endon ( "leaving" );
	chopper endon ( "death" );

	if ( heliType == "minigun" )
	{
		owner thread maps\mp\killstreaks\_helicopter::heliRide( lifeId, chopper );
		chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_spawned( owner );
	}

	attackAreas = getEntArray( "heli_attack_area", "targetname" );
	loopNode = level.heli_loop_nodes[ randomInt( level.heli_loop_nodes.size ) ];	

	switch ( heliType )
	{
		case "minigun":
			chopper thread maps\mp\killstreaks\_helicopter::heli_targeting();
			chopper maps\mp\killstreaks\_helicopter::heli_fly_simple_path( startNode );
			chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_timeout( 40.0 );

			if ( attackAreas.size )
            {
				chopper thread maps\mp\killstreaks\_helicopter::heli_fly_well( attackAreas );
            }
			else
            {
				chopper thread maps\mp\killstreaks\_helicopter::heli_fly_loop_path( loopNode );
            }

			break;
		case "flares":
			chopper thread maps\mp\killstreaks\_helicopter::makeGunShip();

			thread maps\mp\_utility::teamPlayerCardSplash( "used_helicopter_flares", owner );

			chopper maps\mp\killstreaks\_helicopter::heli_fly_simple_path( startNode );
			chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_timeout( 60.0 );
			chopper thread maps\mp\killstreaks\_helicopter::heli_fly_loop_path( loopNode );

			break;
		default:
			chopper thread maps\mp\killstreaks\_helicopter::attack_targets();
			chopper thread maps\mp\killstreaks\_helicopter::heli_targeting();
			chopper maps\mp\killstreaks\_helicopter::heli_fly_simple_path( startNode );
			chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_timeout( 60.0 );
			chopper thread maps\mp\killstreaks\_helicopter::heli_fly_loop_path( loopNode );

			break;
	}
}

custom_helicopter_logic( lifeId, owner, startNode, heli_team, heliType ) 
{
    org = AnglesToForward( ( 0, randomintrange( -180, 180 ), 0 ) );
    heliOrigin = self.origin + ( org[ 0 ] * 8000, org[ 1 ] * 8000, 5700 );
    ang = VectortoAngles( self.origin - startNode.origin );
    heliAngles = ( 0, ang[ 1 ], 0 );

	switch( heliType )
	{
		case "minigun":
			vehicleType = "cobra_minigun_mp";

			if ( owner.team == "allies" )
            {
				vehicleModel = "vehicle_apache_mp";
            }
			else
            {
				vehicleModel = "vehicle_mi-28_mp";
            }

            break;
		case "flares":
			vehicleType = "pavelow_mp";

			if ( owner.team == "allies" )
            {
				vehicleModel = "vehicle_pavelow";
            }
			else
            {
				vehicleModel = "vehicle_pavelow_opfor";
            }

			break;
		default:
			vehicleType = "cobra_mp";

			if ( owner.team == "allies" )
            {
				vehicleModel = "vehicle_cobra_helicopter_fly_low";
            }
			else
            {
				vehicleModel = "vehicle_mi24p_hind_mp";
            }

			break;		
	}

	chopper = maps\mp\killstreaks\_helicopter::spawn_helicopter( owner, heliOrigin, heliAngles, vehicleType, vehicleModel );

	if ( ! isDefined( chopper ) )
    {
		return;
    }

	level.chopper = chopper;
	chopper.heliType = heliType;
	chopper.lifeId = lifeId;
	chopper.team = heli_team;
	chopper.pers[ "team" ] = heli_team;	
	chopper.owner = owner;

	if ( heliType == "flares" )
    {
		chopper.maxhealth = level.heli_maxhealth * 2;
    }
	else
    {
		chopper.maxhealth = level.heli_maxhealth;
    }

	chopper.targeting_delay = level.heli_targeting_delay;
	chopper.primaryTarget = undefined;
	chopper.secondaryTarget = undefined;
	chopper.attacker = undefined;
	chopper.currentstate = "ok";
	
	chopper.empGrenaded = false;

	if ( heliType == "flares" || heliType == "minigun" )
    {
		chopper thread maps\mp\killstreaks\_helicopter::heli_flares_monitor();
    }

	chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_disconnect( owner );
	chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_changeTeams( owner );
	chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_gameended( owner );
	chopper thread maps\mp\killstreaks\_helicopter::heli_damage_monitor();
	chopper thread maps\mp\killstreaks\_helicopter::heli_health();
	chopper thread maps\mp\killstreaks\_helicopter::heli_existance();

	chopper endon ( "helicopter_done" );
	chopper endon ( "crashing" );
	chopper endon ( "leaving" );
	chopper endon ( "death" );

	if ( heliType == "minigun" )
	{
		owner thread maps\mp\killstreaks\_helicopter::heliRide( lifeId, chopper );
		chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_spawned( owner );
	}

	switch ( heliType )
	{
		case "minigun":
			chopper thread maps\mp\killstreaks\_helicopter::heli_targeting();
			chopper heli_fly_simple_path();
			chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_timeout( 40.0 );
			chopper thread heli_fly_loop_path_custom();

			break;
		case "flares":
			chopper thread maps\mp\killstreaks\_helicopter::makeGunShip();

			thread maps\mp\_utility::teamPlayerCardSplash( "used_helicopter_flares", owner );

			chopper heli_fly_simple_path();
			chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_timeout( 60.0 );
			chopper thread heli_fly_loop_path_custom();

			break;
		default:
			chopper thread maps\mp\killstreaks\_helicopter::attack_targets();
			chopper thread maps\mp\killstreaks\_helicopter::heli_targeting();
			chopper heli_fly_simple_path();
			chopper thread maps\mp\killstreaks\_helicopter::heli_leave_on_timeout( 60.0 );
			chopper thread heli_fly_loop_path_custom();

			break;
	}
}

on_heli_think( lifeId, owner, startNode, heli_team, heliType )
{   
    if( isdefined( level.use_stock_helicopter_system ) )
    {
        self thread stock_helicopter_logic( lifeId, owner, startNode, heli_team, heliType );
    }
    else
    {
        self thread custom_helicopter_logic( lifeId, owner, startNode, heli_team, heliType );
    }
}

heli_fly_loop_path_custom(  )
{
	self endon ( "death" );
	self endon ( "crashing" );
	self endon ( "leaving" );

	self notify( "flying" );
	self endon( "flying" );
	
	maps\mp\killstreaks\_helicopter::heli_reset();
	position = undefined;
    rndpos = undefined;
	while ( 1 )
	{
        for( i = 0; i < 8; i++ ) 
        {
            for( ;; ) 
            {
                rndpos = self.owner.origin + ( randomintrange( -2400, 2400 ), randomintrange( -2400, 2400 ), randomintrange( 2500, 2900 ) );
                
                if( Distance2D( rndpos, self.owner.origin ) > 800 )
                {
                    break;
                }
            }

            if( SightTracePassed( rndpos, self.owner.origin, false, self ) ) 
            {
                position = rndpos;
            
                break;
            }
        }

        if( ! isdefined( position ) )
        {
            position = self.owner.origin + ( randomintrange( -2400, 2400 ), randomintrange( -2400, 2400 ), randomintrange( 2500, 2900 ) );
        }

		self setVehGoalPos( position, true );
		self waittill( "near_goal" );

        rnd = randomintrange( 0, 30 ) / 10;

        if( rnd != 0 )
        {
		    wait( rnd );
        }
	}
}

on_heli_fly_well( destNodes )
{
	if( ! isdefined( level.use_stock_helicopter_system ) ) 
    {
		level heli_fly_loop_path_custom( destNodes );
		return;
	}

	self notify( "flying");
	self endon( "flying" );

	self endon ( "death" );
	self endon ( "crashing" );
	self endon ( "leaving" );

	for ( ;; )	
	{
		currentNode = self maps\mp\killstreaks\_helicopter::get_best_area_attack_node( destNodes );
	
		maps\mp\killstreaks\_helicopter::travelToNode( currentNode );
		
		if( isdefined( currentNode.script_airspeed ) && isdefined( currentNode.script_accel ) )
		{
			heli_speed = currentNode.script_airspeed;
			heli_accel = currentNode.script_accel;
		}
		else
		{
			heli_speed = 30 + randomInt( 20 );
			heli_accel = 15 + randomInt( 15 );
		}
		
		self Vehicle_SetSpeed( heli_speed, heli_accel );	
		self setvehgoalpos( currentNode.origin + self.zOffset, 1 );
		self setgoalyaw( currentNode.angles[ 1 ] + level.heli_angle_offset );	

		if ( level.heli_forced_wait != 0 )
		{
			self waittill( "near_goal" );
			wait ( level.heli_forced_wait );			
		}
		else if ( ! isdefined( currentNode.script_delay ) )
		{
			self waittill( "near_goal" );

			wait ( 5 + randomInt( 5 ) );
		}
		else
		{				
			self waittillmatch( "goal" );				
			
            wait ( currentNode.script_delay );
		}
	}
}

on_heli_fly_loop_path( startNode )
{
	if( ! isdefined( level.use_stock_helicopter_system ) ) 
    {
		level heli_fly_loop_path_custom( startNode );
	
    	return;
	}

	self endon ( "death" );
	self endon ( "crashing" );
	self endon ( "leaving" );

	self notify( "flying");
	self endon( "flying" );
	
	maps\mp\killstreaks\_helicopter::heli_reset();
	
	self thread maps\mp\killstreaks\_helicopter::heli_loop_speed_control( startNode );
	
	currentNode = startNode;
	while ( isDefined( currentNode.target ) )
	{
		nextNode = getEnt( currentNode.target, "targetname" );
		assertEx( isDefined( nextNode ), "Next node in path is undefined, but has targetname. Bad Node Position: " + currentNode.origin );
		
		if( isDefined( currentNode.script_airspeed ) && isDefined( currentNode.script_accel ) )
		{
			self.desired_speed = currentNode.script_airspeed;
			self.desired_accel = currentNode.script_accel;
		}
		else
		{
			self.desired_speed = 30 + randomInt( 20 );
			self.desired_accel = 15 + randomInt( 15 );
		}
		
		if ( self.heliType == "flares" )
		{
			self.desired_speed *= 0.5;
			self.desired_accel *= 0.5;
		}
		
		if ( isDefined( nextNode.script_delay ) && isDefined( self.primaryTarget ) && !self maps\mp\killstreaks\_helicopter::heli_is_threatened() )
		{
			self setVehGoalPos( nextNode.origin+(self.zOffset), true );
			self waittill( "near_goal" );

			wait ( nextNode.script_delay );
		}
		else
		{
			self setVehGoalPos( nextNode.origin+(self.zOffset), false );
			self waittill( "near_goal" );

			self setGoalYaw( nextNode.angles[ 1 ] );

			self waittillmatch( "goal" );
		}

		currentNode = nextNode;
	}
}

on_heli_health()
{
	self endon( "death" );
	self endon( "leaving" );
	self endon( "crashing" );
	
	self.currentstate = "ok";
	self.laststate = "ok";
	self setDamageState( 3 );
	
	damageState = 3;
	self setDamageState( damageState );
	
	for ( ;; )
	{
		if ( self.damageTaken >= ( self.maxhealth * 0.33 ) && damageState == 3 )
		{
			damageState = 2;
			
            self setDamageState( damageState );
			self.currentstate = "light smoke";
			
            playFxOnTag( level.chopper_fx[ "damage" ][ "light_smoke" ], self, "tag_engine_left" );
		}
		else if ( self.damageTaken >= ( self.maxhealth * 0.66 ) && damageState == 2 )
		{
			damageState = 1;
			
            self setDamageState( damageState );
			self.currentstate = "heavy smoke";

			stopFxOnTag( level.chopper_fx[ "damage" ][ "light_smoke" ], self, "tag_engine_left" );
			playFxOnTag( level.chopper_fx[ "damage" ][ "heavy_smoke" ], self, "tag_engine_left" );
		}
		else if( self.damageTaken > self.maxhealth )
		{
			damageState = 0;
			
            self setDamageState( damageState );

			stopFxOnTag( level.chopper_fx[ "damage" ][ "heavy_smoke" ], self, "tag_engine_left" );
			
			playFxOnTag( level.chopper_fx[ "damage" ][ "on_fire" ], self, "tag_engine_left" );
			
            self thread maps\mp\killstreaks\_helicopter::heli_crash();
		}
		
		wait 0.05;
	}
}

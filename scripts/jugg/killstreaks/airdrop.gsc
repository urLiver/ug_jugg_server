/*

    INFO:
        - This File Includes the Functions Replacing certain parts of the Airdrop

    TODO:
		- Killstreaks to maybe add:
			- Turret that is useable, like the ones in the edit
			- Drone Strike or something similar to it like bo2
			- Helicopter Flock but with three Littlebirds
		
		hook on otherake anf change time too 4000

    DONE:
        - Total Weight of Assault Airdrops is 100 so percentages are not decimal point numbers
		- Added EMP, Remote UAV, Juggernaut, Helicopter Flock ( littlebird flock ), to assault and trap airdrop
        
*/

init()
{
    replacefunc( maps\mp\killstreaks\_airdrop::airDropMarkerActivate, ::on_airDropMarkerActivate );
    replacefunc( maps\mp\killstreaks\_airdrop::airdropDetonateOnStuck, ::on_airdropDetonateOnStuck );
    replacefunc( maps\mp\killstreaks\_airdrop::getcratetypefordroptype, ::on_getcratetypefordroptype );
    replacefunc( maps\mp\killstreaks\_airdrop::killstreakcratethink, ::on_killstreakcratethink );
    replacefunc( maps\mp\killstreaks\_airdrop::crateSetupForUse, ::on_crateSetupForUse );
    replacefunc( maps\mp\killstreaks\_airdrop::crateothercapturethink, ::on_crateothercapturethink );
    replacefunc( maps\mp\killstreaks\_airdrop::getflyheightoffset, ::on_getflyheightoffset );
    replacefunc( maps\mp\killstreaks\_airdrop::dropTheCrate, ::on_dropTheCrate );

	level.crateTypes = [];

	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"ims",                  	20, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"predator_missile",    		20, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"sentry",               	20, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"ammo",                 	22, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"remote_mg_turret",     	15, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"airdrop_trap",         	15, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"remote_uav",           	13, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"precision_airstrike",  	9,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"stealth_airstrike",    	9,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"helicopter",           	6,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"littlebird_support",   	7,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"littlebird_flock",     	7,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"remote_mortar",        	7,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"harrier_airstrike",    	6,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"helicopter_flares",    	6,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"remote_tank",          	5,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"ac130",                	5,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"airdrop_juggernaut",   	4,  	maps\mp\killstreaks\_airdrop::juggernautcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"osprey_gunner",        	3, 		maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"emp",                  	3,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );

	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"ims",                  	21, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"predator_missile",    		21, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"sentry",               	21, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"ammo",                 	22, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"remote_mg_turret",     	15, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"airdrop_trap",         	15, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"remote_uav",           	13, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"precision_airstrike",  	9,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"stealth_airstrike",    	9,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"helicopter",           	6,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"littlebird_support",   	7,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"littlebird_flock",     	7,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"remote_mortar",        	7,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"harrier_airstrike",    	6,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"helicopter_flares",    	6,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"remote_tank",          	5,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"ac130",                	5,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"airdrop_juggernaut",   	4,  	maps\mp\killstreaks\_airdrop::juggernautcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"emp",                  	3,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );

	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"ims",                  	20, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"predator_missile",     	20, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents",	 		"sentry",               	20, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"ammo",                 	22, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"remote_mg_turret",     	15, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"airdrop_trap",        		15, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"remote_uav",          		13, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"precision_airstrike", 		9,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"stealth_airstrike",    	9,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"helicopter",           	6,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"littlebird_support",   	7,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"littlebird_flock",    		7,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"remote_mortar",        	7,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"harrier_airstrike",    	6,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"helicopter_flares",    	6,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"remote_tank",          	5,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"ac130",                	5,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"airdrop_juggernaut",   	4,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents",	 		"osprey_gunner",        	3,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"emp",                  	3,  	maps\mp\killstreaks\_airdrop::trapNullFunc );

	maps\mp\killstreaks\_airdrop::addCrateType(  "airdrop_sentry_minigun",		"sentry",					100,	maps\mp\killstreaks\_airdrop::killstreakcratethink );

	maps\mp\killstreaks\_airdrop::addCrateType(  "airdrop_juggernaut",			"airdrop_juggernaut",		100,	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	
	maps\mp\killstreaks\_airdrop::addCrateType(  "airdrop_juggernaut_recon",	"airdrop_juggernaut_recon",	100,	maps\mp\killstreaks\_airdrop::killstreakcratethink );

	maps\mp\killstreaks\_airdrop::addCrateType(  "airdrop_trophy",				"airdrop_trophy",			100,	maps\mp\killstreaks\_airdrop::trophyCrateThink );

	maps\mp\killstreaks\_airdrop::addCrateType(  "airdrop_trap",				"airdrop_trap",				100,	maps\mp\killstreaks\_airdrop::trapCrateThink );

	maps\mp\killstreaks\_airdrop::addCrateType(  "littlebird_support",			"littlebird_support",		100,	maps\mp\killstreaks\_airdrop::killstreakcratethink );

	maps\mp\killstreaks\_airdrop::addCrateType(  "airdrop_remote_tank",			"remote_tank"		,		100,	maps\mp\killstreaks\_airdrop::killstreakcratethink );

    foreach ( var_10, var_6 in level.cratetypes )
    {
        level.cratemaxval[ var_10 ] = 0;

        foreach ( var_9, var_8 in level.cratetypes[ var_10 ] )
        {
            if ( ! var_8 )
			{
                continue;
			}

            level.cratemaxval[ var_10 ] += var_8;
            level.cratetypes[ var_10 ][ var_9 ] = level.cratemaxval[ var_10 ];
        }
    }
	
	tdmSpawns = getEntArray( "mp_tdm_spawn" , "classname" );
	lowSpawn = undefined;
	foreach( lspawn in tdmSpawns ) 
	{
		if ( ! isDefined( lowSpawn ) || lspawn.origin[ 2 ] < lowSpawn.origin[ 2 ] )
		{
			lowSpawn = lspawn;
		}
	}

	level.lowSpawn = lowSpawn;
}

createAirDropCrate( owner, dropType, crateType, startPos )
{
	dropCrate = spawn( "script_model", startPos );
	
	dropCrate.curProgress = 0;
	dropCrate.useTime = 0;
	dropCrate.useRate = 0;
	dropCrate.team = self.team;
	
	if ( isDefined( owner ) )
	{
		dropCrate.owner = owner;
	}
	else
	{
		dropCrate.owner = undefined;
	}

	dropCrate.crateType = crateType;
	dropCrate.dropType = dropType;
	dropCrate.targetname = "care_package";
	
	dropCrate setModel( maps\mp\gametypes\_teams::getTeamCrateModel( dropCrate.team ) );
	dropCrate thread maps\mp\killstreaks\_airdrop::crateTeamModelUpdater();	

	modelName = "com_plasticcase_friendly";

	if( crateType == "airdrop_trap" )
	{
		modelName = "com_plasticcase_trap_friendly";
		dropCrate thread maps\mp\killstreaks\_airdrop::trap_createBombSquadModel();
	}

	dropCrate.friendlyModel = spawn( "script_model", startPos );
	dropCrate.friendlyModel setModel( modelName );
	dropCrate.enemyModel = spawn( "script_model", startPos );
	dropCrate.enemyModel setModel( "com_plasticcase_enemy" );

	dropCrate.friendlyModel thread maps\mp\killstreaks\_airdrop::deleteOnOwnerDeath( dropCrate );
	dropCrate.enemyModel thread maps\mp\killstreaks\_airdrop::deleteOnOwnerDeath( dropCrate );

	if( level.teambased )
	{
		dropCrate.enemyModel thread maps\mp\killstreaks\_airdrop::crateModelTeamUpdater( level.otherTeam[ dropCrate.team ] );
		dropCrate.friendlyModel thread maps\mp\killstreaks\_airdrop::crateModelTeamUpdater( dropCrate.team );
	}
	else
	{
		dropCrate.friendlyModel thread maps\mp\killstreaks\_airdrop::crateModelPlayerUpdater( owner, true );
		dropCrate.enemyModel thread maps\mp\killstreaks\_airdrop::crateModelPlayerUpdater( owner, false );
	}

	dropCrate.inUse = false;
	
	dropCrate.killCamEnt = Spawn( "script_model", dropCrate.origin + ( 0, 0, 300 ) );
	dropCrate.killCamEnt SetScriptMoverKillCam( "explosive" );
	dropCrate.killCamEnt LinkTo( dropCrate );

	level.numDropCrates++;

	dropCrate thread maps\mp\killstreaks\_airdrop::dropCrateExistence();

	return dropCrate;
}

findCrateTrace( dropPoint, crate, var_1, var_2, var_3 ) 
{
    self endon("drop_crate");

    locationFound = false;
    dropTries = 0;
    
	while( ! locationFound ) 
	{
        location = bullettrace( dropPoint + ( 0, 0, 700 ), dropPoint + ( 0, 0, -1000 ), 0, crate );
    
	    if( Distance( dropPoint, location[ "position" ] ) < 18 ) 
		{
            crate.trace = location;
            locationFound = true;
        } 
		else if( dropTries >= 12 ) 
		{
            crate.trace = bullettrace( dropPoint + ( 0, 0, 700 ), dropPoint + ( 0, 0, -1000 ), 0, crate );
            locationFound = true;
        } 
		else 
		{
            dropTries++;
        }

        wait 0.25;
    }
}

allow_owner_damage() 
{
    self endon( "death" );

    self setcandamage( 1 );
    
	self.actual_health = 500;
    self.health = 1000000;
    self.maxhealth = 1000000;

    while( isdefined( self ) ) 
	{
        self waittill( "damage", amount, inflictor );

        if( inflictor == self.owner )
		{
            self.actual_health -= ( amount * 2 );
		}
        else
		{
            self.actual_health -= amount;
		}

        if( self.actual_health <= 0 ) 
		{
            self maps\mp\killstreaks\_airdrop::deletecrate();

            break;
        }
    }
}

physicswaiter( var_0, var_1, special ) 
{
	self endon( "death" );

	var_3 = self.origin;

	if( isdefined( special ) )
	{
    	self waittill( "crate_reached_pos" );
	}
    else
	{
    	self waittill( "physics_finished" );
	}

    self thread allow_owner_damage();

	if( isdefined( self ) ) 
	{
    	self thread [ [ level.cratefuncs[ var_0 ][ var_1]  ] ]( var_0 );
    	level thread maps\mp\killstreaks\_airdrop::droptimeout( self, self.owner, var_1 );

    	if( distance( self.origin, var_3 ) > 3500 || self.owner.team != self.team )
		{
        	self maps\mp\killstreaks\_airdrop::deletecrate();
		}

		if( isdefined( level.lowest_crate ) ) 
		{
    		if( self.origin[ 2 ] < level.lowest_crate && self.origin[ 2 ] < level.lowspawn.origin[ 2 ] )
			{
    			self maps\mp\killstreaks\_airdrop::deletecrate();
			}
    	}

        if( isdefined( level.teleporter_ents ) )
		{
            foreach( ent in level.teleporter_ents ) 
			{
                if( distance2d( self.origin, ent.origin ) < 50 )
				{
                    self maps\mp\killstreaks\_airdrop::deletecrate();
				}
            }
        }
    }
}

detect_no_prone() 
{
	self endon( "death" );

	for( ;; ) 
	{
		level waittill( "breach_check" );
		
		foreach( player in level.players ) 
		{
			if( ! isalive( player ) )
			{
				continue;
			}

			if( ! isdefined( player.breaching ) && distance( player geteye(), self.origin ) < 25 ) 
			{
				player.breaching = true;
			}
		}
	}
}

waitfordropcratemsg( dropPoint, crate, var_1, var_2, var_3 ) 
{
    thread findCrateTrace( dropPoint, crate, var_1, var_2, var_3 );

    self waittill( "drop_crate" );

    if( ! isdefined( crate.trace ) )
	{
        crate.trace = bullettrace( dropPoint + ( 0, 0, 700 ), dropPoint + ( 0, 0, -1000 ), 0, crate );
	}
    
    angles = undefined;
	if( isdefined( crate.trace[ "normal" ] ) )
	{
        angles = VectorToAngles( crate.trace[ "normal" ] );
	}

    crate_ground = undefined;
    crate unlink();
    var_6 = undefined;

    dropSystem = 0;

    if( isdefined( crate.trace[ "entity" ] ) && isdefined( crate.trace[ "entity" ].origin ) && isdefined( crate.trace[ "entity" ].model ) && IsSubStr( crate.trace[ "entity" ].model, "com_plasticcase" ) ) 
	{
		dropSystem = 3;
	    var_5 = distance( crate.origin, crate.trace[ "entity" ].origin );
	    var_6 = var_5 / 800;

	    crate rotatevelocity((randomintrange(0, 360), randomintrange(0, 360), randomintrange(0, 360)), var_6 / 2);

        if( isdefined( angles ) ) 
		{
			forward = anglestoforward( angles );
			crate moveto( crate.trace[ "position" ] + forward * 15, var_6 );
        }
        else
		{
	        crate moveto( crate.trace[ "entity" ].origin + ( 0, 0, 28 ), var_6 );
		}

		crate thread detect_no_prone();
	} 
	else if( isdefined( crate.trace[ "position" ] ) && isdefined( crate.trace[ "entity" ] ) && isdefined( crate.trace[ "entity" ].model ) && crate.trace[ "entity" ].model != "" ) 
	{
		dropSystem = 2;
		crate thread detect_no_prone();
		
		var_5 = distance( crate.origin, crate.trace[ "position" ] );
	    var_6 = var_5 / 800;
	    crate rotatevelocity(( randomintrange( 0, 360 ), randomintrange( 0, 360 ), randomintrange( 0, 360 ) ), var_6 / 2 );
	    forward = anglestoforward( angles );
        crate moveto( crate.trace[ "position" ] + forward * 15, var_6 );
    }
	else 
	{
		crate CloneBrushmodelToScriptmodel( level.airdropcratecollision );
		crate physicslaunchserver( ( 0, 0, 0 ), var_1 );
    }

    if( dropSystem != 0 ) 
	{
	    crate thread physicswaiter( var_2, var_3, 1 );

		if( isdefined( crate.killcament ) ) 
		{
			crate.killcament unlink();
			var_5 = distance( crate.origin, crate.trace[ "position" ] );
			var_6 = var_5 / 800;
			crate.killcament moveto( crate.trace[ "position" ] + ( 0, 0, 300 ), var_6 );
		}
	}
    else 
	{
        crate thread physicswaiter( var_2, var_3 );
	}
	
    if( isdefined( crate.trace[ "entity" ] ) && dropSystem == 3 ) 
	{
	    wait var_6 / 2;

	    if( crate.trace[ "entity" ].angles[ 2 ] == 0 && crate.trace[ "entity" ].angles[ 0 ] == 0 ) 
		{
	    	crate rotateto( ( crate.trace[ "entity" ].angles[ 0 ], randomintrange( 0, 360 ), crate.trace[ "entity" ].angles[ 2 ] ), var_6 / 2 );
		}
	    else 
		{
	    	crate rotateto( ( crate.trace[ "entity" ].angles[ 0 ], crate.trace[ "entity" ].angles[ 1 ], crate.trace[ "entity" ].angles[ 2 ] ), var_6 / 2 );
		}

	    wait var_6 / 2;
	
	    crate notify("crate_reached_pos");
	} 
	else if( isdefined( crate.trace[ "position" ] ) && dropSystem == 2 ) 
	{
        wait var_6 / 2;

	    crate rotateto( ( 90 + angles[ 0 ], angles[ 1 ], angles[ 2 ] ), var_6 / 2 );

	    wait var_6 / 2;

	    crate notify("crate_reached_pos");
    }
}

on_dropTheCrate( dropPoint, dropType, lbHeight, dropImmediately, crateOverride, startPos, dropImpulse, previousCrateTypes, tagName )
{
	dropCrate = [];
	self.owner endon ( "disconnect" );
	
	if ( ! isDefined( crateOverride ) )
	{
		if ( isDefined( previousCrateTypes ) )
		{
			foundDupe = undefined;
			crateType = undefined;
			
			for ( i = 0;  i < 100; i++ )
			{
				crateType = maps\mp\killstreaks\_airdrop::getCrateTypeForDropType( dropType );
				foundDupe = false;

				for ( j = 0; j < previousCrateTypes.size; j++ )
				{
					if ( crateType == previousCrateTypes[ j ] )
					{
						foundDupe = true;
						break;
					}
				}
				if ( foundDupe == false )
				{
					break;
				}
			}
			
			if ( foundDupe == true )
			{
				crateType = maps\mp\killstreaks\_airdrop::getCrateTypeForDropType( dropType );
			}
		}
		else
		{
			crateType = maps\mp\killstreaks\_airdrop::getCrateTypeForDropType( dropType );	
		}
	}	
	else
	{
		crateType = crateOverride;
	}

	if ( ! isDefined( dropImpulse ) )
	{
		dropImpulse = ( randomInt( 5 ),randomInt( 5 ),randomInt( 5 ) );
	}

	dropCrate = createAirDropCrate( self.owner, dropType, crateType, startPos );
	
	switch( dropType )
	{
		case "airdrop_mega":
		case "nuke_drop":
		case "airdrop_juggernaut":
		case "airdrop_juggernaut_recon":
			dropCrate LinkTo( self, "tag_ground" , ( 64, 32, -128 ) , ( 0, 0, 0 ) );
			break;
		case "airdrop_escort":
		case "airdrop_osprey_gunner":
			dropCrate LinkTo( self, tagName, ( 0, 0, 0 ), ( 0, 0, 0 ) );
			break;
		default:
			dropCrate LinkTo( self, "tag_ground" , ( 32, 0, 5 ) , ( 0, 0, 0 ) );
			break;
	}

	dropCrate.angles = ( 0, 0, 0 );
	dropCrate show();
	dropSpeed = self.veh_speed;
	
	self thread waitfordropcratemsg( dropPoint, dropCrate, dropImpulse, dropType, crateType );
	
	return crateType;
}

on_getflyheightoffset( var_2 ) 
{
	return var_2[ 2 ] + 1000;
}

on_crateothercapturethink( var_0 )
{
    while ( isdefined( self ) )
    {
        self waittill( "trigger", var_1 );

        if ( isdefined( self.owner ) && var_1 == self.owner )
		{
            continue;
		}

        if ( ! maps\mp\killstreaks\_airdrop::validateopenconditions( var_1 ) )
		{
            continue;
		}

        var_1.iscapturingcrate = 1;
        var_2 = maps\mp\killstreaks\_airdrop::createuseent();
        var_3 = var_2 maps\mp\killstreaks\_airdrop::useholdthink( var_1, 4000, var_0 );

        if ( isdefined( var_2 ) )
		{
            var_2 delete();
		}

        if ( ! var_3 )
        {
            var_1.iscapturingcrate = 0;
            continue;
        }

        var_1.iscapturingcrate = 0;
        self notify( "captured", var_1 );
    }
}

on_airdropDetonateOnStuck()
{
	self endon ( "death" );
	self waittill( "missile_stuck" );

	self notify( "on_airdropDetonateOnStuck", self.origin );

	playfx( level._effect[ "ac130_flare" ], self.origin, ( 0, 0, 0 ) );
}

on_airDropMarkerActivate( type, lifeId ) 
{
	self notify( "airDropMarkerActivate" );
	self endon( "airDropMarkerActivate" );

	self waittill( "on_airdropDetonateOnStuck", position );

	owner = self.owner;
	if( ! isDefined( owner ) )
	{
		return;
	}

	if( owner maps\mp\_utility::isAirDenied() )
	{
		return;
	}

    lower_type = tolower( type );
	if( IsSubStr( lower_type, "escort_airdrop" ) && isDefined( level.chopper ) )
	{
		return;
	}

	if( IsSubStr( lower_type, "escort_airdrop" ) && IsDefined( level.chopper_fx[ "smoke" ][ "signal_smoke_30sec" ] ) )
	{
		PlayFX( level.chopper_fx[ "smoke" ][ "signal_smoke_30sec" ], position, ( 0, 0, -1 ) );
	}

	wait .05;

	if( IsSubStr( lower_type, "escort_airdrop" ) )
	{
		owner maps\mp\killstreaks\_escortairdrop::finishSupportEscortUsage( lifeId, position, randomFloat( 360 ), "escort_airdrop" );
	}
	
    else if( lower_type == "airdrop_assault" || lower_type == "airdrop_sentry_minigun" ) 
    {
        if( distance( owner.origin, position ) > 300 )
        {
            if( owner.sessionteam == "axis" )
            {
                owner IPrintLnBold( "^2Nice try :D" );

                self delete();
            }
            else
            {
                owner maps\mp\killstreaks\_killstreaks::giveKillstreak( type, false, false, self.owner, true );

                owner IPrintLnBold( "^1Nope too far away!" );

                maps\mp\_utility::decrementFauxVehicleCount();
				
                PlayFX( level.money, self.origin );
				
                owner playLocalSound( "item_nightvision_off" );
				
                self delete();
            }
        }
        else
        {
			self detonate();

            level maps\mp\killstreaks\_airdrop::doflyby( owner, position, randomfloat( 360 ), type );
        }
    }

    else
    {
		self detonate();

        level maps\mp\killstreaks\_airdrop::doflyby( owner, position, randomfloat( 360 ), type );
    }
}

on_getcratetypefordroptype( type )
{   
    switch ( type )
    {
        case "airdrop_sentry_minigun":
            return "sentry";
        case "airdrop_predator_missile":
            return "predator_missile";
        case "airdrop_juggernaut":
            return "airdrop_juggernaut";
        case "airdrop_juggernaut_def":
            return "airdrop_juggernaut_def";
        case "airdrop_juggernaut_gl":
            return "airdrop_juggernaut_gl";
        case "airdrop_juggernaut_recon":
            return "airdrop_juggernaut_recon";
        case "airdrop_trap":
            return "airdrop_trap";
        case "airdrop_trophy":
            return "airdrop_trophy";
        case "airdrop_remote_tank":
            return "remote_tank";
        case "airdrop_assault":
        case "airdrop_mega":
        case "airdrop_escort":
        case "airdrop_support":
        case "airdrop_grnd":
        case "airdrop_grnd_mega":
        default:
            return  maps\mp\killstreaks\_airdrop::getrandomcratetype( type );
    }
}

refill_ammo() 
{
	self endon( "death" ); 

	if(self.team == "allies") 
	{
		foreach( weapon in self GetWeaponsListAll()) 
		{
			if( maps\mp\_utility::isKillstreakWeapon( weapon ) )
			{
				continue;
			}

            self GiveMaxAmmo( weapon );
		}
	}
	else 
	{
		self GiveWeapon( "defaultweapon_mp" );
		self SetWeaponAmmoStock( "defaultweapon_mp" , 0 );
		self SetWeaponAmmoclip( "defaultweapon_mp" , 5 );
		self SwitchToWeapon( "defaultweapon_mp" );
	}
}

on_killstreakcratethink( dropType ) 
{
	self endon( "death" );
		
	crateHint = &"PLATFORM_GET_KILLSTREAK";
	if( isDefined( game[ "strings" ][ self.crateType + "_hint" ] ) )
	{
		crateHint = game[ "strings" ][ self.crateType + "_hint" ];
	}

    if( self.crateType == "ammo" )
	{
        maps\mp\killstreaks\_airdrop::crateSetupForUse( crateHint, "all", "waypoint_ammo_friendly" );
	}
	else if(self.crateType == "airdrop_trap")
	{
        maps\mp\killstreaks\_airdrop::crateSetupForUse( crateHint, "all", "dpad_killstreak_airdrop_trap" );
	}
	else
    {
        maps\mp\killstreaks\_airdrop::crateSetupForUse( crateHint, "all", maps\mp\killstreaks\_killstreaks::getKillstreakCrateIcon( self.crateType ) );
	}

	thread maps\mp\killstreaks\_airdrop::crateOtherCaptureThink();
	thread maps\mp\killstreaks\_airdrop::crateOwnerCaptureThink();

	for( ;; ) 
	{
		self waittill( "captured", player );

		if( isDefined( self.owner ) && player != self.owner ) 
		{
			if( !level.teamBased || player.team != self.team ) 
			{
				switch( dropType ) 
				{
                    case "airdrop_assault":
                    case "airdrop_support":
                    case "airdrop_escort":
                    case "airdrop_osprey_gunner":
                        player thread maps\mp\gametypes\_missions::genericChallenge( "hijacker_airdrop" );
                        player thread maps\mp\killstreaks\_airdrop::hijackNotify( self, "airdrop" );
                        break;
                    case "airdrop_sentry_minigun":
                        player thread maps\mp\gametypes\_missions::genericChallenge( "hijacker_airdrop" );
                        player thread maps\mp\killstreaks\_airdrop::hijackNotify( self, "sentry" );
                        break;
                    case "airdrop_remote_tank":
                        player thread maps\mp\gametypes\_missions::genericChallenge( "hijacker_airdrop" );
                        player thread maps\mp\killstreaks\_airdrop::hijackNotify( self, "remote_tank" );
                        break;
                }
			}
			else 
			{
				self.owner thread maps\mp\gametypes\_rank::giveRankXP( "killstreak_giveaway", Int(( maps\mp\killstreaks\_killstreaks::getStreakCost( self.crateType ) / 10 ) * 50) );
				self.owner thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed( "sharepackage", Int(( maps\mp\killstreaks\_killstreaks::getStreakCost( self.crateType ) / 10 ) * 50) );
			}
		}

		player playLocalSound( "ammo_crate_use" );

		if( self.crateType == "ammo" )
		{
			player thread [ [ level.killStreakFuncs[ "ammo" ] ] ]();
		}
		else
		{
			player thread maps\mp\killstreaks\_killstreaks::giveKillstreak( self.crateType, 0, 0, self.owner );
		}

		self maps\mp\killstreaks\_airdrop::deleteCrate();
	}
}

on_crateSetupForUse( hintString, mode, _icon ) 
{
	self setCursorHint( "HINT_NOICON" );
	self setHintString( hintString );
	self makeUsable();
	self.mode = mode;

	if ( level.teamBased || IsDefined( self.owner ) ) 
	{
		curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
		objective_add( curObjID, "invisible", ( 0.0, 0.0, 0.0 ) );
		objective_position( curObjID, self.origin );
		objective_state( curObjID, "active" );

		shaderName = "compass_objpoint_ammo_friendly";
		if( mode == "trap" )
		{
			shaderName = "compass_objpoint_trap_friendly";
		}

		objective_icon( curObjID, shaderName );

		if ( ! level.teamBased && IsDefined( self.owner ) )
		{
			Objective_PlayerTeam( curObjId, self.owner GetEntityNumber() );
		}

		else
		{
			Objective_Team( curObjID, self.team );
		}

		self.objIdFriendly = curObjID;
	}

	curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
	objective_add( curObjID, "invisible", ( 0.0, 0.0, 0.0 ) );
	objective_position( curObjID, self.origin );
	objective_state( curObjID, "active" );
	objective_icon( curObjID, "compass_objpoint_ammo_enemy");

	if( ! level.teamBased && IsDefined( self.owner ) )
	{
		Objective_PlayerEnemyTeam( curObjId, self.owner GetEntityNumber() );
	}
	else
	{
		Objective_Team( curObjID, level.otherTeam[self.team] );
	}

	self.objIdEnemy = curObjID;

	if ( mode == "trap" ) 
	{
		self thread maps\mp\killstreaks\_airdrop::crateUseTeamUpdater( maps\mp\_utility::getOtherTeam( self.team ) );
	}
	else 
	{
		self thread maps\mp\killstreaks\_airdrop::crateUseTeamUpdater();

		if( isSubStr( self.crateType, "juggernaut" ) ) 
		{
			foreach( player in level.players )
			{
				if( player maps\mp\_utility::isJuggernaut() )
				{
					self thread maps\mp\killstreaks\_airdrop::crateUsePostJuggernautUpdater( player );
				}
			}
		}
		
		icon = spawnstruct();
		icon.showto = self.team;
		icon.icon = _icon;
		icon.offset = ( 0.0, 0.0, 24.0 );
		icon.width = 14;
		icon.height = 14;
		icon.archived = 0;
		icon.delay = undefined;
		icon.constantsize = undefined;
		icon.pintoscreenedge = 0;
		icon.fadeoutpinnedicon = undefined;
		icon.is3d = 0;
		
		self maps\mp\_entityheadicons::setheadicon( icon.showto, icon.icon, icon.offset, icon.width, icon.height, icon.archived, icon.delay, icon.constantsize, icon.pintoscreenedge, icon.fadeoutpinnedicon, icon.is3d );
	}

	self thread maps\mp\killstreaks\_airdrop::crateUseJuggernautUpdater();
}
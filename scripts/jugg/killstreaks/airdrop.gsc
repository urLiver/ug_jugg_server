/*

    INFO:
        - This File Includes the Functions Replacing certain parts of the Airdrop

    TODO:
		- Killstreaks to maybe add:
			- Turret that is useable, like the ones in the edit
			- Drone Strike or something similar to it like bo2
			- Helicopter Flock but with three Littlebirds

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

	level.crateTypes = [];

	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"ims",                  	34, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"predator_missile",    		34, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"sentry",               	34, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"ammo",                 	20, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"remote_mg_turret",     	14, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"airdrop_trap",         	14, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"remote_uav",           	12, 	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"precision_airstrike",  	8,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"stealth_airstrike",    	6,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"helicopter",           	5,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"littlebird_support",   	3,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"littlebird_flock",     	3,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"remote_mortar",        	3,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"harrier_airstrike",    	2,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"helicopter_flares",    	2,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"remote_tank",          	2,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"ac130",                	1,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"airdrop_juggernaut",   	1,  	maps\mp\killstreaks\_airdrop::juggernautcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"osprey_gunner",        	1, 		maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_assault",				"emp",                  	1,  	maps\mp\killstreaks\_airdrop::killstreakcratethink );

	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"ims",						20,		maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"predator_missile",			20,		maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"sentry",					20,		maps\mp\killstreaks\_airdrop::killstreakcratethink );
    maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"remote_mg_turret",			10,		maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"stealth_airstrike",		6,		maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"precision_airstrike",		8,		maps\mp\killstreaks\_airdrop::killstreakcratethink );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"remote_tank",				2,		maps\mp\killstreaks\_airdrop::killstreakcratethink );
    maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"ac130",			        1,		maps\mp\killstreaks\_airdrop::killstreakcratethink );
    maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_osprey_gunner",		"remote_mortar",			1,		maps\mp\killstreaks\_airdrop::killstreakcratethink );

	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"ims",                  	34, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"predator_missile",     	34, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents",	 		"sentry",               	34, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"ammo",                 	20, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"remote_mg_turret",     	14, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"airdrop_trap",        		14, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"remote_uav",          		12, 	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"precision_airstrike", 		8,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"stealth_airstrike",    	6,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"helicopter",           	5,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"littlebird_support",   	3,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"littlebird_flock",    		3,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"remote_mortar",        	3,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"harrier_airstrike",    	2,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"helicopter_flares",    	2,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"remote_tank",          	2,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"ac130",                	1,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"airdrop_juggernaut",   	1,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents",	 		"osprey_gunner",        	1,  	maps\mp\killstreaks\_airdrop::trapNullFunc );
	maps\mp\killstreaks\_airdrop::addCrateType( "airdrop_trapcontents", 		"emp",                  	1,  	maps\mp\killstreaks\_airdrop::trapNullFunc );

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

on_airdropDetonateOnStuck()
{
	self endon ( "death" );
	self waittill( "missile_stuck" );

	self notify( "on_airdropDetonateOnStuck", self.origin );

	fx = SpawnFX( level._effect[ "ac130_flare" ], self.origin );
    TriggerFX( fx );
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
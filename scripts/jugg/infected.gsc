init() 
{
    level.roll_items = [];
    level.roll_cur_percent = 0.0;


    add_roll( 0.40, "Nothing!", "You got nothing! Better luck next time", undefined, maps\mp\gametypes\_globallogic::blank, undefined );
    
    add_roll( 1.40, "Temu SMAW", "Rockets Tracks where you aim, when scoped", undefined, ::roll_maaws, undefined );
    add_roll( 1.40, "SMAW", "You have a SMAW rocket launcher", undefined, ::roll_param_weapon, array( "iw5_smaw_mp", 1, 0 ) );
    add_roll( 1.80, "M320", "You have a Noob Tube", undefined, ::roll_param_weapon, array( "m320_mp", 1, 0 ) );
    add_roll( 2.10, "Javelin", "You have a Javelin", ( 0, 0, .5 ), ::roll_param_weapon, array( "javelin_mp" ) );
    add_roll( 2.40, "RPG", "You have an RPG", undefined, ::roll_param_weapon, array( "rpg_mp", 1, 1 ) );
    add_roll( 1.40, "AT4", "You have an AT4", undefined, ::roll_param_weapon, array( "at4_mp", 1, 0 ) );
    add_roll( 1.60, "Stinger", "You have a Stinger rocket launcher", undefined, ::roll_param_weapon, array( "stinger_mp" ) );
    add_roll( 5.60, "Riotshield", "You have a Riotshield.", undefined, ::roll_param_weapon, array( "riotshield_mp" ) );
    add_roll( 1.30, "Akimbo", "You have Akimbo Pistols", undefined, ::roll_param_weapon, array( "iw5_usp45_mp_akimbo", undefined, 0, 1 ) );
    add_roll( 1.60, ".44 Magnum", "You have a .44 Magnum with 6 bullets", undefined, ::roll_param_weapon, array( "iw5_44magnum_mp", undefined, 0 ) );

    add_roll( 2.40, "Push Launcher", "You have a Push Launcher, Use it Scoped or Non Scoped!", undefined, ::roll_pushlauncher, undefined );
    add_roll( 4.20, "Smoke Launcher", "You have a Smoke Launcher", undefined, ::roll_smokelauncher, undefined );
    add_roll( 1.20, "One Bullet", "You have a Sniper with One Bullet", undefined, ::roll_onebullet, undefined );

    add_roll( 2.50, "C4", "You have a C4, Press ^:[{+actionslot 4}] ^7To Use It!", undefined, ::roll_param_nade, array( "c4_mp" ) );
    add_roll( 5.40, "Flash Bang", "You have 2 Flash Grenades, Press ^:[{+actionslot 4}] ^7To Use It!", undefined, ::roll_param_nade, array( "flash_grenade_mp" ) );
    add_roll( 5.50, "Concussion Grenade", "You have 2 Concussion Grenades, Press ^:[{+actionslot 4}] ^7To Use It!", undefined, ::roll_param_nade, array( "concussion_grenade_mp" ) );
    add_roll( 5.40, "EMP Grenade", "You have an EMP Grenade, Press ^:[{+actionslot 4}] ^7To Use It!", undefined, ::roll_param_nade, array( "emp_grenade_mp" ) );
    add_roll( 5.40, "Smoke Grenade", "You have a Smoke Grenade, Press ^:[{+actionslot 4}] ^7To Use It!", undefined, ::roll_param_nade, array( "smoke_grenade_mp" ) );

    add_roll( 4.10, "Extra Speed", "Increased Movement Speed", undefined, ::roll_extraspeed, undefined );
    add_roll( 2.80, "Increased Speed, Reduced Health", "You have less Health, but move much Faster", ( .5, 0, 0 ), ::roll_increasedspeed, undefined );
    
    add_roll( 4.00, "Ballistic Vest", "You have a Ballistic Vest (200 HP).", ( 0, 0, .5 ), level.killStreakFuncs["light_armor"], undefined );
    add_roll( 2.90, "Juggernaut", "You're a Juggernaut (300 HP).", undefined, ::roll_juggernaut, array( 3, 0.33, 0.90, 1, 0 ) );
    add_roll( 2.40, "Powerful Juggernaut", "You're a Powerful Juggernaut (500 HP).", ( .5, .5, 0 ), ::roll_juggernaut, array( 5, 0.66, 1, 1 ) );
    add_roll( 1.90, "Terminator Juggernaut", "You're a Terminator Juggernaut (800 HP).", ( .5, 0, 0 ), ::roll_juggernaut, array( 8, 0.99, 0.80, 1, 1 ) );
    add_roll( 1.20, "Explosive Juggernaut", "You're a powerful & explosive, Juggernaut (500 HP).", ( .5, 0, 0 ), ::roll_suicidejuggernaut, undefined );
    add_roll( 1.70, "Support Juggernaut", "A True Supporter!", undefined, ::roll_supportjuggernaut, undefined );
    
    add_roll( 2.00, "Smoker", "Wait a min, this aint Left 4 Dead", ( 0, .5, .2 ), ::roll_smoker, undefined );
    add_roll( 0.70, "Godmode for 5 seconds", "Temporarily grants invincibility for 5 seconds", ( .5, .5, 0 ), ::roll_godmode, undefined );
    
    add_roll( 1.20, "Extra Knifes", "You have Additional Throwing Knifes.", undefined, ::roll_unlimitedknives, undefined );
    add_roll( 2.40, "Exploding Throwingknife", "You have an Explosive Throwing Knife.", undefined, ::roll_explosiveknive, undefined );
    
    add_roll( 2.30, "Freeze Grenade", "Freeze Enemies or Turrets for 2 seconds, Press ^:[{+actionslot 4}] ^7to Use It!", ( 0, .8, .8 ), ::roll_freezegrenade, undefined );
    add_roll( 2.5, "Confusion Grenade", "Where to go?, Press ^:[{+actionslot 4}] ^7to Use It!", ( .8, .1, .4 ), ::roll_confusionnade, undefined );
    add_roll( 1.40, "Black Hole Grenade!", "Throw a Grenade that creates a Black Hole, ^7Press ^:[{+actionslot 4}] ^7To Use It", ( .6, 0, .6 ), ::roll_blackhole, undefined );
    add_roll( 1.40, "White Hole Grenade!", "Throw a Grenade that creates a White Hole, ^7Press ^:[{+actionslot 4}] ^7To Use It", ( .6, 0, .6 ), ::roll_whitehole, undefined );
    
    add_roll( 0.90, "Trophy Hunter", "Gain Wallhack on the Trophies", undefined, ::roll_trophyhunter, undefined );
    add_roll( 1.90, "Wallhack for 30 seconds", "Gain temporary Wallhack.", undefined, ::roll_wallhack, undefined );
    add_roll( 3.60, "Cold Blooded", "Undetected by Air Support, Sentries & Thermal", undefined, ::roll_coldblooded, undefined );
    
    add_roll( 3.10, "Jump Boost", "You have higher jump Height!", ( 0, .8, .8 ), ::roll_jumpboost, undefined );
    add_roll( 2.60, "Frog Jump", "**Put Frog Sound here**", ( 0, .8, .8 ), ::roll_frogjump, undefined );


    print(  "^1infected::init()^7: level.roll_cur_percent = ^2" + level.roll_cur_percent );

    replacefunc( maps\mp\gametypes\infect::setinfectedmsg, ::on_setinfectedmsg );
    replacefunc( maps\mp\gametypes\infect::chooseFirstInfected, ::on_chooseFirstInfected );
}

add_roll( percentage, name, description, color, func, paramlist  )
{
    index = level.roll_items.size;
    level.roll_items[ index ]                         = SpawnStruct();
    level.roll_items[ index ].rollname                = name;
    level.roll_items[ index ].description             = description;
    level.roll_items[ index ].percentage              = percentage + level.roll_cur_percent;
    level.roll_items[ index ].function                = func;
    level.roll_items[ index ].color                   = color;
    level.roll_items[ index ].paramlist               = paramlist;
    level.roll_cur_percent += percentage;
}

get_random_roll()
{
    self endon( "disconnect" );
    self endon( "death" );

    percent_targert = RandomFloat( level.roll_cur_percent ); 
    ret = undefined;

    foreach ( roll in level.roll_items )
    {
        ret = roll;

        if ( roll.percentage >= percent_targert )
        {
            break;
        }
    }

    return ret;
}

roll_random_effect() 
{
    self endon( "disconnect" );
    self endon( "death" );

    wait .05;

    if( isdefined( level.infected_jammed ) )
    {
        self thread scripts\core\ui::send_hud_notification_handler( "Jammed", "Rolls disabled", undefined );
        return;
    }

    roll = get_random_roll();
    if( ! isdefined( roll ) )
    {
        print(  "^1infected::roll_random_effect()^7: roll = ^2undefined" );
        return;
    }

    if( ! isdefined( roll.paramlist ) )
    {
        self thread [ [ roll.function ] ]( );
    }
    else
    {
        self thread [ [ roll.function ] ]( roll.paramlist );
    }

    self thread scripts\core\ui::send_hud_notification_handler( roll.rollname, roll.description, roll.color );
}

roll_trophyhunter()
{
    self.isTrophyHunter = 1;
    level notify( "update_bombsquad" );
}

roll_supportjuggernaut()
{
    self scripts\jugg\killstreaks\juggernaut::givejuggernaut();
}

roll_maaws()
{
    self GiveWeapon( "iw5_smaw_mp" );
    self setweaponammoclip( "iw5_smaw_mp", 1 );
    self setweaponammostock( "iw5_smaw_mp", 0 );

    // self thread scripts\jugg\weapons\smaw::lasersight_think();
    self thread scripts\jugg\weapons\smaw::monitor_lsr_missile_launch();
}

ondeath_delete( owner ) 
{
    self endon( "exploded" );

    owner waittill( "death" );

    if( isdefined( self ) )
    {
        self delete();
    }
}

spawn_blackhole( origin ) 
{
    fx = SpawnFX( level.fx_airstrike_afterburner, origin );
    TriggerFX( fx );

    for( i = 0; i < 50; i++ ) 
    {
        foreach( player in level.players ) 
        {
        	if( player.sessionteam != "allies" ) 
            {
                continue;
            }

            distance_tocenter = distance( player.origin, origin );

            if( distance_tocenter < 500 && player isonground() ) 
            {
                player allowjump( 0 );

                direction = ( origin - player.origin );
                direction_normalized = direction / sqrt( direction[ 0 ] * direction[ 0 ] + direction[ 1 ] * direction[ 1 ] + direction[ 2 ] * direction[ 2 ] );
                forceMagnitude = ( 500 - distance_tocenter ) / 300 * 130;
                force = direction_normalized * forceMagnitude;

                player SetVelocity( force );
            }
        
        }

        wait .1;
    }

    wait .1;

    foreach( player in level.players )
    {
    	player allowjump( 1 );
    }

    fx delete();
}

roll_blackhole() 
{
    self endon( "death" );
    self endon( "disconnect" );

	self GiveWeapon( "semtex_mp" );
    self maps\mp\_utility::_SetActionSlot( 4, "weapon", "semtex_mp" );

    for( ;; )
    {
		self waittill( "grenade_fire", ent, name );

		if( name == "semtex_mp" ) 
        {
            ent thread ondeath_delete( self );

			wait 1.45;

            if( isdefined( ent ) ) 
            {
                ent notify( "exploded" );

                level thread spawn_blackhole( ent.origin );
                
                ent playsound( "harrier_fly_away" );

                if( isdefined( ent ) )
                {
                    ent delete();
                }
            }

			break;
		}
	}
}

spawn_whitehole( origin ) 
{
    fx = SpawnFX( level.harrier_afterburnerfx, origin );
    TriggerFX( fx );

    for( i = 0; i < 50; i++ ) 
    {
        foreach( player in level.players ) 
        {
        	if( player.sessionteam != "allies" ) 
            {
                continue;
            }

            distance_tocenter = distance( player.origin, origin );

            if( distance_tocenter < 500 && player isonground() ) 
            {
                player allowjump( 0 );

                direction = ( origin - player.origin );
                direction_normalized = direction / sqrt( direction[ 0 ] * direction[ 0 ] + direction[ 1 ] * direction[ 1 ] + direction[ 2 ] * direction[ 2 ] );
                forceMagnitude = -1 * ( ( 500 - distance_tocenter ) / 300 * 130 );
                force = direction_normalized * forceMagnitude;

                player SetVelocity( force );
            }
        
        }

        wait .1;
    }

    wait .1;

    foreach( player in level.players )
    {
    	player allowjump( 1 );
    }

    fx delete();
}

roll_whitehole() 
{
    self endon( "death" );
    self endon( "disconnect" );

	self GiveWeapon( "semtex_mp" );
    self maps\mp\_utility::_SetActionSlot( 4, "weapon", "semtex_mp" );

    for( ;; )
    {
		self waittill( "grenade_fire", ent, name );

		if( name == "semtex_mp" ) 
        {
            ent thread ondeath_delete( self );

			wait 1.45;

            if( isdefined( ent ) ) 
            {
                ent notify( "exploded" );

                level thread spawn_whitehole( ent.origin );
                
                ent playsound( "harrier_fly_away" );

                if( isdefined( ent ) )
                {
                    ent delete();
                }
            }

			break;
		}
	}
}

death_freezegrenade()
{
    self endon( "disconnect" );
    self endon( "unfroozen" );

    self waittill( "death" );

    self freezecontrols( 0 );

    if ( isdefined( self.freezeoverlay ) )
    {
        self.freezeoverlay destroy();
    }
}

player_freezgrenade() 
{
    self endon( "disconnect" );
    self endon( "death" );

    self thread death_freezegrenade();

    self freezecontrols( 1 );
    self iPrintLnBold( "^5Frozen^7 for ^52^7 Seconds!" );

    self.freezeoverlay = newclienthudelem( self );
    self.freezeoverlay.x = 0;
    self.freezeoverlay.y = 0;
    self.freezeoverlay.alignx = "left";
    self.freezeoverlay.aligny = "top";
    self.freezeoverlay.horzalign = "fullscreen";
    self.freezeoverlay.vertalign = "fullscreen";
    self.freezeoverlay setshader( "combathigh_overlay", 640, 480 );
    self.freezeoverlay.sort = -10;
    self.freezeoverlay.archived = 1;
    self.freezeoverlay.color = ( 0.0, 0.498, 1.0 );
    self.freezeoverlay scripts\core\ui_func::fade_out( 2.0 );

    self IPrintLnBold( "Froozen for: ^42" );

    wait 1;

    self IPrintLnBold( "Froozen for: ^41" );

    wait 1;

    self IPrintLnBold( "^1Unfroozen" );

    self notify( "unfroozen" );
    
    self freezecontrols( 0 );
    
    if ( isdefined( self.freezeoverlay ) )
    {
        self.freezeoverlay destroy();
    }
}

remoteturrets_freezgrenade() 
{
    for( i = 0; i < 80; i++ )
    {
        if ( self.owner getcurrentweapon() == "killstreak_remote_turret_remote_mp" )
        {
            self.owner.using_remote_turret = false;
            self.owner maps\mp\killstreaks\_remoteturret::takeKillstreakWeapons( self.turretType );
            self maps\mp\killstreaks\_remoteturret::stopUsingRemoteTurret();

            wait 0.5;

            self.owner ThermalVisionOff();
            self.owner ThermalVisionFOFOverlayOff();
            self.owner VisionSetThermalForPlayer( game["thermal_vision"], 0 );

            break;
        }

        wait 0.05;
    }
}

turret_freezgrenade() 
{
    self endon( "death" );

    moved = undefined;

    PlayFXOnTag( common_scripts\utility::getfx( "sentry_explode_mp" ), self, "tag_aim" );

    self SetDefaultDropPitch( 40 );

    if( isdefined( self.turrettype ) && self.turrettype == "mg_turret" )
    {
        if( isdefined( self.ownertrigger ) ) 
        {
            self.ownertrigger.origin = self.ownertrigger.origin + ( 0, 0, 10000 );
            moved = true;
        }
        
        self thread remoteturrets_freezgrenade();

        self.owner.throwingGrenade = "yeet";
    } 
    else if ( isdefined( self.sentryType ) && self.sentryType == "sentry_minigun" )
    {
        self SetMode( level.sentrySettings[ self.sentryType ].sentryModeOff );
    }
    else 
    {
        self.overheated = true;
        self SetMode( "sentry_offline" );
    }

    wait( 4 );

    if( isdefined( self.turrettype ) && self.turrettype == "mg_turret" ) 
    {
        if( isdefined( moved ) )
        {
            self.ownertrigger.origin = self.ownertrigger.origin - ( 0, 0, 10000 );
        }

        self.owner.throwingGrenade = undefined;
    }
    else if( isdefined( self.sentryType ) && self.sentryType == "sentry_minigun" )
    {
        self SetMode( level.sentrySettings[ self.sentryType ].sentryModeOn );
    }
    else 
    {
        self.overheated = false;
        self SetMode( "manual" );
    }

    self SetDefaultDropPitch( 0 );
}

roll_freezegrenade() 
{
    self endon( "disconnect" );
    self endon( "death" );

    self GiveWeapon( "semtex_mp" );
    self maps\mp\_utility::_SetActionSlot( 4, "weapon", "semtex_mp" );


    for( ;; )
    {
		self waittill( "grenade_fire", ent, name );

		if( name == "semtex_mp" ) 
        {
            ent thread ondeath_delete( self );

			wait 1.45;

            if( isdefined( ent ) ) 
            {
                ent notify( "exploded" );

                playfx( level.empGrenadeExplode, ent.origin );

                foreach( player in level.players ) 
                {
                    if( distance( player.origin, ent.origin ) < 250 && player.team == "allies" )
                    {
                        player thread player_freezgrenade();
                    }
                }

                turrets = getEntArray( "misc_turret", "classname" );

                foreach ( turret in turrets )
                {
                    if( distance( turret.origin, ent.origin ) < 250 )
                    {
                        turret thread turret_freezgrenade();
                    }
                }

                if( isdefined( ent ) )
                {
                    ent delete();
                }
            }

			break;
		}
	}
}

fire_smokelauncher() 
{
    self.smoke = true;

    org = ( 0, 0, 0 );

    while( isdefined( self ) ) 
    {
        org = self.origin;

        wait 0.05;
    }

    PlayFX( level.smokelauncher_fx, org );
}

roll_smokelauncher() 
{
    level endon( "game_ended" );
    self endon( "death" );

    self GiveWeapon( "m320_mp" );
    self setweaponammoclip( "m320_mp", 1 );
    self setweaponammostock( "m320_mp", 0 );

    waittillframeend;

    self SwitchToWeaponImmediate( "m320_mp" );

    for( ;; ) 
    {
        self waittill( "missile_fire", missile, weaponName );

        if ( weaponName == "m320_mp" )
        {
            missile thread fire_smokelauncher();
        }
    }
}

spawn_pushlauncherarrow() 
{
    arrow = spawn( "script_model", self.origin );
    arrow setmodel( "sundirection_arrow" );
    arrow.angles = vectortoangles( AnglesToForward( self.angles ) * -1 );
    arrow linkto( self );

    self waittill( "death" );

    arrow delete();
}

died_pushlauncher( time ) 
{
    self endon( "death" );

    wait time;

    if( isdefined( self ) )
    {
        self delete();
    }
}

fire_pushlauncherarrow( owner, dir, mode ) 
{
    self endon( "death" );

    self.pusher = true;
    
    pushdir = AnglesToForward( dir );
    up = 340;
    side = 180;

    if( mode ) 
    {
        self thread spawn_pushlauncherarrow();
        self thread died_pushlauncher( 4 );

        self.pushlist = [];

        for( ;; ) 
        {
            foreach( player in level.players )
            {
                if( player == owner )
                {
                    continue;
                }

                if( ! isdefined( self.pushlist[ player.name ] ) && Distance( self.origin, player.origin + ( 0, 0, 20 ) ) < 100 ) 
                {
                    self.pushlist[ player.name ] = true;

                    curvel = player getvelocity();
                    player setvelocity( ( curvel[ 0 ] + pushdir[ 0 ] * side, curvel[ 1 ] + pushdir[ 1 ] * side, pushdir[ 2 ] * up ) );
                }
            }

            wait 0.05;
        }
    } 
    else 
    {
        foreach( player in level.players )
        {
            if( Distance( owner.origin, player.origin ) < 100 ) 
            {
                curvel = player getvelocity();
                player setvelocity( ( curvel[ 0 ] + pushdir[ 0 ] * side, curvel[ 1 ] + pushdir[ 1 ] * side, pushdir[ 2 ] * up ) );
            }
        }
        
        if( isdefined( self ) )
        {
            self delete();
        }
    }
}

roll_pushlauncher() 
{
    level endon( "game_ended" );
    self endon( "death" );

    self Attach( "ims_scorpion_explosive1", "j_helmet", true );

    self GiveWeapon( "xm25_mp" );
    self setweaponammoclip( "xm25_mp", 2 );
    self setweaponammostock( "xm25_mp", 0 );

    waittillframeend;

    self SwitchToWeaponImmediate( "xm25_mp" );

    for( ;; ) 
    {
        self waittill( "missile_fire", missile, weaponName );

        if ( weaponName == "xm25_mp" )
        {
            missile thread fire_pushlauncherarrow( self, self getplayerangles(), self adsbuttonpressed() );
        }
    }
}

watch_snipershot( weapon ) 
{
    self endon( "disconnect" );
    self endon( "death" );

    for( ;; )
    {
        self waittill( "weapon_fired", weapName );

        if ( weapName != weapon ) 
        {
            continue;
        }

        wait 1;

        self takeweapon( weapon );
        self switchtoweapon( "iw5_usp45_mp_tactical" );
        break;
    }
}

roll_onebullet() 
{
    weapon = "iw5_dragunov_mp_dragunovscope";
    if( randomint( 100 ) < 50 )
    {
        weapon = "iw5_rsass_mp_rsassscope";   
    }

    self GiveWeapon( weapon );

    waittillframeend;
    
    self setweaponammoclip( weapon, 1 );
    self setweaponammostock( weapon, 0 );
    self SwitchToWeaponImmediate( weapon );

    self thread watch_snipershot( weapon );
}

play_c4ticking() 
{
	self endon( "disconnect" );
    level endon( "game_ended" );

	while( isalive( self ) ) 
    {
		self playsound( "scrambler_beep" );
	
    	wait 1.25;
	}
}

roll_suicidejuggernaut() 
{
    roll_juggernaut( array( 5, 0.33, 0.8 ) );

    self thread play_c4ticking();

    self attach( "weapon_c4_bombsquad", "j_shoulder_le", 1 );
    self attach( "weapon_c4_bombsquad", "j_shoulder_ri", 1 );

 	self.suicide_bomber = 1;
}

play_juggernautbreathing() 
{
	self endon( "disconnect" );
    level endon( "game_ended" );

	while( isalive( self ) ) 
    {
		self playsound( "juggernaut_breathing_sound" );
		
        wait 4;
	}
}

roll_juggernaut( params )
{
    if( ! isdefined( params ) || ! isdefined( params[ 0 ] ) || ! isdefined( params[ 1 ] ) || ! isdefined( params[ 2 ] ) )
    {
        print(  "^1infected::roll_juggernaut()^7: Parsing ^2error ^7!" );
        return;
    }

    self.maxhealth = self.Health * params[ 0 ];
    self.Health = self.Health * params[ 0 ];
    self.healthRegenLevel = params[ 1 ];

    self setmodel( "mp_fullbody_opforce_juggernaut" );
    self setviewmodel( "viewhands_juggernaut_opforce" );

    wait .05;

    self.moveSpeedScaler = params[ 2 ];
    self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

    if( isdefined( params[ 3 ] ) && params[ 3 ] == 1 )
    {    
        self attachshieldmodel( "weapon_riot_shield_mp", "tag_shield_back" );
    }

    if( isdefined( params[ 4 ] ) && params[ 4 ] == 1 )
    {
	    self thread play_juggernautbreathing();
    }
}

roll_godmode() 
{
    self endon( "stopGodMode" );
    self endon( "disconnect" );
    self endon( "game_ended" );

    self.godmode = 1;

    wait 1;

    for( i = 5; i >= 0; i-- ) 
    {
        if( isalive( self ) ) 
        {
            if( i != 0 ) 
            {
                self iprintlnbold( "Godmode For ^:" + i + " ^7Seconds" );
                wait 1;
            }
        }
        else
        {
            break;
        }
    }

    self iprintlnbold( "Godmode turned ^:Off" );

    self.godmode = undefined;

    self notify( "stopGodMode" );
}

play_explosiveknivestuck( owner ) 
{
    self endon( "death" );

    barrel = Spawn( "script_model", self.origin );
    barrel SetModel( "weapon_c4_bombsquad" );
    barrel.angles = self.angles;
    barrel LinkTo( self );
    barrel setcontents( 0 );

    self.stuck = 0;
    self common_scripts\utility::waittill_notify_or_timeout( "missile_stuck", 12 );
    self.stuck = 1;

    maxdam = 200;
    maxdampercent = maxdam / 100;
    maxdist = 350;
    maxdistpercent = maxdist / 100;

    self StopLoopSound( 1 );
    
    playSoundAtPos( self.Origin, "pavelow_helicopter_secondary_exp_close" );
    
    playfx( level.throwingknifeexplosionfx, self.origin );
    
    PhysicsExplosionSphere( self.origin, maxdist, 0, 5 );

    foreach( player in level.players ) 
    {
        d = distance( player.origin, self.origin );

        if( d < maxdist ) 
        {
            pushamount = player DamageConeTrace( self.origin );
            fractionDist = 100 - ( d / maxdistpercent );
            damage = fractiondist * maxdampercent;
            finaldamage = damage * pushamount;

            player thread [ [ level.CallbackPlayerDamage ] ] ( self, owner, finaldamage, 0, "MOD_EXPLOSIVE", "throwingknife_mp", self.origin, self.origin, "none", 0 );
        }
    }

    wait 1;
    
    barrel Delete();
    self delete();
}

play_explosionknive( owner ) 
{
    self thread play_explosiveknivestuck( owner );

    self playsound( "ac130_40mm_fire" );

    wait .1;
    
    self playloopsound( "move_40mm_proj_loop1" );
    
    playfxontag( level.throwingknifefx, self, "tag_origin" );
}

hud_removeondeath( owner ) 
{
    owner common_scripts\utility::waittill_any( "death","disconnect","used_exp_tk","force_end_exp_tk" );

    self destroy();
}

roll_explosiveknive() 
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "force_end_exp_tk" );

    powerup_hud = self maps\mp\gametypes\_hud_util::createFontString( "default", 1.0);
	powerup_hud maps\mp\gametypes\_hud_util::setPoint( "center", "BOTTOMRIGHT", -90, -14 );
    powerup_hud setShader( "compassping_explosion", 24, 24 );
    powerup_hud.HideWhenInMenu = 1;
    powerup_hud.HideWhenInkillcam = 1;
    powerup_hud.HideWhendead = 1;
    powerup_hud.alpha = 1;
	powerup_hud.archived = 1;
    powerup_hud thread hud_removeondeath( self );

    self giveweapon( "throwingknife_mp" );

    fired = 0;
    while( ! fired ) 
    {
        self waittill( "grenade_fire", grenade, weapName );

        if( weapName == "throwingknife_mp" ) 
        {
            self notify( "used_exp_tk" );

            grenade thread play_explosionknive( self );
        
            fired = 1;
        }
    }
}

roll_unlimitedknives() 
{
    self endon( "stopKnifes" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "game_ended" );

    self notify( "rolled_moreknives" );

    amount = 30;
    powerup_hud = newClientHudElem( self );
	powerup_hud.horzAlign = "fullscreen";
	powerup_hud.vertAlign = "fullscreen";
    powerup_hud.x = 585;
    powerup_hud.y = 460;
    powerup_hud.fontscale = 0.60;
    powerup_hud.font = "hudbig";
    powerup_hud.label = &" - ^1";
    powerup_hud.HideWhenInMenu = 1;
    powerup_hud.HideWhenInkillcam = 1;
    powerup_hud.HideWhendead = 1;
    powerup_hud.alpha = 1;
    powerup_hud.color = ( 1,1,1 );
	powerup_hud.archived = true;
    powerup_hud thread hud_removeondeath( self );
    powerup_hud setvalue( amount );

    self GiveWeapon( "throwingknife_mp" );
    self SetOffhandPrimaryClass( "throwingknife" );

    for( ;; ) 
    {
        self waittill( "grenade_fire", grenade, weapName );

        if ( weapName == "throwingknife_mp" ) 
        {
            amount--;
            if( amount > 0 ) 
            {
                powerup_hud setvalue( amount );
         
                wait 0.65;
         
                self SetWeaponAmmoClip( "throwingknife_mp", 1 );
            }
            else 
            {
                self notify( "calling_all_homos" );
         
                return;
            }
        }
    }
}

roll_wallhack() 
{
    self endon( "death" );
    self endon( "stopWh" );
    self endon( "disconnect" );
    self endon( "game_ended" );

    self.has_Wallhack = 1;
    self ThermalVisionFOFOverlayOn();
    
    wait 30;

    self ThermalVisionFOFOverlayOff();
    self.has_Wallhack = undefined;
    
    self notify( "stopWh" );
}

roll_coldblooded() 
{
    self endon( "death" );

    while( isdefined( self.avoidKillstreakOnSpawnTimer ) && self.avoidKillstreakOnSpawnTimer > 0 )
    {
        wait .05;
    }

    wait .05;

    self maps\mp\_utility::giveperk( "specialty_blindeye", 0 );
    self maps\mp\_utility::giveperk( "specialty_fasterlockon", 0 );
	self maps\mp\_utility::giveperk( "specialty_coldblooded", 1 );
	self maps\mp\_utility::giveperk( "specialty_spygame", 1 );
}

play_speed( scale ) 
{
    self endon( "stopSpeed" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "game_ended" );

	self maps\mp\_utility::giveperk( "specialty_fastmantle", 1 );

    for( ;; ) 
    {
        if( isDefined( self ) && isPlayer( self ) && isAlive( self ) )
        {
            self.moveSpeedScaler = scale;
            self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
        }
    
        wait .5;
    }
}

roll_increasedspeed() 
{
    self.maxhealth = 50;
    self.Health = 50;
    self thread play_speed( 1.8 );
}

roll_extraspeed() 
{
    self thread play_speed( 1.5 );
}

play_confusion( ent )
{
    ent waittill( "missile_stuck" );
    ent notify( "exploded" );

    explodedpos = ent.origin;

    if( isdefined( ent ) )
    {
        ent delete();
    }

    fx = SpawnFX( level.red_blinking, explodedpos );
    TriggerFX( fx );

    foreach( player in level.players )
    {
        if( distance( player.origin, explodedpos ) < 256 && player.team == "allies" )
        {
            player SetPlayerAngles( ( RandomFloatRange( -79, 79 ), RandomFloatRange( -180, 180 ), 0.0 ) );
            player SetVelocity( ( RandomFloatRange( -20, 20 ), RandomFloatRange( -20, 20 ), 450 ) );
        }
    }

    wait 2.5;

    fx Delete();
}

roll_confusionnade() 
{
    self endon( "disconnect" );
    self endon( "death" );

	self GiveWeapon( "semtex_mp" );
    self maps\mp\_utility::_SetActionSlot( 4, "weapon", "semtex_mp" );

    for( ;; )
    {
        self waittill( "grenade_fire", ent, name );

        if( name == "semtex_mp" ) 
        {
            level thread play_confusion( ent );
        }
    }
}

roll_smoker()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "smoker_down" );
 
    self Attach( "projectile_m67fraggrenade_bombsquad", "j_helmet", 1 );
    
    for( ;; )
    {
        self waittill( "death" );
        
	    playfx( level.smokelauncher_fx, self.origin );

        self notify( "smoker_down" );
    }
}

roll_param_weapon( params )
{
    if( ! isdefined( params ) || ! isdefined( params[ 0 ] ) )
    {
        print(  "^1infected::roll_param_weapon()^7: Parsing ^2error ^7!" );
        return;
    }

    if( isdefined( params[ 4 ] ) )
    {
        wait .05;
        self TakeWeapon( self GetCurrentWeapon() );
    }

    self GiveWeapon( params[ 0 ] );

    if( isdefined( params[ 1 ] ) )
    {
        self setweaponammoclip( params[ 0 ], params[ 1 ] );
    }

    if( isdefined( params[ 2 ] ) )
    {
        self setweaponammostock( params[ 0 ], params[ 2 ] ); 
    }

    waittillframeend;

    self SwitchToWeaponImmediate( params[ 0 ] );
}

roll_param_nade( params )
{
    if( ! isdefined( params ) || ! isdefined( params[ 0 ] ) )
    {
        print(  "^1infected::roll_param_nade()^7: Parsing ^2error ^7!" );
        return;
    }

    self GiveWeapon( params[ 0 ] );
    self maps\mp\_utility::_SetActionSlot(4, "weapon", params[ 0 ] );
    self thread scripts\core\ui::equipmenthud( params[ 0 ] );
}

roll_jumpboost() 
{
    self endon( "disconnect" );
    self endon( "death" );

    for( ;; ) 
    {
        if( ! isdefined( self.isinjump ) )
        {
            self waittill( "jumped" );

            self.isinjump = 1;

            cur = self GetVelocity();
            self SetVelocity( ( cur[ 0 ], cur[ 1 ], 420 ) );

            wait 0.5;
        }
        else
        {
            while( ! self IsOnGround() )
            {
                wait 0.1;        
            }

            self.isinjump = undefined;
        }
    }
}

roll_frogjump()
{
    self endon( "disconnect" );
    self endon( "death" );

    for( ;; ) 
    {
        if( ! isdefined( self.isinjump ) )
        {
            self waittill( "jumped" );

            self.isinjump = 1;

            cur = self GetVelocity();
            
            self SetVelocity( ( cur[ 0 ] * 3, cur[ 1 ] * 3, 300 ) );

            wait 0.5;
        }
        else
        {
            while( ! self IsOnGround() )
            {
                wait 0.1;        
            }

            self.isinjump = undefined;
        }
    }
}

on_setinfectedmsg() 
{
    if ( isdefined( self.changingtoregularinfected ) ) 
    {
        self.changingtoregularinfected = undefined;

        if ( isdefined( self.changingtoregularinfectedbykill ) ) 
        {
            self.changingtoregularinfectedbykill = undefined;
            thread maps\mp\gametypes\_rank::xpEventPopup( &"SPLASHES_FIRSTBLOOD" );
            maps\mp\gametypes\_gamescore::givePlayerScore( "first_draft", self );
            thread maps\mp\gametypes\_rank::giveRankXP( "first_draft" );
        }
    }
}

on_chooseFirstInfected() 
{
    level endon( "game_ended" );
    level endon( "infect_stopCountdown" );

    level.infect_allowsuicide = 0;
    maps\mp\_utility::gameFlagWait( "prematch_done" );

	if( isdefined( level.infect_timerDisplay ) ) 
	{
		level.infect_timerDisplay destroy();
	}

	level.infect_timerDisplay = maps\mp\gametypes\_hud_util::createServerTimer( "bigfixed", .5);
	level.infect_timerDisplay.horzalign = "fullscreen";
	level.infect_timerDisplay.vertalign = "fullscreen";
	level.infect_timerDisplay.alignx = "left";
	level.infect_timerDisplay.aligny = "middle";
	level.infect_timerDisplay.x = 10;
	level.infect_timerDisplay.y = 120;
	level.infect_timerDisplay.archived = 0;
	level.infect_timerDisplay.hideWhenInMenu = 1;
	level.infect_timerdisplay.alpha = 0;
	level.infect_timerdisplay fadeovertime( 1.0 );
	level.infect_timerdisplay.alpha = 1;
    level.infect_timerDisplay.label = &"Infection Countdown: ^8";
    level.infect_timerDisplay settimer(15);
    level.fadein_infect_timerDisplay = 1;
    
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(15);
    
    if( ! isdefined( level.roll_weapons_started ) )
    {
        level.roll_weapons_started = 1;
        level thread scripts\jugg\weapon::rotateGuns();
    }

	level.infected_timerdisplay_finished = 1;
    level.infect_timerdisplay fadeovertime( 1.0 );
    level.infect_timerdisplay.alpha = 0;

	if( str( tolower( getdvar( "suicide_final" ) ) ) != "undefined" ) 
	{
		for( i = 0; i < level.players.size + 1; i++ ) 
		{
			if( i == level.players.size ) 
			{
				rnd = randomint( level.players.size );
				print( "Failsafe System: ^3" + level.players[ rnd ].name + "^7 Selected As ^1First" );
    			level.players[ rnd ] maps\mp\gametypes\infect::setfirstinfected( 1 );
				break;
			}
			else if( str( tolower( level.players[ i ].guid ) ) == tolower( getdvar( "suicide_final" ) ) ) 
			{
				setdvar( "suicide_final", "undefined" );
				print( "^3" + level.players[ i ].name + " ^1Suicide ^7Forced First" );
				level.players[ i ] maps\mp\gametypes\infect::setfirstinfected( 1 );
				break;
			}
		}
	}
	else 
    {
		setdvar( "suicide_final", "undefined" );
		rnd = randomint( level.players.size );
		print( "Normal System: ^3" + level.players[ rnd ].name + "^7 Selected As ^1First" );
    	level.players[ rnd ] maps\mp\gametypes\infect::setfirstinfected( 1 );
	}

    wait 1;
    
	if( isdefined( level.infect_timerDisplay ) )
    {
		level.infect_timerDisplay destroy();
	}
}
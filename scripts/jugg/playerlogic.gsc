/*

    INFO:
        - This File Includes anything related to the logic of the Player, spawning, conneting, whatever

    TODO:
        - Move on_connect from core\stats.gsc in here
		- Shorten down the Functions
		- Remove "in edit" check, to allow new players to learn easier
		- Change AFK Check to use onNotifyPlayerCommand if that works on movement commands

    DONE:
        - Moved all ui components into core\ui 
		- Added TK Regen to Infected
        
*/

init()
{
	replacefunc(maps\mp\gametypes\_playerlogic::spawnplayer, ::spawnplayer_edit);
    
    level thread on_connecting();
	level thread on_connect();

    level thread scripts\core\ui::level_hud_handler();

	level thread check_players_in_map();
}

checkgoodspawn(grenade) {
    self endon("spawned_player");

    while(isdefined(self.setSpawnPoint))
        wait .05;

    self.goodspawn = undefined;
}

deletetacifinzone() {
    if(!isdefined(self.setSpawnPoint))
    	wait .05;

    if(isdefined(level.meat_playable_bounds) && isdefined(self.setSpawnPoint) && ! scripts\jugg\maps\objects::checkPointInsidePolygon(self.setSpawnPoint.playerSpawnPos)) {
        self iprintlnbold("^1Cannot Place Tactical Insertion Inside Resticted Area!");
        self thread maps\mp\perks\_perkfunctions::deleteTI(self.setSpawnPoint);
        self thread maps\mp\perks\_perkfunctions::setTacticalInsertion();
        return 0;
    }
    else if(!isdefined(self.setSpawnPoint)) {
        print("SETSPAWNPOINT NOT DEFINED FOR PLAYER + " + self.name);
        return 0;
    }
    else
        return 1;
}

timeoutdelete() 
{
    self endon("death");

    result = self common_scripts\utility::waittill_any_timeout( 10, "missile_stuck");
    if( result == "missile_stuck" ) 
	{
        wait 5;
    }
        
	if( isdefined( self ) )
	{
		self delete();
    }
}

on_connecting() {
    for(;;) {
        level waittill("connecting", player);

		if(level.players.size > 10) {
        	if(level.teamCount["allies"] <= 3)
        		player.spawnasinf = 1;
        }
    }
}

on_connect() {
	while(1) {
		level waittill("connected", player);

		player thread maps\mp\gametypes\_hud_message::hintMessageDeathThink();
		player thread maps\mp\gametypes\_hud_message::lowerMessageThink();
		player thread maps\mp\gametypes\_hud_message::initNotifyMessage();
		player.thirdperson = 0;

		print( "^2" + player.name + " ^7with GUID: ^1" + player.guid + "^7 - Connected");

		player SetClientDvar("lowAmmoWarningColor1", "0 0 0 0");
		player SetClientDvar("lowAmmoWarningColor2", "0 0 0 0");
		player SetClientDvar("lowAmmoWarningNoAmmoColor1", "0 0 0 0");
		player SetClientDvar("lowAmmoWarningNoAmmoColor2", "0 0 0 0");
		player SetClientDvar("lowAmmoWarningNoReloadColor1", "0 0 0 0");
		player SetClientDvar("lowAmmoWarningNoReloadColor2", "0 0 0 0");
		player SetClientDvar("cg_teamcolor_allies", "0.831 0.553 0 1");
		player SetClientDvar("cg_teamcolor_axis", ".75 .25 .25 1");

        if(!isdefined(level.SpawnedPlayersCheck[player.guid]) && !isdefined(player.spawnasinf))
			level.SpawnedPlayersCheck[player.guid] = 1;
		else {
			player maps\mp\gametypes\_menus::addToTeam( "axis", 1 );
			maps\mp\gametypes\infect::updateTeamScores();
			player.infect_firstSpawn = 0;
			player.pers["class"] = "gamemode";
			player.pers["lastClass"] = "";
			player.class = player.pers["class"];
			player.lastClass = player.pers["lastClass"];
			foreach(players in level.players) {
				if(isDefined(players.isInitialInfected))
					players thread maps\mp\gametypes\infect::setInitialToNormalInfected();
			}
			if(isdefined(level.infect_timerdisplay) && level.infect_timerdisplay.alpha == 1)
				level.infect_timerdisplay.alpha = 0;
		}

        player.rtd_canroll          = 1;
        player.initial_spawn        = 0;
        player.hud_elements         = [];

        player thread on_spawned();

        player thread equipment_handler();
        player thread scripts\core\ui::handle_door_huds();

		player thread semtex_hold_death_fix();
		player thread javelin_teamkill_fix();

        player.status = "out";
        player.inoomzone = 0;
        player.attackeddoor = 0;

        player thread scripts\jugg\maps\objects::oomzonehud();
	}
}

setkickgraceover( time ) 
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "death" );

	wait time;

	self.inmap_kick_graceperiod_over = true;
}

TK_Regeneration()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("rolled_moreknives");

    for(;;) 
	{
        self waittill("grenade_fire", grenade, weapName );

        if ( weapName == "throwingknife_mp" ) 
		{
			wait 7.5;

            self SetWeaponAmmoClip("throwingknife_mp", 1);
        }
    }
}

on_spawned() {
    self endon("disconnect");

    for(;;) {
        self waittill( "spawned_player" );

        self SetClientDvar( "cg_objectiveText", "www.^3TP^7jugg.com \n^3UG ^7Jugg: ^3discord.gg/wDjKXZCqnm" );

		self.flag_protection = undefined;

        if(self.initial_spawn == 0) {
        	self.initial_spawn = 1;

			self thread setkickgraceover( 15 );

    		self notifyOnPlayerCommand( "jumped", "+gostand" );
			self notifyOnPlayerCommand( "FpsFix_action", "vote no" );
			self notifyOnPlayerCommand( "Fullbright_action", "vote yes" );
			self notifyOnPlayerCommand( "suicide_action", "+actionslot 1" );

			self thread doFps();
			self thread doFullbright();
			self thread suicidePlayer();
			self thread var_resetter();
			self thread track_insertions();
        	self thread adv_afk_check();

			self thread scripts\core\ui::ui_hud();
			self thread scripts\core\ui::ui_xp();
        }

        if(isDefined(self.laststatus) && isdefined(self.goodspawn)) {
            self.status = self.laststatus;
            self.laststatus = undefined;
            self.goodspawn = undefined;
        }
        else {
            self.laststatus = undefined;
            self.goodspawn = undefined;
        }

        if(self.SessionTeam == "axis") {
            self TakeAllWeapons();
            self SetOffhandPrimaryClass("throwingknife");
            self GiveWeapon("throwingknife_mp");

			self thread TK_Regeneration();

            self maps\mp\_utility::giveperk("specialty_tacticalinsertion", 1);
			self setViewKickScale( 0.5 );

            if(!isdefined(self.isInitialInfected)) {
                self GiveWeapon("iw5_usp45_mp_tactical");
                self SetWeaponAmmoClip("iw5_usp45_mp_tactical", 0);
                self SetWeaponAmmoStock("iw5_usp45_mp_tactical", 0);
                self setspawnweapon("iw5_usp45_mp_tactical");
				self notify("force_end_exp_tk");
                self maps\mp\killstreaks\_killstreaks::clearKillstreaks();

                if(self.rtd_canroll == 1 ) 
				{
					wait .05;
					self notify("stopKnifes");
					self notify("stopSpeed");
					self ThermalVisionFOFOverlayOff();
					self thermalvisionoff();
					self.maxhealth = 100;
					self.Health = 100;
					self.rtd_canroll = 0;
					self.moveSpeedScaler = 1;
					self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

                    self thread scripts\jugg\infected::roll_random_effect();
                }
            }
            else {
                self scripts\jugg\infected::PowerfulJuggernaut();
                self GiveWeapon("riotshield_mp");
                self GiveWeapon("at4_mp");
				self SetWeaponAmmoClip("at4_mp", 1);
                self SetWeaponAmmoStock("at4_mp", 1);
                self setspawnweapon("at4_mp");
				self thread [[level.roll_items["exp_tk"].function]]();
				self setperk("specialty_fastreload", 1, 1);
            }

            if(!isdefined(self.initial_axis)) {
                self thread door_damage_handler();
                self.hud_elements["door_bind"] settext("^1Attack Door");

                self.initial_axis = 1;
            }
        }
        else if(self.SessionTeam == "allies") {
            self takeallweapons();

            self maps\mp\_utility::giveperk("trophy_mp", 0);
            self maps\mp\_utility::giveperk("claymore_mp", 0);
            self GiveWeapon(level.selected_starting_weapon);
            self GiveMaxAmmo(level.selected_starting_weapon);
           	self setspawnweapon(level.selected_starting_weapon);

            if( ! isdefined(self.initial_allies)) {
                self.hud_elements["door_bind"] settext("^2Open ^7/ ^1Close");

                self.initial_allies = 1;
            }
        }

        self setperk("specialty_fastoffhand", 1, 1);
    }
}

semtex_hold_death_fix() {
	self endon("disconnect");
	for(;;) {
		self waittill("grenade_fire", ent, weap);
		if(weap != "semtex_mp")
			continue;

		wait 0.1;
		if(!IsAlive(self) && isdefined(ent)){
			ent delete();
		}
	}
}

javelin_teamkill_fix() {
	self endon("disconnect");
	for(;;) {
		self waittill("missile_fire", missile, weap);
		if(weap == "javelin_mp" && self.team == "allies")
			self thread check_javelin_teamchange(missile);
	}
}

check_javelin_teamchange(missile) {
	while(isdefined(missile)) {
		wait 0.05;
		if(self.team != "allies")
			missile delete();
	}
}

adv_afk_check() {
	self endon("disconnect");
	level endon("game_ended");

	wait 3;

	arg = 0;

    while( 1 ) 
	{
		wait 1;
    	if(level.players.size > 3) 
		{
			if( isdefined( self.isinufo ) )
			 	continue;

	    	if(isdefined(self.isInitialInfected) && isAlive(self)) {
	    		org = self.origin;

	    		wait 1;

	    		if(isAlive(self)) {
					if(distance(org, self.origin) <= 30)
						arg++;
					else
						arg = 0;
				}

				if(isdefined(arg) && arg >= 30)
					kick(self getEntityNumber(), "EXE_PLAYERKICKED_INACTIVE");
			}
			else if(self.team == "axis" && isAlive(self)) {
				org = self.origin;

	    		wait 1;

				if(isAlive(self)) {
					if(distance(org, self.origin) <= 90)
						arg++;
					else
						arg = 0;
				}

				if(isdefined(arg) && arg >= 80)
					kick(self getEntityNumber(), "EXE_PLAYERKICKED_INACTIVE");
			}
			else
				wait 1;
		}
    }
}

check_players_in_map() {
	level endon("game_end");

	maps\mp\_utility::gameFlagWait( "prematch_done" );

	wait 1;
	if(!isdefined(level.meat_playable_bounds))
		return;

	start = gettime();
	part = GetDvarfloat("scr_" + getdvar("g_gametype") + "_timelimit") * 0.25;

	for(;;) {
		wait 5;
		if((gettime() - start >= part*60000)) {
			foreach(player in level.players) {
				if(player.team == "allies") {
					if(player.status == "in")
						continue;
					
					if(isdefined(player.inmap_kick_graceperiod_over) && !isdefined(player.not_in_edit_kick)) {
						player.not_in_edit_kick = true;
						player thread scripts\core\ui::ui_kickwarning();
					}
				}
			}
		}
	}
}

door_damage_handler() {
    self endon("disconnect");

    while(1) {
        self waittill("door_damage");

        self.door_cooldown = 1;

        wait 1.5;

        self.door_cooldown = undefined;
    }
}

equipment_handler() {
    self endon("disconnect");

    for(;;) {
        self waittill("grenade_fire", grenade, weapName);

        if(weapName == "flare_mp" && self.sessionteam == "axis") {
            if(!isDefined(self.TISpawnPosition))
                continue;

            if(self maps\mp\_utility::touchingBadTrigger())
                continue;

            if(isDefined(level.meat_playable_bounds) && self.status == "in" && self deletetacifinzone()) {
                self.goodspawn = 1;
                self thread Checkgoodspawn();
                self.laststatus = "in";
            }
        }
        else if(weapName == "throwingknife_mp" && self.sessionteam == "axis")
            grenade thread timeoutdelete();
    }
}

var_resetter() {
	self endon("disconnect");

	while(1) {
		self waittill("death");

		if(isdefined(self.linkedto))
			self.linkedto = undefined;
	}
}

doFps() {
	self endon("disconnect");
    level endon("game_ended");

    self.Fps = 0;

    while(1) {
        self waittill("FpsFix_action");
		if (self.Fps == 0) {
			self setClientDvar ( "r_zfar", "3000" );
			self.Fps = 1;
			self iprintln("^83000");
		}
		else if (self.Fps == 1) {
			self setClientDvar ( "r_zfar", "2000" );
			self.Fps = 2;
			self iprintln("^82000");
		}
		else if (self.Fps == 2) {
			self setClientDvar ( "r_zfar", "1500" );
			self.Fps = 3;
			self iprintln("^81500");
		}
		else if (self.Fps == 3) {
			self setClientDvar ( "r_zfar", "1000" );
			self.Fps = 4;
			self iprintln("^81000");
		}
		else if (self.Fps == 4) {
			self setClientDvar ( "r_zfar", "500" );
			self.Fps = 5;
			self iprintln("^8500");
		}
		else if (self.Fps == 5) {
			self setClientDvar ( "r_zfar", "0" );
			self.Fps = 0;
			self iprintln("^8Default");
		}
	}
}

doFullbright() {
	self endon("disconnect");

    self.Fullbright = 0;

    while(1) {
        self waittill("Fullbright_action");
		if (self.Fullbright == 0) {
			self SetClientDvars("r_fog", "0");
			self.Fullbright = 1;
			self iprintln("^8Fog");
		}
		else if (self.Fullbright == 1) {
			self SetClientDvar("r_lightmap", "3");
			self.Fullbright = 2;
			self iprintln("^8Fullbright Grey");
		}
		else if (self.Fullbright == 2) {
			self SetClientDvar("r_lightmap", "2" );
			self.Fullbright = 3;
			self iprintln("^8Fullbright White");
		}
		else if (self.Fullbright == 3) {
			self SetClientDvars("r_fog", "1", "r_lightmap", "1");
			self.Fullbright = 0;
			self iprintln("^8Default");
		}
	}
}

suicidePlayer() {
	self endon("disconnect");
	level endon("game_ended");

	while(1) {
        self waittill("suicide_action");
        self suicide();
    }
}

track_chicken_damage() 
{
    while( 1 ) 
	{
        self waittill("damage", damage, attacker );

        if( isdefined( attacker ) && self.health <= 0 )
		{
            attacker.player_settings["chicken_kill"]++;
            attacker notify("player_stats_updated");

			if( isdefined( self.origin ) )
			{
				self thread scripts\jugg\killstreaks\nuke::do_money_death();
			}

            break;
        }
    }
}

track_insertions() 
{
    self endon("disconnect");

    while( 1 ) 
	{
        self waittill( "destroyed_insertion", owner );

        if( owner.name != self.name )
		{
            self.player_settings["ti_cancel"]++;
		}
    }
}

spawnplayer_edit(cancer) {
	self endon( "disconnect" );
	self endon( "joined_spectators" );
	self notify( "spawned" );
	self notify( "end_respawn" );

	if( isDefined(self.setSpawnPoint) && self maps\mp\gametypes\_playerlogic::tiValidationCheck()) {
		spawnPoint = self.setSpawnPoint;

		self playLocalSound( "tactical_spawn" );

		if ( level.teamBased )
			self playSoundToTeam( "tactical_spawn", level.otherTeam[self.team] );
		else
			self playSound( "tactical_spawn" );

		spawnOrigin = self.setSpawnPoint.playerSpawnPos;
		spawnAngles = self.setSpawnPoint.angles;

		self.last_ti_spawn = gettime();

		if ( isDefined( self.setSpawnPoint.enemyTrigger ) )
			self.setSpawnPoint.enemyTrigger Delete();

		self.setSpawnPoint delete();

		spawnPoint = undefined;
	}
	else
	{
		spawnPoint = self [[level.getSpawnPoint]]();
		spawnOrigin = spawnpoint.origin;
		spawnAngles = spawnpoint.angles;
	}

	self maps\mp\gametypes\_playerlogic::setSpawnVariables();

	hadSpawned = self.hasSpawned;
	self.fauxDead = undefined;
	self.killsThisLife = [];
	self maps\mp\gametypes\_playerlogic::updateSessionState( "playing", "" );
	self maps\mp\_utility::ClearKillcamState();
	self.cancelkillcam = 1;
	self.maxhealth = maps\mp\gametypes\_tweakables::getTweakableValue( "player", "maxhealth" );
	self.health = self.maxhealth;
	self.friendlydamage = undefined;
	self.hasSpawned = true;
	self.spawnTime = getTime();
	self.wasTI = !isDefined( spawnPoint );
	self.afk = false;
	self.lastStand = undefined;
	self.infinalStand = undefined;
	self.inC4Death = undefined;
	self.damagedPlayers = [];
	self.moveSpeedScaler = 1;
	self.killStreakScaler = 1;
	self.xpScaler = 1;
	self.objectiveScaler = 1;
	self.inLastStand = false;
	self.clampedHealth = undefined;
	self.shieldDamage = 0;
	self.shieldBulletHits = 0;
	self.recentShieldXP = 0;
	self.disabledWeapon = 0;
	self.disabledWeaponSwitch = 0;
	self.disabledOffhandWeapons = 0;
	self common_scripts\utility::resetUsability();
	self.avoidKillstreakOnSpawnTimer = 5.0;

	self maps\mp\gametypes\_playerlogic::addToAliveCount();

	if(!self.wasAliveAtMatchStart) {
		acceptablePassedTime = 20;
		if ( maps\mp\_utility::getTimeLimit() > 0 && acceptablePassedTime < maps\mp\_utility::getTimeLimit() * 60 / 4 )
			acceptablePassedTime = maps\mp\_utility::getTimeLimit() * 60 / 4;

		if ( level.inGracePeriod || maps\mp\_utility::getTimePassed() < acceptablePassedTime * 1000 )
			self.wasAliveAtMatchStart = true;
	}

	if(!isdefined(self.thirdperson))
		self setClientDvar( "cg_thirdPerson", "0" );

	self setDepthOfField( 0, 0, 512, 512, 4, 0 );

	if(isDefined(spawnPoint)) {
		self maps\mp\gametypes\_spawnlogic::finalizeSpawnpointChoice( spawnpoint );
		spawnOrigin = maps\mp\gametypes\_playerlogic::getSpawnOrigin( spawnpoint );
		spawnAngles = spawnpoint.angles;
	}
	else
		self.lastSpawnTime = getTime();

	self.spawnPos = spawnOrigin;

	self spawn( spawnOrigin, spawnAngles );
	[[level.onSpawnPlayer]]();

	if ( isDefined( spawnPoint ) )
		self maps\mp\gametypes\_playerlogic::checkPredictedSpawnpointCorrectness( spawnPoint.origin );

	self maps\mp\gametypes\_missions::playerSpawned();

	prof_begin( "spawnPlayer_postUTS" );

	self maps\mp\gametypes\_class::setClass(self.class);
	self maps\mp\gametypes\_class::giveLoadout(self.team, self.class);

	if ( !maps\mp\_utility::gameFlag( "prematch_done" ) )
		self maps\mp\_utility::freezeControlsWrapper( true );
	else
		self maps\mp\_utility::freezeControlsWrapper( false );

	if ( !maps\mp\_utility::gameFlag( "prematch_done" ) || !hadSpawned && game["state"] == "playing" )
	{
		self setClientDvar( "scr_objectiveText", maps\mp\_utility::getObjectiveHintText( self.pers["team"] ) );

		team = self.pers["team"];

		if ( game["status"] == "overtime" )
			thread maps\mp\gametypes\_hud_message::oldNotifyMessage( game["strings"]["overtime"], game["strings"]["overtime_hint"], undefined, (1, 0, 0), "mp_last_stand" );
		else if ( maps\mp\_utility::getIntProperty( "useRelativeTeamColors", 0 ) )
			thread maps\mp\gametypes\_hud_message::oldNotifyMessage( game["strings"][team + "_name"], undefined, game["icons"][team] + "_blue", game["colors"]["blue"] );
		else
			thread maps\mp\gametypes\_hud_message::oldNotifyMessage( game["strings"][team + "_name"], undefined, game["icons"][team], game["colors"][team] );

		thread maps\mp\gametypes\_playerlogic::showSpawnNotifies();
	}

	prof_end( "spawnPlayer_postUTS" );
	waittillframeend;
	self.spawningAfterRemoteDeath = undefined;

	self notify( "spawned_player" );
	level notify ( "player_spawned", self );

	if(game["state"] == "postgame") {
		assert( !level.intermission );
		self maps\mp\gametypes\_gamelogic::freezePlayerForRoundEnd();
	}
}

on_player_killed(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
    attacker notify("player_stats_updated");
    self.linkedto = undefined;
    self.inoomzone = 0;
    self.status = "out";
    self.healthRegenLevel = undefined;
    self.haswallhack = undefined;

    if(isdefined(self.suicide_bomber) && self.suicide_bomber == 1) {
    	if(isdefined(attacker)) {
    		if(sMeansOfDeath != "MOD_FALLING" && sMeansOfDeath != "MOD_SUICIDE" && attacker.classname != "trigger_hurt") {
    			radiusdamage(self.origin, 400, 220, 20, self, "MOD_EXPLOSIVE", "c4_mp");
    			playfx(level.stealthbombfx, self.origin);
    			thread maps\mp\_utility::playsoundinspace("exp_airstrike_bomb", self.origin);
    			playrumbleonposition("artillery_rumble", self.origin);
            	earthquake(.7, .75, self.origin, 1000);
    		}
    	}

    	self.suicide_bomber = undefined;
    }

    if(isdefined(level.nukeinfo.player) && level.nukeinfo.player == self && isdefined(attacker.name))
        level.nukeinfo.player.nukekiller = attacker;

    if(self.sessionteam == "allies")
        level notify("killedsurvivor");

    if(isdefined(attacker)) {
    	if(isdefined(self.usingremote))
    		self thread cleanup_remote();
    }

    if(isdefined(attacker.classname)) {
        if(!self maps\mp\gametypes\_damage::killedSelf(attacker) && attacker.classname != "trigger_hurt")
            self.rtd_canroll = 1;

        if((sMeansOfDeath == "MOD_SUICIDE" || sMeansOfDeath == "MOD_FALLING" || sMeansOfDeath == "MOD_TRIGGER_HURT") && level.teamCount["allies"] == 1 && self.team == "allies") {
            setdvar("suicide_final", self.guid);
        }
    }

    if(isdefined(attacker.name) && attacker.name != self.name) {
        if(sMeansOfDeath == "MOD_MELEE")
            attacker scripts\core\stats::add_xp(150);
        else if(sMeansOfDeath == "MOD_GRENADE_SPLASH")
            attacker scripts\core\stats::add_xp(125);
        else
            attacker scripts\core\stats::add_xp(100);
    }
    else if(isdefined(attacker.owner))
        attacker.owner scripts\core\stats::add_xp(50);

   	maps\mp\gametypes\_damage::PlayerKilled_internal( eInflictor, attacker, self, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, 0 );
}

on_player_damage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
	if(sWeapon == "m320_mp" || sWeapon == "xm25_mp") {
        if(isdefined(eInflictor) && (isdefined(eInflictor.smoke) || isdefined(eInflictor.pusher))) {
            return;
        }
    }

    if(isdefined(eAttacker) && IsPlayer(eAttacker) && isdefined(eAttacker.breaching) && eInflictor == eAttacker && eAttacker.team != self.team && sMeansOfDeath != "MOD_MELEE") {
        eAttacker iPrintLn("^3Wallbreach!");
        eAttacker.hud_damagefeedback setShader("objpoint_flag_opfor", 24, 24);
        eAttacker.hud_damagefeedback.alpha = 0.5;
        eAttacker.hud_damagefeedback.color = (1, 1, 0);
        eAttacker.hud_damagefeedback fadeOverTime(0.25);
        eAttacker.hud_damagefeedback.alpha = 0;
        eAttacker PlayLocalSound( level.kenker_sounds[randomint(level.kenker_sounds.size)] );
        return;
    }

    if(isdefined(eAttacker)) {
        if(isdefined(eAttacker.using_minigun))
            iDamage += 20;

        if(isdefined(eInflictor) && isdefined(eInflictor.heli_explode_death)) {
			self maps\mp\gametypes\_damage::finishPlayerDamageWrapper( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, 0.0 );
            return;
        }

        if(isdefined(eAttacker.used_streak_team) && eAttacker.used_streak_team == "allies" && eAttacker.team == "axis" && maps\mp\_utility::iskillstreakweapon(sWeapon)) {
            return;
        }
    }

	if(isdefined(eInflictor)) {
   		if(sMeansOfDeath == "MOD_CRUSH" && isdefined(eInflictor) && eInflictor.owner.team == self.sessionteam && self != eInflictor.owner) {
        	eInflictor thread detectinside(self);
        	return;
        }
    }

    if(isdefined(self.flag_protection)) {
        if(isdefined(eAttacker) && IsPlayer(eAttacker) && eAttacker.team == "allies" && self.team == "axis") {
            eAttacker iPrintLn("^3Flag Protection!");
            eAttacker.hud_damagefeedback setShader("objpoint_flag_opfor", 24, 24);
            eAttacker.hud_damagefeedback.alpha = 0.5;
            eAttacker.hud_damagefeedback.color = (1, 1, 0);
            eAttacker.hud_damagefeedback fadeOverTime(0.25);
            eAttacker.hud_damagefeedback.alpha = 0;
            return;
        }
    }
    else if(isdefined(self.godmode) && self.godmode == 1) {
        if(isdefined(eAttacker) /* && IsPlayer(eAttacker) */ ) {
            eAttacker iPrintLn("^3Player has Godmode!");
            eAttacker.hud_damagefeedback setShader("damage_feedback_lightarmor", 24, 48);
            eAttacker.hud_damagefeedback.alpha = 1;
            eAttacker.hud_damagefeedback.color = (1, 1, 0);
            eAttacker.hud_damagefeedback fadeOverTime(1);
            eAttacker.hud_damagefeedback.alpha = 0;
            return;
        }
    }
    else if(isdefined(eAttacker)  && IsPlayer(eAttacker) && isdefined(eAttacker.hud_damagefeedback) && eAttacker.hud_damagefeedback.color != (1, 1, 1)) {
        eAttacker.hud_damagefeedback.color = (1, 1, 1);
        return;
    }

    if(isdefined(level.falldamagetriggers) && sMeansOfDeath == "MOD_FALLING") {
        foreach(trig in level.falldamagetriggers) {
            if(self istouching(trig)) {
                self playlocalsound("vest_deployed");
                return;
            }
        }
    }

   	if(isdefined(eAttacker) && eAttacker == self && (self.health - iDamage) <= 0) {
   		if(isdefined(sWeapon) && sWeapon == "remotemissile_projectile_mp")
   			self thread cleanup_remote();
   	}

	maps\mp\gametypes\_damage::Callback_PlayerDamage_internal( eInflictor, eAttacker, self, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}

cleanup_remote() {
	self thermalvisionfofoverlayoff();
    self controlsunlink();
    self cameraunlink();

    self maps\mp\_utility::clearusingremote();
  	level.remotemissileinprogress = undefined;
}

detectinside(stuckplayer) {
    self endon("death");

    if(!isdefined(self.movingoutplayer))
        self.movingoutplayer = 1;
    else
        return;

    while(stuckplayer istouching(self)) {
        stuckplayer setorigin(stuckplayer.origin + (0,0,5));
        wait .05;
    }
}


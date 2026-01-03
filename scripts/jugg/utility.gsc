/*

    INFO:
        - This File Includes Functions who's categorizing doesnt make sense or would bloat the project 

    TODO:
        - None

    DONE:
        - Added in Death Icon and Resized it to be always the size for Splittscreen, removed not needed checks, fadeouts speed up
        
*/

init() 
{
    replacefunc( maps\mp\_utility::isKillstreakWeapon, ::isKillstreakWeapon_Replace );

    replacefunc( maps\mp\gametypes\_killcam::doFinalKillCamFX, ::disableDoFinalKillCamFX );

	replacefunc( maps\mp\perks\_perkfunctions::GlowStickDamageListener, ::GlowStickDamageListener_replace );

	replacefunc( maps\mp\gametypes\_damage::doFinalKillcam, ::doFinalKillcam_edit );
    replacefunc( maps\mp\gametypes\_damage::handleNormalDeath, ::handleNormalDeath_edit );
	replacefunc( maps\mp\gametypes\_damage::handleSuicideDeath, ::handleSuicideDeath_edit );
    replacefunc( maps\mp\gametypes\_damage::Callback_PlayerDamage, ::Callback_PlayerDamage_hook );

    replacefunc( maps\mp\gametypes\_deathicons::adddeathicon, ::on_adddeathicon );
}

on_adddeathicon( var_0, var_1, var_2, var_3 )
{
    var_4 = var_0.origin;

    var_1 endon( "spawned_player" );
    var_1 endon( "disconnect" );

    wait 0.05;

    maps\mp\_utility::waittillslowprocessallowed();

    if ( isdefined( self.lastdeathicon ) )
        self.lastdeathicon destroy();

    var_5 = newteamhudelem( var_2 );
    var_5.x = var_4[0];
    var_5.y = var_4[1];
    var_5.z = var_4[2] + 54;
    var_5.alpha = 0.61;
    var_5.archived = 1;
    var_5 setshader( "headicon_dead", 7, 7 );
    var_5 setwaypoint( 0 );

    self.lastdeathicon = var_5;

    var_5 thread destroyslowly( var_3 );
}

destroyslowly( var_0 )
{
    self endon( "death" );
    
	wait(var_0);
    
	self fadeovertime( 0.5 );
    self.alpha = 0;
    
	wait 0.5;
    
	self destroy();
}

Callback_PlayerDamage_hook(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime) {
    if(level.lastopfer != self.name) {
	    maps\mp\gametypes\_damage::Callback_PlayerDamage_internal( eInflictor, eAttacker, self, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime );
        level.lastopfer = self.name;
        wait .05;
        level.lastopfer = "";
    }
}

handleNormalDeath_edit( lifeId, attacker, eInflictor, sWeapon, sMeansOfDeath ) {
	attacker thread maps\mp\_events::killedPlayer( lifeId, self, sWeapon, sMeansOfDeath );

    self setclientdvars("ui_playercard_prestige", attacker.player_settings["prestige"], "playercard_type", attacker.player_settings["conv_card"]);
    attacker setclientdvars("ui_playercard_prestige", self.player_settings["prestige"], "playercard_type", self.player_settings["conv_card"]);

	attacker SetCardDisplaySlot( self, 8 );
	attacker openMenu( "youkilled_card_display" );

	self SetCardDisplaySlot( attacker, 7 );
	self openMenu( "killedby_card_display" );

	if ( sMeansOfDeath == "MOD_HEAD_SHOT" ) {
		attacker maps\mp\_utility::incPersStat( "headshots", 1 );
		attacker.headshots = attacker maps\mp\_utility::getPersStat( "headshots" );
		attacker maps\mp\_utility::incPlayerStat( "headshots", 1 );

		if ( isDefined( attacker.lastStand ) )
			value = maps\mp\gametypes\_rank::getScoreInfoValue( "kill" ) * 2;
		else
			value = undefined;

		attacker playLocalSound( "bullet_impact_headshot_2" );
	}
	else {
		if ( isDefined( attacker.lastStand ) )
			value = maps\mp\gametypes\_rank::getScoreInfoValue( "kill" ) * 2;
		else
			value = undefined;
	}

	attacker thread maps\mp\gametypes\_rank::giveRankXP( "kill", value, sWeapon, sMeansOfDeath );

	attacker maps\mp\_utility::incPersStat( "kills", 1 );
	attacker.kills = attacker maps\mp\_utility::getPersStat( "kills" );
	attacker maps\mp\_utility::updatePersRatio( "kdRatio", "kills", "deaths" );
	attacker maps\mp\gametypes\_persistence::statSetChild( "round", "kills", attacker.kills );
	attacker maps\mp\_utility::incPlayerStat( "kills", 1 );

	lastKillStreak = attacker.pers["cur_kill_streak"];

	if ( isAlive( attacker ) || attacker.streakType == "support" ) {
		if ( attacker maps\mp\_utility::killShouldAddToKillstreak( sWeapon ) ) {
			attacker thread maps\mp\killstreaks\_killstreaks::giveAdrenaline( "kill" );
			attacker.pers["cur_kill_streak"]++;

			if( !maps\mp\_utility::isKillstreakWeapon( sWeapon ) )
				attacker.pers["cur_kill_streak_for_nuke"]++;

			numKills = 24;
			if( !maps\mp\_utility::isKillstreakWeapon( sWeapon ) && attacker.pers["cur_kill_streak_for_nuke"] == numKills && !isdefined(attacker.hasnuke)) {
                attacker.hasnuke = 1;
				attacker thread maps\mp\killstreaks\_killstreaks::giveKillstreak( "nuke", false, true, attacker, true );
				attacker thread maps\mp\gametypes\_hud_message::killstreakSplashNotify( "nuke", numKills );
			}
		}

		attacker maps\mp\_utility::setPlayerStatIfGreater( "killstreak", attacker.pers["cur_kill_streak"] );

		if ( attacker.pers["cur_kill_streak"] > attacker maps\mp\_utility::getPersStat( "longestStreak" ) )
			attacker maps\mp\_utility::setPersStat( "longestStreak", attacker.pers["cur_kill_streak"] );
	}

	attacker.pers["cur_death_streak"] = 0;

	if(attacker.pers["cur_kill_streak"] > attacker maps\mp\gametypes\_persistence::statGetChild( "round", "killStreak") )
		attacker maps\mp\gametypes\_persistence::statSetChild( "round", "killStreak", attacker.pers["cur_kill_streak"] );

	if(attacker.pers["cur_kill_streak"] > attacker.kill_streak) {
		attacker maps\mp\gametypes\_persistence::statSet( "killStreak", attacker.pers["cur_kill_streak"] );
		attacker.kill_streak = attacker.pers["cur_kill_streak"];
	}

	maps\mp\gametypes\_gamescore::givePlayerScore( "kill", attacker, self );
	maps\mp\_skill::processKill( attacker, self );

	if ( isDefined( level.ac130player ) && level.ac130player == attacker )
		level notify( "ai_killed", self );

	//if ( lastKillStreak != attacker.pers["cur_kill_streak"] )
	level notify ( "player_got_killstreak_" + attacker.pers["cur_kill_streak"], attacker );
	attacker notify( "got_killstreak" , attacker.pers["cur_kill_streak"] );

	attacker notify ( "killed_enemy" );

	if(isDefined(self.UAVRemoteMarkedBy)) {
		if ( self.UAVRemoteMarkedBy != attacker )
			self.UAVRemoteMarkedBy thread maps\mp\killstreaks\_remoteuav::remoteUAV_processTaggedAssist( self );
		self.UAVRemoteMarkedBy = undefined;
	}

	if ( isDefined( level.onNormalDeath ) && attacker.pers[ "team" ] != "spectator" )
		[[ level.onNormalDeath ]]( self, attacker, lifeId );

	if ( !level.teamBased ) {
		self.attackers = [];
		return;
	}

	level thread maps\mp\gametypes\_battlechatter_mp::sayLocalSoundDelayed( attacker, "kill", 0.75 );

	if ( isDefined( self.lastAttackedShieldPlayer ) && isDefined( self.lastAttackedShieldTime ) && self.lastAttackedShieldPlayer != attacker )
	{
		if ( getTime() - self.lastAttackedShieldTime < 2500 )
		{
			self.lastAttackedShieldPlayer thread maps\mp\gametypes\_gamescore::processShieldAssist( self );

			// if you are using the assists perk, then every assist is a kill towards a killstreak
			if( self.lastAttackedShieldPlayer maps\mp\_utility::_hasPerk( "specialty_assists" ) )
			{
				self.lastAttackedShieldPlayer.pers["assistsToKill"]++;

				if( !( self.lastAttackedShieldPlayer.pers["assistsToKill"] % 2 ) )
				{
					self.lastAttackedShieldPlayer maps\mp\gametypes\_missions::processChallenge( "ch_hardlineassists" );
					self.lastAttackedShieldPlayer maps\mp\killstreaks\_killstreaks::giveAdrenaline( "kill" );
					self.lastAttackedShieldPlayer.pers["cur_kill_streak"]++;
				}
			}
			else
			{
				self.lastAttackedShieldPlayer.pers["assistsToKill"] = 0;
			}
		}
		else if ( isAlive( self.lastAttackedShieldPlayer ) && getTime() - self.lastAttackedShieldTime < 5000 )
		{
			forwardVec = vectorNormalize( anglesToForward( self.angles ) );
			shieldVec = vectorNormalize( self.lastAttackedShieldPlayer.origin - self.origin );

			if ( vectorDot( shieldVec, forwardVec ) > 0.925 )
			{
				self.lastAttackedShieldPlayer thread maps\mp\gametypes\_gamescore::processShieldAssist( self );

				if( self.lastAttackedShieldPlayer maps\mp\_utility::_hasPerk( "specialty_assists" ) )
				{
					self.lastAttackedShieldPlayer.pers["assistsToKill"]++;

					if( !( self.lastAttackedShieldPlayer.pers["assistsToKill"] % 2 ) )
					{
						self.lastAttackedShieldPlayer maps\mp\gametypes\_missions::processChallenge( "ch_hardlineassists" );
						self.lastAttackedShieldPlayer maps\mp\killstreaks\_killstreaks::giveAdrenaline( "kill" );
						self.lastAttackedShieldPlayer.pers["cur_kill_streak"]++;
					}
				}
				else
				{
					self.lastAttackedShieldPlayer.pers["assistsToKill"] = 0;
				}
			}
		}
	}

	if ( isDefined( self.attackers )) {
		foreach ( player in self.attackers ) {
			if ( !isDefined( player ) )
				continue;

			if ( player == attacker )
				continue;

			player thread maps\mp\gametypes\_gamescore::processAssist( self );

			player.pers["assistsToKill"]++;

			if( !( player.pers["assistsToKill"] % 2 ) ) {
				player maps\mp\gametypes\_missions::processChallenge( "ch_hardlineassists" );
				player maps\mp\killstreaks\_killstreaks::giveAdrenaline( "kill" );
				player.pers["cur_kill_streak"]++;

				numKills = 24;
				if( player.pers["cur_kill_streak"] == numKills && !isdefined(player.hasnuke)) {
					player.hasnuke = 1;
					player thread maps\mp\killstreaks\_killstreaks::giveKillstreak( "nuke", false, true, player, true );
					player thread maps\mp\gametypes\_hud_message::killstreakSplashNotify( "nuke", numKills );
				}
			}
		}
		self.attackers = [];
	}
}

handleSuicideDeath_edit( sMeansOfDeath, sHitLoc ) {
    self setclientdvars("ui_playercard_prestige", self.player_settings["prestige"], "playercard_type", self.player_settings["conv_card"]);

	self SetCardDisplaySlot( self, 7 );
	self openMenu( "killedby_card_display" );

	self thread [[ level.onXPEvent ]]( "suicide" );
	self maps\mp\_utility::incPersStat( "suicides", 1 );
	self.suicides = self maps\mp\_utility::getPersStat( "suicides" );

	if ( sMeansOfDeath == "MOD_SUICIDE" && sHitLoc == "none" && isDefined( self.throwingGrenade ) )
		self.lastGrenadeSuicideTime = gettime();
}

doFinalKillcam_edit() 
{
	level waittill ( "round_end_finished" );

	level.showingFinalKillcam = true;

	winner = "none";
	if( IsDefined( level.finalKillCam_winner ) )
		winner = level.finalKillCam_winner;

	delay = level.finalKillCam_delay[ winner ];
	victim = level.finalKillCam_victim[ winner ];
	attacker = level.finalKillCam_attacker[ winner ];
	attackerNum = level.finalKillCam_attackerNum[ winner ];
	killCamEntityIndex = level.finalKillCam_killCamEntityIndex[ winner ];
	killCamEntityStartTime = level.finalKillCam_killCamEntityStartTime[ winner ];
	sWeapon = level.finalKillCam_sWeapon[ winner ];
	deathTimeOffset = level.finalKillCam_deathTimeOffset[ winner ];
	psOffsetTime = level.finalKillCam_psOffsetTime[ winner ];
	timeRecorded = level.finalKillCam_timeRecorded[ winner ];
	timeGameEnded = level.finalKillCam_timeGameEnded[ winner ];

	if( !isDefined( victim ) ||
		!isDefined( attacker ) )
	{
		level.showingFinalKillcam = false;
		level notify( "final_killcam_done" );
		return;
	}

	killCamBufferTime = 15;
	killCamOffsetTime = timeGameEnded - timeRecorded;
	if( killCamOffsetTime > killCamBufferTime )
	{
		level.showingFinalKillcam = false;
		level notify( "final_killcam_done" );
		return;
	}

	if ( isDefined( attacker ) )
		attacker.finalKill = true;

	postDeathDelay = (( getTime() - victim.deathTime ) / 1000);

	foreach(player in level.players){
		player closePopupMenu();
		player closeInGameMenu();
		if( IsDefined( level.nukeDetonated ) && player.player_settings["render_skybox"] == 1 )
			player VisionSetNakedForPlayer( level.nukeVisionSet, 0 );
		else
			player VisionSetNakedForPlayer( "", 0 ); // go to default visionset

        player setclientdvars("ui_playercard_prestige", attacker.player_settings["prestige"], "playercard_type", attacker.player_settings["conv_card"]);

		player.killcamentitylookat = victim getEntityNumber();

		if ( (player != victim || (!maps\mp\_utility::isRoundBased() || maps\mp\_utility::isLastRound())) && player maps\mp\_utility::_hasPerk( "specialty_copycat" ) )
			player maps\mp\_utility::_unsetPerk( "specialty_copycat" );

		player thread maps\mp\gametypes\_killcam::killcam( attackerNum, killcamentityindex, killcamentitystarttime, sWeapon, postDeathDelay + deathTimeOffset, psOffsetTime, 0, 10000, attacker, victim );
	}

	wait .1;

	while ( maps\mp\gametypes\_damage::anyPlayersInKillcam() )
		wait .05;

	level notify( "final_killcam_done" );
	level.showingFinalKillcam = false;
}

disableDoFinalKillCamFX( camtime ) 
{
	if( isDefined( level.doingFinalKillcamFx ) )
    	return;

    level.doingFinalKillcamFx = 1;
    level.doingFinalKillcamFx = undefined;
}

GlowStickDamageListener_replace( owner )
{
	self endon ( "death" );

	self setCanDamage( true );
	// use a health buffer to prevent dying to friendly fire
	self.health = 999999; // keep it from dying anywhere in code
	self.maxHealth = 100; // this is the health we'll check
	self.damageTaken = 0; // how much damage has it taken

	while( true )
	{
		self waittill( "damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags, weapon );
		if(attacker == self.owner)
			continue;

		if ( !maps\mp\gametypes\_weapons::friendlyFireCheck( self.owner, attacker ) )
			continue;

		if( IsDefined( weapon ) )
		{
			switch( weapon )
			{
			case "concussion_grenade_mp":
			case "flash_grenade_mp":
			case "smoke_grenade_mp":
				continue;
			}
		}

		if ( !isdefined( self ) )
			return;

		if ( type == "MOD_MELEE" )
			self.damageTaken += self.maxHealth;

		if ( isDefined( iDFlags ) && ( iDFlags & level.iDFLAGS_PENETRATION ) )
			self.wasDamagedFromBulletPenetration = true;

		self.wasDamaged = true;

		self.damageTaken += damage;

		if( isPlayer( attacker ) )
		{
			attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback( "tactical_insertion" );
		}

		if ( self.damageTaken >= self.maxHealth )
		{
			if ( isDefined( owner ) && attacker != owner )
			{
				attacker notify ( "destroyed_insertion", owner );
				attacker notify( "destroyed_explosive" ); // count towards SitRep Pro challenge
				owner thread maps\mp\_utility::leaderDialogOnPlayer( "ti_destroyed" );
			}

			attacker thread maps\mp\perks\_perkfunctions::deleteTI( self );
		}
	}
}

isKillstreakWeapon_replace( weapon )
{
	if( !IsDefined( weapon ) )
	{
		AssertMsg( "isKillstreakWeapon called without a weapon name passed in" );
		return false;
	}

	if ( weapon == "none" )
		return false;

	tokens = strTok( weapon, "_" );
	foundSuffix = false;

	if( weapon != "destructible_car" && weapon != "barrel_mp" )
	{
		foreach(token in tokens)
		{
			if( token == "mp" )
			{
				foundSuffix = true;
				break;
			}
		}

		if ( !foundSuffix )
		{
			weapon += "_mp";
		}
	}

	if ( isSubStr( weapon, "destructible" ) )
		return false;

	if ( isSubStr( weapon, "killstreak" ) )
		return true;

	if ( maps\mp\killstreaks\_airdrop::isAirdropMarker( weapon ) )
		return true;

	if ( isDefined( level.killstreakWeildWeapons[weapon] ) )
		return true;

    if ( weapon == "c4_mp" || weapon == "flash_mp" || weapon == "smoke_mp" || weapon == "concussion_mp" || weapon == "emp_mp")
		return false;

	return false;
}
/*

    INFO:
        - This File Includes the stats system

    TODO:
		- Re-write for a simpler coding style
		- Move the on_connect into jugg\playerlogic.gsc
		
    DONE:
        - Fixed Prestige Logic, removed not needed code
        
*/

init()
{
    replacefunc( maps\mp\_utility::isBuffUnlockedForWeapon, ::isBuffUnlockedForWeaponReplace );
    replacefunc( maps\mp\gametypes\_gamelogic::setWeaponStat, ::setWeaponStatReplace );
	replacefunc( maps\mp\gametypes\_rank::updateRankAnnounceHUD, ::draw_rank_popup );
	replacefunc( maps\mp\gametypes\_hud_message::actionNotifyMessage, ::actionNotifyMessageReplace );
	replacefunc( maps\mp\gametypes\_missions::mayProcessChallenges, ::mayProcessChallengesreplace );
    replacefunc( maps\mp\gametypes\_rank::updateRank, ::updateRank_hook );

    level thread on_connect();
}

main()
{
	replacefunc(maps\mp\gametypes\_rank::init, ::_rank_init_edit);
}

isBuffUnlockedForWeaponReplace( buffRef, weaponRef ) {
	return false;
}

setWeaponStatReplace( name, incValue, statName )
{
	if ( !incValue )
		return;

	weaponClass = maps\mp\_utility::getWeaponClass( name );

	// we are not currently tracking killstreaks or deathstreaks
	if( maps\mp\_utility::isKillstreakWeapon( name ) || weaponClass == "killstreak" || weaponClass == "deathstreak" || weaponClass == "other" )
		return;

	// we don't want to track environment weapons, like a mounted turret
	if( maps\mp\_utility::isEnvironmentWeapon( name ) )
		return;

	if( weaponClass == "weapon_grenade" || weaponClass == "weapon_riot" || weaponClass == "weapon_explosive" )
	{
			return;
	}

	if( statName != "deaths" )
	{
		name = self getCurrentWeapon();
	}

	// defensive check to ensure current weapon isnt killstreak or deathstreaks weapon
	if( maps\mp\_utility::isKillstreakWeapon( name ) || weaponClass == "killstreak" || weaponClass == "deathstreak" || weaponClass == "other" )
		return;

	if( !isdefined( self.trackingWeaponName ) )
		self.trackingWeaponName = name;

	if( name != self.trackingWeaponName )
	{
		self maps\mp\gametypes\_persistence::updateWeaponBufferedStats();
		self.trackingWeaponName = name;
	}

	switch( statName )
	{
		case "shots":
			self.trackingWeaponShots++;
			break;
		case "hits":
			self.trackingWeaponHits++;
			break;
		case "headShots":
			self.trackingWeaponHeadShots++;
			self.trackingWeaponHits++;
			break;
		case "kills":
			self.trackingWeaponKills++;
			break;
	}

	if( statName == "deaths" )
	{
		//println("wrote deaths");
		tmp = name;
		tokens = strTok( name, "_" );

		altAttachment = undefined;

		//updating for IW5 weapons
		if ( tokens[0] == "iw5" )
			weaponName = tokens[0] + "_" + tokens[1];
		else if( tokens[0] == "alt" )
			weaponName = tokens[1] + "_" + tokens[2];
		else
			weaponName = tokens[0];

		if ( !maps\mp\_utility::isCACPrimaryWeapon( weaponName ) && !maps\mp\_utility::isCACSecondaryWeapon( weaponName ) )
			return;

		/*
		if ( isSubStr( weaponName, "akimbo" ) )
		{
			weaponName = fixAkimboString( weaponName, false );
		}
		*/

		if ( tokens[0] == "alt" )
		{
			weaponName = tokens[1] + "_" + tokens[2];

			foreach( token in tokens )
			{
				if ( token == "gl" || token == "gp25" || token == "m320" )
				{
					altAttachment = "gl";
					break;
				}
				if ( token == "shotgun" )
				{
					altAttachment = "shotgun";
					break;
				}
			}
		}

		if( isDefined( altAttachment) && ( altAttachment == "gl" || altAttachment == "shotgun" ) )
		{
			self maps\mp\gametypes\_persistence::incrementAttachmentStat( altAttachment, statName, incValue );
			self maps\mp\_matchdata::logAttachmentStat( altAttachment, statName, incValue);
			return;
		}

		self maps\mp\gametypes\_persistence::incrementWeaponStat( weaponName, statName, incValue );
		self maps\mp\_matchdata::logWeaponStat( weaponName, "deaths", incValue );

		//weaponAttachments = getWeaponAttachments( name );
		if( tokens[0] != "none" )
		{
			for( i = 0; i < tokens.size; i++ )
			{
				//iw5 token magic
				if(tokens[i] == "alt" )
				{
					i += 2;
					continue;
				}

				//iw5 token magic
				if(tokens[i] == "iw5" )
				{
					i += 1;
					continue;
				}

				if(tokens[i] == "mp" )
					continue;

				if( isSubStr( tokens[i], "camo" ) )
					continue;

				//handles iw5 scoped weapons
				if( isSubStr( tokens[i], "scope" ) && !isSubStr( tokens[i], "vz" ) )
					continue;

				if ( isSubStr( tokens[i], "scope" ) && isSubStr( tokens[i], "vz" ) )
					tokens[i] = "vzscope";

				tokens[i] = maps\mp\_utility::validateAttachment( tokens[i] );

				//IW4 weapon check
				if ( i == 0 && ( tokens[i] != "iw5" && tokens[i] != "alt" ) )
					continue;

				self maps\mp\gametypes\_persistence::incrementAttachmentStat( tokens[i], statName, incValue );
				self maps\mp\_matchdata::logAttachmentStat( tokens[i], statName, incValue);
			}
		}
	}
}

draw_rank_popup() 
{
	rank_icon = newclienthudelem(self);
	rank_icon.y = -160;
	rank_icon.alignx = "center";
	rank_icon.aligny = "middle";
	rank_icon.horzalign = "center";
	rank_icon.vertalign = "middle";
	rank_icon.archived = false;
	rank_icon.foreground = true;
	rank_icon.alpha = 0;
	rank_icon.hidewheninmenu = true;
	rank_icon.hidewhendead = true;
	rank_icon setShader(tableLookup("mp/rankIconTable.csv", 0, maps\mp\gametypes\_rank::getRankForXp(self.player_settings["xp"]), self.player_settings["prestige"] + 1), 102, 102);

	level_hint = newclienthudelem(self);
	level_hint.y = -129;
	level_hint.alignx = "center";
	level_hint.aligny = "middle";
	level_hint.horzalign = "center";
	level_hint.vertalign = "middle";
	level_hint.archived = false;
	level_hint.foreground = true;
	level_hint.fontscale = 1.15;
	level_hint.alpha = 0;
	level_hint.color = (1, 1, 1);
	level_hint.hidewheninmenu = true;
	level_hint.hidewhendead = true;
	level_hint.font = "default";
	level_hint.label = &"LEVEL ^3&&1";
	level_hint setvalue(maps\mp\gametypes\_rank::getRankForXp(self.player_settings["xp"]) + 1);

    self playlocalsound("mp_level_up");

	rank_icon fadeovertime(.25);
	rank_icon scaleovertime(.25, 46, 46);
	rank_icon.alpha = 1;

	wait .25;
	level_hint fadeovertime(.25);
	level_hint.alpha = 1;

	wait 3;
	rank_icon fadeovertime(.25);
	level_hint fadeovertime(.25);
	rank_icon.alpha = 0;
	level_hint.alpha = 0;

	wait .25;
	rank_icon destroy();
	level_hint destroy();
}

actionNotifyMessageReplace( actionData )
{
	self endon ( "disconnect" );

	assert( isDefined( actionData.slot ) );
	slot = actionData.slot;

	if ( level.gameEnded )
	{
		wait ( 0 );

		if ( isDefined( actionData.type ) && ( actionData.type == "rank" || actionData.type == "weaponRank" ) )
		{
			self setClientDvar( "ui_promotion", 1 );
			self.postGamePromotion = true;
		}
		else if ( isDefined( actionData.type ) && actionData.type == "challenge" )
		{
			self.pers["postGameChallenges"]++;
			self setClientDvar( "ui_challenge_"+ self.pers["postGameChallenges"] +"_ref", actionData.name );
		}

		if ( self.splashQueue[ slot ].size )
			self thread maps\mp\gametypes\_hud_message::dispatchNotify( slot );

		return;
	}
	else
	{
		if(isDefined( actionData.type ) && ( actionData.type == "rank"))
		{
			return;
		}
	}

	assertEx( tableLookup( "mp/splashTable.csv", 0, actionData.name, 0 ) != "", "ERROR: unknown splash - " + actionData.name );

	if ( tableLookup( "mp/splashTable.csv", 0, actionData.name, 0 ) != "" )
	{
		if ( isDefined( actionData.playerCardPlayer ) )
			self SetCardDisplaySlot( actionData.playerCardPlayer, 5 );

		if ( isDefined( actionData.optionalNumber ) )
			self ShowHudSplash( actionData.name, actionData.slot, actionData.optionalNumber );
		else
			self ShowHudSplash( actionData.name, actionData.slot );

		self.doingSplash[ slot ] = actionData;

		duration = maps\mp\_utility::stringToFloat( tableLookup( "mp/splashTable.csv", 0, actionData.name, 4 ) );

		if ( isDefined( actionData.sound ) )
			self playLocalSound( actionData.sound );

		if ( isDefined( actionData.leaderSound ) )
		{
			if ( isDefined( actionData.leaderSoundGroup ) )
				self maps\mp\_utility::leaderDialogOnPlayer( actionData.leaderSound, actionData.leaderSoundGroup, true );
			else
				self maps\mp\_utility::leaderDialogOnPlayer( actionData.leaderSound );
		}

		self notify ( "actionNotifyMessage" + slot );
		self endon ( "actionNotifyMessage" + slot );

		wait ( duration - 0.05 );

		self.doingSplash[ slot ] = undefined;
	}

	if ( self.splashQueue[ slot ].size )
		self thread maps\mp\gametypes\_hud_message::dispatchNotify( slot );
}

mayProcessChallengesreplace() 
{
	return false;
}

updateRank_hook(value) {
	newRankId = maps\mp\gametypes\_rank::getRankForXp(self.player_settings["xp"]);

	if(newRankId == self.rank)
		return false;

    if(self.player_settings["prestige"] != 40 && newRankId >= 79) {
        self.rank = 79;
	    self setRank(79);
        return false;
    }

    self.rank = newRankId;
    self setRank(newRankId);

	return true;
}

on_connect() 
{
    while( 1 ) 
	{
        level waittill( "connected", player );

        player thread player_settings_main();
        player.survivor_melee_kills = 0;

        player setclientdvar("inf_xp", getdvarint("inf_xp"));
    }
}


update_stats_aftertime( time ) 
{
    self endon( "disconnect" );

    while( 1 ) 
    {
        wait time;

        self notify( "player_stats_updated" );
    }
}

add_xp( value ) 
{
    value = int( value * getdvarint( "inf_xp" ) );
    if( isdefined( self.player_settings[ "special_xp" ] ) && self.player_settings[ "special_xp"]  != 0 && self.player_settings[ "special_xp" ] > getdvarint( "inf_xp" ) )
    {
        value = int(value * self.player_settings ["special_xp" ] );
    }

    if( ( self.player_settings[ "xp" ] + value ) > maps\mp\gametypes\_rank::getRankInfoMaxXP( level.maxRank ) )
        self.player_settings[ "xp" ] = maps\mp\gametypes\_rank::getRankInfoMaxXP( level.maxRank );
    else
    {   
        self.player_settings["xp"] += value;
    }
}

prestige_update() 
{
    if( self.player_settings[ "xp" ] >= maps\mp\gametypes\_rank::getRankInfoMaxXP( 80 ) && self.player_settings[ "prestige" ] < level.maxPrestige ) 
	{
		self.player_settings[ "xp" ] = self.player_settings[ "xp" ] - maps\mp\gametypes\_rank::getRankInfoMaxXP( 80 );
		if( self.player_settings[ "xp" ] < 0 )
			self.player_settings[ "xp" ] = 0;

		var_1 = self maps\mp\gametypes\_rank::getRankForXp( self.player_settings[ "xp" ] );
		var_2 = self.player_settings[ "prestige" ] + 1;
        self.player_settings[ "prestige" ] = var_2;

		self setRank( var_1, var_2 );

		self tell_raw( "^8^7[ ^8Information ^7]: You Are Now Prestige ^8" + var_2 );

        self setclientdvar( "inf_prestige", self.player_settings[ "prestige" ] );

        self notify( "player_stats_updated" );
	}
}

csv_decode(string) {
    if(!isdefined(string))
        return;

	result = [];

	rows = strToK(string, "\r\n");
	columns = strToK(rows[0], ",");

	for (x = 1; x < rows.size; x++) {
		row = strToK(rows[x], ",");

		for (y = 0; y < columns.size; y++) {
			r_index = (x - 1);
			c_index = columns[y];

			result[r_index][c_index] = row[y];
		}
	}

	return result;
}

csv_encode(array) {
	if (!isDefined(array[0])) {
		temp_array = array;
		array = [];
		array[0] = temp_array;
	}

	columns = GetArrayKeys(array[0]);
	csv_result = "";

	for (x = -1; x < array.size; x++) {
		c_i = 0;

		foreach(column in columns) {
			seperator = ",";
			c_i++;

			if (c_i == columns.size) {
				row_id = int(x + 1);
				seperator = (row_id == int(array.size)) ? "" : "\n";
				c_i = 0;
			}

			if (x == -1)
				csv_result += column + seperator;

			else
				csv_result += array[x][column] + seperator;
		}
	}

	return csv_result;
}

player_settings_main() {
    self endon("disconnect");

    players_dir = level.basepath + "/players/" + self.guid + "/infected_data.csv";
    player_csv_data = readFile(players_dir);

    self.player_settings                = [];
    needs_update                        = undefined;

    int_columns = strTok("masked,inf_ks_5,inf_ks_10,inf_ks_15,inf_ks_20,inf_ks_25,inf_ks_30,challenge_halloween,called_in_moabs,assists,xp,prestige,deaths,suicides,died_by_moabs,kills,headshots,gc_hud,custom_ents,ui_scorelimit,render_skybox,cj_challenge_01,bb_deaths,inf_teamcolor_inf,inf_teamcolor_surv,conv_card,chicken_kill,ti_cancel,choosen_pres,cl_voice,xp_bar,velocity,cancelled_moabs,inf_kills,surv_kills,bounces,tk_kills,nade_kills,betty_kills,melee_kills,knife_moab_challenge", ",");

    if(!isDefined(player_csv_data) || player_csv_data == "") {
        keys = getarraykeys(level.base_values);

        for(i = 0;i < keys.size;i++)
            self.player_settings[keys[i]] = level.base_values[keys[i]];

        needs_update = 1;
    }
    else {
        self.player_settings = csv_decode(player_csv_data)[0];

        foreach(i_column in int_columns) {
            if(!isdefined(self.player_settings[i_column])) {
                self.player_settings[i_column] = level.base_values[i_column];

                needs_update = 1;
            }
        }
    }

    foreach(i_column in int_columns) {
        if(i_column != "conv_card")
            self.player_settings[i_column] = int(self.player_settings[i_column]);
    }

    if(isdefined(self.player_settings["special_xp"]))
        self.player_settings["special_xp"] = int(self.player_settings["special_xp"]);
    if(isdefined(self.player_settings["special_xp_time"]))
        self.player_settings["special_xp_time"] = int(self.player_settings["special_xp_time"]);


    self thread update_stats_aftertime(25);
   
    self setclientdvars("inf_ks_30", self.player_settings["inf_ks_30"], 
                        "inf_ks_25", self.player_settings["inf_ks_25"], 
                        "inf_ks_20", self.player_settings["inf_ks_20"], 
                        "inf_ks_15", self.player_settings["inf_ks_15"], 
                        "inf_ks_10", self.player_settings["inf_ks_10"], 
                        "inf_ks_5", self.player_settings["inf_ks_5"], 
                        "challenge_halloween", self.player_settings["challenge_halloween"], 
                        "ui_username", self.name, "inf_gc_hud", self.player_settings["gc_hud"], 
                        "custom_ents", self.player_settings["custom_ents"], 
                        "ui_value", 0, 
                        "inf_render_skybox", self.player_settings["render_skybox"], 
                        "inf_bb_deaths", self.player_settings["bb_deaths"], 
                        "cj_challenge_01", self.player_settings["cj_challenge_01"], 
                        "inf_teamcolor_surv", 6, 
                        "inf_teamcolor_inf", 4, 
                        "inf_chickens", self.player_settings["chicken_kill"], 
                        "inf_hud_xp_bar", self.player_settings["xp_bar"], 
                        "inf_hud_velocity", self.player_settings["velocity"], 
                        "inf_ti_cancel", self.player_settings["ti_cancel"], 
                        "inf_experience", self.player_settings["xp"], 
                        "inf_challenge_1", self.player_settings["knife_moab_challenge"], 
                        "inf_nade_kills", self.player_settings["nade_kills"], 
                        "inf_surv_kills", self.player_settings["surv_kills"], 
                        "inf_inf_kills", self.player_settings["inf_kills"], 
                        "inf_melee_kills", self.player_settings["melee_kills"], 
                        "inf_prestige", self.player_settings["prestige"], 
                        "inf_moabs", self.player_settings["called_in_moabs"], 
                        "inf_cancel_moabs", self.player_settings["cancelled_moabs"]);

    if(self.player_settings["ui_scorelimit"] == 1)
        self setclientdvar("inf_scorelimit", 18);
    else
        self setclientdvar("inf_scorelimit", 0);

    self.rank = maps\mp\gametypes\_rank::getRankForXp(self.player_settings["xp"]);

    self.player_settings["conv_card"] = level.calling_cards[ randomint( level.calling_cards.size ) ];

    self SetClientDvar("cg_teamcolor_allies", "0.831 0.553 0 1");
    self SetClientDvar("cg_teamcolor_axis", ".75 .25 .25 1");

    wait .05;
    
    if(self.player_settings["choosen_pres"] != -1)
        self setrank(self.pers["rank"], self.player_settings["choosen_pres"]);

    self setrank(self.rank, self.player_settings["prestige"]);

    while(1) {
        if(!isdefined(needs_update))
            self waittill("player_stats_updated");
        else
            needs_update = undefined;

        player_data = csv_encode(self.player_settings);
        writeFile(players_dir, player_data);

        self setclientdvars( "inf_ks_30", self.player_settings["inf_ks_30"], 
                            "inf_ks_25", self.player_settings["inf_ks_25"], 
                            "inf_ks_20", self.player_settings["inf_ks_20"], 
                            "inf_ks_15", self.player_settings["inf_ks_15"], 
                            "inf_ks_10", self.player_settings["inf_ks_10"], 
                            "inf_ks_5", self.player_settings["inf_ks_5"], 
                            "challenge_halloween", self.player_settings["challenge_halloween"], 
                            "ui_username", self.name, 
                            "inf_gc_hud", self.player_settings["gc_hud"], 
                            "custom_ents", self.player_settings["custom_ents"], 
                            "ui_value", 0, 
                            "inf_render_skybox", self.player_settings["render_skybox"], 
                            "inf_bb_deaths", self.player_settings["bb_deaths"], 
                            "cj_challenge_01", self.player_settings["cj_challenge_01"], 
                            "inf_teamcolor_surv", 6, 
                            "inf_teamcolor_inf", 4, 
                            "inf_chickens", self.player_settings["chicken_kill"], 
                            "inf_hud_xp_bar", self.player_settings["xp_bar"], 
                            "inf_hud_velocity", self.player_settings["velocity"], 
                            "inf_ti_cancel", self.player_settings["ti_cancel"], 
                            "inf_experience", self.player_settings["xp"],
                            "inf_challenge_1", self.player_settings["knife_moab_challenge"], 
                            "inf_nade_kills", self.player_settings["nade_kills"], 
                            "inf_surv_kills", self.player_settings["surv_kills"], 
                            "inf_inf_kills", self.player_settings["inf_kills"], 
                            "inf_melee_kills", self.player_settings["melee_kills"], 
                            "inf_prestige", self.player_settings["prestige"], 
                            "inf_moabs", self.player_settings["called_in_moabs"], 
                            "inf_cancel_moabs", self.player_settings["cancelled_moabs"]
                            );
    }
}

registerScoreInfo( type, value )
{ 
	level.scoreInfo[type]["value"] = value; 
}

_rank_init_edit() {
	level.scoreInfo = [];
	level.xpScale = getDvarInt( "scr_xpscale" );

	if ( level.xpScale > 4 || level.xpScale < 0)
		exitLevel( false );

    registerScoreInfo( "kill", 50 );
	registerScoreInfo( "headshot", 50 );
	registerScoreInfo( "assist", 10 );
	registerScoreInfo( "suicide", 0 );
	registerScoreInfo( "teamkill", 0 );
    registerScoreInfo( "final_rogue", 200 );
	registerScoreInfo( "draft_rogue", 100 );
	registerScoreInfo( "survivor", 100 );
	registerScoreInfo( "win", 1 );
	registerScoreInfo( "loss", 0.5 );
	registerScoreInfo( "tie", 0.75 );
	registerScoreInfo( "capture", 300 );
	registerScoreInfo( "defend", 300 );

	level.xpScale = min( level.xpScale, 4 );
	level.xpScale = max( level.xpScale, 0 );

	level.rankTable = [];
	level.weaponRankTable = [];

	precacheShader("white");

	precacheString( &"RANK_PLAYER_WAS_PROMOTED_N" );
	precacheString( &"RANK_PLAYER_WAS_PROMOTED" );
	precacheString( &"RANK_WEAPON_WAS_PROMOTED" );
	precacheString( &"RANK_PROMOTED" );
	precacheString( &"RANK_PROMOTED_WEAPON" );
	precacheString( &"MP_PLUS" );
	precacheString( &"RANK_ROMANI" );
	precacheString( &"RANK_ROMANII" );
	precacheString( &"RANK_ROMANIII" );

	precacheString( &"SPLASHES_LONGSHOT" );
	precacheString( &"SPLASHES_PROXIMITYASSIST" );
	precacheString( &"SPLASHES_PROXIMITYKILL" );
	precacheString( &"SPLASHES_EXECUTION" );
	precacheString( &"SPLASHES_AVENGER" );
	precacheString( &"SPLASHES_ASSISTEDSUICIDE" );
	precacheString( &"SPLASHES_DEFENDER" );
	precacheString( &"SPLASHES_POSTHUMOUS" );
	precacheString( &"SPLASHES_REVENGE" );
	precacheString( &"SPLASHES_DOUBLEKILL" );
	precacheString( &"SPLASHES_TRIPLEKILL" );
	precacheString( &"SPLASHES_MULTIKILL" );
	precacheString( &"SPLASHES_BUZZKILL" );
	precacheString( &"SPLASHES_COMEBACK" );
	precacheString( &"SPLASHES_KNIFETHROW" );
	precacheString( &"SPLASHES_ONE_SHOT_KILL" );

	level.maxRank = int(tableLookup( "mp/rankTable.csv", 0, "maxrank", 1 ));
	level.maxPrestige = int(tableLookup( "mp/rankIconTable.csv", 0, "maxprestige", 1 ));

	rankId = 0;
	rankName = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );

	while ( isDefined( rankName ) && rankName != "" )
	{
		level.rankTable[rankId][1] = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );
		level.rankTable[rankId][2] = tableLookup( "mp/ranktable.csv", 0, rankId, 2 );
		level.rankTable[rankId][3] = tableLookup( "mp/ranktable.csv", 0, rankId, 3 );
		level.rankTable[rankId][7] = tableLookup( "mp/ranktable.csv", 0, rankId, 7 );

		precacheString( tableLookupIString( "mp/ranktable.csv", 0, rankId, 16 ) );

		rankId++;
		rankName = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );
	}

	weaponMaxRank = int(tableLookup( "mp/weaponRankTable.csv", 0, "maxrank", 1 ));
	for( i = 0; i < weaponMaxRank + 1; i++ )
	{
		level.weaponRankTable[i][1] = tableLookup( "mp/weaponRankTable.csv", 0, i, 1 );
		level.weaponRankTable[i][2] = tableLookup( "mp/weaponRankTable.csv", 0, i, 2 );
		level.weaponRankTable[i][3] = tableLookup( "mp/weaponRankTable.csv", 0, i, 3 );
	}

	level thread maps\mp\gametypes\_rank::patientZeroWaiter();
	level thread maps\mp\gametypes\_rank::onPlayerConnect();
}
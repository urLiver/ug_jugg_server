/*

    INFO:
        - This File Includes the Functions Replacing for the general _killstreaks.gsc file

    TODO:
        - Fix Nuke icon on Sentry Airdrop

    DONE:
        - None
        
*/

KILLSTREAK_STRING_TABLE = "mp/killstreakTable.csv";
STREAKCOUNT_MAX_COUNT = 3;
KILLSTREAK_NAME_COLUMN = 1;
KILLSTREAK_KILLS_COLUMN = 4;
KILLSTREAK_EARNED_HINT_COLUMN = 6;
KILLSTREAK_SOUND_COLUMN = 7;
KILLSTREAK_EARN_DIALOG_COLUMN = 8;
KILLSTREAK_ENEMY_USE_DIALOG_COLUMN = 11;
KILLSTREAK_WEAPON_COLUMN = 12;
KILLSTREAK_ICON_COLUMN = 14;
KILLSTREAK_OVERHEAD_ICON_COLUMN = 15;
KILLSTREAK_DPAD_ICON_COLUMN = 16;

NUM_KILLS_GIVE_ALL_PERKS = 8;

KILLSTREAK_GIMME_SLOT = 0;
KILLSTREAK_SLOT_1 = 1;
KILLSTREAK_SLOT_2 = 2;
KILLSTREAK_SLOT_3 = 3;
KILLSTREAK_ALL_PERKS_SLOT = 4;
KILLSTREAK_STACKING_START_SLOT = 5;

init()
{
    replacefunc(maps\mp\killstreaks\_killstreaks::getKillstreakInformEnemy, ::getKillstreakInformEnemy_replace);
    replacefunc(maps\mp\killstreaks\_killstreaks::getKillstreakSound, ::getKillstreakSound_replace);
    replacefunc(maps\mp\killstreaks\_killstreaks::getKillstreakWeapon, ::getKillstreakWeapon_replace);
    replacefunc(maps\mp\killstreaks\_killstreaks::getKillstreakCrateIcon, ::getKillstreakCrateIcon_replace);
    replacefunc(maps\mp\killstreaks\_killstreaks::getKillstreakIndex, ::getKillstreakIndex_replace);
    replacefunc(maps\mp\killstreaks\_killstreaks::givekillstreak, ::givekillstreak_replace);
    replacefunc(maps\mp\killstreaks\_killstreaks::initKillstreakData, ::initKillstreakData_replace);
    replacefunc(maps\mp\killstreaks\_killstreaks::usedKillstreak, ::usedKillstreak_edit);
    replacefunc(maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon, ::on_getkillstreakcrateicon);
}

getkillstreakcrateicon( var_0 )
{
    if( var_0 == "nuke" )
    {
        return "dpad_killstreak_nuke";
    }

    return tablelookup( "mp/killstreakTable.csv", 1, var_0, 15 );
}


usedKillstreak_edit(streakName, awardXp) {
	self playLocalSound("weap_c4detpack_trigger_plr");

	if(awardXp) {
		self thread [[ level.onXPEvent ]]( "killstreak_" + streakName);
		self thread maps\mp\gametypes\_missions::useHardpoint(streakName);
	}

    self.used_streak_team = self.team;

	awardref = maps\mp\_awards::getKillstreakAwardRef(streakName);
	if(IsDefined(awardref))
		self thread maps\mp\_utility::incPlayerStat(awardref, 1);

	if(maps\mp\killstreaks\_killstreaks::isAssaultKillstreak(streakName))
		self thread maps\mp\_utility::incPlayerStat("assaultkillstreaksused", 1);
	else if(maps\mp\killstreaks\_killstreaks::isSupportKillstreak(streakName))
		self thread maps\mp\_utility::incPlayerStat("supportkillstreaksused", 1);
	else if(maps\mp\killstreaks\_killstreaks::isSpecialistKillstreak(streakName)) {
		self thread maps\mp\_utility::incPlayerStat("specialistkillstreaksearned", 1);
		return;
	}

	team = self.team;
	if(level.teamBased) {
		thread maps\mp\_utility::leaderDialog( team + "_friendly_" + streakName + "_inbound", team );

		if(maps\mp\killstreaks\_killstreaks::getKillstreakInformEnemy(streakName))
			thread maps\mp\_utility::leaderDialog( team + "_enemy_" + streakName + "_inbound", level.otherTeam[ team ] );
	}
	else {
		self thread maps\mp\_utility::leaderDialogOnPlayer( team + "_friendly_" + streakName + "_inbound" );

		if(maps\mp\killstreaks\_killstreaks::getKillstreakInformEnemy(streakName)) {
			excludeList[0] = self;
			thread maps\mp\_utility::leaderDialog( team + "_enemy_" + streakName + "_inbound", undefined, undefined, excludeList );
		}
	}
}

build_killstreak_data(arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8, arg_9, arg_10, arg_11) {
	game["dialog"][arg_1] = arg_3;

	if(isdefined(arg_2)) {
		if(arg_2 == "Loc_String")
			arg_2 = tablelookupistring( "mp/killstreakTable.csv", 1, arg_1, 6 );

		precachestring( arg_2 );
	}
	
	game["dialog"]["allies_friendly_" + arg_1 + "_inbound"] = "use_" + arg_4;
	game["dialog"]["allies_enemy_" + arg_1 + "_inbound"] = "enemy_" + arg_4;
	game["dialog"]["axis_friendly_" + arg_1 + "_inbound"] = "use_" + arg_5;
	game["dialog"]["axis_enemy_" + arg_1 + "_inbound"] = "enemy_" + arg_5;
	precacheitem( arg_6 );
	maps\mp\gametypes\_rank::registerscoreinfo( "killstreak_" + arg_1, arg_7 );
	precacheshader( arg_8 );

	arg_8 = tablelookup( "mp/killstreakTable.csv", 1, arg_1, 14 );

	if(isdefined(arg_9))
		precacheshader( arg_9 );
	if(isdefined(arg_10))
		precacheshader( arg_10 );
	if(isdefined(arg_11))
		precacheshader( arg_11 );
}

getKillstreakInformEnemy_replace( streakName )
{
	if(streakName == "harrier_airstrike")
		return 1;
	return int( tableLookup( KILLSTREAK_STRING_TABLE, KILLSTREAK_NAME_COLUMN, streakName, KILLSTREAK_ENEMY_USE_DIALOG_COLUMN ) );
}

getKillstreakSound_replace( streakName )
{
	if(streakName == "harrier_airstrike")
		return "mp_killstreak_jet";
	return tableLookup( KILLSTREAK_STRING_TABLE, KILLSTREAK_NAME_COLUMN, streakName, KILLSTREAK_SOUND_COLUMN );
}

getKillstreakWeapon_replace( streakName )
{
	if(streakName == "harrier_airstrike")
		return "killstreak_precision_airstrike_mp";
	return tableLookup( KILLSTREAK_STRING_TABLE, KILLSTREAK_NAME_COLUMN, streakName, KILLSTREAK_WEAPON_COLUMN );
}

getKillstreakCrateIcon_replace( streakName )
{
	if(streakName == "harrier_airstrike")
		return "death_harrier";
	return tableLookup( KILLSTREAK_STRING_TABLE, KILLSTREAK_NAME_COLUMN, streakName, KILLSTREAK_OVERHEAD_ICON_COLUMN );
}

getKillstreakIndex_replace( streakName )
{
	if(streakName == "harrier_airstrike")
		return 7;
	return tableLookupRowNum( KILLSTREAK_STRING_TABLE, KILLSTREAK_NAME_COLUMN, streakName )-1;
}

givekillstreak_replace( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "givingLoadout" );

    if ( !isdefined( level.killstreakfuncs[var_0] ))
        return;

    if ( !isdefined( self.pers["killstreaks"] ) )
        return;

    self endon( "disconnect" );

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    var_5 = undefined;

    if ( !isdefined( var_1 ) || var_1 == 0 )
    {
        var_6 = self.pers["killstreaks"].size;

        if ( !isdefined( self.pers["killstreaks"][var_6] ) )
            self.pers["killstreaks"][var_6] = spawnstruct();

        self.pers["killstreaks"][var_6].available = 0;
        self.pers["killstreaks"][var_6].streakname = var_0;
        self.pers["killstreaks"][var_6].earned = 0;
        self.pers["killstreaks"][var_6].awardxp = isdefined( var_2 ) && var_2;
        self.pers["killstreaks"][var_6].owner = var_3;
        self.pers["killstreaks"][var_6].kid = self.pers["kID"];
        self.pers["killstreaks"][var_6].lifeid = -1;
        self.pers["killstreaks"][var_6].isgimme = 1;
        self.pers["killstreaks"][var_6].isspecialist = 0;
        self.pers["killstreaks"][0].nextslot = var_6;
        self.pers["killstreaks"][0].streakname = var_0;
        var_5 = 0;
        var_7 = maps\mp\killstreaks\_killstreaks::getkillstreakindex( var_0 );
        self setplayerdata( "killstreaksState", "icons", 0, var_7 );

        if ( !var_4 )
            maps\mp\killstreaks\_killstreaks::showselectedstreakhint( var_0 );
    }
    else
    {
        for ( var_8 = 1; var_8 < 4; var_8++ )
        {
            if ( isdefined( self.pers["killstreaks"][var_8] ) && isdefined( self.pers["killstreaks"][var_8].streakname ) && var_0 == self.pers["killstreaks"][var_8].streakname )
            {
                var_5 = var_8;
                break;
            }
        }

        if ( !isdefined( var_5 ) )
            return;
    }

    self.pers["killstreaks"][var_5].available = 1;
    self.pers["killstreaks"][var_5].earned = isdefined( var_1 ) && var_1;
    self.pers["killstreaks"][var_5].awardxp = isdefined( var_2 ) && var_2;
    self.pers["killstreaks"][var_5].owner = var_3;
    self.pers["killstreaks"][var_5].kid = self.pers["kID"];
    self.pers["kID"]++;

    if ( !self.pers["killstreaks"][var_5].earned )
        self.pers["killstreaks"][var_5].lifeid = -1;
    else
        self.pers["killstreaks"][var_5].lifeid = self.pers["deaths"];

    if ( self.streaktype == "specialist" && var_5 != 0 )
    {
        self.pers["killstreaks"][var_5].isspecialist = 1;

        if ( isdefined( level.killstreakfuncs[var_0] ) )
            self [[ level.killstreakfuncs[var_0] ]]();

        maps\mp\killstreaks\_killstreaks::usedkillstreak( var_0, var_2 );
    }
    else if ( self maps\mp\killstreaks\_killstreaks::is_player_gamepad_enabled())
    {
        var_9 = maps\mp\killstreaks\_killstreaks::getkillstreakweapon( var_0 );
        maps\mp\killstreaks\_killstreaks::givekillstreakweapon( var_9 );

        if ( isdefined( self.killstreakindexweapon ) )
        {
            var_0 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
            var_10 = maps\mp\killstreaks\_killstreaks::getkillstreakweapon( var_0 );

            if ( !maps\mp\killstreaks\_killstreaks::iscurrentlyholdingkillstreakweapon( var_10 ) )
                self.killstreakindexweapon = var_5;
        }
        else
            self.killstreakindexweapon = var_5;
    }
    else
    {
        if ( 0 == var_5 && self.pers["killstreaks"][0].nextslot > 5 )
        {
            var_11 = self.pers["killstreaks"][0].nextslot - 1;
            var_12 = maps\mp\killstreaks\_killstreaks::getkillstreakweapon( self.pers["killstreaks"][var_11].streakname );
            self takeweapon( var_12 );
        }

        var_10 = maps\mp\killstreaks\_killstreaks::getkillstreakweapon( var_0 );
        maps\mp\_utility::_giveweapon( var_10, 0 );
        maps\mp\_utility::_setactionslot( var_5 + 4, "weapon", var_10 );
    }

    maps\mp\killstreaks\_killstreaks::updatestreakslots();

    if ( isdefined( level.killstreaksetupfuncs[var_0] ) )
        self [[ level.killstreaksetupfuncs[var_0] ]]();

    if ( isdefined( var_1 ) && var_1 && isdefined( var_2 ) && var_2 )
        self notify( "received_earned_killstreak" );
}

initKillstreakData_replace()
{
	game[ "dialog" ][ "harrier_airstrike" ] = "mp_killstreak_jet";

	game[ "dialog" ][ "allies_friendly_harrier_airstrike_inbound" ] = "use_achieve_airstrike";
	game[ "dialog" ][ "allies_enemy_harrier_airstrike_inbound" ] = "enemy_achieve_airstrike";
	game[ "dialog" ][ "axis_friendly_harrier_airstrike_inbound" ] = "use_achieve_airstrike";
	game[ "dialog" ][ "axis_enemy_harrier_airstrike_inbound" ] = "enemy_achieve_airstrike";

	precacheshader("death_harrier");
	precacheheadicon("waypoint_ammo_friendly");
	precacheheadicon("dpad_killstreak_airdrop_trap");

	build_killstreak_data( "harrier_airstrike" , undefined , "achieve_airstrike" , "airstrike" , "airstrike" , "killstreak_precision_airstrike_mp" , 200 , "death_harrier" , "death_harrier" , "death_harrier" , "death_harrier" );
	build_killstreak_data( "uav" , "Loc_String" , "achieve_uav" , "uav" , "uav" , "killstreak_uav_mp" , 100 , "dpad_killstreak_uav_static" , "specialty_uav_crate" , "dpad_killstreak_uav" , "dpad_killstreak_uav" );
	build_killstreak_data( "airdrop_assault" , "Loc_String" , "achieve_carepackage" , "carepackage" , "carepackage" , "airdrop_marker_mp" , 100 , "dpad_killstreak_carepackage_static" , "specialty_null" , "dpad_killstreak_carepackage" , "dpad_killstreak_carepackage" );
	build_killstreak_data( "predator_missile" , "Loc_String" , "achieve_hellfire" , "hellfire" , "hellfire" , "killstreak_predator_missile_mp" , 150 , "dpad_killstreak_predator_missile_static" , "specialty_predator_missile_crate" , "dpad_killstreak_predator_missile" , "dpad_killstreak_predator_missile" );
	build_killstreak_data( "ims" , "Loc_String" , "achieve_ims" , "null" , "null" , "killstreak_ims_mp" , 150 , "dpad_killstreak_ims_static" , "specialty_ims_crate" , "dpad_killstreak_ims" , "dpad_killstreak_ims" );
	build_killstreak_data( "airdrop_sentry_minigun" , "Loc_String" , "achieve_sentrygun" , "sentrygun" , "sentrygun" , "airdrop_sentry_marker_mp" , 150 , "dpad_killstreak_sentry_gun_static" , "specialty_null" , "dpad_killstreak_sentry_gun" , "dpad_killstreak_sentry_gun" );
	build_killstreak_data( "sentry" , "Loc_String" , "deploy_sentry" , "null" , "null" , "killstreak_sentry_mp" , 150 , "dpad_killstreak_sentry_gun_static" , "specialty_sentry_gun_crate" , "dpad_killstreak_sentry_gun" , "dpad_killstreak_sentry_gun" );
	build_killstreak_data( "precision_airstrike" , "Loc_String" , "achieve_airstrike" , "airstrike" , "airstrike" , "killstreak_precision_airstrike_mp" , 200 , "dpad_killstreak_precision_airstrike_static" , "specialty_precision_airstrike_crate" , "dpad_killstreak_precision_airstrike" , "dpad_killstreak_precision_airstrike" );
	build_killstreak_data( "helicopter" , "Loc_String" , "achieve_heli" , "cobra" , "hind" , "killstreak_helicopter_mp" , 200 , "dpad_killstreak_attack_helicopter_static" , "specialty_attack_helicopter_crate" , "dpad_killstreak_attack_helicopter" , "dpad_killstreak_attack_helicopter" );
	build_killstreak_data( "littlebird_flock" , "Loc_String" , "achieve_strafe" , "strafe" , "strafe" , "killstreak_precision_airstrike_mp" , 200 , "dpad_killstreak_helicopter_flock_static" , "specialty_helicopter_flock_crate" , "dpad_killstreak_helicopter_flock" , "dpad_killstreak_helicopter_flock" );
	build_killstreak_data( "littlebird_support" , "Loc_String" , "achieve_ah6guard" , "ah6guard" , "ah6guard" , "killstreak_helicopter_mp" , 200 , "dpad_killstreak_helicopter_guard_static" , "specialty_helicopter_guard_crate" , "dpad_killstreak_helicopter_guard" , "dpad_killstreak_helicopter_guard" );
	build_killstreak_data( "remote_mortar" , "Loc_String" , "achieve_agm" , "agm" , "agm" , "killstreak_remote_mortar_mp" , 100 , "dpad_killstreak_reaper_static" , "specialty_reaper_crate" , "dpad_killstreak_reaper" , "dpad_killstreak_reaper" );
	build_killstreak_data( "airdrop_remote_tank" , "Loc_String" , "achieve_assault_drone" , "null" , "null" , "airdrop_tank_marker_mp" , 150 , "dpad_killstreak_talon_static" , "specialty_null" , "dpad_killstreak_talon" , "dpad_killstreak_talon" );
	build_killstreak_data( "remote_tank" , "Loc_String" , "achieve_assault_drone" , "assault_drone" , "assault_drone" , "killstreak_remote_tank_mp" , 350 , "dpad_killstreak_talon_static" , "specialty_talon_crate" , "dpad_killstreak_talon" , "dpad_killstreak_talon" );
	build_killstreak_data( "helicopter_flares" , "Loc_String" , "achieve_pavelow" , "pavelow" , "pavelow" , "killstreak_helicopter_flares_mp" , 300 , "dpad_killstreak_pave_low_static" , "specialty_pave_low_crate" , "dpad_killstreak_pave_low" , "dpad_killstreak_pave_low" );
	build_killstreak_data( "ac130" , "Loc_String" , "achieve_ac130" , "ac130" , "ac130" , "killstreak_ac130_mp" , 350 , "dpad_killstreak_ac130_static" , "specialty_ac130_crate" , "dpad_killstreak_ac130" , "dpad_killstreak_ac130" );
	build_killstreak_data( "airdrop_juggernaut" , "Loc_String" , "achieve_juggernaut" , "juggernaut" , "juggernaut" , "airdrop_juggernaut_mp" , 150 , "dpad_killstreak_airdrop_juggernaut_static" , "specialty_juggernaut_crate" , "dpad_killstreak_airdrop_juggernaut" , "dpad_killstreak_airdrop_juggernaut" );
	build_killstreak_data( "osprey_gunner" , "Loc_String" , "achieve_osprey_gunner" , "osprey_gunner" , "osprey_gunner" , "killstreak_helicopter_minigun_mp" , 350 , "dpad_killstreak_osprey_gunner_static" , "specialty_osprey_gunner_crate" , "dpad_killstreak_osprey_gunner" , "dpad_killstreak_osprey_gunner" );
	build_killstreak_data( "deployable_vest" , "Loc_String" , "achieve_vest_dep" , "null" , "null" , "deployable_vest_marker_mp" , 200 , "dpad_killstreak_deployable_vest_static" , "specialty_deployable_vest_crate" , "dpad_killstreak_deployable_vest" , "dpad_killstreak_deployable_vest" );
	build_killstreak_data( "airdrop_trap" , "Loc_String" , "achieve_airtrap" , "airtrap" , "airtrap" , "airdrop_trap_marker_mp" , 100 , "dpad_killstreak_airdrop_trap_static" , "specialty_null" , "dpad_killstreak_airdrop_trap" , "dpad_killstreak_airdrop_trap" );
	build_killstreak_data( "remote_mg_turret" , "Loc_String" , "achieve_remote_sentry" , "null" , "null" , "killstreak_remote_turret_mp" , 250 , "dpad_killstreak_remote_mg_turret_static" , "specialty_remote_mg_turret_crate" , "dpad_killstreak_remote_mg_turret" , "dpad_killstreak_remote_mg_turret" );
	build_killstreak_data( "stealth_airstrike" , "Loc_String" , "achieve_stealth" , "null" , "null" , "killstreak_stealth_airstrike_mp" , 300 , "dpad_killstreak_stealth_bomber_static" , "specialty_stealth_bomber_crate" , "dpad_killstreak_stealth_bomber" , "dpad_killstreak_stealth_bomber" );
	build_killstreak_data( "nuke" , "Loc_String" , "achieve_moab" , "moab" , "moab" , "killstreak_uav_mp" , 100 , "dpad_killstreak_nuke" , "specialty_null" , "dpad_killstreak_nuke" , "dpad_killstreak_nuke" );
	build_killstreak_data( "emp", "Loc_String", "achieve_emp", "emp", "emp", "killstreak_emp_mp", 500, "dpad_killstreak_emp_static", "specialty_emp_crate", "dpad_killstreak_emp", "dpad_killstreak_emp" );
    build_killstreak_data( "sam_turret", "Loc_String", "achieve_sam", "sam", "sam", "killstreak_sentry_mp", 150, "dpad_killstreak_sam_turret_static", "specialty_sam_turret_crate", "dpad_killstreak_sam_turret", "dpad_killstreak_sam_turret" );
    build_killstreak_data( "remote_uav", "Loc_String", "achieve_recon_drone", "recon_drone", "recon_drone", "killstreak_uav_mp", 350, "dpad_killstreak_remote_uav_static", "specialty_remote_uav_crate", "dpad_killstreak_remote_uav", "dpad_killstreak_remote_uav" );
}
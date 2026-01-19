/*

    INFO:
        - Calling init and main / loads all needed for jugg servers

    TODO:
        - Move replace func in utility
        - Re-move nont needed stuff

    DONE:
        - Created and filled
        
*/

init()
{
    level.infect_loadouts[ "allies" ][ "loadoutPrimary" ] = "none";
    level.infect_loadouts[ "allies" ][ "loadoutPrimaryAttachment" ] = "none";
    level.infect_loadouts[ "allies" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.infect_loadouts[ "allies" ][ "loadoutPrimaryBuff" ] = "none";
    level.infect_loadouts[ "allies" ][ "loadoutPrimaryCamo" ] = "none";
    level.infect_loadouts[ "allies" ][ "loadoutPrimaryReticle" ] = "none";
    level.infect_loadouts[ "allies" ][ "loadoutSecondary" ] = "none";
    level.infect_loadouts[ "allies" ][ "loadoutSecondaryAttachment" ] = "none";
    level.infect_loadouts[ "allies" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.infect_loadouts[ "allies" ][ "loadoutSecondaryBuff" ] = "specialty_null";
    level.infect_loadouts[ "allies" ][ "loadoutSecondaryCamo" ] = "none";
    level.infect_loadouts[ "allies" ][ "loadoutSecondaryReticle" ] = "none";
    level.infect_loadouts[ "allies" ][ "loadoutEquipment" ] = "claymore_mp";
    level.infect_loadouts[ "allies" ][ "loadoutOffhand" ] = "trophy_mp";
    level.infect_loadouts[ "allies" ][ "loadoutPerk1" ] = "specialty_fastreload";
    level.infect_loadouts[ "allies" ][ "loadoutPerk2" ] = "specialty_hardline";
    level.infect_loadouts[ "allies" ][ "loadoutPerk3" ] = "specialty_bulletaccuracy";
    level.infect_loadouts[ "allies" ][ "loadoutStreakType" ] = "assault";
    level.infect_loadouts[ "allies" ][ "loadoutKillstreak1" ] = "airdrop_assault";
    level.infect_loadouts[ "allies" ][ "loadoutKillstreak2" ] = "airdrop_sentry_minigun";
    level.infect_loadouts[ "allies" ][ "loadoutKillstreak3" ] = "none";
    level.infect_loadouts[ "allies" ][ "loadoutDeathstreak" ] = "specialty_null";
    level.infect_loadouts[ "allies" ][ "loadoutJuggernaut" ] = 0;

    level.infect_loadouts[ "axis_initial" ][ "loadoutPrimary" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutPrimaryAttachment" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutPrimaryBuff" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutPrimaryCamo" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutPrimaryReticle" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutSecondary" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutSecondaryAttachment" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutSecondaryBuff" ] = "specialty_null";
    level.infect_loadouts[ "axis_initial" ][ "loadoutSecondaryCamo" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutSecondaryReticle" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutEquipment" ] = "throwingknife_mp";
    level.infect_loadouts[ "axis_initial" ][ "loadoutOffhand" ] = "specialty_tacticalinsertion";
    level.infect_loadouts[ "axis_initial" ][ "loadoutPerk1" ] = "specialty_longersprint";
    level.infect_loadouts[ "axis_initial" ][ "loadoutPerk2" ] = "specialty_quickdraw";
    level.infect_loadouts[ "axis_initial" ][ "loadoutPerk3" ] = "specialty_quieter";
    level.infect_loadouts[ "axis_initial" ][ "loadoutStreakType" ] = "assault";
    level.infect_loadouts[ "axis_initial" ][ "loadoutKillstreak1" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutKillstreak2" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutKillstreak3" ] = "none";
    level.infect_loadouts[ "axis_initial" ][ "loadoutDeathstreak" ] = "specialty_null";
    level.infect_loadouts[ "axis_initial" ][ "loadoutJuggernaut" ] = 0;

    level.infect_loadouts[ "axis" ][ "loadoutPrimary" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutPrimaryAttachment" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutPrimaryBuff" ] = "specialty_null";
    level.infect_loadouts[ "axis" ][ "loadoutPrimaryCamo" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutPrimaryReticle" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutSecondary" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutSecondaryAttachment" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutSecondaryBuff" ] = "specialty_null";
    level.infect_loadouts[ "axis" ][ "loadoutSecondaryCamo" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutSecondaryReticle" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutEquipment" ] = "throwingknife_mp";
    level.infect_loadouts[ "axis" ][ "loadoutOffhand" ] = "specialty_tacticalinsertion";
    level.infect_loadouts[ "axis" ][ "loadoutPerk1" ] = "specialty_longersprint";
    level.infect_loadouts[ "axis" ][ "loadoutPerk2" ] = "specialty_quickdraw";
    level.infect_loadouts[ "axis" ][ "loadoutPerk3" ] = "specialty_quieter";
    level.infect_loadouts[ "axis" ][ "loadoutStreakType" ] = "assault";
    level.infect_loadouts[ "axis" ][ "loadoutKillstreak1" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutKillstreak2" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutKillstreak3" ] = "none";
    level.infect_loadouts[ "axis" ][ "loadoutDeathstreak" ] = "specialty_null";
    level.infect_loadouts[ "axis" ][ "loadoutJuggernaut" ] = 0;

    level.green_ball = loadFX( "misc/aircraft_light_wingtip_green" );
    level.red_ball = loadFX( "misc/aircraft_light_wingtip_red" );
    level.smoke_trail = loadFX( "smoke/smoke_geotrail_rpg" );
    level.red_blinking = loadFX( "misc/laser_glow" );
    level.emp_explosion = loadFX( "explosions/emp_grenade" );
    level.flashbang_explosion = loadFX( "explosions/flashbang" );
    level.money = loadfx( "props/cash_player_drop" );
    level.barrel_explode = loadfx( "props/barrelExp" );
    level.barrel_fire = loadfx( "props/barrel_fire" ); 
    level.c4_blinking = loadfx( "misc/light_c4_blink" ); 
    level.claymore_laser = loadfx( "misc/claymore_laser" ); 
    level.red_flare = loadfx( "misc/flare_ambient" ); 
    level.green_flare = loadfx( "misc/flare_ambient_green" ); 
    level.airdrop_flare = loadfx( "smoke/airdrop_flare_mp_effect_now" ); 
    level.signal_smoke_airdrop = loadfx( "smoke/signal_smoke_airdrop" ); 
    level.signal_smoke_airdrop = loadfx( "smoke/signal_smoke_airdrop" ); 
    level.stinger_explosion = loadfx( "explosions/stinger_explosion" );
    level.throwingknifefx = loadFX( "smoke/smoke_geotrail_javelin" );
    level.throwingknifeexplosionfx = loadFX( "explosions/default_explosion" );
    level.smokelauncher_fx = loadfx( "smoke/smoke_grenade_11sec_mp" );

	level.players_num_list = [];
    level.SpawnedPlayersCheck = [];
    level.usables = [];
	level.info_hud_elements = [];
    level.teleporter_ents = [];

	level.original_getSpawnPoint = level.getSpawnPoint;
	level.getSpawnPoint = scripts\jugg\maps\objects::new_getspawnpoint;
    level.callbackPlayerKilled = scripts\jugg\playerlogic::on_player_killed;
	level.callbackPlayerDamage = scripts\jugg\playerlogic::on_player_damage;
    level.killstreakfuncs["nuke"] =  scripts\jugg\killstreaks\nuke::tryusenuke;
	level.killStreakFuncs["ammo"] = scripts\jugg\killstreaks\airdrop::refill_ammo;

    level.sentrySettings["sentry_minigun"].timeOut                = 45;
	level.sentrySettings["sentry_minigun"].maxHealth              = 400;
    level.turretSettings[ "mg_turret" ].maxHealth                 =	400;
    level.ospreySettings["escort_airdrop"].timeOut                = 40;
    level.ospreySettings["osprey_gunner"].timeOut                 = 50;
    level.turretSettings["mg_turret"].timeOut                     = 45;
    level.tankSettings["remote_tank"].timeOut                     = 90;
	level.tankSettings[ "remote_tank" ].maxHealth =				500;
	level.imsSettings[ "ims" ].lifeSpan =				180.0;
	level.imsSettings[ "ims" ].gracePeriod =			0.4;
	level.airstrike_planes = 0;

    level.finalguy = 0;
    level.noclearkillstreaksonaxisspawn = 1;

    level._effect["nuke_player"] = loadfx( "explosions/player_death_nuke" );
    level._effect["nuke_flash"] = loadfx( "explosions/player_death_nuke_flash" );
    level._effect["nuke_aftermath"] = loadfx( "dust/nuke_aftermath_mp" );
    
    level.nukeInfo.xpScalar = 2;
    level.nukevisionset = "aftermath";
    level.nukeinfo = spawnstruct();

	level.unselected_color = (0.5,0.0,0.0);
	level.selected_color = (0,1,1);
	level.selected_text_color = (1,0.8,0.0);

    level._meat_location_center = (0,0,0);

    level.mapname = getdvar("ui_mapname");
    level.curObjID = 1;
	level.crates_placed = 1;

    game[ "strings" ][ "objective_hint_axis" ] = " ";
    game[ "strings" ][ "objective_hint_allies" ] = " ";
    game[ "strings" ][ "nuke_hint" ] = &"MP_NUKE_PICKUP";

    precachelocationselector( "map_artillery_selector" );
    
    precacheshader( "stencil_base" );
    precacheshader( "hud_us_flashgrenade" );
    precacheshader( "hud_us_smokegrenade" );
    precacheshader( "hud_us_stungrenade" );
    precacheshader( "hud_icon_c4" );
    precacheshader( "equipment_emp_grenade" );
    precacheshader( "compassping_explosion" );
    precacheshader( "objpoint_flag_opfor" );
    precacheshader( "waypoint_flag_friendly" );
    precacheshader( "compass_objpoint_ammo_friendly" );
	precacheshader( "compass_objpoint_trap_friendly" );
	precacheshader( "compass_objpoint_ammo_enemy" );
	precacheshader( "waypoint_ammo_friendly" );
	precacheshader( "dpad_killstreak_airdrop_trap" );
    precacheshader( "death_moab" );
    precacheshader( "death_harrier" );

	precacheheadicon( "waypoint_ammo_friendly" );
	precacheheadicon( "dpad_killstreak_airdrop_trap" );

	precacheitem( "at4_mp" );

    precachemodel( scripts\jugg\maps\objects::getAlliesFlagModel( getdvar( "ui_mapname" ) ) );
    precachemodel( "prop_flag_neutral" );
    precachemodel( "com_plasticcase_green_big" );
    precachemodel( "projectile_cbu97_clusterbomb" );
    precachemodel( "projectile_javelin_missile" );
    precachemodel( "vehicle_b2_bomber" );
    precachemodel( "vehicle_mig29_desert" );

    precacheminimapicon( "compass_objpoint_airstrike_friendly" );
    precacheminimapicon( "compass_objpoint_airstrike_busy" );
    
    thread scripts\jugg\equipment\equipment::init();
    thread scripts\jugg\equipment\javelin::init();

    thread scripts\jugg\killstreaks\ac130::init();
    thread scripts\jugg\killstreaks\airdrop::init();
    thread scripts\jugg\killstreaks\autosentry::init();
    thread scripts\jugg\killstreaks\emp::init();
    thread scripts\jugg\killstreaks\harrier::init();
    thread scripts\jugg\killstreaks\helicopter_guard::init();
    thread scripts\jugg\killstreaks\helicopter::init();
    thread scripts\jugg\killstreaks\ims::init();
    thread scripts\jugg\killstreaks\juggernaut::init();
    thread scripts\jugg\killstreaks\killstreaks::init();
    thread scripts\jugg\killstreaks\nuke::init();
    thread scripts\jugg\killstreaks\recondrone::init();
    thread scripts\jugg\killstreaks\remotemissile::init();
    thread scripts\jugg\killstreaks\straferun::init();

    thread scripts\jugg\maps\destructible::init();
    thread scripts\jugg\maps\edits::init();
    thread scripts\jugg\maps\map_list::init();
    thread scripts\jugg\maps\objects_new::init();
    thread scripts\jugg\maps\objects::init();
    thread scripts\jugg\maps\spawnlogic::init();
    thread scripts\jugg\maps\voting::init();

    thread scripts\jugg\weapons\smaw::init();

    thread scripts\jugg\infected::init();
    thread scripts\jugg\playerlogic::init();
    thread scripts\jugg\utility::init();
    thread scripts\jugg\weapon::init();

    replacefunc( maps\mp\gametypes\_music_and_dialog::onPlayerSpawned, ::blanky );

    wait 1;

    level.ac130_num_flares = 1;
    level.emptimeout = 20.0;
    level.emptimeremaining = int( level.emptimeout );
}

main()
{
    level.lastopfer = "";

	replacefunc( maps\mp\gametypes\_gamelogic::prematchPeriod, ::blanky );
}

blanky() 
{

}

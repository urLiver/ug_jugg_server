/*

    INFO:
        - Calling init and main / loads all needed for the core of all servers

    TODO:
        - Re-move not needed stuff

    DONE:
        - Created and filled
        
*/

init()
{
	level.basepath = "C:/IW5-Data/global_stats";
   
    level.users = [];
    level.kenker_sounds = [];
    level.calling_cards = [];
    level.base_values = [];

    level.calling_cards[ level.calling_cards.size ] = "iw5_cardtitle_camo_classic";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_07";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_02";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_bg_prestige15";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_10";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_20";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_19";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_18";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_17";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_16";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_45";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_26";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_08";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_05";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_01";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_21";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_13";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_27";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_04";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_23";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_06";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_25";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_34";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_33";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_44";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_43";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_28";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_38";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_46";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_47";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_48";
    level.calling_cards[ level.calling_cards.size ] = "calling_cards/emblem_custom_53";

    level.kenker_sounds[ level.kenker_sounds.size ] = "enable_activeperk";
    level.kenker_sounds[ level.kenker_sounds.size ] = "physics_car_door_default";
    level.kenker_sounds[ level.kenker_sounds.size ] = "mp_war_objective_taken";
    level.kenker_sounds[ level.kenker_sounds.size ] = "mp_war_objective_lost";

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

    level.base_values[ "choosen_pres" ] = -1;
    level.base_values[ "cl_voice" ] = 1;
    level.base_values[ "xp_bar" ] = 1;
    level.base_values[ "velocity" ] = 0;
    level.base_values[ "cancelled_moabs" ] = 0;
    level.base_values[ "conv_card" ] = "iw5_cardtitle_camo_classic";
    level.base_values[ "inf_kills" ] = 0;
    level.base_values[ "surv_kills" ] = 0;
    level.base_values[ "bounces" ] = 0;
    level.base_values[ "tk_kills" ] = 0;
    level.base_values[ "nade_kills" ] = 0;
    level.base_values[ "betty_kills" ] = 0;
    level.base_values[ "melee_kills" ] = 0;
    level.base_values[ "knife_moab_challenge" ] = 0;
    level.base_values[ "ti_cancel" ] = 0;
    level.base_values[ "chicken_kill" ] = 0;
    level.base_values[ "bb_deaths" ] = 0;
    level.base_values[ "cj_challenge_01" ] = 0;
    level.base_values[ "inf_teamcolor_surv" ] = 0;
    level.base_values[ "inf_teamcolor_inf" ] = 0;
    level.base_values[ "render_skybox" ] = 1;
    level.base_values[ "ui_scorelimit" ] = 1;
    level.base_values[ "custom_ents" ] = 1;
    level.base_values[ "gc_hud" ] = 1;
    level.base_values[ "prestige" ] = 0;
    level.base_values[ "xp" ] = 0;
    level.base_values[ "suicides" ] = 0;
    level.base_values[ "assists" ] = 0;
    level.base_values[ "died_by_moabs" ] = 0;
    level.base_values[ "kills" ] = 0;
    level.base_values[ "deaths" ] = 0;
    level.base_values[ "headshots" ] = 0;
    level.base_values[ "called_in_moabs" ] = 0;
    level.base_values[ "challenge_halloween" ] = 1;
    level.base_values[ "inf_ks_5" ] = 0;
    level.base_values[ "inf_ks_10" ] = 0;
    level.base_values[ "inf_ks_15" ] = 0;
    level.base_values[ "inf_ks_20" ] = 0;
    level.base_values[ "inf_ks_25" ] = 0;
    level.base_values[ "inf_ks_30" ] = 0;
    level.base_values[ "masked"] = 0;
    level.base_values[ "noabs"] = 0;

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
    level.someone_spectating = 0;

    precachelocationselector( "map_artillery_selector" );
    
    precacheshader( "stencil_base" );
    precacheshader( "killiconmelee" );
    precacheshader( "gradient" );
    precacheshader( "iw5_cardtitle_specialty_veteran" );
    precacheshader( "hud_material/xp_token" );
    precacheshader( "hud_us_flashgrenade" );
    precacheshader( "hud_us_smokegrenade" );
    precacheshader( "hud_us_stungrenade" );
    precacheshader( "hud_icon_c4" );
    precacheshader( "equipment_emp_grenade" );
    precacheshader( "compassping_explosion" );
    precacheshader( "objpoint_flag_opfor" );
    precacheshader( "hud_scorebar_topcap" );
    precacheshader( "waypoint_flag_friendly" );
    precacheshader( "xp" );
    precacheshader( "hudcolorbar" );
    precacheshader( "line_horizontal" );
    precacheshader( "waypoint_kill" );
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
    
    SetDvar( "inf_xp", ( 5 ) );
    if( getcurrentday() == "Friday" && int( strtok( strtok( getservertime(), " "  )[ 1 ], ":"  )[ 0 ]  ) > 18 || getcurrentday() == "Saturday" || getcurrentday( ) == "Sunday" )
    {
        SetDvar( "inf_xp", ( 20 ) );
    }

    // uncomment if overwrite it needed and repalce value with wished value
    // SetDvar( "inf_xp", ( value ) );

	SetDvarIfUninitialized( "mapvote_mapedit", "undefined;undefined" );
	SetDvarIfUninitialized( "mapvote_skip_maps", "undefined;undefined;undefined;undefined;undefined;undefined;undefined;undefined;undefined;undefined" );
    SetDvar( "g_scorescolor_allies", "0.831 0.553 0 1" );
    SetDvar( "g_scorescolor_axis", ".75 .25 .25 1" );
    SetDvar( "g_teamname_allies", "^3SURVIVORS" );
    SetDvar( "g_teamname_axis", "^1INFECTED" );
    SetDvar( "g_teamicon_allies", "iw5_cardicon_sandman2" );
    SetDvar( "g_teamicon_axis", "iw5_cardicon_juggernaut_a" );
    SetDvar( "sv_sayname", "^8^7[ ^8UG ^7JUGG ]" );
    SetDvar( "prefix", "\r^8^7[ ^8UG ^7JUGG ] " );

    thread scripts\core\chat::init();
    thread scripts\core\menu::init();
    thread scripts\core\stats::init();
    thread scripts\core\ui_func::init();
    thread scripts\core\ui::init();
}

main()
{
    precacheMenu( "popup_leavegame" );
    precacheMenu( "youkilled_card_display" );
    precacheMenu( "killedby_card_display" );
	precacheMenu( "scoreboard" );
	precacheMenu( "endgameupdate" );
	precacheMenu( "quickmessage" );
	precacheMenu( "quickcommands" );
	precacheMenu( "quicksounds" );

    thread scripts\core\stats::main();
}
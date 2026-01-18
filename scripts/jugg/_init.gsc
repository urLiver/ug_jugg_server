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
	level.imsSettings[ "ims" ].gracePeriod =			0.4; // time once triggered when it'll fire
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

    replacefunc(maps\mp\gametypes\_music_and_dialog::onPlayerSpawned, ::blanky ); // for my sanity

    wait 1;

    level.ac130_num_flares = 1;
    level.emptimeout = 20.0;
    level.emptimeremaining = int( level.emptimeout );
    
	ents = getentarray();
    foreach(ent in ents) {
        if(isdefined(ent.targetname) && ent.targetname == "destructible_toy") {
            if(isdefined(ent.model) && issubstr(ent.model, "chicken"))
                ent thread scripts\jugg\playerlogic::track_chicken_damage();
        }
    }
}

main()
{
    level.lastopfer = "";

	replacefunc(maps\mp\gametypes\_gamelogic::prematchPeriod, ::blanky);
	replacefunc(maps\mp\gametypes\_gamelogic::fixranktable, ::blanky);
}

blanky() 
{

}

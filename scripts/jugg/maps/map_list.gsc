/*

    INFO:
        - This File Includes the Map List for every playable maps, some breach logic

    TODO:
		- Add more edits
		- Re-write for a simpler coding style

    DONE:
        - Added Dome and Undeground Edit
        
*/

init() 
{
	wait 1;

	rnd = undefined;
    level.map_name = getdvar("mapname");

	scripts\jugg\maps\objects::delete_all_spawn_except("tdm");

	level.tpjugg_maplist = [];
	level.tpjugg_mapedit = [];
	level.tpjugg_maplist_display_name = [];
	
	add_map_to_maplist("mp_showdown_sh", "Showdown" ,"Rooftop Rumble", scripts\jugg\maps\edits::showdown_edit1, "Clippy");
	add_map_to_maplist("mp_rust", "Rust" ,"Run Around Rust", scripts\jugg\maps\edits::rust_edit1, "Clippy");
	add_map_to_maplist("mp_village", "Village" ,"Village Sux", scripts\jugg\maps\edits::village_edit1, "Unveiled");
	add_map_to_maplist("mp_hillside_ss", "Getaway" ,"Beach Invasion", scripts\jugg\maps\edits::Getaway_edit1, "TMGlion");
	add_map_to_maplist("mp_paris", "Resistance" ,"Alley Annihilation", scripts\jugg\maps\edits::resistance_edit1, "Revox");
	add_map_to_maplist("mp_paris", "Resistance" ,"Roof Revenge", scripts\jugg\maps\edits::resistance_edit2, "Clippy");
	add_map_to_maplist("mp_paris", "Resistance" ,"Lush Lane", scripts\jugg\maps\edits::resistance_edit3, "TMGlion");
	add_map_to_maplist("mp_exchange", "Downturn" ,"Running For Cover", scripts\jugg\maps\edits::downturn_edit1, "Unveiled & Clippy");
	add_map_to_maplist("mp_exchange", "Downturn" ,"Crossing The Bridge", scripts\jugg\maps\edits::downturn_edit2, "Unveiled, Clippy & TMGlion");
	add_map_to_maplist("mp_exchange", "Downturn" ,"Gated Roofs", scripts\jugg\maps\edits::downturn_edit3, "TMGlion");
	add_map_to_maplist("mp_lambeth", "Fallen" ,"Rundown Warehouse", scripts\jugg\maps\edits::fallen_edit1, "Revox");
	add_map_to_maplist("mp_lambeth", "Fallen" ,"Fallen Chimney", scripts\jugg\maps\edits::fallen_edit2, "Clippy & TMGlion");
	add_map_to_maplist("mp_hardhat", "Hardhat" ,"Construction Pit", scripts\jugg\maps\edits::hardhat_edit1, "Clippy & TMGlion");
	add_map_to_maplist("mp_hardhat", "Hardhat" ,"Road Refuge", scripts\jugg\maps\edits::hardhat_edit2, "Clippy & TMGlion");
	add_map_to_maplist("mp_mogadishu", "Bakaara" ,"Attack on the backlot", scripts\jugg\maps\edits::bakaara_edit1, "Unveiled & Clippy");
	add_map_to_maplist("mp_mogadishu", "Bakaara" ,"Docks", scripts\jugg\maps\edits::bakaara_edit2, "Clippy & TMGlion");
	add_map_to_maplist("mp_mogadishu", "Bakaara" ,"Guns N' Roofs", scripts\jugg\maps\edits::bakaara_edit3, "TMGlion");
	add_map_to_maplist("mp_bravo", "Mission" ,"Open plane with a building", scripts\jugg\maps\edits::mission_edit1, "Unveiled");
	add_map_to_maplist("mp_bravo", "Mission" ,"Around & Up", scripts\jugg\maps\edits::mission_edit2, "Clippy, Sloth & TMGlion");
	add_map_to_maplist("mp_favela", "Favela" ,"Jesus", scripts\jugg\maps\edits::favela_edit1, "Clippy & TMGlion");
	add_map_to_maplist("mp_favela", "Favela" ,"Streets & Roofs", scripts\jugg\maps\edits::favela_edit2, "Revox & TMGlion");
	add_map_to_maplist("mp_interchange", "Interchange" ,"Highway...", scripts\jugg\maps\edits::interchange_edit1, "Unveiled & Clippy & TMGlion");
	add_map_to_maplist("mp_interchange", "Interchange" ,"between two warehouses", scripts\jugg\maps\edits::interchange_edit2, "Unveiled");
	add_map_to_maplist("mp_seatown", "Seatown" ,"Coast Castle", scripts\jugg\maps\edits::seatown_edit1, "Clippy");
	add_map_to_maplist("mp_seatown", "Seatown" ,"Truck Gate", scripts\jugg\maps\edits::seatown_edit2, "Unveiled & Clippy");
	add_map_to_maplist("mp_plaza2", "Arkaden" ,"Plaza Road", scripts\jugg\maps\edits::arkaden_edit1, "Revox");
	add_map_to_maplist("mp_plaza2", "Arkaden" ,"Bridge Domination", scripts\jugg\maps\edits::arkaden_edit2, "Unveiled & Clippy");
	add_map_to_maplist("mp_alpha", "Lockdown" ,"Roof Runners", scripts\jugg\maps\edits::lockdown_edit1, "Clippy" );
	add_map_to_maplist("mp_alpha", "Lockdown" ,"Street Scurry", scripts\jugg\maps\edits::lockdown_edit2, "TMGlion");
	//add_map_to_maplist("mp_nuked", "Nuketown" ,"Bunker Bombing", scripts\jugg\maps\edits::nuketown_edit1, "TMGlion");
	add_map_to_maplist("mp_carbon", "Carbon" ,"Factory Fumbling", scripts\jugg\maps\edits::carbon_edit1, "Unveiled, Clippy & TMGlion");
	add_map_to_maplist("mp_bootleg", "Bootleg" ,"Tuk Tuk Trouble", scripts\jugg\maps\edits::bootleg_edit1, "Revox");
	add_map_to_maplist("mp_bootleg", "River" ,"River Splashing", scripts\jugg\maps\edits::bootleg_edit2, "Unveiled");
	//add_map_to_maplist("mp_dome", "Dome" ,"Around The Back", scripts\jugg\maps\edits::dome_edit1, "Unveiled");
	//add_map_to_maplist("mp_dome", "Dome" ,"Dome Depot", scripts\jugg\maps\edits::dome_edit2, "Clippy");
	add_map_to_maplist("mp_dome", "Dome" ,"Bunker Defence", scripts\jugg\maps\edits::dome_edit3, "TMGlion");
	add_map_to_maplist("mp_underground", "Underground" ,"Loading Bay", scripts\jugg\maps\edits::underground_edit1, "Clippy & TMGlion");
	add_map_to_maplist("mp_underground", "Underground" ,"The Long Road", scripts\jugg\maps\edits::underground_edit2, "TMGlion");
	add_map_to_maplist("mp_underground", "Underground" ,"Abandoned Station", scripts\jugg\maps\edits::underground_edit3, "TMGlion");
	add_map_to_maplist("mp_nightshift", "Skidrow" ,"The Long Straight", scripts\jugg\maps\edits::skidrow_edit1, "Clippy & TMGlion");
	add_map_to_maplist("mp_nightshift", "Skidrow" ,"Venting rooftop", scripts\jugg\maps\edits::skidrow_edit2, "Clippy & TMGlion");
	add_map_to_maplist("mp_nightshift", "Skidrow" ,"Stairway Struggle", scripts\jugg\maps\edits::skidrow_edit3, "TMGlion");
	add_map_to_maplist("mp_terminal_cls", "Terminal" ,"Airport Shops", scripts\jugg\maps\edits::terminal_edit1, "Clippy");
	add_map_to_maplist("mp_terminal_cls", "Terminal" ,"...No Russian", scripts\jugg\maps\edits::terminal_edit2, "TMGlion");
	add_map_to_maplist("mp_roughneck", "Offshore" ,"Crane Blasting", scripts\jugg\maps\edits::offshore_edit1, "Clippy & TMGlion");
	add_map_to_maplist("mp_courtyard_ss", "Erosion" ,"Courtyard", scripts\jugg\maps\edits::erosion_edit1, "Revox");
	//add_map_to_maplist("mp_courtyard_ss", "Erosion" ,"Bridge Runner", scripts\jugg\maps\edits::erosion_edit2, "TMGlion");
	add_map_to_maplist("mp_highrise", "Highrise" ,"Helipad Crossing", scripts\jugg\maps\edits::highrise_edit1, "Clippy");
	add_map_to_maplist("mp_highrise", "Highrise" ,"Around The Roof", scripts\jugg\maps\edits::highrise_edit2, "Clippy & TMGlion");
	add_map_to_maplist("mp_moab", "Gulch" ,"Prickly Pain", scripts\jugg\maps\edits::gulch_edit1, "Clippy");
	add_map_to_maplist("mp_shipbreaker", "Decommision" ,"Coastal Defence", scripts\jugg\maps\edits::decommision_edit1, "Clippy");
	// add_map_to_maplist("mp_boneyard", "Scrapyard" ,"Airplane Graveyard", scripts\jugg\maps\edits::scrapyard_edit1, "Clippy & TMGlion");
	add_map_to_maplist("mp_vacant", "Vacant" ,"Hotel Polissya", scripts\jugg\maps\edits::vacant_edit1, "Clippy & Sloth");
	add_map_to_maplist("mp_vacant", "Vacant" ,"Shit Vacant", scripts\jugg\maps\edits::vacant_edit2, "Clippy");
	add_map_to_maplist("mp_lockout_h2", "Lockout H2" ,"Halo Ascension", scripts\jugg\maps\edits::lockout_h2_edit1, "Clippy & TMGlion");
	add_map_to_maplist("mp_lockout_h2", "Lockout H2" ,"Shafted", scripts\jugg\maps\edits::lockout_h2_edit2, "Clippy");
	add_map_to_maplist("mp_cement", "Foundation" ,"Cement Cannon", scripts\jugg\maps\edits::foundation_edit1, "Sloth & TMGlion");
	add_map_to_maplist("mp_derail", "Derail" ,"Snowy Sewer", scripts\jugg\maps\edits::derail_edit1, "Revox, Sloth & TMGlion");
	add_map_to_maplist("mp_checkpoint", "Karachi" ,"Storm the Drain", scripts\jugg\maps\edits::karachi_edit1, "TMGlion");
	add_map_to_maplist("mp_checkpoint", "Karachi" ,"Base Defence", scripts\jugg\maps\edits::karachi_edit2, "TMGlion");
	add_map_to_maplist("mp_overwatch", "Overwatch" ,"Skyscraper", scripts\jugg\maps\edits::overwatch_edit1, "Steven, TMGlion & Sloth");
	add_map_to_maplist("mp_qadeem", "Oasis" ,"Pool Defence", scripts\jugg\maps\edits::oasis_edit1, "TMGlion");
	add_map_to_maplist("mp_factory_sh", "Der Riese" ,"Camping at the Catwalk", scripts\jugg\maps\edits::DerRiese_edit1, "TMGlion");
	add_map_to_maplist("mp_poolparty", "Pool Party" ,"Dock Party", scripts\jugg\maps\edits::poolparty_edit1, "Clippy");
	add_map_to_maplist("mp_firingrange", "Firing Range" ,"Target Practice", scripts\jugg\maps\edits::firingrange_edit1, "Clickerz");
	add_map_to_maplist("mp_minecraft", "Minecraft" ,"Mining & Camping", scripts\jugg\maps\edits::minecraft_edit1, "Clippy");

	add_map_to_maplist("mp_dome", "Dome" ,"Simple Times", scripts\jugg\maps\edits::dome_liver_1, "urLiver");
	add_map_to_maplist("mp_underground", "Underground" ,"Running down the Allyway", scripts\jugg\maps\edits::underground_liver_1, "urLiver");
	add_map_to_maplist("mp_poolday", "Pool Day" ,"Splish Splash Splosh", scripts\jugg\maps\edits::edit_none, "" );
	add_map_to_maplist("mp_poolday_reunion", "Pool Day Reunion" ,"Splish Splash Splosh 2", scripts\jugg\maps\edits::edit_none, "" );

	selected_edit = strtok(getdvar("mapvote_mapedit"), ";");
	
	if(isdefined(selected_edit[0]) && selected_edit[0] == level.map_name) {
		rnd = selected_edit[1];
		level [[level.tpjugg_mapedit[selected_edit[1]]]]();
		if(isdefined(level.tpjugg_mapedit_credits[selected_edit[1]]))
			level thread map_credits_edit_hud(level.tpjugg_maplist_display_name[selected_edit[0]], selected_edit[1], level.tpjugg_mapedit_credits[selected_edit[1]]);
		else
			level thread map_credits_edit_hud(level.tpjugg_maplist_display_name[selected_edit[0]], selected_edit[1]);
	}
	else if(isdefined(level.tpjugg_maplist[level.map_name])) {
		rnd = level.tpjugg_maplist[level.map_name][randomint(level.tpjugg_maplist[level.map_name].size)];
		level [[level.tpjugg_mapedit[rnd]]]();
		if(isdefined(level.tpjugg_mapedit_credits[rnd]))
			level thread map_credits_edit_hud(level.tpjugg_maplist_display_name[level.map_name], rnd, level.tpjugg_mapedit_credits[rnd]);
		else
			level thread map_credits_edit_hud(level.tpjugg_maplist_display_name[level.map_name], rnd);
	}

	if(!isdefined(level.lowest_crate)) {
		ents = getentarray("tpjug", "targetname");
	
		if(ents.size) {
			level.lowest_crate = ents[0].origin[2];
			for(i = 0;i < ents.size;i++) {
				if(ents[i].origin[2] < level.lowest_crate)
					level.lowest_crate = ents[i].origin[2];
			}
		}
	}

	scripts\jugg\maps\objects::delete_remote_spawnpoints();
	
    if(!isdefined(rnd))
		print(getdvar("prefix") + "No Random Map Edit On Map: ^5" + level.map_name + " - Playing Mapedit ^5" + rnd);
    else
		print(getdvar("prefix") + "Mapedit ^5" + rnd + " ^7Picked On ^5" + level.map_name);
	
	//Logic after map load
	level thread anti_breach_logic();
	level thread airstrike_ent_check();

	wait 5;

	print("^1-= Edit Has : ^3" + level.crates_placed + "^1 Crates =-");
}

add_map_to_maplist(map, display_name, edit_name, edit_func, maker) {
	if(!isdefined(level.tpjugg_maplist[map])) {
		level.tpjugg_maplist[map] = [];
		level.tpjugg_maplist_display_name[map] = display_name;
	}
	level.tpjugg_maplist[map][level.tpjugg_maplist[map].size] = edit_name;
	level.tpjugg_mapedit[edit_name] = edit_func;
	level.tpjugg_mapedit_credits[edit_name] = maker;
}

airstrike_ent_check() {
	ents = GetEntArray("script_origin", "classname");
	airstrikeheight = false;
	foreach(ent in ents) {
		if(isdefined(ent.targetname) && ent.targetname == "airstrikeheight")
			airstrikeheight = true;
	}

	if(!airstrikeheight) {
		if(isdefined(level.lowest_crate)) {
			airstrike_height = spawn("script_origin", level.lowest_crate + (0,0,1500));
			airstrike_height.targetname = "airstrikeheight";
		} else{
			trace = bullettrace((0,0,10000), (0,0,-5000), false, undefined);
			airstrike_height = spawn("script_origin", trace["position"] + (0,0,1000));
			airstrike_height.targetname = "airstrikeheight";
		}
	}

}

anti_breach_logic() {

	for(;;) {
		wait 0.5;
		foreach(player in level.players) {
			player.breaching = undefined;
		}

		if(isdefined(level.antibreachtriggers)) {
			for(i=0;i<level.antibreachtriggers.size;i++) {
				foreach(player in level.players) {
					if(player.team != "allies")
						continue;
					
					if(level.antibreachtriggers[i].classname == "trigger_radius") {
						if(player istouching(level.antibreachtriggers[i]))
							player.breaching = true;
					}
					else {
						if(scripts\jugg\maps\objects::insideRegionZ(level.antibreachtriggers[i].corner1, level.antibreachtriggers[i].corner2, player.origin))
							player.breaching = true;
					}
				}
			}
		}
		
		level notify("breach_check");
	}
}

map_credits_edit_hud(map, edit, maker) {
	if(!isdefined(map) || !isdefined(edit))
		return;

	if(!isdefined(level.info_hud_elements))
		level.info_hud_elements = [];

	level.info_hud_elements["credits_info"] = newhudelem();
	level.info_hud_elements["credits_info"].horzalign = "fullscreen";
	level.info_hud_elements["credits_info"].vertalign = "fullscreen";
	level.info_hud_elements["credits_info"].alignx = "left";
	level.info_hud_elements["credits_info"].aligny = "top";
	level.info_hud_elements["credits_info"].x = 10;
	level.info_hud_elements["credits_info"].y = 126;
	level.info_hud_elements["credits_info"].font = "bigfixed";
	level.info_hud_elements["credits_info"].archived = true;
	level.info_hud_elements["credits_info"].hidewheninmenu = 1;
	level.info_hud_elements["credits_info"].hidewheninkillcam = 1;
	level.info_hud_elements["credits_info"].fontscale = .4;
	level.info_hud_elements["credits_info"].alpha = 0;

	while( ! isdefined( level.fadein_infect_timerDisplay ) )
	{
		wait 0.1;
	}

	level.info_hud_elements["credits_info"] fadeovertime( 1.0 );
	level.info_hud_elements["credits_info"].alpha = 1;

	level.info_hud_elements["credits_info"] settext("^7Map: ^8" + map + "\n^7Edit: ^8" + edit);
	if( isdefined( maker ) )
	{
		level.info_hud_elements["credits_info"] settext("^7Map: ^8" + map + "\n^7Edit: ^8" + edit + "\n^7Made By: ^8" + maker);
	}

	while( ! isdefined( level.infected_timerdisplay_finished ) )
	{
		wait 0.1;
	}
	
	level.info_hud_elements["credits_info"] fadeovertime( 1.0 );
	level.info_hud_elements["credits_info"].alpha = 0;
	
	wait 1;
	
	level.info_hud_elements["credits_info"] destroy();
}

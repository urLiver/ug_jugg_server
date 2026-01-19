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

    level.someone_spectating = 0;

    precacheshader( "iw5_cardtitle_specialty_veteran" );
    precacheshader( "hud_scorebar_topcap" );
    precacheshader( "line_horizontal" );
    precacheshader( "waypoint_kill" );

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

	ents = getentarray(); // move to stats
    foreach( ent in ents ) 
    {
        if( isdefined( ent.targetname ) && ent.targetname == "destructible_toy" ) 
        {
            if( isdefined( ent.model ) && issubstr( ent.model, "chicken" ) )
            {
                ent thread track_chicken_damage();
            }
        }
    }
}

track_chicken_damage() 
{
    while( 1 ) 
	{
        self waittill( "damage", damage, attacker );

        if( isdefined( attacker ) && self.health <= 0 )
		{
            attacker.player_settings[ "chicken_kill" ]++;
            attacker notify( "player_stats_updated" );

			if( isdefined( self.origin ) )
			{
				PlayFX( level.money, self.origin );
			}

            break;
        }
    }
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

	replacefunc( maps\mp\gametypes\_gamelogic::fixranktable, ::blanky );

    thread scripts\core\stats::main();
}

blanky() 
{

}
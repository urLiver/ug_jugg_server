/*

    INFO:
        - This File Includes the ui and its creation

    TODO:
		- Re-write to fully only use core\ui_func.gsc

    DONE:
        - Created and rewrote parts of the ui to use core\ui_func.gsc
        
*/

init()
{

}

ui_nuke()
{
    level endon( "nuke_cancelled" );

	if( isdefined( level.nuke_timer_ui ) ) 
    {
		level.nuke_timer_ui destroy();
	}

    level.nuke_timer_ui = maps\mp\gametypes\_hud_util::createservertimer( "bigfixed", 0.8 );
    level.nuke_timer_ui maps\mp\gametypes\_hud_util::setpoint( "CENTER", "TOP", 0, 60 );
    level.nuke_timer_ui.label = &"Impact in: ^1";
    level.nuke_timer_ui settimer( 10 );
    level.nuke_timer_ui.archived = 1;
    level.nuke_timer_ui.hidewheninmenu = 1;
    level.nuke_timer_ui scripts\core\ui_func::fade_in( 1.0 );
}

ui_nuke_hide()
{
    if( isdefined( level.nuke_timer_ui ) )
    {
        level.nuke_timer_ui scripts\core\ui_func::fade_out( 1.0 );
    }
}

ui_kickwarning() 
{
	self endon("disconnect");
	self endon("kicked_outofedit");
	
    kicktime = 15;
	
    if( ! isdefined( self.hud_elements[ "about_to_kick" ] ) ) 
    {
        self.hud_elements[ "about_to_kick" ] = scripts\core\ui_func::client_text( self, "", "objective", 1.8, 230, 80, "left", "top", "fullscreen", "fullscreen", 1, 0, ( 1, 1, 1 ), undefined, 1, 1 );
        self.hud_elements[ "about_to_kick" ].label = &"^7Getting ^1KICKED^7 In: ^1&&1\n^7Move Into The ^3Edit";
        self.hud_elements[ "about_to_kick" ] setvalue( kicktime );
        scripts\core\ui_func::fade_in( 0.2, 1 );
    }

	while( self.status == "out" && self.team == "allies" ) 
    {
		self.hud_elements[ "about_to_kick" ] setvalue( kicktime );
		
        if( kicktime <= 0 )  
        {
			kick( self getEntityNumber(), "EXE_PLAYERKICKED_INACTIVE" );
			self notify( "kicked_outofedit" );
			break;
		}
		
        wait 1;
		
        kicktime--;
	}

	if( isdefined( self.hud_elements[ "about_to_kick" ] ) )
    {		
        self.hud_elements[ "about_to_kick" ] destroy();
    }

	self.not_in_edit_kick = undefined;
}

ui_killhudandxp()
{
    self notify( "kill_hudandxp" );

    if( isdefined( self.hud_elements[ "xp_value" ] ) )
    {
        self.hud_elements[ "xp_value" ] destroy();
    }

    if( isdefined( self.hud_elements[ "xp_value_max" ] ) )
    {
        self.hud_elements[ "xp_value_max" ] destroy();
    }

    if( isdefined( self.hud_elements[ "killsstreak_ui" ] ) )
    {
        self.hud_elements[ "killsstreak_ui" ] destroy();
    }

    if( isdefined( self.hud_elements[ "kills_ui" ] ) )
    {
        self.hud_elements[ "kills_ui" ] destroy();
    }

    if( isdefined( self.hud_elements[ "health_ui" ] ) )
    {
        self.hud_elements[ "health_ui" ] destroy();
    }

    if( isdefined( self.hud_elements[ "background_right" ] ) )
    {
        self.hud_elements[ "background_right" ] destroy();
    }

    if( isdefined( self.hud_elements[ "background_left" ] ) )
    {
        self.hud_elements[ "background_left" ] destroy();
    }

    if( isdefined( self.hud_elements[ "text_info_right" ] ) )
    {
        self.hud_elements[ "text_info_right" ] destroy();
    }

    ui_nuke_hide();
}

ui_xp()
{
	self endon( "disconnect" );
    self endon( "kill_hudandxp" );

	common_scripts\utility::waitframe();
    
    if( ! isdefined( self.hud_elements[ "xp_value" ] ) ) 
    {
        self.hud_elements[ "xp_value" ] = scripts\core\ui_func::client_text( self, "", "bigfixed", 0.4, 320, 475, "right", "bottom", 0, 1, ( 0, 1, 0 ), undefined, 1, 1 );
        self.hud_elements[ "xp_value" ].label = &"&&1 /";
        self.hud_elements[ "xp_value" ] scripts\core\ui_func::fade_in( 1.0 );

    }

    if( ! isdefined( self.hud_elements[ "xp_value_max" ] ) ) 
    {
        self.hud_elements[ "xp_value_max" ] = scripts\core\ui_func::client_text( self, " ", "bigfixed", 0.4, 320, 475, "left", "bottom", 0, 1, ( 0, 1, 0 ), undefined, 1, 1 );
        self.hud_elements[ "xp_value_max" ].label = &"^7 &&1";
        self.hud_elements[ "xp_value_max" ] scripts\core\ui_func::fade_in( 1.0 );
    }

	oldxp = self.player_settings[ "xp" ] - 1;
	for( ;; ) 
    {
		wait 0.25;
		
        if( oldxp == self.player_settings[ "xp" ] ) 
        {
            continue;
        }

        rank = self maps\mp\gametypes\_rank::getRankForXp( self.player_settings[ "xp" ] );

        xp_current = self.player_settings[ "xp" ] - maps\mp\gametypes\_rank::getRankInfoMinXp( rank );
        xp_next = ( maps\mp\gametypes\_rank::getRankInfoMaxXp( rank ) - maps\mp\gametypes\_rank::getRankInfoMinXp( rank ) ) ;
        fraction = ( xp_current / xp_next / 100 ) / 100;

        self.hud_elements[ "xp_value" ].color = ( fraction, 1 - fraction, 0 );
        self.hud_elements[ "xp_value" ] SetValue( xp_current );

        self.hud_elements[ "xp_value_max" ].color = ( fraction / 100, 1 - fraction, 0 );
        self.hud_elements[ "xp_value_max" ] SetValue( xp_next );


        oldxp = self.player_settings["xp"];

	}
}

update_ad( text )
{
	self endon( "disconnect" );
    self endon( "kill_hudandxp" );
	level endon( "game_ended" );

	if( isdefined( self.hud_elements[ "text_info_right" ] ) )
	{
		self.hud_elements[ "text_info_right" ].alpha = 1;
		self.hud_elements[ "text_info_right" ] FadeOverTime( .2 );
		self.hud_elements[ "text_info_right" ].alpha = 0;
		wait .2;

		self.hud_elements[ "text_info_right" ] SetText( text );
		self.hud_elements[ "text_info_right" ].alpha = 0;
		self.hud_elements[ "text_info_right" ] FadeOverTime( .2 );
		self.hud_elements[ "text_info_right" ].alpha = 1;
		wait .2;
	}
}

ui_hud() 
{
	self endon( "disconnect" );
    self endon( "kill_hudandxp" );
	level endon( "game_ended" );

	if( ! isdefined( self.hud_elements[ "background_right" ] ) ) 
    {
		self.hud_elements[ "background_right" ] = scripts\core\ui_func::client_shader( self, "iw5_cardtitle_specialty_veteran", 220, -20, 200, 45, "center", "top", "fullscreen", "fullscreen", 0, -3, ( .4, .4, .4 ), 0, 1 );
        self.hud_elements[ "background_right" ] scripts\core\ui_func::fade_in( 1.0 );

	}

	if( ! isdefined( self.hud_elements[ "background_left" ] ) )
    {
		self.hud_elements[ "background_left" ] = scripts\core\ui_func::client_shader( self, "iw5_cardtitle_specialty_veteran", 420, -20, 200, 45, "center", "top", "fullscreen", "fullscreen", 0, -3, ( .4, .4, .4 ), 0, 1 );
        self.hud_elements[ "background_left" ] scripts\core\ui_func::fade_in( 1.0 );
	}

	if( ! isdefined( self.hud_elements[ "text_info_right" ] ) ) 
    {
		self.hud_elements[ "text_info_right" ] = scripts\core\ui_func::client_text( self, "", "bigfixed", .35, 420, 2, "center", "top", "fullscreen", "fullscreen", 0, 0, ( 1, 1, 1 ), undefined, 0, 1 );
        self.hud_elements[ "text_info_right" ].label = &"";
        self.hud_elements[ "text_info_right" ] scripts\core\ui_func::fade_in( 1.0 );
	}

	if( ! isdefined( self.hud_elements[ "health_ui" ] ) ) 
    {
		self.hud_elements[ "health_ui" ] = scripts\core\ui_func::client_text( self, "", "bigfixed", .35, 285, 2, "right", "top", "fullscreen", "fullscreen", 0, 0, ( 1, 1, 1 ), undefined, 0, 1 );
        self.hud_elements[ "health_ui" ].label = &"Health: ^8";
        self.hud_elements[ "health_ui" ] scripts\core\ui_func::fade_in( 1.0 );
	}

	if( ! isdefined( self.hud_elements[ "kills_ui" ] ) ) 
    {
		self.hud_elements[ "kills_ui" ] = scripts\core\ui_func::client_text( self, "", "bigfixed", .35, 220, 2, "center", "top", "fullscreen", "fullscreen", 0, 0, ( 1, 1, 1 ), undefined, 0, 1 );
        self.hud_elements[ "kills_ui" ].label = &"Assists: ^8";
        self.hud_elements[ "kills_ui" ] scripts\core\ui_func::fade_in( 1.0 );
	}

	if( ! isdefined( self.hud_elements[ "killsstreak_ui" ] ) ) 
    {
		self.hud_elements[ "killsstreak_ui" ] = scripts\core\ui_func::client_text( self, "", "bigfixed", .35, 155, 2, "left", "top", "fullscreen", "fullscreen", 0, 0, ( 1, 1, 1 ), undefined, 0, 1 );
        self.hud_elements[ "killsstreak_ui" ].label = &"Kills: ^8";
        self.hud_elements[ "killsstreak_ui" ] scripts\core\ui_func::fade_in( 1.0 );
	}

	self thread ui_delete();
	
	current_Ad = 0;
	current_Ad_Time = 0;
	self thread update_ad( "^8[{vote no}] ^7High Fps   ^8[{vote yes}] ^7Fullbright   ^8[{+actionslot 1}] ^7Suicide" );
			
	while( 1 ) 
	{
        if( isdefined( self.hud_elements["killsstreak_ui" ] ) ) 
		{
            self.hud_elements["killsstreak_ui"]         setValue( self.pers[ "cur_kill_streak" ] );
            self.hud_elements["kills_ui"]               setvalue( self.pers[ "assistsToKill" ] );
            self.hud_elements["health_ui"]              setvalue( self.health );
        }

		if( isdefined( self.hud_elements[ "text_info_right" ] ) ) 
		{
			if( current_Ad_Time >= 400 && current_Ad == 0 )
			{
				current_Ad = 1;
				current_Ad_Time = 0;
				self thread update_ad( "Find us here: www.^8TP^7jugg.com" );
			}
			else if( current_Ad_Time >= 200 && current_Ad == 1 )
			{
				current_Ad = 0;
				current_Ad_Time = 0;
				self thread update_ad( "^8[{vote no}] ^7High Fps   ^8[{vote yes}] ^7Fullbright   ^8[{+actionslot 1}] ^7Suicide" );
			}
		}

		current_Ad_Time++;
        wait .1;
	}
}

handle_door_huds() 
{
	level endon("game_ended");
    self endon("disconnect");

    if(!isdefined(self.hud_elements["door_title"])) {
        self.hud_elements["door_title"] = newclienthudelem(self);
        self.hud_elements["door_title"].x = 320;
        self.hud_elements["door_title"].y = 258;
        self.hud_elements["door_title"].alignx = "center";
        self.hud_elements["door_title"].aligny = "top";
        self.hud_elements["door_title"].horzalign = "fullscreen";
        self.hud_elements["door_title"].vertalign = "fullscreen";
        self.hud_elements["door_title"].alpha = 0;
        self.hud_elements["door_title"].color = (1, 1, 1);
        self.hud_elements["door_title"].foreground = 0;
        self.hud_elements["door_title"].HideWhenInMenu = 1;
        self.hud_elements["door_title"].archived = 1;
        self.hud_elements["door_title"].fontscale = 1.3;
        self.hud_elements["door_title"].font = "small";
        self.hud_elements["door_title"].label = &"Door is: &&1";
    }

    if(!isdefined(self.hud_elements["door_hp_bar_bg"])) {
        self.hud_elements["door_hp_bar_bg"] = newclienthudelem(self);
        self.hud_elements["door_hp_bar_bg"].x = 320;
        self.hud_elements["door_hp_bar_bg"].y = 258 + 19;
        self.hud_elements["door_hp_bar_bg"].alignx = "center";
        self.hud_elements["door_hp_bar_bg"].aligny = "top";
        self.hud_elements["door_hp_bar_bg"].horzalign = "fullscreen";
        self.hud_elements["door_hp_bar_bg"].vertalign = "fullscreen";
        self.hud_elements["door_hp_bar_bg"].alpha = 0;
        self.hud_elements["door_hp_bar_bg"].color = (1, 1, 1);
        self.hud_elements["door_hp_bar_bg"].foreground = 0;
        self.hud_elements["door_hp_bar_bg"].sort = 0;
        self.hud_elements["door_hp_bar_bg"].HideWhenInMenu = 1;
        self.hud_elements["door_hp_bar_bg"].archived = 1;
        self.hud_elements["door_hp_bar_bg"] setshader("black", 120, 6);
    }

    if(!isdefined(self.hud_elements["door_hp_bar"])) {
        self.hud_elements["door_hp_bar"] = newclienthudelem(self);
        self.hud_elements["door_hp_bar"].x = 320 - 59;
        self.hud_elements["door_hp_bar"].y = 258 + 20;
        self.hud_elements["door_hp_bar"].alignx = "left";
        self.hud_elements["door_hp_bar"].aligny = "top";
        self.hud_elements["door_hp_bar"].horzalign = "fullscreen";
        self.hud_elements["door_hp_bar"].vertalign = "fullscreen";
        self.hud_elements["door_hp_bar"].alpha = 0;
        self.hud_elements["door_hp_bar"].color = (0, .5, 0);
        self.hud_elements["door_hp_bar"].sort = 1;
        self.hud_elements["door_hp_bar"].foreground = 0;
        self.hud_elements["door_hp_bar"].HideWhenInMenu = 1;
        self.hud_elements["door_hp_bar"].archived = 1;
        self.hud_elements["door_hp_bar"] setshader("white", 1, 4);
    }

    if(!isdefined(self.hud_elements["door_bind"])) {
        self.hud_elements["door_bind"] = newclienthudelem(self);
        self.hud_elements["door_bind"].x = 320;
        self.hud_elements["door_bind"].y = 258 + 130;
        self.hud_elements["door_bind"].alignx = "center";
        self.hud_elements["door_bind"].aligny = "top";
        self.hud_elements["door_bind"].horzalign = "fullscreen";
        self.hud_elements["door_bind"].vertalign = "fullscreen";
        self.hud_elements["door_bind"].alpha = 0;
        self.hud_elements["door_bind"].color = (1, 1, 1);
        self.hud_elements["door_bind"].foreground = 0;
        self.hud_elements["door_bind"].HideWhenInMenu = 1;
        self.hud_elements["door_bind"].archived = 1;
        self.hud_elements["door_bind"].fontscale = 1.3;
        self.hud_elements["door_bind"].font = "small";
        self.hud_elements["door_bind"].label = &"Press/Hold ^3[{+activate}]^7 to ";
    }

    state = "";

    while(1) {
        if(isdefined(self.touching_trigger)) {
            if(self.hud_elements["door_title"].alpha != 1)
                self.hud_elements["door_title"].alpha = 1;

            if(self.touching_trigger.state == "closed") {
                if(self.hud_elements["door_hp_bar"].alpha != .7) {
                    self.hud_elements["door_hp_bar"].alpha = .7;
                    self.hud_elements["door_hp_bar_bg"].alpha = .6;
                }

                if(self.hud_elements["door_bind"].alpha != 1)
                    self.hud_elements["door_bind"].alpha = 1;
            }
            else {
                if(self.hud_elements["door_hp_bar"].alpha != 0) {
                    self.hud_elements["door_hp_bar"].alpha = 0;
                    self.hud_elements["door_hp_bar_bg"].alpha = 0;
                }

                if(self.hud_elements["door_bind"].alpha != 1 && self.team == "allies")
                    self.hud_elements["door_bind"].alpha = 1;
            }

            if(self.touching_trigger.state != state) {
                if(self.touching_trigger.state == "open")
                    self.hud_elements["door_title"] settext("^2Open");
                else
                    self.hud_elements["door_title"] settext("^1Closed");

                state = self.touching_trigger.state;
            }

            if(self.touching_trigger.hp >= (self.touching_trigger.maxhp / 2))
                self.hud_elements["door_hp_bar"].color = (0, .5, 0);
            else if(self.touching_trigger.hp >= (self.touching_trigger.maxhp / 3))
                self.hud_elements["door_hp_bar"].color = (.5, .5, 0);
            else if(self.touching_trigger.hp >= (self.touching_trigger.maxhp / 5))
                self.hud_elements["door_hp_bar"].color = (.5, 0, 0);

            self.hud_elements["door_hp_bar"] setshader("white", int((self.touching_trigger.hp / self.touching_trigger.maxhp) * 118), 4);
        }
        else {
            self.save_origin = self.origin;

            if(self.hud_elements["door_title"].alpha != 0) {
                self.hud_elements["door_title"].alpha = 0;
                self.hud_elements["door_hp_bar"].alpha = 0;
                self.hud_elements["door_hp_bar_bg"].alpha = 0;
                self.hud_elements["door_bind"].alpha = 0;
            }
        }

        wait .1;
    }
}

level_hud_handler() {
    if(!isdefined(level.hud_elements))
        level.hud_elements = [];

    if(!isdefined(level.hud_elements["last_alive"])) {
        level.hud_elements["last_alive"] = newteamhudelem("axis");
        level.hud_elements["last_alive"].x = 0;
        level.hud_elements["last_alive"].y = 0;
        level.hud_elements["last_alive"].z = 0;
        level.hud_elements["last_alive"].archived = 1;
        level.hud_elements["last_alive"].alpha = 0;
        level.hud_elements["last_alive"] setShader( "waypoint_kill", 10, 10 );
        level.hud_elements["last_alive"] setWaypoint( 0, 1, 0, 0 );
    }

    target = undefined;

    while(1) {
        if(level.teamCount["allies"] == 1 && level.hud_elements["last_alive"].alpha != 1) {
            foreach(player in level.players) {
                if(player.team == "allies")
                    target = player;
            }
            level.hud_elements["last_alive"] settargetent(target);
            level.hud_elements["last_alive"].alpha = 0.85;
            level.hud_elements["last_alive"] fadeovertime( 1 );
            level.hud_elements["last_alive"].alpha = 0;
        }
        else if(level.teamCount["allies"] > 1 && level.hud_elements["last_alive"].alpha != 0)
            level.hud_elements["last_alive"].alpha = 0;

        wait 1;
    }
}

equipmenthud(gunname)
{
    self endon("disconnect");
    self endon("death");
    self endon("stopequipmenthud");

    self.equipmenthudicon = self maps\mp\gametypes\_hud_util::createFontString( "default", 1.0);
	self.equipmenthudicon maps\mp\gametypes\_hud_util::setPoint( "CENTER", "BOTTOMRIGHT", -67, -12 );
    self.equipmenthudicon.HideWhenInMenu = 1;
    self.equipmenthudicon.HideWhenInkillcam = 1;
    self.equipmenthudicon.HideWhendead = 1;
    self.equipmenthudicon.foreground = 0;
    self.equipmenthudicon.alpha = 1;
	self.equipmenthudicon.archived = 0;

    self.equipmenthudnum = self maps\mp\gametypes\_hud_util::createFontString( "default", 1.3);
	self.equipmenthudnum maps\mp\gametypes\_hud_util::setPoint( "CENTER", "BOTTOMRIGHT", -62, -8 );
    self.equipmenthudnum.HideWhenInMenu = 1;
    self.equipmenthudnum.HideWhenInkillcam = 1;
    self.equipmenthudnum.HideWhendead = 1;
    self.equipmenthudnum.foreground = 1;
    self.equipmenthudnum setvalue(self getammocount(gunname));
    self.equipmenthudnum.alpha = 1;
	self.equipmenthudnum.archived = 0;

    if(gunname == "smoke_grenade_mp")
    {
        self.equipmenthudicon setShader("hud_us_smokegrenade", 21, 21);
    }
    else if(gunname == "concussion_grenade_mp")
    {
        self.equipmenthudicon setShader("hud_us_stungrenade", 21, 21);
    }
    else if(gunname == "emp_grenade_mp")
    {
        self.equipmenthudicon setShader("equipment_emp_grenade", 21, 21);
    }
    else if(gunname == "flash_grenade_mp")
    {
        self.equipmenthudicon setShader("hud_us_flashgrenade", 21, 21);
    }
    else if(gunname == "c4_mp")
    {
        self.equipmenthudicon setShader("hud_icon_c4", 21, 21);
    }

    self thread destroyequipmenthudondeath();


    while(1)
    {
        self waittill( "grenade_fire", grenade, weapName);

        if(weapname == gunname)
        {
            if(self getammocount(gunname) == 0)
            {
                if(isdefined(self.equipmenthudicon)) self.equipmenthudicon destroy();
                if(isdefined(self.equipmenthudnum)) self.equipmenthudnum destroy();
                self notify("stopequipmenthud");
            }
            else
            {
                self.equipmenthudnum setvalue(self getammocount(gunname));
            }
        }
    }
}

send_hud_notification_handler( text1, text2, color ) {
    if( isdefined( self.notificationtitle ) ) 
    {
        self.notificationtitle destroy();
        self.notificationtext destroy();
        self.notification_bg destroy();

        self notify("hud_new_input");
    }

    self thread send_hud_notification(text1, text2, color);
}

send_hud_notification( text1, text2, backgroundcolor ) {
    self endon("disconnect");
    self endon("hud_new_input");

    if( !isdefined( backgroundcolor ) )
    {
        backgroundcolor = ( RandomInt( 100 ) / 100, RandomInt( 100 ) / 100, RandomInt( 100 ) / 100 );
    }

    if( isdefined( text1 ) ) 
    {
        self.notificationtitle = newClientHudElem(self);
        self.notificationtitle.x = 320;
        self.notificationtitle.y = 320;
        self.notificationtitle.alignx = "center";
        self.notificationtitle.aligny = "middle";
        self.notificationtitle.horzalign = "fullscreen";
        self.notificationtitle.vertalign = "fullscreen";
        self.notificationtitle.alpha = 0;
        self.notificationtitle.sort = 1;
        self.notificationtitle.fontscale = .55;
        self.notificationtitle.font = "bigfixed";
        self.notificationtitle.color = backgroundcolor;
        self.notificationtitle.foreground = 0;
        self.notificationtitle.HideWhenInMenu = 1;
        self.notificationtitle.archived = 1;
        self.notificationtitle settext( text1 );

        self.notificationtext = newClientHudElem(self);
        self.notificationtext.x = 320;
        self.notificationtext.y = 335;
        self.notificationtext.alignx = "center";
        self.notificationtext.aligny = "middle";
        self.notificationtext.horzalign = "fullscreen";
        self.notificationtext.vertalign = "fullscreen";
        self.notificationtext.alpha = 0;
        self.notificationtext.sort = 1;
        self.notificationtext.fontscale = 1.3;
        self.notificationtext.color = (1, 1, 1);
        self.notificationtext.font = "small";
        self.notificationtext.foreground = 0;
        self.notificationtext.HideWhenInMenu = 1;
        self.notificationtext.archived = 1;
        self.notificationtext settext( text2 );

        self.notification_bg = newClientHudElem(self);
        self.notification_bg.x = 320;
        self.notification_bg.y = 312;
        self.notification_bg.alignx = "center";
        self.notification_bg.aligny = "top";
        self.notification_bg.horzalign = "fullscreen";
        self.notification_bg.vertalign = "fullscreen";
        self.notification_bg.alpha = 0;
        self.notification_bg.sort = 0;
        self.notification_bg.color = backgroundcolor;
        self.notification_bg.foreground = 0;
        self.notification_bg.HideWhenInMenu = 1;
        self.notification_bg.archived = 1;
        self.notification_bg setshader("line_horizontal", int(text2.size * 6), 33);
    }

    self.notificationtext fadeovertime( .2 );
    self.notificationtitle fadeovertime( .2 );
    self.notification_bg fadeovertime( .2 );

    self.notificationtitle.alpha = 1;
    self.notificationtext.alpha = 1;
    self.notification_bg.alpha = .7;

    self playlocalsound("copycat_steal_class");

    wait 3.5;

    self.notificationtext fadeovertime( .2 );
    self.notificationtitle fadeovertime( .2 );
    self.notification_bg fadeovertime( .2 );

    self.notificationtitle.alpha = 0;
    self.notificationtext.alpha = 0;
    self.notification_bg.alpha = 0;

    wait .3;

    self.notificationtitle destroy();
    self.notificationtext destroy();
    self.notification_bg destroy();
}

destroyequipmenthudondeath() 
{
    self waittill("death");

    if(isdefined( self.equipmenthudicon ) )
    {
        self.equipmenthudicon destroy();
    }

    if(isdefined( self.equipmenthudnum ) )
    {
        self.equipmenthudnum destroy();
    }
}

ui_delete() 
{
    self endon( "kill_hudandxp" );
	
    level waittill( "game_ended" );

	wait 0.05;

	if( isdefined( self.hud_elements ) )
    {
		foreach( hud in self.hud_elements )
        {
			hud destroy();
		}
		
        self.hud_elements = undefined;
	}

	if( isdefined( self.cz_elements ) )
    {
		foreach( hud in self.cz_elements )
        {
			hud destroy();
		}
		
        self.cz_elements = undefined;
	}

	self notify("hud_new_input");
}

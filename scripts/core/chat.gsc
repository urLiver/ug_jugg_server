/*

    INFO:
        - This File Includes the chat and its commands

    TODO:
		- Add More Tools for the Anti Cheat Team
        - Fix team chat by checking if substr [ Infected ] or [ Survivor ] exist and if so tell to all of those teams only
        - All commands go into chat_commands.gsc and then here just filter them or so 
    DONE:
        - Replaced the iw4m calls to a simple struct, for usability and not reliability on iw4m
        
*/

init() 
{
    onPlayerSay( ::on_onPlayerSay );

    /*

        Normally a bad way of doing, best here tho allowing for custom tags and infinite possibile ones.
        Works too without using iw4m + purpose for also setting the anti cheat team up

    */

    add_user( "0100000000434F72", "5", undefined, "^5Co-Owner^7", "5", true ); // liver
    add_user( "01000000000D3E9A", "7", "^6Zop^0.", "^1O^0wner", "8", false ); // zop

    add_user( "0100000000584517", "1", undefined, undefined, "1", false ); // gart
    add_user( "0100000000169CFE", ":", undefined, undefined, ":", true ); // neo
    
    add_mod( "010000000025A66D" ); // benji
    add_mod( "0100000000560722" ); // lim3
    add_mod( "0100000000194961" ); // deboo

    add_trusted( "01000000005C36EB" ); // Cheech23
    add_trusted( "010000000040B7F3" ); // xglcx
    add_trusted( "01000000004B5033" ); // ayrano
    add_trusted( "01000000004819CD" ); // abonoor
    add_trusted( "01000000005EA493" ); // miro
    add_trusted( "01000000005407DE" ); // k2poised
    add_trusted( "01000000005ECE6E" ); // not koto
    add_trusted( "01000000004E5A8A" ); // thetird
    add_trusted( "010000000004CF19" ); // pussy
    add_trusted( "01000000004CCD04" ); // norah
    add_trusted( "010000000008f785" ); // recked
    add_trusted( "01000000003BA5C1" ); // sham
    add_trusted( "0100000000598C58" ); // kristall
    add_trusted( "0100000000033F2A" ); // eg507
    add_trusted( "0100000000560ED8" ); // honky
    add_trusted( "01000000002ACFCC" ); // osko
    add_trusted( "01000000003360FA" ); // nippes
    add_trusted( "0100000000338734" ); // Loko

    add_organdonator( "01000000004EB9A3" ); // uwu
    add_organdonator( "0100000000088600" ); // usecode    

    add_donator( "01000000003089E5" ); // infinity gaybow
    add_donator( "01000000005DFBEA" ); // ghost
    add_donator( "01000000005F0469" ); // schocco

    add_supporter( "010000000054CAE4" ); // riles1
    add_supporter( "01000000003EA63D" ); // kermit
    add_supporter( "01000000001471E1" ); //XBLwatson
    add_supporter( "01000000000C0B53" ); //bunni
}

add_mod( guid )
{
    add_user( guid, "5", undefined, "^5Mod^7", "5", false );
}

add_trusted( guid )
{
    add_user( guid, "6", undefined, "^6Trusted^7", "6", false );
}

add_donator( guid )
{
    add_user( guid, "2", undefined, "^2$$$^7", "2", false );
}

add_supporter( guid )
{
    add_user( guid, "4", undefined, "^2$^7", "4", false );
}

add_organdonator( guid )
{
    add_user( guid, "0", undefined, "^0$$$$$^7", "0", false );
}

add_user( guid, name_color, name_replace, tag, background_color, anti_cheat ) 
{
    guid = tolower( guid );
	level.users[ guid ] = [];
    level.users[ guid ][ "color" ] = name_color;
    level.users[ guid ][ "name" ] = name_replace;
	level.users[ guid ][ "tag" ] = tag;
	level.users[ guid ][ "back" ] = background_color;
    level.users[ guid ][ "anti_cheat" ] = anti_cheat;
}

on_onPlayerSay( message, mode ) 
{
    if( isdefined( message ) && message != "" && message != " " ) 
    {
        guid = tolower( self.guid );
        args = strtok( tolower( message ), " " );

        if( args[ 0 ] == "@moabs" )
        {
            if( isdefined( args[ 1 ] ) )
            {
                target = playerexits( args[ 1 ] );
                if( ! isdefined( target ) )
                {
                    self tell_raw("^8^7[ ^8Information^7 ] No ^8matching ^7Player found in active Sesssion!" );
                }
                else
                {
                    say_raw("^8^7[ ^8Information^7 ] ^8" + target.name + "^7 called in ^8" + target.player_settings[ "called_in_moabs" ] + "^7 M.O.A.Bs");
                }
            }
            else
            {
                say_raw("^8^7[ ^8Information^7 ] ^8" + self.name + "^7 called in ^8" + self.player_settings[ "called_in_moabs" ] + "^7 M.O.A.Bs");
            }
        }

        if( args[ 0 ] == "@noabs" )
        {
            if( isdefined( args[ 1 ] ) )
            {
                target = playerexits( args[ 1 ] );
                if( ! isdefined( target ) )
                {
                    self tell_raw("^8^7[ ^8Information^7 ] No ^8matching ^7Player found in active Sesssion!" );
                }
                else
                {
                    say_raw("^8^7[ ^8Information^7 ] ^8" + target.name + "^7 called in ^8" + target.player_settings[ "noabs" ] + "^7 N.O.A.Bs");
                }
            }
            else
            {
                say_raw("^8^7[ ^8Information^7 ] ^8" + self.name + "^7 called in ^8" + self.player_settings[ "noabs" ] + "^7 N.O.A.Bs");
            }
        }

        if( message == "!y" && isdefined( level.votekick_inbound ) && ! isdefined( self.votekick_voted ) )
        {
            self.votekick_voted = 1;
            level.votekickers++;
            self tell_raw( "^8^7[ ^8Information^7 ] You voted for ^2yes" );
            return false;
        }

        if( message == "!n" && isdefined( level.votekick_inbound ) && ! isdefined( self.votekick_voted ) )
        {
            self.votekick_voted = 1;
            self tell_raw( "^8^7[ ^8Information^7 ] You voted for ^1no" );
            return false;
        }

        if( args[ 0 ] == "!moabs" )
        {
            if( isdefined( args[ 1 ] ) )
            {
                target = playerexits( args[ 1 ] );
                if( ! isdefined( target ) )
                {
                    self tell_raw("^8^7[ ^8Information^7 ] No ^8matching ^7Player found in active Sesssion!" );
                }
                else
                {
                    self tell_raw("^8^7[ ^8Information^7 ] ^8" + target.name + "^7 called in ^8" + target.player_settings[ "called_in_moabs" ] + "^7 M.O.A.Bs");
                }
            }
            else
            {
                self tell_raw("^8^7[ ^8Information^7 ] ^8" + self.name + "^7 called in ^8" + self.player_settings[ "called_in_moabs" ] + "^7 M.O.A.Bs");
            }
        }

        if( args[ 0 ] == "!noabs" )
        {
            if( isdefined( args[ 1 ] ) )
            {
                target = playerexits( args[ 1 ] );
                if( ! isdefined( target ) )
                {
                    self tell_raw("^8^7[ ^8Information^7 ] No ^8matching ^7Player found in active Sesssion!" );
                }
                else
                {
                    self tell_raw("^8^7[ ^8Information^7 ] ^8" + target.name + "^7 called in ^8" + target.player_settings[ "noabs" ] + "^7 N.O.A.Bs");
                }
            }
            else
            {
                self tell_raw("^8^7[ ^8Information^7 ] ^8" + self.name + "^7 called in ^8" + self.player_settings[ "noabs" ] + "^7 N.O.A.Bs");
            }
        }

        if( message == "!prestige" ) 
        {
            self thread scripts\core\stats::prestige_update();
            return false;
        }

        if( isdefined( level.users[ guid ] ) ) 
        {
            if( message[ 0 ] != "/" ) 
            {
                if( args[ 0 ] == "!votekick" && ! isdefined( level.votekick_inbound ) )
                {
                    if( isdefined( args[ 1 ] ) )
                    {
                        target = playerexits( args[ 1 ] );
                        if( ! isdefined( target ) )
                        {
                            self tell_raw("^8^7[ ^8Information^7 ] No ^8matching ^7Player found in active Sesssion!" );
                        }
                        else
                        {
                            self.votekick_voted = 1;
                            level.votekickers = 1;
                            level.votekick_inbound = 1;
                            say_raw( "^8^7[ ^8Information^7 ] ^2" + self.name + " ^7wants to vote kick ^1" + target.name + " ^7( ^8!y ^7/ ^8!n ^7)" );
                            target thread votekick_check();
                            level thread votekick( target );
                        }
                    }
                    else
                    {
                        self tell_raw( "^8^7[ ^8Information^7 ] No ^8matching ^7Player found in active Sesssion!" );
                    }

                    return false;
                }

                if( message == "?mask" )
                {
                    if( ! isdefined( self.player_settings[ "masked" ] ) || self.player_settings[ "masked" ] == 0 )
                    {
                        self.player_settings[ "masked" ] = 1;
                        self tell_raw( "^8^7[ ^8Information^7 ] ^8Masked" );
                    }
                    else
                    {
                        self.player_settings[ "masked" ] = 0;
                        self tell_raw( "^8^7[ ^8Information^7 ] ^8Unmasked" );
                    }

                    return false;
                }

                if( message == "?ufo" && level.users[ guid ][ "anti_cheat" ] )
                {
                    if( level.someone_spectating == 0 || level.someone_spectating == 1 && self.sessionstate == "spectator" )
                    {
                        if( self.sessionstate == "playing" || ! isdefined( self.isinufo ) ) 
                        {
                            level.someone_spectating = 1;

                            self.savedweapons = self getweaponslistprimaries();
                            self.isinufo = true;
                            self.sessionstate = "spectator";

                            self disableweapons();
                            self allowspectateteam( "allies", true );
                            self allowspectateteam( "axis", true );
                            self allowspectateteam( "freelook", true );

                            self thread wallhack();
                            self thread scripts\core\ui::ui_killhudandxp();
                        }
                        else 
                        {
                            level.someone_spectating = 0;

                            self.sessionstate = "playing";
                            self.isinufo = undefined;

                            self notify( "wallhack_end" );

                            self thread ufo_weapons_back();

                            self thread scripts\core\ui::ui_xp();
                            self thread scripts\core\ui::ui_hud();
                        }
                    }
                    else
                    {
                        self tell_raw( "^8^7[ ^8Information^7 ] Someone is already Spectating!" );
                    }

                    return false;
                }

                if( isdefined( self.player_settings[ "masked" ] ) && self.player_settings[ "masked" ] )
                {
                    name = self.name;

                    if( isdefined( level.users[ guid ][ "name" ] ) )
                    {
                        name = level.users[ guid ][ "name" ];
                    }

                    if( isdefined( level.users[ guid ][ "tag" ] ) )
                    {
                        say_raw( "^" + level.users[ guid ][ "back" ] + "^7[ " + level.users[ guid ][ "tag" ] + "^7 ] ^" + level.users[ guid ][ "color" ] + name + "^7: " + message );
                    }
                    else
                    {
                        say_raw( "^" + level.users[ guid ][ "back" ] + "^" + level.users[ guid ][ "color" ] + name + "^7: " + message );
                    }

                    return false;
                }
            }
        }
    }
}

votekick( target )
{
    level endon( "game_ended" );
    level endon( "votekick_calloff" );
    level endon( "votekick_ended" );

    say_raw( "^8^7[ ^8Information^7 ] Vote kick ends in: ^130" );
    wait 15;
    say_raw( "^8^7[ ^8Information^7 ] Vote kick ends in: ^115" );
    wait 10;
    say_raw( "^8^7[ ^8Information^7 ] Vote kick ends in: ^15" );
    wait 5;

    votekickers_needed = ( int( level.players.size / 2 ) + level.players.size % 2 );

    if( level.votekickers >= votekickers_needed )
    {
        say_raw( "^8^7[ ^8Information^7 ] Vote Kick ^2Succeded! ^7Votes:" + level.votekickers + "/" + votekickers_needed );
        kick( target getentitynumber() );
    }
    else
    {
        say_raw( "^8^7[ ^8Information^7 ] Vote Kick ^1Failed! ^7Votes:" + level.votekickers + "/" + votekickers_needed );
    }

    level.votekickers = 0;
    level.votekick_inbound = undefined;

    level notify( "votekick_ended" );
}

votekick_check()
{
    level endon( "votekick_calloff" );
    level endon( "votekick_ended" );
    
    for( ;; )
    {
        self waittill( "disconnect" );

        say_raw( "^8^7[ ^8Information^7 ] Vote Kick ^1Ended! ^7Player Left the Game" );
            
        level.votekickers = 0;
        level.votekick_inbound = undefined;

        level notify( "votekick_calloff" );
    }
}

ufo_weapons_back() 
{
    self enableweapons();
    guns = self getweaponslistprimaries();
    
    for( i = 0; i < guns.size; i++ )
    {
        self takeweapon( guns[ i ] );
    }

    wait 0.5;

    self.health = self.maxhealth;
    if( ! isdefined( self.savedweapons ) ) 
    {
        return;
    }
     
    if( isdefined( self.savedweapons[ 0 ] ) ) 
    {
        self giveweapon( self.savedweapons[ 0 ] );
        self switchtoweapon( self.savedweapons[ 0 ] );
    }
    
    if( isdefined( self.savedweapons[ 1 ] ) )
    { 
        self giveweapon( self.savedweapons[ 1 ] );
    }    
}

end_wallhack() 
{
	self endon("disconnect");

	self waittill("wallhack_end");

	foreach( hud in self.wallhack_huds )
    {
		hud destroy();
    }
}

wallhack_disconnected( user ) 
{
	user waittill( "disconnect" );

	if( isdefined( self ) )
    {
        self destroy();
    }
}

wallhack() 
{
	self endon( "disconnect" );
	self endon( "wallhack_end" );

	self.wallhack_huds = [];

	self thread end_wallhack();

	while( 1 ) 
    {
		foreach( player in level.players ) 
        {
			if( player == self ) 
            {
                continue;
            }

            spectating = self getspectatingplayer();

            if( ! isdefined( spectating ) || isdefined( spectating ) && spectating.team == player.team )
            {
                if( isdefined( player.wallhack_shader ) )
                {
                    player.wallhack_shader Destroy();
                }

                continue;
            }

            if( ! isdefined( player.wallhack_shader ) ) 
            {
                player.wallhack_shader = scripts\core\ui_func::client_wallhack( self, "hud_scorebar_topcap", 6, 6, .4 );
                player.wallhack_shader thread wallhack_disconnected( player );
                self.wallhack_huds[ self.wallhack_huds.size ] = player.wallhack_shader;
            }

            player.wallhack_shader.x = player.origin[ 0 ];
            player.wallhack_shader.y = player.origin[ 1 ];
            player.wallhack_shader.z = player.origin[ 2 ] + 10;
            player.wallhack_shader.color = ( .75, .75, 0 );

            if( spectating is_looking_at( player ) && sighttracepassed( spectating.origin + ( 0, 0, 64 ), player.origin + ( 0, 0, 64 ), false, spectating ) ) 
            {
                player.wallhack_shader.color = ( 1, .25, .25 );
            }
		}

		wait .05;
	}
}

is_looking_at( who ) 
{
	angles = vectortoAngles( ( who.origin + ( 0,0,50 ) ) - self.origin );

	if( angles[ 1 ] > 180 )
    {
		angles[ 1 ] = angles[ 1 ] - 360;
    }

	looking = ( self.angles[ 1 ] - angles[ 1 ] );
	if( looking > 340 )
    {
        looking = looking - 360;
    }

	if( looking < -340 )
    {
        looking = looking + 360;
    }

	if( looking > -35 && looking < 35 )
    {		
        return true;
    }

	return false;
}

playerexits( name ) 
{
    foreach( player in level.players ) 
    {
		if( issubstr( tolower( player.name ), tolower( name ) ) )
        {
			return player;
        }
    }

    return undefined;
}
/*

    INFO:
        - This File Includes the fix ( kick if used ) for the openmenu "bug" in plutonium allowing to switch teams and so on in gamemodes that normaly wont all that

    TODO:
		- None

    DONE:
        - Created
        
*/

init()
{
    replacefunc( maps\mp\gametypes\_menus::onmenuresponse, ::on_onmenuresponse );
}

quicksound_cooldown() 
{
    self endon( "disconnect" );

	self notify("quicksound_cooldownfunc");
	self endon("quicksound_cooldownfunc");

	self.quicksound_cooldown = 5;

	wait 5;

	self.quicksound_cooldown = undefined;
}

on_onmenuresponse()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "menuresponse", var_0, var_1 );

        if ( var_1 == "back" )
        {
            self closepopupmenu();
            self closeingamemenu();

            if ( maps\mp\gametypes\_menus::isoptionsmenu( var_0 ) )
            {
                if ( self.pers["team"] == "allies" )
                    self openpopupmenu( game["menu_class_allies"] );

                if ( self.pers["team"] == "axis" )
                    self openpopupmenu( game["menu_class_axis"] );
            }

            continue;
        }

        if ( var_1 == "changeteam" )
        {
            self closepopupmenu();
            self closeingamemenu();
            self openpopupmenu( game["menu_team"] );
        }

        if ( var_1 == "changeclass_marines" )
        {
            self closepopupmenu();
            self closeingamemenu();
            self openpopupmenu( game["menu_changeclass_allies"] );
            continue;
        }

        if ( var_1 == "changeclass_opfor" )
        {
            self closepopupmenu();
            self closeingamemenu();
            self openpopupmenu( game["menu_changeclass_axis"] );
            continue;
        }

        if ( var_1 == "changeclass_marines_splitscreen" )
            self openpopupmenu( "changeclass_marines_splitscreen" );

        if ( var_1 == "changeclass_opfor_splitscreen" )
            self openpopupmenu( "changeclass_opfor_splitscreen" );

        if ( var_1 == "endgame" )
        {
            /*
            if ( level.splitscreen )
            {
                endparty();

                if ( !level.gameended )
                    level thread maps\mp\gametypes\_gamelogic::forceend();
            }
            */
            
            continue;
        }

        if ( var_1 == "endround" )
        {
            /*
            if ( !level.gameended )
                level thread maps\mp\gametypes\_gamelogic::forceend();
            else
            {
                self closepopupmenu();
                self closeingamemenu();
                self iprintln( &"MP_HOST_ENDGAME_RESPONSE" );
            }
            */

            continue;
        }

        if ( var_0 == game["menu_team"] )
        {
            kick( self getentitynumber() );
            //switch ( var_1 )
            //{
            //    case "allies":
            //        self [[ level.allies ]]();
            //        break;
            //    case "axis":
            //        self [[ level.axis ]]();
            //        break;
            //    case "autoassign":
            //        self [[ level.autoassign ]]();
            //        break;
            //    case "spectator":
            //        self [[ level.spectator ]]();
            //        break;
            //}

            continue;
        }

        if ( var_0 == game["menu_changeclass"] || isdefined( game["menu_changeclass_defaults_splitscreen"] ) && var_0 == game["menu_changeclass_defaults_splitscreen"] || isdefined( game["menu_changeclass_custom_splitscreen"] ) && var_0 == game["menu_changeclass_custom_splitscreen"] )
        {
            kick( self getentitynumber() );
            //self closepopupmenu();
            //self closeingamemenu();
            //self.selectedclass = 1;
            //self [[ level.class ]]( var_1 );
            continue;
        }

        if ( !level.console )
        {
            if( var_0 == "quickcommands" ) 
            {
                if( var_1 == "thirdperson" ) 
                {
                    self.thirdperson = !self.thirdperson;
                    self setclientdvar( "cg_thirdperson", self.thirdperson );
                } 
                else if( var_1 == "suicide" ) 
                {
                    self suicide();
                }
                continue;
            }
            
            if( var_0 == "quicksounds" ) 
            {
                if( ! isdefined( self.quicksound_cooldown ) ) 
                {
                    self thread quicksound_cooldown( 5 );
                    self playsound( "quick_sound" + var_1 );
                }

                continue;
            }
            /*
            if ( var_0 == game["menu_quickcommands"] )
            {
                maps\mp\gametypes\_quickmessages::quickcommands( var_1 );
                continue;
            }

            if ( var_0 == game["menu_quickstatements"] )
            {
                maps\mp\gametypes\_quickmessages::quickstatements( var_1 );
                continue;
            }

            if ( var_0 == game["menu_quickresponses"] )
                maps\mp\gametypes\_quickmessages::quickresponses( var_1 );
            */  
        }
    }
}
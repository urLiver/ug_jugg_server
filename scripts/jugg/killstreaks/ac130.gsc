/*

    INFO:
        

*/

init()
{
    replacefunc( maps\mp\killstreaks\_ac130::overlay, ::on_overlay );
}

on_overlay( player ) 
{
	level.HUDItem = [];

	level.HUDItem[ "thermal_vision" ] = NewClientHudElem( player );
	level.HUDItem[ "thermal_vision" ].x = 200;
	level.HUDItem[ "thermal_vision" ].y = 0;
	level.HUDItem[ "thermal_vision" ].alignX = "left";
	level.HUDItem[ "thermal_vision" ].alignY = "top";
	level.HUDItem[ "thermal_vision" ].horzAlign = "left";
	level.HUDItem[ "thermal_vision" ].vertAlign = "top";
	level.HUDItem[ "thermal_vision" ].fontScale = 2.5;
	level.HUDItem[ "thermal_vision" ] SetText( &"AC130_HUD_FLIR");
	level.HUDItem[ "thermal_vision" ].alpha = 1.0;

	level.HUDItem[ "enhanced_vision" ] = NewClientHudElem( player );
	level.HUDItem[ "enhanced_vision" ].x = -200;
	level.HUDItem[ "enhanced_vision" ].y = 0;
	level.HUDItem[ "enhanced_vision" ].alignX = "right";
	level.HUDItem[ "enhanced_vision" ].alignY = "top";
	level.HUDItem[ "enhanced_vision" ].horzAlign = "right";
	level.HUDItem[ "enhanced_vision" ].vertAlign = "top";
	level.HUDItem[ "enhanced_vision" ].fontScale = 2.5;
	level.HUDItem[ "enhanced_vision" ] SetText( &"AC130_HUD_OPTICS");
	level.HUDItem[ "enhanced_vision" ].alpha = 1;

	player thread maps\mp\killstreaks\_ac130::overlay_coords();
}
/*

    INFO:
        - This File Includes the wrapper functions for the ui, to be used in core\ui_func.gsc
        - Function Prefixes explained:
            - server_ = server sided ui elements
            - client_ = client sided ui elements

    TODO:
		- Add more elemnts

    DONE:
        - Created
        
*/

init()
{

}

fade_out( time, alpha )
{
    if( ! isdefined( alpha ) )
        alpha = 0;

    self.alpha = 1;
    self FadeOverTime ( time );
    self.alpha = alpha;
}

fade_in( time, alpha )
{
    if( ! isdefined( alpha ) )
        alpha = 1;

    self.alpha = 0;
    self FadeOverTime ( time );
    self.alpha = alpha;
}

client_text( client, text, font, fontsize, x, y, alignx, aligny, horzalign, vertalign, alpha, sortkey, color, glowcolor, archived, hidewheninmenu )
{
    elem = NewClientHudElem( client );
    elem.x = x;
    elem.y = y;
    elem.alignx = alignx;
    elem.aligny = aligny;
    elem.horzalign = horzalign;
    elem.vertalign = vertalign;
    elem.alpha = alpha;
    elem.sort = sortkey;
    elem.archived = archived;
    elem.hidewheninmenu = hidewheninmenu;
    elem.hidewheninkillcam = 1;
    elem.fontscale = fontsize;
    elem.color = color;

    if( isdefined( glowcolor ) )
    {
        elem.glowcolor = glowcolor;
        elem.glowalpha = 1;
    }

    elem.font = font;

    if( text != "" )
    {
        elem settext( text );
    }

    return elem;
}

client_wallhack( client, shader, width, height, alpha )
{
    elem = NewClientHudElem( client );
    elem setshader( shader, width, height );
    elem setwaypoint( 2, 0 );
    elem.hideWhenInMenu = false;
    elem.hidewheninkillcam = false;
    elem.archived = false;
    elem.alpha = alpha;

    return elem;
}

client_shader( client, material, x, y, widht, height, alignx, aligny, horzalign, vertalign, alpha, sortkey, color, archived, hidewheninmenu )
{
    elem = NewClientHudElem( client );
    elem.x = x;
    elem.y = y;
    elem.alignx = alignx;
    elem.aligny = aligny;
    elem.horzalign = horzalign;
    elem.vertalign = vertalign;
    elem.alpha = alpha;
    elem.sort = sortkey;
    elem.archived = archived;
    elem.hidewheninmenu = hidewheninmenu;
    elem.hidewheninkillcam = 1;
    elem.color = color;
    elem setshader( material, widht, height );

    return elem;
}

server_timer( text, time, font, fontsize, x, y, alignx, aligny, horzalign, vertalign, alpha, sortkey, color, archived, hidewheninmenu )
{
    elem = maps\mp\gametypes\_hud_util::createservertimer( font, fontsize );
    elem settimer( time );
    elem.x = x;
    elem.y = y;
    elem.alignx = alignx;
    elem.aligny = aligny;
    elem.horzalign = horzalign;
    elem.vertalign = vertalign;
    elem.alpha = alpha;
    elem.sort = sortkey;
    elem.archived = archived;
    elem.hidewheninmenu = hidewheninmenu;
    elem.hidewheninkillcam = 1;
    elem.color = color;
    elem.label = text;

    return elem;
}

server_text( text, font, fontsize, x, y, alignx, aligny, horzalign, vertalign, alpha, sortkey, color, glowcolor, archived, hidewheninmenu )
{
    elem = NewHudElem();
    elem.x = x;
    elem.y = y;
    elem.alignx = alignx;
    elem.aligny = aligny;
    elem.horzalign = horzalign;
    elem.vertalign = vertalign;
    elem.alpha = alpha;
    elem.sort = sortkey;
    elem.archived = archived;
    elem.hidewheninmenu = hidewheninmenu;
    elem.hidewheninkillcam = 1;
    elem.fontscale = fontsize;
    elem.color = color;

    if( isdefined( glowcolor ) )
    {
        elem.glowcolor = glowcolor;
        elem.glowalpha = 1;
    }

    elem.font = font;

    if( text != "" )
    {
        elem settext( text );
    }

    return elem;
}

server_shader( material, x, y, widht, height, alignx, aligny, horzalign, vertalign, alpha, sortkey, color, archived, hidewheninmenu )
{
    elem = NewHudElem();
    elem.x = x;
    elem.y = y;
    elem.alignx = alignx;
    elem.aligny = aligny;
    elem.horzalign = horzalign;
    elem.vertalign = vertalign;
    elem.alpha = alpha;
    elem.sort = sortkey;
    elem.archived = archived;
    elem.hidewheninmenu = hidewheninmenu;
    elem.hidewheninkillcam = 1;
    elem.color = color;
    elem setshader( material, widht, height );

    return elem;
}
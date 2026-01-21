init()
{

}

givejuggernaut()
{
    self endon( "death" );
    self endon( "disconnect" );

    wait 0.05;

    self setmodel( "mp_fullbody_ally_juggernaut" );
    self setviewmodel( "viewhands_juggernaut_ally" );
    self.isjuggernautrecon = 1;
    self.juggmovespeedscaler = 0.75;
    self.movespeedscaler = 0.75;
    self.maxhealth = 50;
    self.health = self.maxhealth;
    var_1 = spawn( "script_model", self.origin );
    var_1.team = self.team;
    var_1 makeportableradar( self );
    self.personalradar = var_1;
    thread radarmover( var_1 );

    maps\mp\gametypes\_weapons::updatemovespeedscale();

    self attachshieldmodel( "weapon_riot_shield_mp", "tag_shield_back" );

    self.juggernautoverlay = newclienthudelem( self );
    self.juggernautoverlay.x = 0;
    self.juggernautoverlay.y = 0;
    self.juggernautoverlay.alignx = "left";
    self.juggernautoverlay.aligny = "top";
    self.juggernautoverlay.horzalign = "fullscreen";
    self.juggernautoverlay.vertalign = "fullscreen";
    self.juggernautoverlay setshader( "goggles_overlay", 640, 480 );
    self.juggernautoverlay.sort = -10;
    self.juggernautoverlay.archived = 1;
    self.juggernautoverlay.hidein3rdperson = 1;

    thread juggernautsounds();

    self setperk( "specialty_radarjuggernaut", 1, 0 );

    thread juggremover();
}

juggernautsounds()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );

    for ( ;; )
    {
        wait 3.0;
        self playsound( "juggernaut_breathing_sound" );
    }
}

radarmover( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    self endon( "jugdar_removed" );

    for ( ;; )
    {
        var_0 moveto( self.origin, 0.05 );
        wait 0.05;
    }
}

juggremover()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );

    thread juggremoveongameended();
    thread juggremoveradarongameended();

    common_scripts\utility::waittill_any( "death", "joined_team", "joined_spectators", "lost_juggernaut" );

    self enableweaponpickup();
    self.isjuggernaut = 0;
    self.isjuggernautdef = 0;
    self.isjuggernautgl = 0;
    self.isjuggernautrecon = 0;

    if ( isdefined( self.juggernautoverlay ) )
    {
        self.juggernautoverlay destroy();
    }

    self unsetperk( "specialty_radarjuggernaut", 1 );

    if ( isdefined( self.personalradar ) )
    {
        self notify( "jugdar_removed" );
        level maps\mp\gametypes\_portable_radar::deleteportableradar( self.personalradar );
        self.personalradar = undefined;
    }

    self notify( "jugg_removed" );
}

juggremoveongameended()
{
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    level waittill( "game_ended" );

    if ( isdefined( self.juggernautoverlay ) )
    {
        self.juggernautoverlay destroy();
    }
}

juggremoveradarongameended()
{
    self endon( "jugg_removed" );
    level endon( "game_ended" );
    var_0 = self.personalradar;
    self waittill( "disconnect" );

    if ( isdefined( var_0 ) )
    {
        level maps\mp\gametypes\_portable_radar::deleteportableradar( var_0 );
    }
}
/*

    File includes the system for map edits by urLiver, used on custom edits by him

    TODOS:
    - Check if replacing getspawnpoint works flawlessly without fucking up the main spawn shit hole
*/

/*

    INFO:
        - This File Includes the custom logic for any future edit

    TODO:
		- Add more Elements, Elevator, Cannon and so on

    DONE:
        - Created
        
*/

init()
{
    level.ObjectiveID = 1;

    level.door_ui = [];
}

add_intermission( origin, angles )
{
    ent = getent( "mp_global_intermission", "classname" );
    ent.origin = origin;
    ent.angles = angles;
}

add_spawnpoint( origin, angles )
{
    if( !isdefined( level.customspawnpoints ) )
    {
        level.customspawnpoints = [];
    }

    ent = spawn("script_origin", origin);
	ent.origin = origin;
	ent.angles = angles;
    
    level.customspawnpoints[ level.customspawnpoints.size ] = ent;
}

playheatfx()
{
    level endon( "game_ended" );

    self endon( "not_overheated" );

    for (;;)
    {
        playfxontag( common_scripts\utility::getfx( "sentry_overheat_mp" ), self, "tag_flash" );
        wait( 0.3 );
    }
}

turret_shotmonitor()
{
    level endon( "game_ended" );

    var_1 = weaponfiretime( "sam_mp" );

    for (;;)
    {
        self waittill( "turret_fire" );
        self.heatlevel += var_1;
        self.cooldownwaittime = var_1;

        if( self.momentum < 0.05 )
            self.momentum += 0.01;
    }
}

turret_heatmonitor()
{
    level endon( "game_ended" );
    
    for (;;)
    {
        if ( self.heatlevel > 8.0 )
        {
            self.overheated = 1;
            self turretfiredisable();
            thread playheatfx();

            //playfxontag( common_scripts\utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );

            while ( self.heatlevel )
            {
                self.momentum = max( 0, self.momentum - 0.01 );
                wait 0.1;
            }

            self.overheated = 0;
            self turretfireenable();
            self notify( "not_overheated" );
        }

        wait 0.05;
    }
}

turret_coolmonitor()
{
    level endon( "game_ended" );
    
    for (;;)
    {
        if ( self.heatlevel > 0 )
        {
            if ( self.cooldownwaittime <= 0 )
            {      
                self.heatlevel = max( 0, self.heatlevel - 0.05 );
            
                if( self.momentum > 0 )
                    self.momentum -= 0.01;  
            }
            else
                self.cooldownwaittime = max( 0, self.cooldownwaittime - 0.05 );
        }

        wait 0.05;
    }
}

spawnuseableturret( origin, angles )
{
    ent = spawnturret( "misc_turret", origin, "sentry_minigun_mp" );
    ent setmodel( "sentry_minigun_weak" );
    ent.sentrytype = "sentry_minigun_mp";
    ent.angles = angles;
    ent sethintstring( &"PLATFORM_HOLD_TO_USE" );
    ent setleftarc( 50 );
    ent setrightarc( 50 );
    ent setbottomarc( 50 );
    ent setdefaultdroppitch( 0.0 );
    ent.laser_on = 1;
    ent laseron();
    ent.momentum = 0;
    ent.heatlevel = 0;
    ent.cooldownwaittime = 0;
    ent.overheated = 0;
    ent thread turret_heatmonitor();
    ent thread turret_coolmonitor();
    ent thread turret_shotmonitor();
}

portableradarproximitytrackerandsound()
{
    level endon( "game_ended" );

    var_0 = 128;
    
    for (;;)
    {
        wait 2.0;
        self playsound( "sentry_gun_beep" );

        foreach ( player in level.players )
        {
            player.hasradar = 0;
            if ( player.team != self.team )
                continue;

            if ( distancesquared( player.origin, self.origin ) < var_0 * var_0 )
            {
                player.hasradar = 1;
            }
        }
    }
}

spawnportableradar( origin )
{
    ent = spawn( "script_model", origin );
    ent setmodel( "weapon_radar" );
    ent.angles = ( 0, RandomInt( 361 ), 0 );
    ent.team = "allies";

    ent thread portableradarproximitytrackerandsound();
}

addobjective( origin, icon )
{
    level.ObjectiveID += 1;
	ID = 31 - level.ObjectiveID;
	
    objective_add( ID, "active" );
	objective_position( ID, origin );
    
    if( icon != "" )
    {
        objective_icon( ID, icon );
    }
}

endprotection()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    wait 0.69;
    self.flagprotection = undefined;
}

flagwatcher( origin, ent_exit )
{
    trigger = Spawn( "trigger_radius", origin, 0, 50, 50);

    for( ;; )
    {
        trigger waittill( "trigger", player );

        if( isdefined( ent_exit.flagprotection ) ) 
        {
            player.flagprotection = 1;
            player thread endprotection();
        }

        player SetOrigin( ent_exit.origin + ( 0, 0, 1 ) );
        player SetPlayerAngles( ent_exit.angles );
        player SetVelocity( ( 0, 0, 0 ) );
    }
}

spawnflagentrance( origin, ent_exit )
{
    ent = spawn( "script_model", origin );

   	ent setmodel( "prop_flag_neutral" );

    ent.angles = ( 0, RandomInt( 361 ), 0 );

    addobjective( origin, "" );

    level thread flagwatcher( origin, ent_exit );

    return ent;
}

spawnendpoint( origin, angles, flagprotection, fx )
{
    ent = spawn( "script_model", origin );

   	ent setmodel( "mil_emergency_flare_mp" );

    ent.angles = angles;

    ent playloopsound( "emt_road_flare_burn" );

    if( isdefined( flagprotection) )
    {  
        ent.flagprotection = 1;
    }

    wait 0.05;
    
    var_3 = ent gettagangles( "tag_fire_fx" );

    if( !isdefined( fx ) ) 
    {
        fx = level.red_flare;
    }

    var_4 = spawnfx( fx, ent gettagorigin( "tag_fire_fx" ), anglestoforward( var_3 ), anglestoup( var_3 ) );

    triggerfx( var_4 );

    return ent;
}

spawncrate( origin, angles, model ) 
{
    ent = spawn( "script_model", origin );

    if( isdefined( model ) )
    {
      	ent setmodel( model );
    }

    ent.angles = angles;

    ent clonebrushmodeltoscriptmodel( level.airdropcratecollision );

    return ent;
}

spawnfriendlycrate( origin, angles )
{
    return spawncrate( origin, angles, "com_plasticcase_friendly" );
}

spawnenemycrate( origin, angles )
{
    return spawncrate( origin, angles, "com_plasticcase_enemy" );
}

spawntrapcrate( origin, angles )
{
    return spawncrate( origin, angles, "com_plasticcase_trap_friendly" );
}

spawnramp( bottom, top, model )
{
    distance = Distance( top, bottom );
    cratecount = ceil( distance / 30 ) + 1;

    stepX = ( top[0] - bottom[0] ) / cratecount;
    stepY = ( top[1] - bottom[1] ) / cratecount;
    stepZ = ( top[2] - bottom[2] ) / cratecount;
    step = ( stepX, stepY, stepZ );

    vector = VectortoAngles( top - bottom );
    angles = ( vector[2], vector[1] + 90, vector[0] );

    bottomentity = spawn( "script_origin", bottom );

    for( var_0 = 0; var_0 < cratecount; var_0++ )
    {
        ent = spawncrate( bottom + ( step * var_0 ), angles, model );

        ent LinkTo( bottomentity );
        
        wait 0.05;
    }
}

spawnramp_friendly( bottom, top )
{
    thread spawnramp( bottom, top, "com_plasticcase_friendly" );
}

spawnramp_enemy( bottom, top )
{
    thread spawnramp( bottom, top, "com_plasticcase_enemy" );
}

spawnramp_trap( bottom, top )
{
    thread spawnramp( bottom, top, "com_plasticcase_trap_friendly" );
}

spawnwall( bottom, top, model, maxblocks, maxlayers ) {
    horizontalDist = Distance( ( bottom[0], bottom[1], 0 ), ( top[0], top[1], 0 ) );
    verticalDist = Distance( ( 0, 0, bottom[2] ), ( 0, 0, top[2] ) );

    numBlocks = ceil( horizontalDist / 50 ) + 1;

    if( isdefined( maxblocks ) )
        numBlocks = maxblocks;

    numLayers = ceil( verticalDist / 40 ) + 1;

    if( isdefined( maxlayers ) )
        numLayers = maxlayers;

    stepX = ( top[0] - bottom[0] ) / numBlocks;
    stepY = ( top[1] - bottom[1] ) / numBlocks;
    stepZ = ( top[2] - bottom[2] ) / numLayers;

    vector = VectorToAngles( top - bottom );
    angle = ( 0, vector[1], 90 );

    bottomentity = spawn("script_origin", bottom );
    
    for ( layer = 0; layer < numLayers; layer++ ) {
        for ( i = 0; i < numBlocks; i++ ) {
            ent = spawnCrate( bottom + ( ( stepX * i ), ( stepY * i ), ( 10 + stepZ * layer ) ), angle, model );

            ent LinkTo( bottomentity );

            wait 0.05;
        }
    }
}

spawnwall_friendly( bottom, top, maxblocks, maxlayers )
{
    thread spawnwall( bottom, top, "com_plasticcase_friendly", maxblocks, maxlayers );
}

spawnwall_enemy( bottom, top, maxblocks, maxlayers )
{
    thread spawnwall( bottom, top, "com_plasticcase_enemy", maxblocks, maxlayers );
}

spawnwall_trap( bottom, top, maxblocks, maxlayers )
{
    thread spawnwall( bottom, top, "com_plasticcase_trap_friendly", maxblocks, maxlayers );
}

spawnwall_redglowing( bottom, top, maxblocks, maxlayers )
{
    thread spawnwall( bottom, top, "com_plasticcase_trap_bombsquad", maxblocks, maxlayers );
}

spawnwall_invisibile( bottom, top, maxblocks, maxlayers )
{
    thread spawnwall( bottom, top, "", maxblocks, maxlayers );
}

moveleftirght()
{
    for( ;; )
    {
        wait 10;

        self MoveTo( self.origin + ( 0, 0, 200 ), 5 );

        wait 10;

        self MoveTo( self.origin + ( 0, 0, -200 ), 5 );

        wait 10;
    }
}

dooropen( id, movdir )
{
    self MoveTo( self.origin + movdir, 3 );
    wait 3;
    level.door_ui[ id ].state = 1;
}

doorclose( id, movdir, stuckreset )
{
    self MoveTo( self.origin - movdir, 3 );
    wait 3;
    level.door_ui[ id ].state = 0;

    foreach( player in level.players )
    {
        foreach ( ent in self.triggers )
        {
            if( player IsTouching( ent ) ) 
            {
                oldorigin = player.origin;
                player SetVelocity( ( 0, 0, 30 ) );
                wait .05;
                
                if( player.origin == oldorigin )
                {
                    player SetOrigin( stuckreset );
                }
            }
        }
    }
}

doorupdateui( id )
{
    level endon( "game_ended" );
    //level endon( "cancle_door_ui_updates" );

    // level.door_ui[ id ].durability SetValue( level.door_ui[ id ].health );
    //percent = ( level.door_ui[ id ].health / 100 );

    //level.door_ui[ id ].durability setshader( "white", int( percent * 75.0 ), 2 );
    //level.door_ui[ id ].durability.color = ( ( 1 - percent ), percent, 0 );
}

doorhit( id, dmg, attacker )
{
    if( level.door_ui[ id ].health - dmg < 0)
        level.door_ui[ id ].health = 0;
    else 
        level.door_ui[ id ].health -= dmg;

    attacker IPrintLnBold( "Health: ^1" + level.door_ui[ id ].health + " ^7/ ^1100" );

    attacker playlocalsound( "MP_hit_alert" );

    //level notify( "cancle_door_ui_updates" );
    //level thread doorupdateui( id );

    wait 1.5;

    attacker.door_hit_cooldown = 0;
}

spawndecoy() {
	ent = spawn("script_model", self.origin);

	ent setmodel( self.model );

	ent.angles = self.angles;

	self delete();

    num1 = randomintrange(-300, 300);
    num2 = randomintrange(-300, 300);
    num3 = randomintrange(-300, 300);
    num4 = randomintrange(-300, 300);
    
    ent physicslaunchserver( ( num1, num2, 1000), ( num3, num4, 1000));
    
    wait ( RandomInt( 10 ) + 10 );

    ent delete();
}

doorlistener( id, entity )
{
    level endon( "game_ended" );
    level endon( "door" + id + "_finished" );

    for( ;; )
    {
        if( level.door_ui[ id ].health != level.door_ui[ id ].oldhealth)
        {
            level.door_ui[ id ].oldhealth = level.door_ui[ id ].health;

            // level.door_ui[ id ].durability SetValue( level.door_ui[ id ].health );
        }

        if( level.door_ui[ id ].health <= 0 )
        {
            level notify( "door" + id + "_fucked" );

            PlayFX(level.stinger_explosion, entity.origin);

            earthquake( 0.1, 0.5, entity.origin, 1000 );

            entity PlaySound( "exp_suitcase_bomb_main" );

            foreach( ent in entity.linkers )
            {
                ent thread spawndecoy();
            }

            foreach( fx in entity.fxs )
            {
                fx delete();
            }

            foreach( trigger in entity.triggers )
            {
                trigger delete();
            }

            wait 0.5;

            entity Delete();

            level notify( "door" + id + "_finished" );
        }

        wait 0.2;
    }
}

doortrigger( id, link, movdir, dmg, stuckreset )
{
    level endon( "game_ended" );
    level endon( "door" + id + "_fucked" );

    while( isdefined( level.infect_choseFirstInfected ) && !level.infect_choseFirstInfected )
        wait 1;

    for( ;; )   
    {
        self waittill( "trigger", player );

        if( player.sessionteam == "axis" )
        {
            if( level.door_ui[ id ].state == 0  )
            {
                player maps\mp\_utility::setlowermessage( "pickup_hint", "Press ^3[{+activate}]^7 to ^3Attack^7 the Door", 1, undefined, undefined, undefined, undefined, undefined, 1 );
            }

            if( player UseButtonPressed() && player.door_hit_cooldown == 0 && level.door_ui[ id ].state == 0 )
            {    
                player.door_hit_cooldown = 1;

                link thread doorhit( id, dmg, player );
            }
        }

        if( player.sessionteam == "allies" )
        {

            if( level.door_ui[ id ].state == 0 ) 
            {
                player maps\mp\_utility::setlowermessage( "pickup_hint", "Press ^3[{+activate}]^7 to ^3Open^7 the Door", 1, undefined, undefined, undefined, undefined, undefined, 1 );
            }
            else if( level.door_ui[ id ].state == 1 ) 
            {
                player maps\mp\_utility::setlowermessage( "pickup_hint", "Press ^3[{+activate}]^7 to ^3Close^7 the Door", 1, undefined, undefined, undefined, undefined, undefined, 1 );
            }
                       
            if( player UseButtonPressed() && level.door_ui[ id ].state != 2 )
            {
                oldstate = level.door_ui[ id ].state;
                level.door_ui[ id ].state = 2;

                if( oldstate == 0 )
                {
                    IPrintLnBold( "Door " + ( id + 1 ) + " ^2opened ^7by ^3" + player.name + "^7!");
                    link thread dooropen( id, movdir );
                }
                else 
                {
                    IPrintLnBold( "Door " + ( id + 1 ) + " ^1closed ^7by ^3" + player.name + "^7!");
                    link thread doorclose( id, movdir, stuckreset );
                }
            }
        }
    }
}

spawndoor( id, bottom, top, movdir, dmg, model, maxblocks, stuckreset )
{
    new_door_ui = SpawnStruct();
    new_door_ui.state = 1;
    new_door_ui.health = 100;
    new_door_ui.oldhealth = 100;
    level.door_ui[ level.door_ui.size ] = new_door_ui;

    horizontalDist = Distance( ( bottom[0], bottom[1], 0 ), ( top[0], top[1], 0 ) );
    verticalDist = Distance( ( 0, 0, bottom[2] ), ( 0, 0, top[2] ) );

    numBlocks = ceil( horizontalDist / 50 ) + 1;

    if( isdefined( maxblocks ) )
        numBlocks = maxblocks;

    numLayers = ceil( verticalDist / 40 ) + 1;

    stepX = ( top[0] - bottom[0] ) / numBlocks;
    stepY = ( top[1] - bottom[1] ) / numBlocks;
    stepZ = ( top[2] - bottom[2] ) / numLayers;

    vector = VectorToAngles( top - bottom );
    angle = ( 0, vector[1], 90 );

    bottomentity = spawn("script_origin", bottom );
    level thread doorlistener( id, bottomentity );

    bottomentity.triggers = [];
    bottomentity.fxs = [];
    bottomentity.linkers = [];

    for ( layer = 0; layer < numLayers; layer++ ) {
        if( ( layer + 2 ) % 2 != 0 )
            continue;

        for ( i = 0; i < numBlocks; i++ ) {
            pos = bottom + ( ( stepX * i ), ( stepY * i ), ( 10 + stepZ * layer ) );
            ent = spawnCrate( pos, angle, model );

            bottomentity.linkers[ bottomentity.linkers.size ] = ent;

            if( layer == 0 )
            {
                trigger = spawn("trigger_radius", pos, 1,  70, verticalDist);
                trigger thread doortrigger( id, bottomentity, movdir, dmg, stuckreset );

                fx = SpawnFX( level.green_ball, pos );
                TriggerFX( fx );
                
                bottomentity.fxs[ bottomentity.fxs.size ] = fx;
                bottomentity.triggers[ bottomentity.triggers.size ] = trigger;
            }

            ent LinkTo( bottomentity );

            wait 0.05;
        }
    }

    bottomentity MoveTo( bottomentity.origin + movdir, 1 );
}

spawndoor_friendly( id, bottom, top, movdir, dmg, maxblocks, stuckreset )
{
    thread spawndoor( id, bottom, top, movdir, dmg, "com_plasticcase_friendly", maxblocks, stuckreset );
}

spawndoor_enemy( id, bottom, top, movdir, dmg, maxblocks, stuckreset )
{
    thread spawndoor( id, bottom, top, movdir, dmg, "com_plasticcase_enemy", maxblocks, stuckreset );
}

spawndoor_trap( id, bottom, top, movdir, dmg, maxblocks, stuckreset )
{
    thread spawndoor( id, bottom, top, movdir, dmg, "com_plasticcase_trap_friendly", maxblocks, stuckreset );
}

resettrigger( resetpos )
{
    level endon( "game_ended" );

    for( ;; )   
    {
        self waittill( "trigger", player );
        
        player SetOrigin( resetpos );
    }
}

spawnteleportwall( left, right, height, resetpos ) {
    horizontalDist = Distance( ( left[0], left[1], 0 ), ( right[0], right[1], 0 ) );

    numBlocks = ceil( horizontalDist / 60 ) + 1;

    stepX = ( right[0] - left[0] ) / numBlocks;
    stepY = ( right[1] - left[1] ) / numBlocks;

    for ( i = 0; i < numBlocks; i++ ) {
        pos = left + ( ( stepX * i ), ( stepY * i ), 0 );

        trigger = spawn("trigger_radius", pos, 1, 70, height);
        trigger thread resettrigger( resetpos );

        //ent = spawn( "script_model", pos );
      	//ent setmodel( "projectile_bouncing_betty_grenade_bombsquad" );
        //ent.angles = ( 0, 0, 0 );

        fx = SpawnFX( level.c4_blinking, pos );
        TriggerFX( fx );

        wait 0.05;
    }
}

checkplayersinz( minx, maxx, miny, maxy, minz )
{
    level endon( "game_ended" );

    for( ;; )
    {
        foreach( player in level.players )
        {
            if( player.origin[0] >= minx && player.origin[0] <= maxx
                && player.origin[1] >= miny && player.origin[1] <= maxy )
            {
                if( player.origin[2] < minz )
                {
                    player Suicide();
                }
            }
        }

        wait 1;
    }
}

spawn_zkillzone( minx, maxx, miny, maxy, minz )
{
    level thread checkplayersinz( minx, maxx, miny, maxy, minz );
}

spawnplatform( bottom, top, model, maxRows, maxCols ) 
{
    horizontalDist = Distance( ( bottom[0], bottom[1], 0 ), ( top[0], top[1], 0 ) );
    verticalDist = Distance( ( 0, 0, bottom[2] ), ( 0, 0, top[2] ) );

    numRows = ceil( horizontalDist / 50 ) + 1; 
    numCols = ceil( verticalDist / 30 ) + 1;

    if ( isdefined( maxRows ) )
        numRows = maxRows;

    if ( isdefined( maxCols ) )
        numCols = maxCols;

    stepX = ( top[0] - bottom[0] ) / ( numRows - 1 );
    stepY = ( top[1] - bottom[1] ) / ( numCols - 1 );
    stepZ = ( top[2] - bottom[2] ) / ( numCols - 1 ); 

    vector = VectorToAngles( top - bottom );
    angles = ( 0, vector[1], 0 );

    bottomEntity = spawn( "script_origin", bottom );

    for ( row = 0; row < numRows; row++ ) 
    {
        for ( col = 0; col < numCols; col++ ) 
        {
            spawnPosition = ( bottom[0] + ( stepX * row ), bottom[1] + ( stepY * col ), bottom[2] );

            ent = spawnCrate( spawnPosition, angles, model );

            ent LinkTo( bottomEntity );

            wait 0.05;
        }
    }
}

spawnplattform_friendly( bottom, top, model, maxRows, maxCols )
{
    thread spawnplatform( bottom, top, "com_plasticcase_friendly", maxRows, maxCols );
}

spawnplattform_enemy( bottom, top, model, maxRows, maxCols )
{
    thread spawnplatform( bottom, top, "com_plasticcase_enemy", maxRows, maxCols );
}

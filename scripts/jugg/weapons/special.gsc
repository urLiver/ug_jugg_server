init()
{

}

ent_magicbullet( projectile )
{
    pos_start = self GetEye();
    pos_end = pos_start + AnglesToForward( self GetPlayerAngles() ) * 9999;
    trace = BulletTrace( pos_start, pos_end, 0, self );
    
    return magicbullet( projectile, pos_start, trace[ "position" ], self );
}

watch_shootingmustangandsallly()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for( ;; )
    {
        self waittill( "weapon_fired", weapname );

        if( weapname == "iw5_usp45_mp_akimbo" )
        {   
            ent_magicbullet( "m320_mp" );
        }
    }
}

give_mustangandsallly()
{
    self GiveWeapon( "iw5_usp45_mp_akimbo" );
    self setweaponammoclip( "iw5_usp45_mp_akimbo", 24 );
    self setweaponammostock( "iw5_usp45_mp_akimbo", 48 ); 

    self thread watch_shootingmustangandsallly();
}

give_flaregun()
{
    // .44 with one bullet, each minute gets a bullet extra if it has none in the clip ( if not shot check ), on shot spawn m320mp with a flar attached to it. on death spawn flare on ground and let two or so missiles rain down.

}
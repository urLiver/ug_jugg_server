init()
{
    
}

lasersight_think()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    for ( ;; )
    {
        if ( self getcurrentweapon() == "iw5_smaw_mp" )
        {
            self laseron(); // Doesn't work why?
        }
        else
        {
            self laseroff();
        }

        wait 0.05;
    }
}

monitor_lsr_missile_launch()
{
    self endon( "death" );
    self endon( "disconnect" );

    for ( ;; )
    {
        self waittill( "missile_fire", var_0, var_1 );

        if ( self getcurrentweapon() == "iw5_smaw_mp" )
        {
            if ( ! isdefined( self.lsr_target_ent ) )
            {
                self.lsr_target_ent = spawn( "script_origin", self.origin );
                self.lsr_target_ent.targetname = "lsr_missile";
            }

            self.lsr_target_ent thread lsr_target_monitor_and_cleanup( var_0 );
            var_0 thread lsr_rocket_think( self );
        }
    }
}

lsr_rocket_think( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );

    for ( ;; )
    {
        if ( var_0 playerads() > 0.3 )
        {
            var_1 = anglestoforward( var_0 getplayerangles() );
            var_2 = var_0 geteye();
            var_3 = var_2 + var_1 * 15000;
            var_4 = bullettrace( var_2, var_3, 1, var_0, 1, 0, 0, 0, 0 );
            var_0.lsr_target_ent.origin = var_4["position"];
            self missile_settargetent( var_0.lsr_target_ent );
        }

        wait 0.05;
    }
}

lsr_target_monitor_and_cleanup( var_0 )
{
    if ( ! isdefined( self.lsr_rocket_count ) )
    {
        self.lsr_rocket_count = 1;
    }
    else
    {
        self.lsr_rocket_count++;
    }

    var_0 waittill( "death" );
    self.lsr_rocket_count--;

    if ( self.lsr_rocket_count == 0 )
    {
        self delete();
    }
}
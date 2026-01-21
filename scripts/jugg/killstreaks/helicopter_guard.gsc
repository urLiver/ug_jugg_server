init()
{
    replacefunc( maps\mp\killstreaks\_helicopter_guard::lbSupport_followPlayer, ::on_lbSupport_followPlayer );
}

lbSupport_moveToPlayer() 
{
	level endon( "game_ended" );
	self endon( "death" );
	self endon( "leaving" );

	self.owner endon( "death" );
	self.owner endon( "disconnect" );
	self.owner endon( "joined_team" );
	self.owner endon( "joined_spectators" );

	self notify( "lbSupport_moveToPlayer" );
	self endon( "lbSupport_moveToPlayer" );

	self.inTransit = 1;

    distance = distance( self.owner.origin, self.origin );
    if( distance > 1000 )
    {
        distanceSpeed = distance / 30;
        self Vehicle_SetSpeed( distanceSpeed, distanceSpeed / 10, distanceSpeed / 10 );
    }
    else
    {
        self Vehicle_SetSpeed( self.speed, 60, 30 );
    }

	self setVehGoalPos( self.owner.origin + ( 0,0,700 ) + ( randomintrange( -50, 50 ), randomintrange( -50, 50 ), randomintrange( -10, 10 ) ), 1 );
	
    self waittill ( "goal" );
	
    self.inTransit = 0;
	
    self notify( "hit_goal" );
}

on_lbSupport_followPlayer() 
{
	level endon( "game_ended" );
	self endon( "death" );
	self endon( "leaving" );

	if( ! IsDefined( self.owner ) ) 
    {
		self thread maps\mp\killstreaks\_helicopter_guard::lbSupport_leave();
		return;
	}

	self.owner endon( "disconnect" );
	self.owner endon( "joined_team" );
	self.owner endon( "joined_spectators" );

	self Vehicle_SetSpeed( self.followSpeed, 20, 20 );

	while( 1 ) 
    {
		if( IsDefined( self.owner ) && IsAlive( self.owner ) ) 
        {
			if( distance2d( self.origin, self.owner.origin ) > 300 )
            {
			    lbSupport_moveToPlayer();
            }
		}

		wait 1;
	}
}
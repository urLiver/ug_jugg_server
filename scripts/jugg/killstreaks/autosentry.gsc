/*

    INFO:
        

*/

init()
{
    replacefunc( maps\mp\killstreaks\_autosentry::updateSentryPlacement, ::on_updateSentryPlacement );
}

on_updateSentryPlacement( sentryGun ) 
{
	self endon ( "death" );
	self endon ( "disconnect" );
	level endon ( "game_ended" );

	sentryGun endon ( "placed" );
	sentryGun endon ( "death" );

	sentryGun.canBePlaced = 1;
	lastCanPlaceSentry = -1;

	for( ;; ) 
    {
        placement = self canPlayerPlaceSentry();
        
        anglesForward = anglestoforward( self getplayerangles() );
        origin = self.origin + anglesForward * 55;

        traceOutter = bullettrace( origin + ( 0,0,50 ), origin - ( 0,0,30 ), 0, self );
        traceInner = bullettracepassed( self.origin + ( 0,0,40 ), origin + ( 0,0,40 ), 0, self );

		sentryGun.origin = placement[ "origin" ];
		sentryGun.angles = placement[ "angles" ];
		sentryGun.canBePlaced = self isOnGround()  && ( abs( sentryGun.origin[ 2 ] - self.origin[ 2 ] ) < 10 ) && placement[ "result" ] && traceInner || traceOutter[ "fraction" ] < 1 && traceInner;

		if( sentryGun.canBePlaced != lastCanPlaceSentry ) 
        {
			if ( sentryGun.canBePlaced ) 
            {
				sentryGun setModel( level.sentrySettings[ sentryGun.sentryType ].modelPlacement );
				self ForceUseHintOn( &"SENTRY_PLACE" );
			}
			else 
            {
				sentryGun setModel( level.sentrySettings[ sentryGun.sentryType ].modelPlacementFailed );
				self ForceUseHintOn( &"SENTRY_CANNOT_PLACE" );
			}
		}

		lastCanPlaceSentry = sentryGun.canBePlaced;
		wait .05;
	}
}
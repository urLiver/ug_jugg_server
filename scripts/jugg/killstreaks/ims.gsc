/*

    INFO:
        

*/

init()
{
	replacefunc( maps\mp\killstreaks\_ims::updateImsPlacement, ::on_updateImsPlacement );
}

on_updateImsPlacement( ims ) 
{
	self endon ( "death" );
	self endon ( "disconnect" );
	level endon ( "game_ended" );

	ims endon ( "placed" );
	ims endon ( "death" );

	ims.canBePlaced = 1;
	lastCanPlaceIMS = -1;

	for( ;; ) 
    {
        placement = self canPlayerPlaceSentry();
        
        anglesForward = anglestoforward( self getplayerangles() );
        origin = self.origin + anglesForward * 55;

        traceOutter = bullettrace( origin + ( 0,0,50 ), origin - ( 0,0,30 ), 0, self );
        traceInner = bullettracepassed( self.origin + ( 0,0,40 ), origin + ( 0,0,40 ), 0, self );

		ims.origin = placement[ "origin" ];
		ims.angles = placement[ "angles" ];
		ims.canBePlaced = self isOnGround()  && ( abs( ims.origin[ 2 ] - self.origin[ 2 ] ) < 10 ) && placement[ "result" ] && traceInner || traceOutter[ "fraction" ] < 1 && traceInner;

		if ( ims.canBePlaced != lastCanPlaceIMS )
		{
			if ( ims.canBePlaced )
			{
				ims setModel( level.imsSettings[ ims.imsType ].modelPlacement );
				self ForceUseHintOn( level.imsSettings[ ims.imsType ].placeString );
			}
			else
			{
				ims setModel( level.imsSettings[ ims.imsType ].modelPlacementFailed );
				self ForceUseHintOn( level.imsSettings[ ims.imsType ].cannotPlaceString );
			}
		}

		lastCanPlaceIMS = ims.canBePlaced;

        wait .05;
	}
}
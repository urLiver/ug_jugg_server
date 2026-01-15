/*

    INFO:
        

*/

init()
{
	replacefunc( maps\mp\gametypes\_spawnlogic::getSpawnpointArray, ::on_getSpawnpointArray );
	replacefunc( maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints, ::on_getTeamSpawnPoints );
}

on_getTeamSpawnPoints( team )
{
	return on_getSpawnpointArray();
}

on_getSpawnpointArray( classname )
{
	spawnPoints = getEntArray( "mp_tdm_spawn", "classname" );

	newSpawnPoints = [];
	for( idx = 0; idx < spawnPoints.size; idx++ ) 
    {
		if( ! isdefined( spawnPoints[ idx ].disabled ) )
        {
			newSpawnPoints[ newSpawnPoints.size ] = spawnPoints[ idx ];
        }
	}

    if( isdefined( level.custom_spawnpoints ) )
    {
        for( idx = 0; idx < level.custom_spawnpoints.size; idx++ ) 
        {
            newSpawnPoints[ newSpawnPoints.size ] = level.custom_spawnpoints[ idx ];
        }
    }

	return newSpawnPoints;
}

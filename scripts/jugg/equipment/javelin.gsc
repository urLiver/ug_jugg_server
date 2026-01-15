/*

    INFO:
        

*/

init()
{
	replacefunc( maps\mp\_javelin::EyeTraceForward, ::on_EyeTraceForward );
}

on_EyeTraceForward()
{
	origin = self GetEye();
	angles = self GetPlayerAngles();
	forward = AnglesToForward( angles );
	endpoint = origin + forward * 30000;
	
	res = BulletTrace( origin, endpoint, false, undefined );

	if ( res[ "surfacetype" ] == "none" )
    {
		return undefined;
    }
    
	if ( res[ "surfacetype" ] == "default" )
    {
		return undefined;
    }

	ent = res[ "entity" ];
	if ( IsDefined( ent ) )
	{
		if ( ent == level.ac130.planeModel )
        {
			return undefined;
        }
	}

	results = [];
	results[ 0 ] = res[ "position" ];
	results[ 1 ] = res[ "normal" ];

	return results;
}


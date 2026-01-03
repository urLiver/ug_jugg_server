main() 
{
	scripts\core\main::main();
}

init() 
{
	port = getdvar( "net_port" );

	if( ! isdefined( port ) ) 
	{
		print( "^1No Port found!" );
		return;
	}

	scripts\core\main::init();

	switch( port )
	{
		case "27015":
		case "27016":
			scripts\jugg\main::init();

			print( "^2UG Jugg Scripts Loaded! For Port 27015" );
		break;

		default:
			print( "^1Port defined, but we dont have a server case for it ! \nPort: " + port );
		break;
	}
}
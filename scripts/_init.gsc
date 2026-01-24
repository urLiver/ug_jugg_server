main() 
{
    level.port = getdvar( "net_port" );
    level.ports = [];

    add_script( "27015", scripts\jugg\_init::init, 1 );
    add_script( "27016", scripts\jugg\_init::init, 1 );

    if( ! isdefined( level.port ) ) 
    {
        print( "^1_init::main()^7: level.port is undefined" );
        return;
    }
    
    if( ! isdefined( level.ports[ level.port ] ) ) 
    {
        print( "^1_init::main()^7: level.ports[ port ] for level.port = ^2" + level.port + "^7 is undefined" );
        return;
    }

    if( isdefined( level.ports[ level.port ].include_core ) )
    {
        print( "^1_init::main()^7: core scripts loaded for level.port = ^2" + level.port );
	    // thread cripts\core\_init::main();
    }
}

init()
{
    if( ! isdefined( level.port ) ) 
    {
        print( "^1_init::init()^7: level.port is undefined" );
        return;
    }

    if( ! isdefined( level.ports[ level.port ] ) ) 
    {
        print( "^1_init::init()^7: level.ports[ port ] for level.port = ^2" + level.port + "^7 is undefined" );
        return;
    }

    if( isdefined( level.ports[ level.port ].include_core ) )
    {
        print( "^1_init::init()^7: core scripts loaded for level.port = ^2" + level.port );
        thread scripts\core\_init::init();
    }

    if( isdefined( level.ports[ level.port ].init ) )
    {
        print( "^1_init::init()^7: game scripts loaded for level.port = ^2" + level.port );
        thread [ [ level.ports[ level.port ].init ] ]();
    }
}

add_script( str_port, init, include_core )
{
    level.ports[ str_port ] = SpawnStruct();
    level.ports[ str_port].init = init;
    level.ports[ str_port].include_core = include_core;
}
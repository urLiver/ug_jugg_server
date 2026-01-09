/*

    INFO:
        - the main init() and main() used to load any of the scripts
    
    TODO:
        - Implement Ohm loading

    DONE:
        - None
    
    IMPORTANT:
        - I'm aware a simple switch case would have workd tho i wanan log and make it easy to add to so this is the way

*/

main() 
{
    level.port = getdvar( "net_port" );
    level.ports = [];

    add_script( "27015", scripts\jugg\main::init, 1, 1 );
    add_script( "27016", scripts\jugg\main::init, 1, 1 );

    if( ! isdefined( port ) ) 
    {
        print( "^1_init::main()^7: level.port is undefined" );
        return;
    }
    
    if( ! isdefined( level.ports[ port ] ) ) 
    {
        print( "^1_init::main()^7: level.ports[ port ] for level.port = ^2" + level.port "^7 is undefined" );
        return;
    }

    if( isdefined( level.ports[ port ].include_core ) )
    {
        print( "^1_init::main()^7: core scripts loaded for level.port = ^2" + level.port );
	    scripts\core\main::main();
    }
}

init()
{
    port = getdvar( "net_port" );
    if( ! isdefined( port ) ) 
    {
        return;
        print( "^1_init::init()^7: level.port is undefined" );
    }

    if( ! isdefined( level.ports[ port ] ) ) 
    {
        print( "^1_init::init()^7: level.ports[ port ] for level.port = ^2" + level.port "^7 is undefined" );
        return;
    }

    if( isdefined( level.ports[ port ].include_core ) )
    {
        print( "^1_init::init()^7: core scripts loaded for level.port = ^2" + level.port );
        scripts\core\main::init();
    }

    if( isdefined( level.ports[ port ].include_ohm ) )
    {
        print( "^1_init::init()^7: ohm scripts loaded for level.port = ^2" + level.port );
    }

    if( isdefined( level.ports[ port ].init ) )
    {
        print( "^1_init::init()^7: game scripts loaded for level.port = ^2" + level.port );
        [ [ level.ports[ port ].init ] ]();
    }
}

add_script( str_port, init, include_core, include_ohm )
{
    level.ports[ str_port ] = SpawnStruct();
    level.ports[ str_port].init = init;
    level.ports[ str_port].include_core = include_core;
    level.ports[ str_port].include_ohm = include_ohm;
}
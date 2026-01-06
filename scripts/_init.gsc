main() 
{
	scripts\core\main::main();
}

add_port( str_port, init )
{
    level.ports[ str_port ] = SpawnStruct();
    level.ports[ str_port].init = init;
}

init()
{
    level.ports = [];
    add_port( "27015", scripts\jugg\main::init );
    add_port( "27016", scripts\jugg\main::init );

    port = getdvar( "net_port" );
    if( ! isdefined( port ) ) 
    {
        print( "^1No Port found!" );
        return;
    }

    scripts\core\main::init();

    if( isdefined( level.ports[ port ] ) && isdefined( level.ports[ port ].init ) )
    {
        [ [ level.ports[ port ].init ] ]();
    }
}
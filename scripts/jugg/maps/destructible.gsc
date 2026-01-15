/*

    INFO:
        - File to find out what destructibiles are loaded if wanted to be used in an edit, later will be used to spawn them too

*/

init()
{
    wait 2;

    print( "^1_destructible::init()^7: Start of Printing Destructibles for map ^2" + getdvar( "mapname" ) );

    destructible_vehicle = getentarray( "destructible_vehicle", "targetname" );

    foreach ( var_3 in destructible_vehicle )
    {
        switch ( getdvar( "mapname" ) )
        {
            case "mp_interchange":
                if ( var_3.origin[2] > 150.0 )
                {
                    var_4 = 0;

                    foreach ( var_6 in var_0 )
                    {
                        if ( int( var_3.origin[0] ) == int( var_6[0] ) && int( var_3.origin[1] ) == int( var_6[1] ) && int( var_3.origin[2] ) == int( var_6[2] ) )
                        {
                            var_4 = 1;
                            break;
                        }
                    }

                    if ( var_4 )
                        continue;
                }

                break;
        }

        print( "^1" + var_3.destructible_type );
    }

    print( "^1_destructible::init()^7: End of Printing Destructibles" );


    print( "^1_destructible::init()^7: Start of Printing Lanterns for map ^2" + getdvar( "mapname" ) );

    lantern_glowFX_origin = getentarray( "lantern_glowFX_origin", "targetname" );

    for ( var_1 = 0; var_1 < lantern_glowFX_origin.size; var_1++ )
    {

        print( "^1Lantern^7 at Position: ^2" + lantern_glowFX_origin[var_1].origin );
    }

    print( "^1_destructible::init()^7: End of Printing Lanterns" );
    

    print( "^1_destructible::init()^7: Start of Printing Toys for map ^2" + getdvar( "mapname" ) );
    
    destructible_toy = getentarray( "destructible_toy", "targetname" );
    for ( var_1 = 0; var_1 < destructible_toy.size; var_1++ )
    {
        print( "^1" + destructible_toy[var_1].destructible_type );
    }

    print( "^1_destructible::init()^7: End of Printing Toys" );

}
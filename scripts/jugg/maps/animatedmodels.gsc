init()
{
    wait 2;

    print( "^1animatedmodels::init()^7: Start of Printing Lanterns for map ^2" + getdvar( "mapname" ) );

    animated_model = getentarray( "animated_model", "targetname" );

    for ( var_1 = 0; var_1 < animated_model.size; var_1++ )
    {
        print( "^1" + animated_model[ var_1 ] );
    }

    print( "^1animatedmodels::init()^7: End of Printing Lanterns" );
}
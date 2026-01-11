/*

    INFO:
        - function to hook _destructible and see what they spawn where to reproduce for some maps

*/

init()
{
    replacefunc( common_scripts/_destructible::destructible_create, ::on_destructible_create );
}


on_destructible_create( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( ! isdefined( level.destructible_type ) )
    {
        level.destructible_type = [];
    }

    var_6 = level.destructible_type.size;
    var_6 = level.destructible_type.size;
    level.destructible_type[var_6] = spawnstruct();
    level.destructible_type[var_6].v["type"] = var_0;
    level.destructible_type[var_6].parts = [];
    level.destructible_type[var_6].parts[0][0] = spawnstruct();
    level.destructible_type[var_6].parts[0][0].v["modelName"] = self.model;
    level.destructible_type[var_6].parts[0][0].v["tagName"] = var_1;
    level.destructible_type[var_6].parts[0][0].v["health"] = var_2;
    level.destructible_type[var_6].parts[0][0].v["validAttackers"] = var_3;
    level.destructible_type[var_6].parts[0][0].v["validDamageZone"] = var_4;
    level.destructible_type[var_6].parts[0][0].v["validDamageCause"] = var_5;
    level.destructible_type[var_6].parts[0][0].v["godModeAllowed"] = 1;
    level.destructible_type[var_6].parts[0][0].v["rotateTo"] = self.angles;
    level.destructible_type[var_6].parts[0][0].v["vehicle_exclude_anim"] = 0;

    print( "^1_destructible::destructible_create( ^2" + var_0 + ", " + var_1 + ", " + var_2 + ", " + var_3 + ", " + var_4 + ", " + var_5, + "^1 )" );
}

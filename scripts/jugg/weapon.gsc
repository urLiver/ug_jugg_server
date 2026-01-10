/*

    INFO:
        - This File Includes the System for the Weapon Roll on Survivors

    TODO:
        - Learn Weapon Porting xD

    DONE:
        - Changed Weapon Roll System from GilletteClans one to fully custom one
        
*/

init() 
{
    replacefunc( maps\mp\gametypes\_weapons::mayDropWeapon, ::hook_mayDropWeapon );

    level.selected_starting_weapon =  "iw5_mp7_mp_silencer";
    level.old_weapon = "";
    level.cur_weapon = "";
 
    level.weaponrolls_survivor = [];

    Empty_List = [];

    //Special | No Categorie
    addsurvivorweaponroll( "MK12 SPR", "iw5_mk12spr", [ "thermal", "acog" ], [ "silencer03", "heartbeat", "xmags" ] );
    addsurvivorweaponroll( "Default Weapon", "defaultweapon", Empty_List, Empty_List );

    // Pistols
    Pistol_Attachments = [ "akimbo", "xmags" ];
    // addsurvivorweaponroll( ".44 Magnum", "iw5_44magnum", Empty_List, Pistol_Attachments );
    // addsurvivorweaponroll( "USP .45", "iw5_usp45", Empty_List, Pistol_Attachments );
    // addsurvivorweaponroll( "Desert Eagle", "iw5_deserteagle", Empty_List, Pistol_Attachments );
    // addsurvivorweaponroll( "MP412", "iw5_mp412", Empty_List, Pistol_Attachments );
    // addsurvivorweaponroll( "P99", "iw5_p99", Empty_List, Pistol_Attachments );
    addsurvivorweaponroll( "Five Seven", "iw5_fnfiveseven", Empty_List, Pistol_Attachments );

    //Sub Machinge Guns Single Hand
    SMG_Hand_Attachments = [ "silencer02", "akimbo", "xmags" ];
    SMG_Hand_Scopes = [ "reflex", "eotech" ];
    addsurvivorweaponroll( "FMG9", "iw5_fmg9", SMG_Hand_Scopes, SMG_Hand_Attachments );
    addsurvivorweaponroll( "MP9", "iw5_mp9", SMG_Hand_Scopes, SMG_Hand_Attachments );
    addsurvivorweaponroll( "Skorpion", "iw5_skorpion", SMG_Hand_Scopes, SMG_Hand_Attachments );
    addsurvivorweaponroll( "G18", "iw5_g18", SMG_Hand_Scopes, SMG_Hand_Attachments );

    //Launcher?
    addsurvivorweaponroll( "SMAW", "iw5_smaw", Empty_List, Empty_List );
    //addsurvivorweaponroll( "Javelin", "javelin", Empty_List, Empty_List );
    addsurvivorweaponroll( "M320 GLM", "m320", Empty_List, Empty_List );
    addsurvivorweaponroll( "RPG-7", "rpg", Empty_List, Empty_List );
    addsurvivorweaponroll( "AT4", "at4", Empty_List, Empty_List );

    //Rifles
    Rifles_Attachments1 = [ "gp25", "silencer", "heartbeat", "xmags" ];
    Rifles_Attachments2 = [ "gl", "silencer", "heartbeat", "xmags" ];
    Rifles_Attachments3 = [ "m320", "silencer", "heartbeat", "xmags" ];
    Rifles_Attachments4 = [ "m320", "silencer", "rof", "heartbeat", "xmags" ];
    Rifles_Scopes = [ "reflex", "acog", "eotech", "thermal" ];
    addsurvivorweaponroll( "M4A1", "iw5_m4", Rifles_Scopes, Rifles_Attachments2 );
    addsurvivorweaponroll( "M16A4", "iw5_m16", Rifles_Scopes, Rifles_Attachments2 );
    addsurvivorweaponroll( "Scar-L", "iw5_scar", Rifles_Scopes, Rifles_Attachments3 );
    addsurvivorweaponroll( "CM901", "iw5_cm901", Rifles_Scopes, Rifles_Attachments3 );
    addsurvivorweaponroll( "Type95", "iw5_type95", Rifles_Scopes, Rifles_Attachments4 );
    addsurvivorweaponroll( "G36C", "iw5_g36c", Rifles_Scopes, Rifles_Attachments3 );
    addsurvivorweaponroll( "ACR 6.8", "iw5_acr", Rifles_Scopes, Rifles_Attachments3 );
    addsurvivorweaponroll( "MK14", "iw5_mk14", Rifles_Scopes, Rifles_Attachments4 );
    addsurvivorweaponroll( "AK-47", "iw5_ak47", Rifles_Scopes, Rifles_Attachments1 );
    addsurvivorweaponroll( "FAD", "iw5_fad", Rifles_Scopes, Rifles_Attachments3 );

    //SMGs
    SMG_Attachments = [ "silencer", "rof", "xmags" ];
    SMG_Scopes = [ "reflex", "acog", "eotech", "thermal" ];
    addsurvivorweaponroll( "MP5", "iw5_mp5", SMG_Scopes, SMG_Attachments );
    addsurvivorweaponroll( "UMP45", "iw5_ump45", SMG_Scopes, SMG_Attachments );
    addsurvivorweaponroll( "PP90M1", "iw5_pp90m1", SMG_Scopes, [ "silencer", "rof", "xmags", "akimbo" ] );
    addsurvivorweaponroll( "P90", "iw5_p90", SMG_Scopes, SMG_Attachments );
    addsurvivorweaponroll( "PM-9", "iw5_m9", SMG_Scopes, SMG_Attachments );
    addsurvivorweaponroll( "MW2 - Vector", "iw4_kriss_mp", Empty_List, [ "iw4_krissacog_mp", "iw4_krisseotech_mp", "iw4_krissreflex_mp", "iw4_krissthermal_mp", "iw4_krisssilencer_mp", "iw4_krissrof_mp" ] );
    addsurvivorweaponroll( "CoD4 - AK-74u", "iw5_iw3ak74u", [ "reflexsmg","acogsmg","eotechsmg","thermalsmg" ], [ "rof", "xmags" ] );
    addsurvivorweaponroll( "AK-74u", "iw5_ak74u_mp", [ "reflexsmg","acogsmg","eotechsmg","thermalsmg" ], [ "rof", "xmags", "silencer" ] );
    
    //LMGs
    LMGs_Attachments = [ "silencer", "grip", "rof", "heartbeat", "xmags" ];
    LMGs_Scopes = [ "reflex", "acog", "eotech", "thermal" ];
    addsurvivorweaponroll( "L86 LSW", "iw5_sa80", LMGs_Scopes, LMGs_Attachments );
    addsurvivorweaponroll( "MG36", "iw5_mg36", LMGs_Scopes, LMGs_Attachments );
    addsurvivorweaponroll( "PKP Pecheneg", "iw5_pecheneg", LMGs_Scopes, LMGs_Attachments );
    addsurvivorweaponroll( "MK46", "iw5_mk46", LMGs_Scopes, LMGs_Attachments );
    addsurvivorweaponroll( "M60E4", "iw5_m60", LMGs_Scopes, LMGs_Attachments );
    
    //Shotguns
    Shotguns_Attachments = [ "grip", "silencer03", "xmags" ];
    Shotguns_Scopes = [ "reflex", "eotech" ];
    //addsurvivorweaponroll_rare( "USAS 12", "iw5_usas12", Shotguns_Scopes, Shotguns_Attachments );
    //addsurvivorweaponroll_rare( "KSG 12", "iw5_ksg", Shotguns_Scopes, Shotguns_Attachments );
    //addsurvivorweaponroll_rare( "Spas-12", "iw5_spas12", Shotguns_Scopes, Shotguns_Attachments );
    //addsurvivorweaponroll_rare( "AA-12", "iw5_aa12", Shotguns_Scopes, Shotguns_Attachments );
    //addsurvivorweaponroll_rare( "Striker", "iw5_striker", Shotguns_Scopes, Shotguns_Attachments );
    addsurvivorweaponroll_rare( "Model 1887", "iw5_1887", Empty_List, [ "akimbo" ] );
    
    //Snipers
    Sniper_Attachments = [ "silencer03", "heartbeat", "xmags" ];
    Sniper_Scopes = [ "acog", "thermal", "vzscope" ];
    addsurvivorweaponroll( "Barrett .50Cal", "iw5_barrett", Sniper_Scopes, Sniper_Attachments );
    addsurvivorweaponroll( "L118A", "iw5_l96a1", Sniper_Scopes, Sniper_Attachments );
    addsurvivorweaponroll( "Dragunov", "iw5_dragunov", Sniper_Scopes, Sniper_Attachments );
    addsurvivorweaponroll( "AS50", "iw5_as50", Sniper_Scopes, Sniper_Attachments );
    addsurvivorweaponroll( "RSASS", "iw5_rsass", Sniper_Scopes, Sniper_Attachments );
    addsurvivorweaponroll( "MSR", "iw5_msr", Sniper_Scopes, Sniper_Attachments );
    addsurvivorweaponroll( "Intervention", "iw5_cheytac_mp", [ "acog", "thermal", "cheytacscopevz" ], Sniper_Attachments );
}

hook_mayDropWeapon( weapon ) 
{
    return 0;
}

addsurvivorweaponroll(  name, internal_name, scopes, attachments )
{
    newWeapon = SpawnStruct();
    newWeapon.name = name;
    newWeapon.internal_name = internal_name;
    newWeapon.scopes = scopes;
    newWeapon.attachments = attachments;

    level.weaponrolls_survivor[ level.weaponrolls_survivor.size ] = newWeapon;
}

addsurvivorweaponroll_rare(  name, internal_name, scopes, attachments )
{
    newWeapon = SpawnStruct();
    newWeapon.name = name;
    newWeapon.internal_name = internal_name;
    newWeapon.scopes = scopes;
    newWeapon.attachments = attachments;
    newWeapon.is_rare = 1;

    level.weaponrolls_survivor[ level.weaponrolls_survivor.size ] = newWeapon;
}

rotateGuns()
{
    level endon( "game_ended" );

    for( ;; )
    {
        level.is_rare_weapon = undefined;

        roll_weapon();

        if( isdefined( level.is_rare_weapon ) && RandomInt( 100 ) < 50 ) // Re-roll due to rare weapon not hitting its 50% chance
        {
            roll_weapon();
        }

        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 32 );
    
        show_roll();

        foreach( player in level.players )
        {
            if( isdefined( player ) && isdefined( player.sessionteam ) && player.sessionteam == "allies" )
            {
                gunheld = player GetCurrentWeapon();

                player TakeWeapon( level.old_weapon );
                player GiveWeapon( level.cur_weapon );
                player GiveMaxAmmo( level.cur_weapon );

                if( player GetCurrentWeapon() != level.selected_starting_weapon && ! player maps\mp\_utility::isusingremote() && gunheld != "none" )
                {   
                    player SwitchToWeaponImmediate( level.cur_weapon );
                }
            }
        }

        wait 0.1;
    }
}

show_roll()
{
    resttime = 3;
    while( resttime != 0 )
    {
        foreach( player in level.players )
        {
            if( player.sessionteam == "allies")
            {
                player iPrintLnBold( "Next Gun ^8" + level.print_weapon + "^7 in ^8" + resttime );
            }
        }

        resttime--;
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 1 );
    }
}

roll_weapon()
{
    level endon( "game_ended" );
    
    weaponroll = level.weaponrolls_survivor[ randomint( level.weaponrolls_survivor.size ) ];

    level.old_weapon = level.cur_weapon;

    final_wep = SpawnStruct();
    final_wep.name = weaponroll.name;
    final_wep.internal_name = weaponroll.internal_name;
    final_wep.attachment1 = "none";
    final_wep.attachment2 = "none";
    final_wep.rectile = 0;

    level.is_rare_weapon = final_wep.is_rare;

    attachmentcount = 0;
    if( weaponroll.attachments.size != 0 )
    {
        attachmentcount = RandomInt( 2 ) + 1;

        if( weaponroll.scopes.size == 1 )
        {
            attachmentcount = 1;
        }
    }

    includescope = 0;
    if( weaponroll.scopes.size != 0 )
    {
        includescope = RandomInt( 2 );
        
        if( final_wep.internal_name == "iw5_mk12spr" )
        {
            includescope = true;
        }
    }

    if( includescope && weaponroll.attachments.size == 0 )
    {
        attachmentcount = RandomInt( 2 );
    }

    if( attachmentcount == 2 )
    {
        if( includescope )
        {
            final_wep.attachment1 = weaponroll.scopes[ RandomInt( weaponroll.scopes.size ) ];
            final_wep.attachment2 = weaponroll.attachments[ RandomInt( weaponroll.attachments.size ) ];
        }
        else
        {
            num1 = RandomInt( weaponroll.attachments.size );
            num2 = RandomInt( weaponroll.attachments.size );

            while ( num1 == num2 )
            {
                num2 = RandomInt( weaponroll.attachments.size ); 
            }
            
            final_wep.attachment1 = weaponroll.attachments[ num1 ];
            final_wep.attachment2 = weaponroll.attachments[ num2 ];
        }
    }
    else if( attachmentcount == 1 )
    {
        if( includescope )
        {
            final_wep.attachment1 = weaponroll.scopes[ RandomInt( weaponroll.scopes.size ) ];
        }
        else
        {
            final_wep.attachment1 = weaponroll.attachments[ RandomInt( weaponroll.attachments.size ) ];
        }
    }

    if( includescope && ( final_wep.attachment1 == "reflex" || final_wep.attachment1 == "acog" || final_wep.attachment1 == "eotech" ) )
    { 
        final_wep.reticle = RandomInt( 7 );
    }

    level.cur_weapon = maps\mp\gametypes\_class::buildWeaponName( final_wep.internal_name, final_wep.attachment1, final_wep.attachment2, 0, final_wep.reticle );

    if( final_wep.internal_name == "iw4_kriss_mp" )
    {
        level.cur_weapon = weaponroll.attachments[ RandomInt( weaponroll.attachments.size ) ];
    }

    level.print_weapon = final_wep.name;

    print(  "^1weapon::roll_weapon()^7: level.print_weapon = ^2" + level.print_weapon + " ^7 || level.cur_weapon = ^2" + level.cur_weapon );
}
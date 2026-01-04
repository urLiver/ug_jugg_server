/*

    INFO:
        - This File Includes the System for the Infected Rolls

    TODO:
        - Fix bug with frogjump and jumpboost, if this current untested fix doesnt work
        - Add In Rolls:
            - Commander -> Wears a Flag on back and speeds up ( 20% increase ) close mates for 4 seconds every 7 seconds
            - White Hole -> Black Hole, but pushes the enemies away
            - Hunter -> The Jugg from Call of Duty Ghost that is fast and has only a knive
        - Combine jumpboost and frogjump into one using paramlist

    DONE:
        - Changed add_roll and get_random_roll for simplicity and also moved away from weight to actuall percentage system
        - Modified the add_roll color to get a random color for if undefined is passed
        - Rolls added:
            - Smoker -> Explodes in a cloud of smoke on death, wears a red nade as hat
            - Frog Jump -> Jump boost but forward
        
*/

init() 
{
    level.roll_items = [];
    level.roll_cur_percent = 0.0;

    add_roll( 1.40, "SMAW", "You have a SMAW rocket launcher", undefined, ::Give_Param_Weapon, array( "iw5_smaw_mp", 1, 0) );
    add_roll( 1.80, "M320", "You have a Noob Tube", undefined, ::Give_Param_Weapon, array( "m320_mp", 1, 0) );
    add_roll( 2.10, "Javelin", "You have a Javelin", ( 0, 0, .5 ), ::Give_Param_Weapon, array( "javelin_mp") );
    add_roll( 2.40, "RPG", "You have an RPG", undefined, ::Give_Param_Weapon, array( "rpg_mp", 1, 1) );
    add_roll( 1.40, "AT4", "You have an AT4", undefined, ::Give_Param_Weapon, array( "at4_mp", 1, 0) );
    add_roll( 1.60, "Stinger", "You have a Stinger rocket launcher", undefined, ::Give_Param_Weapon, array( "stinger_mp") );
    add_roll( 6.20, "Riotshield", "You have a Riotshield.", undefined, ::Give_Param_Weapon, array( "riotshield_mp") );
    add_roll( 1.30, "Akimbo", "You have Akimbo Pistols", undefined, ::Give_Param_Weapon, array( "iw5_usp45_mp_akimbo", undefined, 0, 1) );
    add_roll( 1.60, ".44 Magnum", "You have a .44 Magnum with 6 bullets", undefined, ::Give_Param_Weapon, array( "iw5_44magnum_mp", undefined, 0) );

    add_roll( 2.50, "C4", "You have a C4, Press ^:[{+actionslot 4}] ^7To Use It!", undefined, ::Give_Param_Nade, array( "c4_mp") );
    add_roll( 5.50, "Flash Bang", "You have 2 Flash Grenades, Press ^:[{+actionslot 4}] ^7To Use It!", undefined, ::Give_Param_Nade, array( "flash_grenade_mp") );
    add_roll( 5.90, "Concussion Grenade", "You have 2 Concussion Grenades, Press ^:[{+actionslot 4}] ^7To Use It!", undefined, ::Give_Param_Nade, array( "concussion_grenade_mp") );
    add_roll( 5.50, "EMP Grenade", "You have an EMP Grenade, Press ^:[{+actionslot 4}] ^7To Use It!", undefined, ::Give_Param_Nade, array( "emp_grenade_mp") );
    add_roll( 5.50, "Smoke Grenade", "You have a Smoke Grenade, Press ^:[{+actionslot 4}] ^7To Use It!", undefined, ::Give_Param_Nade, array( "smoke_grenade_mp") );

    add_roll( 0.40, "Nothing!", "You got nothing! Better luck next time", undefined, maps\mp\gametypes\_globallogic::blank, undefined );
    add_roll( 2.40, "Push Launcher", "You have a Push Launcher, Use it Scoped or Non Scoped!", undefined, ::push_xm, undefined );
    add_roll( 4.40, "Smoke Launcher", "You have a Smoke Launcher", undefined, ::M_320_smoke, undefined );
    add_roll( 4.30, "Extra Speed", "Increased Movement Speed", undefined, ::ExtraSpeed, undefined );
    add_roll( 2.80, "Increased Speed, Reduced Health", "You have less Health, but move much Faster", ( .5, 0, 0 ), ::lowhealthquick, undefined );
    add_roll( 4.10, "Ballistic Vest", "You have a Ballistic Vest (200 HP).", ( 0, 0, .5 ), level.killStreakFuncs["light_armor"], undefined );
    add_roll( 2.90, "Juggernaut", "You're a Juggernaut (300 HP).", undefined, ::Juggernaut, undefined );
    add_roll( 2.40, "Powerful Juggernaut", "You're a Powerful Juggernaut (500 HP).", ( .5, .5, 0 ), ::PowerfulJuggernaut, undefined );
    add_roll( 1.90, "Terminator Juggernaut", "You're a Terminator Juggernaut (800 HP).", ( .5, 0, 0 ), ::TerminatorJuggernaut, undefined );
    add_roll( 1.20, "Explosive Juggernaut", "You're a powerful & explosive, Juggernaut (500 HP).", ( .5, 0, 0 ), ::juggernaut_suicide, undefined );
    add_roll( 2.40, "Smoker", "Wait a min, this aint Left 4 Dead", ( 0, .5, .2 ), ::roll_smoker, undefined );
    add_roll( 0.70, "Godmode for 5 seconds", "Temporarily grants invincibility for 5 seconds", ( .5, .5, 0 ), ::GodMode, undefined );
    add_roll( 1.40, "Black Hole Grenade!", "Throw a Grenade that creates a Black Hole, ^7Press ^:[{+actionslot 4}] ^7To Use It", ( .6, 0, .6 ), ::blackholegrenade, undefined );
    add_roll( 1.20, "One Bullet", "You have a Sniper with One Bullet", undefined, ::OneBullet, undefined );
    add_roll( 1.20, "Extra Knifes", "You have Additional Throwing Knifes.", undefined, ::UnlimitedKnifes, undefined );
    add_roll( 2.40, "Exploding Throwingknife", "You have an Explosive Throwing Knife.", undefined, ::ExplosiveKnife, undefined );
    add_roll( 2.30, "Freeze Grenade", "Freeze Enemies or Turrets for 2 seconds, Press ^:[{+actionslot 4}] ^7to Use It!", ( 0, .8, .8 ), ::givefreezegrenade, undefined );
    add_roll( 3.60, "Confusion Grenade", "Where to go?, Press ^:[{+actionslot 4}] ^7to Use It!", ( .8, .1, .4 ), ::roll_confusionnade, undefined );
    add_roll( 3.60, "Wallhack for 30 seconds", "Gain temporary Wallhack.", undefined, ::Wallhack, undefined );
    add_roll( 3.60, "Cold Blooded", "Undetected by Air Support, Sentries & Thermal", undefined, ::givecoldblooded, undefined );
    add_roll( 3.30, "Jump Boost", "You have higher jump Height!", ( 0, .8, .8 ), ::jump_boost, undefined );
    add_roll( 2.80, "Frog Jump", "**Put Frog Sound here**", ( 0, .8, .8 ), ::roll_frogjump, undefined );

    print( "^2Roll Percentage cumulated is: " + level.roll_cur_percent );

    replacefunc(maps\mp\gametypes\infect::setinfectedmsg, ::setinfectedmsg_edit);
    replacefunc(maps\mp\gametypes\infect::chooseFirstInfected, ::_chooseFirstInfected);
}

add_roll( percentage, name, description, color, func, paramlist  )
{
    index = level.roll_items.size;
    level.roll_items[ index ]                         = SpawnStruct();
    level.roll_items[ index ].rollname                = name;
    level.roll_items[ index ].description             = description;
    level.roll_items[ index ].percentage              = percentage + level.roll_cur_percent;
    level.roll_items[ index ].function                = func;
    level.roll_items[ index ].color                   = color;
    level.roll_items[ index ].paramlist               = paramlist;
    level.roll_cur_percent += percentage;
}

get_random_roll()
{
    self endon("disconnect");
    self endon("death");

    percent_targert = RandomFloat( level.roll_cur_percent ); 
    ret = undefined;

    foreach ( roll in level.roll_items )
    {
        ret = roll;

        if ( roll.percentage >= percent_targert )
        {
            break;
        }
    }

    return ret;
}

roll_random_effect() 
{
    self endon("disconnect");
    self endon("death");

    wait .05;

    if( isdefined( level.infected_jammed ) )
    {
        self thread scripts\core\ui::send_hud_notification_handler( "Jammed", "Rolls disabled", undefined );
        return;
    }

    roll = get_random_roll();
    if( ! isdefined( roll ) )
    {
        print( "^1roll_random_effect: Roll = undefined" );
        return;
    }

    if( ! isdefined( roll.paramlist ) )
    {
        self thread [ [ roll.function ] ]( );
    }
    else
    {
        self thread [ [ roll.function ] ]( roll.paramlist );
    }

    self thread scripts\core\ui::send_hud_notification_handler(roll.rollname, roll.description, roll.color );
}

explosiveknife() {
    self endon("disconnect");
    self endon("death");
    self endon("force_end_exp_tk");

    powerup_hud = self maps\mp\gametypes\_hud_util::createFontString( "default", 1.0);
	powerup_hud maps\mp\gametypes\_hud_util::setPoint( "center", "BOTTOMRIGHT", -90, -14 );
    powerup_hud setShader("compassping_explosion", 24, 24);
    powerup_hud.HideWhenInMenu = 1;
    powerup_hud.HideWhenInkillcam = 1;
    powerup_hud.HideWhendead = 1;
    powerup_hud.alpha = 1;
	powerup_hud.archived = 1;
    powerup_hud thread delete_on_death(self);

    self giveweapon("throwingknife_mp");

    fired = 0;
    while(!fired) {
        self waittill( "grenade_fire", grenade, weapName);

        if(weapName == "throwingknife_mp") {
            self notify("used_exp_tk");
            grenade thread expknife(self);
            fired = 1;
        }
    }
}

delete_on_death(owner) {
    owner common_scripts\utility::waittill_any("death","disconnect","used_exp_tk","force_end_exp_tk");
    self destroy();
}

expknife(owner) {
    self thread checkstuck(owner);
    self playsound("ac130_40mm_fire");
    wait .1;
    self playloopsound( "move_40mm_proj_loop1" );
    playfxontag( level.throwingknifefx, self, "tag_origin" );
}

checkstuck(owner) {
    self endon("death");

    barrel = Spawn( "script_model", self.origin );
    barrel SetModel( "weapon_c4_bombsquad" );
    barrel.angles = self.angles;
    barrel LinkTo( self );
    barrel setcontents( 0 );

    self.stuck = 0;
    self common_scripts\utility::waittill_notify_or_timeout( "missile_stuck", 12 );
    self.stuck = 1;

    maxdam = 200;
    maxdampercent = maxdam / 100;
    maxdist = 350;
    maxdistpercent = maxdist / 100;

    self StopLoopSound(1);
    playSoundAtPos(self.Origin, "pavelow_helicopter_secondary_exp_close");
    playfx(level.throwingknifeexplosionfx, self.origin);
    PhysicsExplosionSphere( self.origin, maxdist, 0, 5 );

    foreach(player in level.players) {
        d = distance(player.origin, self.origin);
        if(d < maxdist) {
            pushamount = player DamageConeTrace(self.origin);
            fractionDist = 100 - (d / maxdistpercent);
            damage = fractiondist * maxdampercent;
            finaldamage = damage * pushamount;
            player thread [[level.CallbackPlayerDamage]](self, owner, finaldamage, 0, "MOD_EXPLOSIVE", "throwingknife_mp", self.origin, self.origin, "none", 0);
        }
    }

    wait 1;
    
    barrel Delete();
    self delete();
}

blackholegrenade() {
    self endon("death");
    self endon("disconnect");

	self GiveWeapon("semtex_mp");
    self maps\mp\_utility::_SetActionSlot(4, "weapon", "semtex_mp");

	while(1) {
		self waittill("grenade_fire", ent, name);

		if(name == "semtex_mp") {
            ent thread delete_ifdied(self);

			wait 1.45;

            if(isdefined(ent)) {
                ent notify("exploded");

                fx = spawnfx(level.fx_airstrike_afterburner, ent.origin);
                triggerfx(fx);
                level thread create_black_hole(ent.origin, fx);
                ent playsound("harrier_fly_away");

                if(isdefined(ent))
                    ent delete();
            }

			break;
		}
	}
}

delete_ifdied(owner) {
    self endon("exploded");

    owner waittill("death");

    if(isdefined(self))
        self delete();
}

create_black_hole( origin, fx ) {
    for(i = 0;i < 50;i++) {
        foreach(player in level.players) {
        	if(player.sessionteam == "allies") {
           		distanceToBlackHole = distance(player.origin, origin);
            	if(distanceToBlackHole < 500 && player isonground()) {
            		player allowjump(0);

                	direction = (origin - player.origin);
                	direction_normalized = direction / sqrt(direction[0] * direction[0] + direction[1] * direction[1] + direction[2] * direction[2]);
                	forceMagnitude = (500 - distanceToBlackHole) / 300 * 130;

                	force = direction_normalized * forceMagnitude;

                	player SetVelocity(force);
                }
            }
        }

        wait .1;
    }

    wait .1;

    foreach(player in level.players)
    	player allowjump(1);

    fx delete();
}

givefreezegrenade() {
    self endon("disconnect");
    self endon("death");

    self GiveWeapon("semtex_mp");
    self maps\mp\_utility::_SetActionSlot(4, "weapon", "semtex_mp");

	while(1) {
		self waittill("grenade_fire", ent, name);

		if(name == "semtex_mp") {
            ent thread delete_ifdied(self);

			wait 1.45;

            if(isdefined(ent)) {
                ent notify("exploded");

                playfx(level.empGrenadeExplode, ent.origin);
                turrets = getEntArray( "misc_turret", "classname" );

                foreach(player in level.players) {
                    if(distance(player.origin, ent.origin) < 250 && player.team == "allies")
                        player thread frozen(2);
                }
                foreach ( turret in turrets )
                {
                    if(distance(turret.origin, ent.origin) < 250)
                        turret thread turret_frozen(4);
                }

                if(isdefined(ent))
                    ent delete();
            }

			break;
		}
	}
}

turret_frozen(freeze_time) {
    self endon("death");
    moved=undefined;
    PlayFXOnTag( common_scripts\utility::getfx( "sentry_explode_mp" ), self, "tag_aim" );

    //self makeUnUsable();
    self SetDefaultDropPitch( 40 );
    if(isdefined(self.turrettype) && self.turrettype == "mg_turret"){
        //self SetMode( level.turretSettings[ self.turretType ].sentryModeOff );
        if(isdefined(self.ownertrigger)) {
            self.ownertrigger.origin = self.ownertrigger.origin + (0,0,10000);
            moved = true;
        }
        self thread remote_bug_fix_turret(freeze_time);
        self.owner.throwingGrenade = "yeet";
    } else if(isdefined(self.sentryType) && self.sentryType == "sentry_minigun")
        self SetMode( level.sentrySettings[ self.sentryType ].sentryModeOff );
    else {
        self.overheated = true;
        self SetMode("sentry_offline");
    }

    wait( freeze_time );


    if(isdefined(self.turrettype) && self.turrettype == "mg_turret") {
        //self SetMode( level.turretSettings[ self.turretType ].sentryModeOn );
        if(isdefined(moved))
            self.ownertrigger.origin = self.ownertrigger.origin - (0,0,10000);
        self.owner.throwingGrenade = undefined;
    }else if(isdefined(self.sentryType) && self.sentryType == "sentry_minigun")
        self SetMode( level.sentrySettings[ self.sentryType ].sentryModeOn );
    else {
        self.overheated = false;
        self SetMode("manual");
    }

    self SetDefaultDropPitch( 0 );
    //self makeusable();

    //still bugged with remotes - hopefully fixed now
}
remote_bug_fix_turret(time) {
    time_total = time*20;
    for(i=0;i<time_total;i++){
        if ( self.owner getcurrentweapon() == "killstreak_remote_turret_remote_mp" )
        {
            self.owner.using_remote_turret = false;
            self.owner maps\mp\killstreaks\_remoteturret::takeKillstreakWeapons( self.turretType );
            self maps\mp\killstreaks\_remoteturret::stopUsingRemoteTurret();
            wait 0.5;
            self.owner ThermalVisionOff();
            self.owner ThermalVisionFOFOverlayOff();
            self.owner VisionSetThermalForPlayer( game["thermal_vision"], 0 );
            break;
        }

        wait 0.05;
    }
}

frozen(time) {
    self endon("disconnect");

    self freezecontrols(1);
    self iPrintLnBold("^5Frozen^7 for ^52^7 Seconds!");

    self.frozenoverlay = newClientHudElem(self);
	self.frozenoverlay.x = 0;
	self.frozenoverlay.y = 0;
	self.frozenoverlay.alignX = "left";
	self.frozenoverlay.alignY = "top";
	self.frozenoverlay.horzAlign = "fullscreen";
	self.frozenoverlay.vertAlign = "fullscreen";
	self.frozenoverlay setshader("combathigh_overlay", 640, 480);
	self.frozenoverlay.sort = -10;
	self.frozenoverlay.archived = 1;
    self.frozenoverlay.color = (0, 1, 1);

    wait time;

    self freezecontrols(0);
    self.frozenoverlay destroy();
}

ExtraSpeed() {
    self thread Speed(1.5);
}

M_320_smoke() {
    level endon("game_ended");
    self endon("death");

    self GiveWeapon("m320_mp");
    self setweaponammoclip("m320_mp", 1);
    self setweaponammostock("m320_mp", 0);
    waittillframeend;
    self SwitchToWeaponImmediate("m320_mp");

    for(;;) {
        self waittill( "missile_fire", missile, weaponName );
        if ( weaponName == "m320_mp")
        {
            missile thread smoke_launcher_thread();
        }
    }
}

smoke_launcher_thread() {
    self.smoke = true;
    org = (0,0,0);
    while(isdefined(self)) {
        org = self.origin;
        wait 0.05;
    }
    PlayFX(level.smokelauncher_fx, org);
}

push_xm() {
    level endon("game_ended");
    self endon("death");

    self Attach("ims_scorpion_explosive1", "j_helmet", true);

    self GiveWeapon("xm25_mp");
    self setweaponammoclip("xm25_mp", 2);
    self setweaponammostock("xm25_mp", 0);
    waittillframeend;
    self SwitchToWeaponImmediate("xm25_mp");
    for(;;) {
        self waittill( "missile_fire", missile, weaponName );
        if ( weaponName == "xm25_mp")
        {
            missile thread push_launcher_thread(self, self getplayerangles(), self adsbuttonpressed());
        }
    }
}

push_launcher_thread(owner, dir, mode) {
    self endon("death");
    self.pusher = true;
    pushdir = AnglesToForward(dir);
    up = 340;
    side = 180;


    if(mode) {
        self thread push_xm_arrow();
        self thread push_launcher_delay_delete(4);
        self.pushlist = [];
        for(;;) {
            foreach(bozo in level.players) {
                if(bozo == owner)
                    continue;
                
                if(!isdefined(self.pushlist[bozo.name]) && Distance(self.origin, bozo.origin + (0,0,20)) < 100) {
                    self.pushlist[bozo.name] = true;
                    curvel = bozo getvelocity();
                    bozo setvelocity((curvel[0] + pushdir[0] * side, curvel[1] + pushdir[1] * side, pushdir[2] * up));
                }
            }
            wait 0.05;
        }
    } else {
        foreach(bozo in level.players) {
            if(Distance(owner.origin, bozo.origin) < 100) {
                curvel = bozo getvelocity();
                bozo setvelocity((curvel[0] + pushdir[0] * side, curvel[1] + pushdir[1] * side, pushdir[2] * up));
            }
        }
        if(isdefined(self))
            self delete();
    }
}

push_xm_arrow() {
    arrow = spawn("script_model", self.origin);
    arrow setmodel("sundirection_arrow");
    arrow.angles = vectortoangles(AnglesToForward(self.angles) * -1);
    arrow linkto(self);
    self waittill("death");
    arrow delete();
}

push_launcher_delay_delete(time) {
    self endon("death");
    wait time;
    if(isdefined(self))
        self delete();
}

OneBullet() {
    weapon = "iw5_dragunov_mp_dragunovscope";
    if( randomint( 100 ) < 50)
    {
        weapon = "iw5_rsass_mp_rsassscope";   
    }

    self GiveWeapon(weapon);
    waittillframeend;
    self setweaponammoclip(weapon, 1);
    self setweaponammostock(weapon, 0);
    self SwitchToWeaponImmediate(weapon);
    self thread onebulletwatcher(weapon);
}

onebulletwatcher(weapon) {
    self endon("disconnect");
    self endon("death");

    fired = 0;
    while(!fired) {
        self waittill( "weapon_fired", weapName);

        if ( weapName == weapon ) {
            wait 1;
            self takeweapon(weapon);
            self switchtoweapon("iw5_usp45_mp_tactical");
            fired = 1;
        }
    }
}

Juggernaut() {
    self.maxhealth = self.Health * 3;
    self.Health = self.Health * 3;
    self.healthRegenLevel = .33;
    self setmodel("mp_fullbody_ally_juggernaut");
    self setviewmodel("viewhands_juggernaut_ally");
    wait .05;
    self attachshieldmodel("weapon_riot_shield_mp", "tag_shield_back");

    self.moveSpeedScaler = .90;
    self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

juggernaut_suicide() {
    self.maxhealth = self.Health * 5;
    self.Health = self.Health * 5;
    self.healthRegenLevel = .33;
    wait .05;
    self thread play_tick_sound();
    self attach("weapon_c4_bombsquad", "j_shoulder_le", 1);
    self attach("weapon_c4_bombsquad", "j_shoulder_ri", 1);
    self setmodel("mp_fullbody_opforce_juggernaut");
    self setviewmodel("viewhands_juggernaut_opforce");
    self.moveSpeedScaler = .8;
    self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
 	self.suicide_bomber = 1;
}

play_tick_sound() {
	self endon("disconnect");
    level endon("game_ended");

	while(isalive(self)) {
		self playsound("scrambler_beep");
		wait 1.25;
	}
}

PowerfulJuggernaut() {
	self.maxhealth = 100;
	self.health = self.maxhealth;

    self.maxhealth = self.Health * 5;
    self.Health = self.Health * 5;
    self.healthRegenLevel = .66;
    self setmodel("mp_fullbody_opforce_juggernaut");
    self setviewmodel("viewhands_juggernaut_opforce");
    self SetPerk("specialty_fastermelee", 1, 1);
    self SetPerk("specialty_lightweight", 1, 1);
    wait .05;
    self attachshieldmodel("weapon_riot_shield_mp", "tag_shield_back");

    self.moveSpeedScaler = .80;
    self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

TerminatorJuggernaut() {
	self thread play_vader_sound();
    self.maxhealth = self.Health * 8;
    self.Health = self.Health * 8;
    self.healthRegenLevel = .99;
    self setmodel("mp_fullbody_opforce_juggernaut");
    self setviewmodel("viewhands_juggernaut_opforce");

    self.moveSpeedScaler = .80;
    self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

play_vader_sound() {
	self endon("disconnect");
    level endon("game_ended");

	while(isalive(self)) {
		self playsound("juggernaut_breathing_sound");
		wait 4;
	}
}

lowhealthquick() {
    self.maxhealth = 50;
    self.Health = 50;
    self thread Speed(1.8);
    // PlayFXOnTag( level.smoke_trail, self, "j_ankle_le" );
    // PlayFXOnTag( level.smoke_trail, self, "j_ankle_ri" );
}

GodMode() {
    self endon("stopGodMode");
    self endon("disconnect");
    self endon("game_ended");

    self.godmode = 1;

    wait 1;

    for(i = 5;i >= 0;i--) {
        if(isalive(self)) {
            if(i != 0) {
                self iprintlnbold("Godmode For ^:" + i + " ^7Seconds");
                wait 1;
            }
        }
        else
            break;
    }

    self iprintlnbold("Godmode turned ^:Off");
    self.godmode = undefined;
    self notify("stopGodMode");
}

UnlimitedKnifes() {
    self endon("stopKnifes");
    self endon("death");
    self endon("disconnect");
    self endon("game_ended");

    self notify( "rolled_moreknives" );

    amount = 30;
    powerup_hud = newClientHudElem( self );
	powerup_hud.horzAlign = "fullscreen";
	powerup_hud.vertAlign = "fullscreen";
    powerup_hud.x = 585;
    powerup_hud.y = 460;
    powerup_hud.fontscale = 0.60;
    powerup_hud.font = "hudbig";
    powerup_hud.label = &" - ^1";
    powerup_hud.HideWhenInMenu = 1;
    powerup_hud.HideWhenInkillcam = 1;
    powerup_hud.HideWhendead = 1;
    powerup_hud.alpha = 1;
    powerup_hud.color = (1,1,1);
	powerup_hud.archived = true;
    powerup_hud thread delete_on_death(self);
    powerup_hud setvalue(amount);

    self GiveWeapon("throwingknife_mp");
    self SetOffhandPrimaryClass( "throwingknife" );


    for(;;) {
        self waittill("grenade_fire", grenade, weapName);

        if (weapName == "throwingknife_mp") {
            amount--;
            if(amount > 0) {
                powerup_hud setvalue(amount);
                wait 0.65;
                self SetWeaponAmmoClip("throwingknife_mp", 1);
            }
            else {
                self notify("calling_all_homos");
                return;
            }
        }
    }
}

Wallhack() {
    self endon("death");
    self endon("stopWh");
    self endon("disconnect");
    self endon("game_ended");

    self.haswallhack = 1;
    self ThermalVisionFOFOverlayOn();
    wait 30;
    self ThermalVisionFOFOverlayOff();
    self.haswallhack = undefined;
    self notify("stopWh");
}

givecoldblooded() {
    self endon("death");
    while(isdefined(self.avoidKillstreakOnSpawnTimer) && self.avoidKillstreakOnSpawnTimer > 0)
        wait .05;

    wait .05;
    self maps\mp\_utility::giveperk( "specialty_blindeye", 0 );
    self maps\mp\_utility::giveperk( "specialty_fasterlockon", 0 );
	self maps\mp\_utility::giveperk("specialty_coldblooded", 1);
	self maps\mp\_utility::giveperk("specialty_spygame", 1);
}

Speed(scale) {
    self endon("stopSpeed");
    self endon("death");
    self endon("disconnect");
    self endon("game_ended");
	self maps\mp\_utility::giveperk("specialty_fastmantle", 1);

    for(;;) {
        if(isDefined(self) && isPlayer(self) && isAlive(self))
            self.moveSpeedScaler = scale;	self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

        wait .5;
    }
}

confusion( ent )
{
    ent waittill( "missile_stuck" );
    ent notify( "exploded" );

    explodedpos = ent.origin;

    if( isdefined( ent ) )
    ent delete();

    fx = SpawnFX( level.red_blinking, explodedpos );
    TriggerFX( fx );

    foreach( player in level.players ) {
        if( distance( player.origin, explodedpos ) < 256 && player.team == "allies" )
        {
            player SetPlayerAngles( ( RandomFloatRange( -79, 79 ), RandomFloatRange( -180, 180 ), 0.0 ) );
            player SetVelocity( ( RandomFloatRange( -20, 20 ), RandomFloatRange( -20, 20 ), 450 ) );
        }
    }

    wait 2.5;

    fx Delete();
}

roll_confusionnade() 
{
    self endon( "disconnect" );
    self endon( "death" );

	self GiveWeapon( "semtex_mp" );
    self maps\mp\_utility::_SetActionSlot( 4, "weapon", "semtex_mp" );

    for( ;; )
    {
        self waittill( "grenade_fire", ent, name );

        if( name == "semtex_mp" ) {
            level thread confusion( ent );
        }
    }
}

roll_smoker()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "smoker_down" );
 
    self Attach( "projectile_m67fraggrenade_bombsquad", "j_helmet", 1 );
    
    for( ;; )
    {
        self waittill( "death" );
        
        smoke = SpawnFX( level.smokelauncher_fx, self.origin );
        TriggerFX( smoke );

        self notify( "smoker_down" );
    }
}

Give_Param_Weapon( params )
{
    if( ! isdefined( params ) || ! isdefined( params[ 0 ] ) )
    {
        print( "^1 Give_Param_Weapon Parsing error !" );
        return;
    }

    if( isdefined( params[ 4 ] ) )
    {
        wait .05;
        self TakeWeapon( self GetCurrentWeapon() );
    }

    self GiveWeapon( params[ 0 ] );

    if( isdefined( params[ 1 ] ) )
    {
        self setweaponammoclip( params[ 0 ], params[ 1 ] );
    }

    if( isdefined( params[ 2 ] ) )
    {
        self setweaponammostock( params[ 0 ], params[ 2 ] ); 
    }

    waittillframeend;

    self SwitchToWeaponImmediate( params[ 0 ] );
}

Give_Param_Nade( params )
{
    if( ! isdefined( params ) || ! isdefined( params[ 0 ] ) )
    {
        print( "^1 Give_Param_Nade Parsing error !" );
        return;
    }

    self GiveWeapon( params[ 0 ] );
    self maps\mp\_utility::_SetActionSlot(4, "weapon", params[ 0 ] );
    self thread scripts\core\ui::equipmenthud( params[ 0 ] );
}

jump_boost() 
{
    self endon( "disconnect" );
    self endon( "death" );

    for( ;; ) 
    {
        if( ! isdefined( self.isinjump ) )
        {
            self waittill( "jumped" );

            self.isinjump = 1;

            cur = self GetVelocity();
            self SetVelocity( ( cur[ 0 ], cur[ 1 ], 420 ) );

            wait 0.5;
        }
        else
        {
            while( ! self IsOnGround() )
            {
                wait 0.1;        
            }

            self.isinjump = undefined;
        }
    }
}

roll_frogjump()
{
    self endon( "disconnect" );
    self endon( "death" );

    for( ;; ) 
    {
        if( ! isdefined( self.isinjump ) )
        {
            self waittill( "jumped" );

            self.isinjump = 1;

            cur = self GetVelocity();
            
            self SetVelocity( ( cur[ 0 ] * 3, cur[ 1 ] * 3, 300 ) );

            wait 0.5;
        }
        else
        {
            while( ! self IsOnGround() )
            {
                wait 0.1;        
            }

            self.isinjump = undefined;
        }
    }
}

setinfectedmsg_edit() {
    if ( isdefined( self.changingtoregularinfected ) ) {
        self.changingtoregularinfected = undefined;

        if ( isdefined( self.changingtoregularinfectedbykill ) ) {
            self.changingtoregularinfectedbykill = undefined;
            thread maps\mp\gametypes\_rank::xpEventPopup( &"SPLASHES_FIRSTBLOOD" );
            maps\mp\gametypes\_gamescore::givePlayerScore( "first_draft", self );
            thread maps\mp\gametypes\_rank::giveRankXP( "first_draft" );
        }
    }
}

_chooseFirstInfected() {
    level endon( "game_ended" );
    level endon( "infect_stopCountdown" );

    level.infect_allowsuicide = 0;
    maps\mp\_utility::gameFlagWait( "prematch_done" );

	if( isdefined( level.infect_timerDisplay ) ) 
	{
		level.infect_timerDisplay destroy();
	}

	level.infect_timerDisplay = maps\mp\gametypes\_hud_util::createServerTimer("bigfixed", .5);
	level.infect_timerDisplay.horzalign = "fullscreen";
	level.infect_timerDisplay.vertalign = "fullscreen";
	level.infect_timerDisplay.alignx = "left";
	level.infect_timerDisplay.aligny = "middle";
	level.infect_timerDisplay.x = 10;
	level.infect_timerDisplay.y = 120;
	level.infect_timerDisplay.archived = 0;
	level.infect_timerDisplay.hideWhenInMenu = 1;
	level.infect_timerdisplay.alpha = 0;
	level.infect_timerdisplay fadeovertime( 1.0 );
	level.infect_timerdisplay.alpha = 1;
    level.infect_timerDisplay.label = &"Infection Countdown: ^8";
    level.infect_timerDisplay settimer(15);
    level.fadein_infect_timerDisplay = 1;
    
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(15);
    
    if( ! isdefined( level.roll_weapons_started ) )
    {
        level.roll_weapons_started = 1;
        level thread scripts\jugg\weapon::rotateGuns();
    }

	level.infected_timerdisplay_finished = 1;
    level.infect_timerdisplay fadeovertime( 1.0 );
    level.infect_timerdisplay.alpha = 0;

	if( str( tolower( getdvar("suicide_final" ) ) ) != "undefined" ) 
	{
		for( i = 0; i < level.players.size + 1; i++ ) 
		{
			if( i == level.players.size ) 
			{
				rnd = randomint( level.players.size );
				print( "Failsafe System: ^3" + level.players[ rnd ].name + "^7 Selected As ^1First" );
    			level.players[ rnd ] maps\mp\gametypes\infect::setfirstinfected( 1 );
				break;
			}
			else if( str( tolower( level.players[ i ].guid ) ) == tolower( getdvar( "suicide_final" ) ) ) 
			{
				setdvar( "suicide_final", "undefined" );
				print( "^3" + level.players[ i ].name + " ^1Suicide ^7Forced First" );
				level.players[ i ] maps\mp\gametypes\infect::setfirstinfected( 1 );
				break;
			}
		}
	}
	else {
		setdvar( "suicide_final", "undefined" );
		rnd = randomint( level.players.size );
		print( "Normal System: ^3" + level.players[ rnd ].name + "^7 Selected As ^1First" );
    	level.players[ rnd ] maps\mp\gametypes\infect::setfirstinfected( 1 );
	}

    wait 1;
    
	if( isdefined( level.infect_timerDisplay ) )
    {
		level.infect_timerDisplay destroy();
	}
}
/*

    INFO:


*/

init()
{
	replacefunc( maps\mp\_equipment::trophyActive, ::on_trophyActive );
}

on_trophyActive( owner )
{
	owner endon( "disconnect" );
	self endon ( "death" );
	
	position = self.origin;
	
	for( ;; )
	{
		wait 0.05;

		if ( ! isDefined( level.grenades ) || ( level.grenades.size < 1 && level.missiles.size < 1 ) || isDefined( self.disabled ) )
		{
			continue;
		}
		
		sentryTargets = maps\mp\_utility::combinearrays ( level.grenades, level.missiles );
		
		foreach ( grenade in sentryTargets )
		{
            wait 0.05;

			if ( ! isDefined( grenade ) )
            {
				continue;
            }

			if ( grenade == self )
            {
				continue;
            }

			switch( grenade.model )
			{
                case "mp_trophy_system":
                case "weapon_radar":
                case "weapon_jammer":
                case "weapon_parabolic_knife":
                    continue;
			}
			
			if ( isDefined( grenade.weaponName) )
			{
				switch( grenade.weaponName )
				{
                    case "claymore_mp":
                        continue;
				}
			}
	
			if ( ! isDefined( grenade.owner ) )
            {
				grenade.owner = GetMissileOwner( grenade );
            }

			if ( isDefined( grenade.owner ) && level.teamBased && grenade.owner.team == owner.team )
            {
				continue;
            }

			if ( isDefined( grenade.owner ) && grenade.owner == owner )
            {
				continue;
            }

			grenadeDistanceSquared = DistanceSquared( grenade.origin, ( self.origin + ( 0,0,20 ) ) );
			
            // 147456 is the original value, increased by 20% too 176947
			if ( grenadeDistanceSquared < 176947 )
			{
				if ( BulletTracePassed( grenade.origin, ( self.origin + ( 0,0,10 ) ), false, self ) || BulletTracePassed( grenade.origin, ( self.origin + ( 0,0,30 ) ), false, self ) )
				{ 
					playFX( level.sentry_fire, self.origin + ( 0,0,32 ) , ( grenade.origin - self.origin ), AnglesToUp( self.angles ) );
					self playSound( "trophy_detect_projectile" );
					
					owner thread maps\mp\_equipment::projectileExplode( grenade, self );
					owner maps\mp\gametypes\_missions::processChallenge( "ch_noboomforyou" );			

					self.ammo--;
					
					if ( self.ammo <= 0 )
                    {
						self thread maps\mp\_equipment::trophyBreak();
                    }
				}
			}	
		}
	}
}

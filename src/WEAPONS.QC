void (entity targ, entity inflictor, entity attacker, float damage) T_Damage;
void () player_run;
void(entity bomb, entity attacker, float rad, entity ignore) T_RadiusDamage;

/*
void() W_PrecacheSinglePlayer =
{
if(temp1&"Mutant")
        precache_sound ("weapons/heartatt.wav");          //heart attack
if(temp1&"Jedi")
        {
        precache_model ("progs/lsaber.mdl");
        precache_sound ("weapons/saberon.wav");        
        precache_sound ("weapons/saberoff.wav");        
        precache_sound ("weapons/saberhum.wav");        
        precache_sound ("weapons/saberhup.wav");        
        precache_sound ("weapons/saberhit.wav");
        }
if(temp1&"Borg")
        {
        precache_sound ("borg/death.wav");
        precache_sound ("borg/werborg.wav");
        precache_sound ("borg/assimilt.wav");
        precache_sound ("borg/resist.wav");
        }
if(temp1&"Predator")
        {
        precache_sound ("predator/pdischum.wav");
        precache_sound ("predator/pdischit.wav");        
        precache_sound ("predator/pdiscgo.wav");        
        precache_sound ("predator/die.wav");
        precache_sound ("predator/die2.wav");
        precache_sound ("predator/fire.wav");    
        precache_sound ("predator/pain1.wav");  
        precache_sound ("predator/pain2.wav");   
        precache_sound ("predator/invis.wav"); 
        precache_sound ("predator/invis2.wav"); 
        precache_sound ("predator/cloak.wav"); 
        precache_sound ("predator/cloak2.wav"); 
        precache_model ("progs/pred2.mdl"); 
	precache_sound ("player/plyrjmp8.wav");		// player jump
	precache_sound ("player/land.wav");			// player landing
	precache_sound ("player/land2.wav");		// player hurt landing
	precache_sound ("player/drown1.wav");		// drowning pain
	precache_sound ("player/drown2.wav");		// drowning pain
	precache_sound ("player/gasp1.wav");		// gasping for air
	precache_sound ("player/gasp2.wav");		// taking breath
	precache_sound ("player/h2odeath.wav");		// drowning death
        }
if(temp1&"Valkyrie"||temp1&"Xena")
        {
        if(temp1&"Xena")
                {
                precache_model ("progs/chakram.mdl");
                precache_sound ("xena/femyell.wav");         // female player yell
                }
        precache_sound ("xena/femjump.wav");         // female player jump
        precache_sound ("xena/femhurt.wav");
        precache_sound ("xena/femdie.wav");
        precache_sound ("xena/femdie2.wav");
        precache_sound ("xena/land.wav");         
        precache_sound ("xena/gasp1.wav");         
        precache_sound ("xena/gasp2.wav");
        precache_sound ("xena/drown2.wav");
        precache_sound ("xena/h2odeath.wav");
        precache_sound ("xena/land2.wav");         
        precache_sound ("xena/lburn1.wav");         
        precache_sound ("xena/lburn2.wav");
        precache_sound ("xena/pain6.wav");
        }
if(temp1&"TigerMan")
        {
        precache_sound ("tiger/die.wav");
        precache_sound ("tiger/angry.wav");    
        precache_sound ("tiger/hurt1.wav");  
        precache_sound ("tiger/hurt2.wav");   
        precache_sound ("tiger/hurt3.wav"); 
        precache_sound ("tiger/attack.wav"); 
        }
if(temp1&"Jaworski")
        {
        precache_sound ("jaworski/terlet.wav");
        precache_sound ("jaworski/piss.wav");    
        precache_sound ("jaworski/ow1.wav");  
        precache_sound ("jaworski/ow2.wav");   
        precache_sound ("jaworski/ow3.wav"); 
        precache_sound ("jaworski/ow4.wav"); 
        precache_sound ("jaworski/badguy.wav"); 
        precache_sound ("jaworski/whoohoo.wav"); 
        precache_sound ("jaworski/fuckthis.wav");
        precache_sound ("jaworski/ohshit.wav");    
        precache_sound ("jaworski/yes.wav");  
        precache_sound ("jaworski/comeon.wav");   
        precache_sound ("jaworski/bastard.wav"); 
        precache_sound ("jaworski/die1.wav"); 
        precache_sound ("jaworski/keitel.wav"); 
        precache_sound ("jaworski/ow-ooo.wav"); 
        precache_sound ("jaworski/oo-uh.wav"); 
        precache_sound ("jaworski/jump.wav"); 
        precache_sound ("jaworski/land.wav"); 
        }
if((!temp1&"Jaworski")&&(!temp1&"Predator")&&(!temp1&"T-800")&&(!temp1&"Valkyrie")&&(!temp1&"Xena")&&(!temp1&"Tigerman"))
        {
        // player pain sounds
	precache_sound ("player/pain1.wav");
	precache_sound ("player/pain2.wav");
	precache_sound ("player/pain3.wav");
	precache_sound ("player/pain4.wav");
	precache_sound ("player/pain5.wav");
	precache_sound ("player/pain6.wav");
        // player death sounds
	precache_sound ("player/death1.wav");
	precache_sound ("player/death2.wav");
	precache_sound ("player/death3.wav");
	precache_sound ("player/death4.wav");
	precache_sound ("player/death5.wav");
        }
};
*/

void() W_Precache =
{
/*
if(temp1!="0"&&temp1!=0)
        W_PrecacheSinglePlayer();
else
{
*/
        precache_sound ("weapons/heartatt.wav");          //heart attack
        precache_model ("progs/chakram.mdl");
        precache_sound ("xena/femyell.wav");         // female player yell
        precache_model ("progs/lsaber.mdl");
        precache_sound ("weapons/saberon.wav");        
        precache_sound ("weapons/saberoff.wav");        
        precache_sound ("weapons/saberhum.wav");        
        precache_sound ("weapons/saberhup.wav");        
        precache_sound ("weapons/saberhit.wav");        
        precache_sound ("borg/death.wav");
        precache_sound ("borg/werborg.wav");
        precache_sound ("borg/assimilt.wav");
        precache_sound ("borg/resist.wav");
        precache_sound ("predator/pdischum.wav");
        precache_sound ("predator/pdischit.wav");        
        precache_sound ("predator/pdiscgo.wav");        
        precache_sound ("predator/die.wav");
        precache_sound ("predator/die2.wav");
        precache_sound ("predator/fire.wav");    
        precache_sound ("predator/pain1.wav");  
        precache_sound ("predator/pain2.wav");   
        precache_sound ("predator/invis.wav"); 
        precache_sound ("predator/invis2.wav"); 
        precache_sound ("predator/cloak.wav"); 
        precache_sound ("predator/cloak2.wav"); 
        precache_model ("progs/pred2.mdl"); 
	precache_sound ("player/plyrjmp8.wav");		// player jump
	precache_sound ("player/land.wav");			// player landing
	precache_sound ("player/land2.wav");		// player hurt landing
	precache_sound ("player/drown1.wav");		// drowning pain
	precache_sound ("player/drown2.wav");		// drowning pain
	precache_sound ("player/gasp1.wav");		// gasping for air
	precache_sound ("player/gasp2.wav");		// taking breath
	precache_sound ("player/h2odeath.wav");		// drowning death
        precache_sound ("xena/femjump.wav");         // female player jump
        precache_sound ("xena/femhurt.wav");
        precache_sound ("xena/femdie.wav");
        precache_sound ("xena/femdie2.wav");
        precache_sound ("xena/land.wav");         
        precache_sound ("xena/gasp1.wav");         
        precache_sound ("xena/gasp2.wav");
        precache_sound ("xena/drown2.wav");
        precache_sound ("xena/h2odeath.wav");
        precache_sound ("xena/land2.wav");         
        precache_sound ("xena/lburn1.wav");         
        precache_sound ("xena/lburn2.wav");
        precache_sound ("xena/pain6.wav");
        precache_sound ("tiger/die.wav");
        precache_sound ("tiger/angry.wav");    
        precache_sound ("tiger/hurt1.wav");  
        precache_sound ("tiger/hurt2.wav");   
        precache_sound ("tiger/hurt3.wav"); 
        precache_sound ("tiger/attack.wav"); 
/*
        precache_sound ("jaworski/terlet.wav");
        precache_sound ("jaworski/piss.wav");    
        precache_sound ("jaworski/ow1.wav");  
        precache_sound ("jaworski/ow2.wav");   
        precache_sound ("jaworski/ow3.wav"); 
        precache_sound ("jaworski/ow4.wav"); 
        precache_sound ("jaworski/badguy.wav"); 
        precache_sound ("jaworski/whoohoo.wav"); 
        precache_sound ("jaworski/fuckthis.wav");
        precache_sound ("jaworski/ohshit.wav");    
        precache_sound ("jaworski/yes.wav");  
        precache_sound ("jaworski/comeon.wav");   
        precache_sound ("jaworski/bastard.wav"); 
        precache_sound ("jaworski/die1.wav"); 
        precache_sound ("jaworski/keitel.wav"); 
        precache_sound ("jaworski/ow-ooo.wav"); 
        precache_sound ("jaworski/oo-uh.wav"); 
        precache_sound ("jaworski/jump.wav"); 
        precache_sound ("jaworski/land.wav"); 
*/
        precache_model ("progs/v_uzi.mdl");
        precache_model ("progs/v_six.mdl");
        precache_sound ("weapons/gbugun.wav");
        precache_sound ("weapons/gbugun2.wav");
        precache_sound ("weapons/gbu1.wav");
        precache_sound ("weapons/gbu2.wav");
        precache_sound ("weapons/gbu3.wav");
        precache_sound ("weapons/gbu4.wav");
//^ Gunslinger Sounds

// player pain sounds

	precache_sound ("player/pain1.wav");
	precache_sound ("player/pain2.wav");
	precache_sound ("player/pain3.wav");
	precache_sound ("player/pain4.wav");
	precache_sound ("player/pain5.wav");
	precache_sound ("player/pain6.wav");

// player death sounds
	precache_sound ("player/death1.wav");
	precache_sound ("player/death2.wav");
	precache_sound ("player/death3.wav");
	precache_sound ("player/death4.wav");
	precache_sound ("player/death5.wav");
//}
        precache_model ("progs/hover.mdl");
        precache_sound ("weapons/hoverpop.wav");
        precache_sound ("weapons/beep1.wav");
        precache_sound ("weapons/beep5.wav");
        precache_model ("progs/tripmine.mdl"); 
        precache_sound ("weapons/setlaser.wav");
//^Tripmine sounds
        precache_sound ("weapons/blaster1.wav");
        precache_sound ("weapons/blaster2.wav");
        precache_sound ("weapons/blaster4.wav");
        precache_sound ("weapons/blaster5.wav");
        precache_sound ("weapons/blaster6.wav");
        precache_sound ("weapons/blaster7.wav");
        precache_sound ("weapons/blaster8.wav");
        precache_sound ("weapons/blaster9.wav");
        precache_sound2 ("enforcer/enfire.wav");
//^laser gun sounds
        precache_model ("progs/v_freeze.mdl"); 
        precache_model ("progs/snowball.mdl"); 
        precache_sound ("weapons/frozen.wav");
        precache_sound ("weapons/fshatter.wav");
//^Freeze Gun
        precache_model ("progs/v_shrink.mdl"); 
        precache_model ("progs/shrink.mdl"); 
        precache_sound ("weapons/shrink.wav");
        precache_sound ("weapons/grow.wav");
        precache_sound ("weapons/squish.wav");
	precache_sound ("boss1/throw.wav");
//^Shrink Gun
        precache_model ("progs/s_h_play.mdl"); 
        precache_model ("progs/s_laser.mdl"); 
        precache_model ("progs/s_nail.mdl"); 
        precache_model ("progs/s_s_spk.mdl"); 
        precache_model ("progs/s_flame.mdl"); 
        precache_model ("progs/s_shell.mdl"); 
        precache_model ("progs/s_shrink.mdl"); 
        precache_model ("progs/s_miss.mdl"); 
        precache_model ("progs/s_gren.mdl"); 
        precache_model ("progs/s_lava.mdl"); 
        precache_model ("progs/s_pipe.mdl"); 
        precache_model ("progs/s_snowb.mdl"); 
        precache_model ("progs/s_trip.mdl"); 
//^Shrunken player and attacks
        precache_model ("progs/throwaxe.mdl");
        precache_sound ("weapons/woosh.wav");
        precache_sound ("weapons/taxhit1.wav");
        precache_sound ("weapons/taxhit2.wav");
        precache_sound ("weapons/taxhit3.wav");
//^Throwing Axe
        precache_model ("progs/lsword.mdl");
        precache_model ("progs/batleth.mdl");
        precache_sound ("knight/sword1.wav");
        precache_sound ("knight/sword2.wav");
        precache_sound ("hknight/slash1.wav");
        precache_sound ("weapons/unsheath.wav");
//^Melee Weaps

        precache_sound ("weapons/step1.wav");
        precache_sound ("weapons/step5.wav");
        precache_sound ("weapons/step6.wav");
        precache_sound ("weapons/stepstop.wav");
//^Stepping sounds
        precache_sound ("weapons/moadib.wav");
        precache_model ("progs/hand.mdl");
        precache_model ("progs/null.spr");
        precache_sound ("magic/castfar1.wav");
        precache_sound ("magic/castfar2.wav");
        precache_sound ("weapons/teleeyes.wav");
        precache_sound ("weapons/anvilhit.wav");
//^Magic
        precache_model ("progs/laser.mdl");
        precache_model ("progs/backpack.mdl");
        precache_model ("progs/shelcase.mdl");
        precache_model ("progs/pipebomb.mdl"); 
        precache_model ("progs/v_ghook.mdl"); 
        precache_model ("progs/ghook.mdl"); 
        precache_model ("progs/link.mdl"); 
        precache_model ("progs/v_maud.mdl"); 
        precache_model ("progs/v_laser.mdl"); 
        precache_model ("progs/g_laser.mdl"); 
        precache_model ("progs/v_betty.mdl"); 
        precache_model ("progs/v_trip.mdl"); 
        precache_model ("progs/lavaball.mdl");
        precache_sound ("weapons/flame.wav");  
        precache_sound ("weapons/fbfire.wav"); 
        precache_sound ("weapons/r_exp3.wav");        
        precache_sound ("weapons/rocket1i.wav");        
	precache_sound ("weapons/sgun1.wav");
        precache_sound ("weapons/guncock.wav"); 
        precache_sound ("weapons/ric1.wav");    
        precache_sound ("weapons/ric2.wav");    
        precache_sound ("weapons/ric3.wav");    
        precache_sound ("weapons/spike2.wav");  
        precache_sound ("weapons/tink1.wav");   
        precache_sound ("weapons/grenade.wav"); 
        precache_sound ("weapons/bounce.wav");          
        precache_sound ("weapons/shotgn2.wav"); 
	precache_model ("progs/flame2.mdl");
        precache_model ("progs/cross2.mdl");
//^Absolutely Neccessary
        precache_sound ("weapons/jethover.wav");
        precache_sound ("weapons/jeton.wav");
//^Jet pack
        precache_sound ("weapons/kick.wav");
        precache_sound ("weapons/slop.wav");
        precache_sound ("demon/ddeath.wav");
	precache_sound ("hknight/hit.wav");		// used by C code, so don't sound2
	precache_sound2 ("enforcer/enfstop.wav");
        precache_sound ("weapons/warning.wav");
        precache_sound ("weapons/bullseye.wav");
        precache_sound ("weapons/lhit.wav");
        precache_sound ("weapons/sniper.wav");
        precache_sound ("misc/power.wav");
        precache_sound ("doors/basetry.wav");
        precache_sound ("doors/baseuse.wav");
        precache_sound ("weapons/pkup.wav");  
        precache_sound ("weapons/shellhit.wav"); 
        precache_sound ("player/tornoff2.wav");
        precache_sound ("player/slimbrn2.wav");
	precache_sound ("ambience/fire1.wav");
        precache_sound ("zombie/z_miss.wav");
        precache_sound ("buttons/airbut1.wav");
        precache_sound("weapons/scream.wav");
//        precache_sound ("items/inv2.wav");//?
        precache_sound ("items/inv3.wav");//?
//        precache_sound ("items/r_item1.wav");//?
//        precache_sound ("items/protect2.wav");//?
//        precache_sound ("items/protect3.wav");//?
//^Miscellaneous
};

/*
================
W_FireAxe
================
*/
void() W_FireAxe =
{
	local   vector  source;
        local   vector  org,vec;

        makevectors(self.v_angle);
	source = self.origin + '0 0 16';
        vec = (self.accuracy*(random() - 0.5)/10)*v_up + (self.accuracy*(random() - 0.5)/10)*v_right;
        traceline (source, source + vec + v_forward*64, FALSE, self);
	if (trace_fraction == 1.0)
		return;
	
	org = trace_endpos - v_forward*4;

	if (trace_ent.takedamage)
	{
		trace_ent.axhitme = 1;
                SpawnBlood (org, '0 0 0', 20,trace_ent);
                if(self.small)
                        sound (self, CHAN_WEAPON, "zombie/z_miss.wav", 0.25, ATTN_NORM);
                else sound (self, CHAN_WEAPON, "zombie/z_miss.wav", 1, ATTN_NORM);
		T_Damage (trace_ent, self, self, 20);
	}
	else
        {       
                if(self.small)
                        sound (self, CHAN_WEAPON, "player/axhit2.wav", 0.25, ATTN_NORM);
                else sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST, org_x);
		WriteCoord (MSG_BROADCAST, org_y);
		WriteCoord (MSG_BROADCAST, org_z);
	}
};

vector() wall_velocity =
{
	local vector    vel;
	
	vel = normalize (self.velocity);
	vel = normalize(vel + v_up*(random()- 0.5) + v_right*(random()- 0.5));
	vel = vel + 2*trace_plane_normal;
	vel = vel * 200;
	
	return vel;
};


/*
================
SpawnBlood
================
*/
void(vector org, vector vel, float damage, entity loser) SpawnBlood =
{
local float col;
        if(loser.racename=="T-800"||loser.racename=="Borg"||loser.classname=="lightsaber"||loser.classname=="chakram"||loser.classname=="disc"||loser.classname=="longsword"||loser.classname=="batleth"||loser.netname=="rockets")
                col = 242;
        else if(loser.racename=="Predator")
                col = 192;
        else
                col = 73;
        particle (org, vel*0.1, col, damage*2);
};

/*
================
spawn_touchblood
================
*/
void(float damage) spawn_touchblood =
{
	local vector    vel;

	vel = wall_velocity () * 0.2;
        SpawnBlood (self.origin + vel*0.01, vel, damage,self);
};


/*
================
SpawnChunk
================
*/
void(vector org, vector vel) SpawnChunk =
{
	particle (org, vel*0.02, 0, 10);
};

/*
==============================================================================

MULTI-DAMAGE

Collects multiple small damages into a single damage

==============================================================================
*/

void(vector org,entity targ) Ricochet =
{
local float r;
WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
WriteByte (MSG_BROADCAST, TE_GUNSHOT);
WriteCoord (MSG_BROADCAST, org_x);
WriteCoord (MSG_BROADCAST, org_y);
WriteCoord (MSG_BROADCAST, org_z);
                r = random()*100;
                if (r > 95)
                        sound (targ,CHAN_AUTO,"weapons/ric1.wav",1,ATTN_NORM);
                else if (r > 91)
                        sound (targ,CHAN_AUTO,"weapons/ric2.wav",1,ATTN_NORM);
                else if (r > 87)
                        sound (targ,CHAN_AUTO,"weapons/ric3.wav",1,ATTN_NORM);
};

entity  multi_ent;
float   multi_damage;

void() ClearMultiDamage =
{
	multi_ent = world;
	multi_damage = 0;
};

void() ApplyMultiDamage =
{
local float kicker, inertia;
	if (!multi_ent)
		return;

	if(multi_ent.phase==self.phase&&multi_ent.racename=="Borg")
	{
		BorgShield(multi_ent);
		Ricochet(multi_ent.origin , multi_ent);
		return;
	}
        else
        {
        local entity loser,winner;
        if(multi_ent.reflecttime>time)
        {
                if(multi_ent.classname=="lightsaber")
                {
                        particle (multi_ent.origin,'0 0 16'*0.1, 242, 10);
                        if(random()<0.5)
                                sound (multi_ent, CHAN_WEAPON, "weapons/saberhit.wav", 1, ATTN_NORM);
                        else sound (multi_ent, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_NORM);
                }
                else spawn_bounce (multi_ent.origin);

		Ricochet(multi_ent.origin , multi_ent);
                winner=multi_ent;
                loser=self;
                multi_damage= random()*multi_damage/2 + multi_damage/2;
        }
        else
        {
                winner=self;
                loser=multi_ent;
        }
        kicker = multi_damage * 20 - vlen(winner.origin - loser.origin);
	if(kicker>0)
	{	
                if(loser.flags&FL_ONGROUND)
		{	
                        loser.flags = loser.flags - FL_ONGROUND;
                        loser.velocity_z = loser.velocity_z + 150;
		}
		if(random()<0.5)
		{
                        if(loser.classname=="player")
                        {
                        local float spin;
                                if(random()<0.5)
                                        spin=random()*9+1;
                                else
                                        spin=random()*-9 - 1;
                        loser.punchangle_y=spin;
                        kicker=kicker - fabs(spin)/2;
                        }
                        else
                        {
                        kicker=kicker*0.5;
//                        if(random()<0.5)
//                        {
                                current_yaw = anglemod( loser.angles_y );
                                loser.angles_y = anglemod (current_yaw + random()*270 + 45);
//                         }
/*
                         else
                        {
                          bprint("Angular Velocity\n");
                         if(random()<0.5) // This is supposed to make them spin with the hit, but it doesn't work, I think it has to do with the movetype- avelocity may only effect flymissile and bounce movetypes?
                                loser.avelocity_y = random()* 600 + 400;
                         else
                                loser.avelocity_y = 0 - (random()* 600 + 400);
                        }                        
*/
                       }
		}
                  if (loser.mass==0)
			inertia = 1;
                  else inertia = loser.mass;
            if(loser==self)
                    loser.velocity = loser.velocity - (normalize(loser.v_angle) * (kicker / inertia));
            else loser.velocity = loser.velocity + (normalize(winner.v_angle) * (kicker / inertia));
	}
        T_Damage (loser, winner, winner, multi_damage);
        }
};

void(entity hit, float damage) AddMultiDamage =
{
	if (!hit)
		return;
	
	if (hit != multi_ent)
	{
		ApplyMultiDamage ();
		multi_damage = damage;
		multi_ent = hit;
	}
	else
		multi_damage = multi_damage + damage;
};

void(entity winner) BorgShield =
{
                spawn_bounce(winner.origin);
                if(random()<0.2)
                        BorgSpeak(winner);
};

/*
==============================================================================

BULLETS

==============================================================================
*/

/*
================
TraceAttack
================
*/
void(float damage, vector dir) TraceAttack =
{
	local   vector  vel, org;
	
	vel = normalize(dir + v_up*crandom() + v_right*crandom());
	vel = vel + 2*trace_plane_normal;
	vel = vel * 200;

	org = trace_endpos - dir*4;

	if (trace_ent.takedamage)
	{
                if (trace_ent.reflecttime > time||(trace_ent.phase==self.owner.phase&&trace_ent.racename=="Borg"))
                {
                        Ricochet(org,trace_ent);
                        if(trace_ent.phase==self.owner.phase&&trace_ent.racename=="Borg")
                                BorgShield(trace_ent);
                }
                else
                        SpawnBlood (org, vel*0.2, damage,trace_ent);
		AddMultiDamage (trace_ent, damage);
	}
	else
                Ricochet(org,trace_ent);
};

/*
================
FireBullets

Used by shotgun, super shotgun, and enemy soldier firing
Go to the trouble of combining multiple pellets into a single damage call.
================
*/
void(float shotcount, vector dir, vector spread) FireBullets =
{
	local   vector direction;
        local   vector  src,vec;
	
	makevectors(self.v_angle);

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	ClearMultiDamage ();
	while (shotcount > 0)
	{
		direction = dir + crandom()*spread_x*v_right + crandom()*spread_y*v_up;

		traceline (src, src + direction*2048, FALSE, self);
		if (trace_fraction != 1.0)
                        if((self.skin==6||self.oldskin==6)&&self.weapon==IT_SHOTGUN)
                                if(deathmatch||teamplay)
                                        TraceAttack (10, direction);
                                else TraceAttack (20, direction);
                        if((self.skin==17||self.oldskin==17)&&self.weapon==IT_SNIPERGUN)
                                TraceAttack (80, direction);
                        else
                        TraceAttack (4, direction);

		shotcount = shotcount - 1;
	}
	ApplyMultiDamage ();
};

/* Flare */
void() flare_dim =
{
	self.effects=8;
        self.nextthink = time + 10;
	self.think = SUB_Remove;
};
void() FlarePlayerTouch =
{
        self.origin = self.enemy.origin + '0 0 16';
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};
void() flare_touch =
{
local float rand;
	if (other == self.owner)
		return;

	if (other.solid == SOLID_TRIGGER)
		return; // trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	if(other.takedamage == DAMAGE_AIM)
	{
                spawn_touchblood (2);
                self.enemy = other;
                self.origin = other.origin + '0 0 8';
		if (self.effects != EF_DIMLIGHT)
		{
                        sprint (self.owner, "You lit up ");
			if (self.enemy.classname == "player")
			{
				sprint (self.owner, self.enemy.netname);
				sprint (self.owner, "!\n");
			
                                sprint (self.enemy, "You are lit up!");
			}
			else
			{
				sprint (self.owner, "a ");
				sprint (self.owner, self.enemy.classname);
				sprint (self.owner, "!\n");
			}
			self.effects = EF_DIMLIGHT;
                        self.touch = FlarePlayerTouch;
		}

	}
       else
       {
        self.movetype = MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
       }
};
/*
==============================================================================

ROCKETS

==============================================================================
*/
void() SmallExplosion =
{
        particle (self.origin, '0 0 10', 242, 5);
        self.movetype = MOVETYPE_NONE;
        self.velocity = '0 0 0';
        self.touch = SUB_Null;
        self.solid = SOLID_NOT;
        sound(self,CHAN_AUTO,"weapons/r_exp3.wav",0.25,ATTN_NORM);
        remove(self);
};

void() T_SpreadTouch =
{
	local float	damg;

	if (other == self.owner)
                return;         

        if(other.classname==self.classname)
                return;
        
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

        if(other.reflecttime > time&&other.classname!="lightsaber")
              {
              BounceBack(self.owner,other);
              return;
              }

        damg = 20 + random()*10;
	
        if (other.health)
	{
		if (other.classname == "monster_shambler")
                        damg = damg * 0.5;      
                if(other.phase==self.owner.phase&&other.racename=="Borg")
                {
                        T_RadiusDamage (self, self.owner, 50, other);
                        BorgShield(other);
                }
                else T_Damage (other, self, self.owner, damg );
        }

        T_RadiusDamage (self, self.owner, 50, other);

	self.origin = self.origin - 8*normalize(self.velocity);

        if(self.small)
                SmallExplosion();
        else
        {
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	BecomeExplosion ();
        }
};

/*
Rockets find target
*/
entity () HomeFindTarget =
{
        local entity head, selected;
        local float dist;
        dist = 100000;
        selected = world;
        head = findradius(self.origin, 1000);
        while(head)
        {
          if((head.health > 0.1) && (head != self) && (head != self.owner) && !( (teamplay == 1) && (head.team > 0)&&(head.team == self.owner.team) ) && (head.classname != "door") && (head.classname != "misc_explobox") && (head.invisible_finished<time) && (head.beendead != TRUE) && (head.controller != self.owner)&&!(head.isfeign)&&head!=self.controller&&head.solid!=SOLID_TRIGGER&&visible(head))
	         {
                        if((self.touch == T_SpreadTouch && self.owner == head.owner)||(head.alive==FALSE&&(vlen(head.origin-self.owner.origin)<256))||(head.netname=="rockets"&&head.classname!="player"))
                                SUB_Null();
                        else
                        {
                        traceline(self.origin,head.origin,TRUE,self);
                        if ( (trace_fraction >= 1) && (vlen(head.origin - self.origin) < dist))
                            if(self.allset||(!self.allset&&infront(head)))
                            {
                                selected = head;
                                dist = vlen(head.origin - self.origin);
                            }
                        }
                }
                head = head.chain;
        }

        self.allset=TRUE;
        if (selected != world)   
        {
                sprint (self.owner,"Homing->");
                if (selected.classname == "player"||selected.classname=="holo")
                {
/*
                        if(selected.skin==1&&selected.zap_finished<time)
                                {
                                sound (selected, CHAN_VOICE, "jaworski/ohshit.wav",1, ATTN_NORM);
                                selected.zap_finished = time + 1;
                                }
*/
                        sprint (self.owner,selected.netname);
                        sprint(selected,"Warning!  ");
                        if(self.classname == "disc")
                                {
                                sprint(selected,self.controller.netname);
                                sprint(selected,"'s Disc");
                                }
                        else sprint(selected,self.owner.netname);
                        sprint(selected," has a lock on you!\n");
                }
                else sprint (self.owner,selected.classname);
                sprint (self.owner,"\n");
                if(self.classname!="disc")
                        sound(self, CHAN_WEAPON, "weapons/warning.wav", 1, ATTN_NORM);
        }
        
        return selected;
};

void() HomeThink =
{
	local vector dir, vtemp;

        if ((self.enemy.alive==FALSE&&(vlen(self.enemy.origin-self.owner.origin)<256))||self.enemy.isfeign||!(self.enemy) || (self.enemy == world) || (self.enemy.health <=0) && (self.enemy.beendead != TRUE)||(!visible(self.enemy))||(self.enemy.invisible_finished>=time))
		self.enemy = HomeFindTarget();

        if (self.enemy != world) 
	{
		vtemp = self.enemy.origin + '0 0 10';
		dir = normalize(vtemp - self.origin);
                if(self.classname=="plasmabolt")
                        self.velocity = dir * 700;
                else
                {
                if(self.velocity=='0 0 0')
                        self.velocity = dir * 350;
                else if(self.velocity!=dir*350)
                        self.velocity = (self.velocity + dir*350 + dir*350)*0.33;
                self.velocity_x = self.velocity_x + (random () * 150 - 75);
                self.velocity_y = self.velocity_y + (random () * 150 - 75);
                self.velocity_z = self.velocity_z + (random () * 150 - 75);
                }
                self.angles = vectoangles(self.velocity);
                if (self.flags & FL_ONGROUND)// && self.follow == 0)
                   {
                   self.flags = self.flags - FL_ONGROUND;
//                   self.follow = 1;
                   }
	}
        if ((vlen(self.enemy.origin-self.origin)<7)||(self.alivetime < time && (self.classname == "homerocket"||self.classname=="plasmabolt")))
                {
                GrenadeExplode();
                remove(self);
                }
        self.nextthink = time + 0.2;
	self.think=HomeThink;
};

void()	s_explode1	=	[0,		s_explode2] {};
void()	s_explode2	=	[1,		s_explode3] {};
void()	s_explode3	=	[2,		s_explode4] {};
void()	s_explode4	=	[3,		s_explode5] {};
void()	s_explode5	=	[4,		s_explode6] {};
void()	s_explode6	=	[5,		SUB_Remove] {};

void() RocketExplodeFix =
{
	if (self.spawnflags & WEAPON_BIG2)
		setmodel (self, "maps/b_rock1.bsp");
	else
		setmodel (self, "maps/b_rock0.bsp");
	self.model = string_null;
	self.solid = SOLID_NOT;
        self.movetype = MOVETYPE_STEP;
        self.takedamage=DAMAGE_AIM;
        self.health=25;
        self.th_die=GrenadeExplode;
        self.touch = ammo_touch;
        self.nextthink = time + 30;
        self.think = SUB_regen;
};

void()  r_explode1      =       [0,             r_explode2] {};
void()  r_explode2      =       [1,             r_explode3] {};
void()  r_explode3      =       [2,             r_explode4] {};
void()  r_explode4      =       [3,             r_explode5] {};
void()  r_explode5      =       [4,             r_explode6] {};
void()  r_explode6      =       [5,             RocketExplodeFix] {};

void() spike_touch;

void() BecomeExplosion =
{
	self.movetype = MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
        if (deathmatch == 1&&self.netname=="rockets")
                r_explode1 ();
        else s_explode1 ();
};

void() T_MissileTouch =
{
	local float	damg;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

        if(other.reflecttime > time&&other.classname!="lightsaber")
              {
              BounceBack(self.owner,other);
              return;
              }

        if(self.classname=="homerocket"&&(deathmatch||(coop&&other.classname=="player")))
                damg = 60 + random()*40;
        else damg = 100 + random()*20;
	

        if(other.health>0&&other.health<99999999)
	{
            if(other.phase==self.owner.phase&&other.racename=="Borg")
            {
                    T_RadiusDamage (self, self.owner, 120, other);
                    BorgShield(other);
            }
            else
            {
		if (other.classname == "monster_shambler")
			damg = damg * 0.5;	// mostly immune
                if(self.classname=="shrapnel")
                        self.classname="rocket";
                if((other.classname=="lightsaber"&&other.running)||other.classname=="monster_oldone"||other.classname=="monster_boss")
                        T_Damage (other, self, self.owner, damg );
                else
                {
		T_Damage (other, self, self.owner, damg );
                other.velocity_x = other.velocity_x + self.velocity_x;
                other.velocity_y = other.velocity_y + self.velocity_y;
                other.velocity_z = other.velocity_z + 100;
                if(other.flags&FL_ONGROUND)
                        other.flags = other.flags - FL_ONGROUND;
                }
            }
	}
        else if (self.classname == "homerocket"&&self.active==FALSE)
        {
        sound(self,CHAN_WEAPON,"weapons/pkup.wav",1,ATTN_NORM);
        self.angles = vectoangles ('0 0 0' - self.velocity);
        self.enemy = world;
        self.velocity = '0 0 0';
        self.alivetime = time + 180;
        self.active = TRUE;
        return;
        }
	// don't do radius damage to the other, because all the damage
	// was done in the impact
	T_RadiusDamage (self, self.owner, 120, other);

	self.origin = self.origin - 8*normalize(self.velocity);

        if(self.small)
                SmallExplosion();
        else
        {
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	BecomeExplosion ();
        }
};

void() GrenadeExplode =
{
        if(self.classname=="throwaxe"||self.hover||self.netname=="rockets")
                T_RadiusDamage (self, self.owner, 200, world);
        else if(self.classname=="maudib")
                T_RadiusDamage (self, self.owner, self.mass, world);
        else if(self.owner.classname=="ogre"||self.classname=="betty")
           {
           if(self.owner.classname=="ogre"&&self.owner.onfire&&self.netname=="dumb ass ogre")
                   T_RadiusDamage (self, self.owner.enemy, 60*(self.owner.ammo_rockets+1), world);
           else T_RadiusDamage (self, self.owner, 40, world);
//           sound (self, CHAN_VOICE, "weapons/r_exp3.wav", 1, ATTN_NORM);
           }
        else
                T_RadiusDamage (self, self.owner, 80, world);

        if(self.small)
                SmallExplosion();
        else
        {
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

        if(self.owner.classname=="ogre")
        {
                self.velocity = '0 0 0';
                self.touch = SUB_Null;
                setmodel (self, "progs/s_explod.spr");
                self.solid = SOLID_NOT;
                s_explode1 ();
        }
        else BecomeExplosion ();
        }
};

void(entity ignore) EmptyExplode =
{
        if(self.classname=="throwaxe"||self.hover)
                T_RadiusDamage (self, self.owner, 200, ignore);
        else if(self.owner.classname=="ogre"||self.classname=="betty")
           {
           T_RadiusDamage (self, self.owner, 40, ignore);
//           sound (self, CHAN_VOICE, "weapons/r_exp3.wav", 1, ATTN_NORM);
           }
        else
                T_RadiusDamage (self, self.owner, 80, ignore);

//        if(self.classname!="maudib")
//        {
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
//        }

        if(self.owner.classname=="ogre")
        {
                self.velocity = '0 0 0';
                self.touch = SUB_Null;
                setmodel (self, "progs/s_explod.spr");
                self.solid = SOLID_NOT;
                s_explode1 ();
        }
        else BecomeExplosion ();
};

void() GoEE =
{
        EmptyExplode(self.enemy);
};

float(entity targ) visible;
float(entity targ) infront;

/*
================
W_FireRocket
================
*/
void(vector dir,entity cont,string type) W_FireRocket2 =
{
	local   entity missile, mpuff;
	missile = spawn ();
        missile.owner = cont;
        missile.movetype = MOVETYPE_FLYMISSILE;
        missile.solid = SOLID_BBOX;
        missile.health = 10;
        missile.takedamage = DAMAGE_AIM;
        missile.th_die = T_MissileTouch;
        missile.classname = type;
        missile.small=cont.small;
        makevectors (cont.v_angle);
	missile.touch = T_MissileTouch;
// set missile speed    

        if (type == "homerocket"||type == "plasmabolt") 
        {
        missile.think = HomeThink;
        missile.nextthink = time + 0.2;
	missile.enemy = world;
        missile.controller = self;
        missile.alivetime = time + 30;
        if(type=="plasmabolt")
        {
        if(cont.small)
                setmodel (missile, "progs/s_laser.mdl");
        else setmodel (missile, "progs/laser.mdl");
        missile.skin = 1;
        missile.speed = 700;
        if(missile.owner.lockentity!=world)
                missile.enemy=missile.owner.lockentity;
        if(missile.owner.racename!="Predator"||(missile.owner.lockentity==world))
                {
                missile.think = GrenadeExplode;
                missile.nextthink = time + 3;
                }
        if(missile.owner.racename=="Predator"&&missile.owner.classlabel=="Assassin")
                {
                missile.think = HomeThink;
                missile.nextthink = time + 0.2;
                missile.enemy = world;
                }
        }
        else
        {
        if(cont.small)
                setmodel (missile, "progs/s_miss.mdl");
        else setmodel (missile, "progs/missile.mdl");
        missile.speed = 350;
        }
        missile.velocity = dir * missile.speed;
        }
        else
        {
        missile.speed = 1000;
        missile.velocity = dir * missile.speed;
	missile.nextthink = time + 5;
	missile.think = SUB_Remove;
        if(cont.small)
                setmodel (missile, "progs/s_miss.mdl");
        else setmodel (missile, "progs/missile.mdl");
        }
	missile.angles = vectoangles(missile.velocity);

/* Tried to make rockets shootable- didn't work
        if(type=="homerocket")
                setsize (missile, '-2 -2 -2', '2 2 2');
        else
*/
                setsize (missile, '0 0 0', '0 0 0');
        if(type=="homerocket")
                if(cont.small)
                        setorigin (missile, cont.origin + v_forward*4 + v_right*1 + v_up*1);
                else setorigin (missile, cont.origin + v_forward*8 + v_right*9 + v_up*20);
        else if(cont.small)
                setorigin (missile, cont.origin + v_forward*4 + v_up*1);
        else setorigin (missile, cont.origin + v_forward*8 + v_up*16);
};

/*
================
W_FireSpread
================
*/
void() SpreadThink =
{
        self.velocity_x = self.velocity_x + (random() * 100 - 50);
        self.velocity_y = self.velocity_y + (random() * 100 - 50);
        self.velocity_z = self.velocity_z + (random() * 100 - 50);
        self.angles = vectoangles(self.velocity);
        self.nextthink = time + 0.2;
        self.think = SpreadThink;
};

void(vector dir,entity cont,string type) W_FireSpread2 =
{
	local	entity missile, mpuff;

	missile = spawn ();
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = SOLID_BBOX;
        missile.owner = cont;
        missile.health = 10;
        missile.takedamage = DAMAGE_AIM;
        missile.th_die = T_SpreadTouch;
        makevectors (cont.v_angle);
        if(cont.small)
                missile.speed = 50;
        else missile.speed = 500;
	missile.nextthink = time + 0.2;
        missile.classname = type;
        missile.small=cont.small;

        if (type == "spreadrocket")
        {
        missile.touch = T_SpreadTouch;
        missile.think = SpreadThink;
        }
        else if (type == "homespread")
        {
        missile.touch = T_SpreadTouch;
        missile.think = HomeThink;
        missile.enemy = world;
        }
        missile.velocity = dir * missile.speed;
        if(cont.small)
        {
        missile.velocity_x = missile.velocity_x + (random() * 10 - 5);
        missile.velocity_y = missile.velocity_y + (random() * 10 - 5);
        missile.velocity_z = missile.velocity_z + (random() * 10 - 5);
        }
        else
        {
        missile.velocity_x = missile.velocity_x + (random() * 100 - 50);
        missile.velocity_y = missile.velocity_y + (random() * 100 - 50);
        missile.velocity_z = missile.velocity_z + (random() * 100 - 50);
        }
	missile.angles = vectoangles(missile.velocity);
        if(cont.small)
                setmodel (missile, "progs/s_miss.mdl");
        else setmodel (missile, "progs/missile.mdl");
        setsize (missile, '0 0 0', '0 0 0');
        if(cont.small)
                setorigin (missile, cont.origin + v_forward*4 + '0 0 4');
        else setorigin (missile, cont.origin + v_forward*8 + '0 0 16');
};

void(string type) W_FireSpread =
{
local vector dir;
        dir = aim(self, 1000);
        self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
        if(self.small)
                sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 0.25, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
        self.punchangle_x = -5;
        W_FireSpread2(dir,self,type);
};

/*
===============================================================================

LIGHTNING

===============================================================================
*/

/*
=================
LightningDamage
=================
*/

void (vector endpos) ThroughWaterZap =
{
local entity waterloser;
                waterloser = spawn();        
                setorigin (waterloser, endpos);
                T_RadiusDamageWater (self, self, 666*2,self);
                remove (waterloser);
};

void (vector startpos) ThroughWater =
{
local vector endpos;
local float mover;
        mover = 600;
        while (mover)
        {
        mover = mover - 10;
        endpos = startpos + v_forward * mover;
        if (pointcontents(endpos) == CONTENT_WATER || pointcontents(endpos) == CONTENT_SLIME)
                ThroughWaterZap(endpos);
        else if (pointcontents(endpos) == CONTENT_SOLID)
                return;
        }
};

void(vector p1, vector p2, entity from, float damage) LightningDamage =
{
        local entity            e1, e2, swap;
	local vector            f;
        local float             absorb;
	f = p2 - p1;
	normalize (f);
	f_x = 0 - f_y;
	f_y = f_x;
	f_z = 0;
	f = f*16;

	e1 = e2 = world;

	traceline (p1, p2, FALSE, self);

        if (self.classname == "spell")
                trace_ent = self.enemy;

        if((pointcontents(trace_endpos) == CONTENT_WATER || pointcontents(trace_endpos) == CONTENT_SLIME)&&trace_ent.racename!="Bossk")
                ThroughWaterZap(trace_endpos);
        else if((trace_ent.watertype == CONTENT_WATER || trace_ent.watertype == CONTENT_SLIME)&&trace_ent.racename!="Bossk")
                T_RadiusDamageWater (self, self, 666*2,self);
        else if (trace_ent.takedamage)
	{
		particle (trace_endpos, '0 0 100', 225, damage*4);
                if(trace_ent.phase==from.phase&&trace_ent.racename=="Borg")
                {
                                BorgShield(trace_ent);
                                return;
                }
                else if (trace_ent.reflecttime > time&&from.classname!="spell")
                        {
                        if (from.reflecttime > time||(trace_ent.phase==from.phase&&from.racename=="Borg"))
                                return;
                        else {
                             swap = from;
                             from = trace_ent;
                             trace_ent = swap;
                             }
                        }
                if (from.classname == "shambler")
                        {
                        if(trace_ent.prottime < time)
                                T_Damage (trace_ent, from, from, damage);
                        }
                else if(other.energyabsorb)
                {
                stuffcmd (other, "bf\n");
                other.health=other.health + damage;
                if(other.health>other.max_health*2)
                        other.health=other.max_health*2;
                }
                else
                {
                if(trace_ent.racename=="T-800"||trace_ent.racename=="Borg")
                        damage=damage*2;
                else if(trace_ent.skin==13||trace_ent.oldskin==13)
                        damage=damage*0.5;
                T_Damage (trace_ent, from, from, damage);
                }
                if (self.classname == "player"&&(trace_ent.flags&FL_ONGROUND))
                        {
                        trace_ent.velocity_z = trace_ent.velocity_z + 400;
                        if(trace_ent.flags&FL_ONGROUND)
                                trace_ent.flags=trace_ent.flags-FL_ONGROUND;
                        }
	}
        else ThroughWater(p1);

        e1 = trace_ent;
	traceline (p1 + f, p2 + f, FALSE, self);
        if (trace_ent != e1 && trace_ent.takedamage)
	{
		particle (trace_endpos, '0 0 100', 225, damage*4);
                if(trace_ent.phase==from.phase&&trace_ent.racename=="Borg")
                {
                                BorgShield(trace_ent);
                                return;
                }
                if (trace_ent.reflecttime > time)
                        {
                        if (from.reflecttime > time||(trace_ent.phase==from.phase&&from.racename=="Borg"))
                                return;
                        else swap = trace_ent;
                             from = trace_ent;
                             trace_ent = swap;
                        }
                T_Damage (trace_ent, from, from, damage);
	}
	e2 = trace_ent;
	traceline (p1 - f, p2 - f, FALSE, self);
        if (trace_ent != e1 && trace_ent != e2 && trace_ent.takedamage)
	{
		particle (trace_endpos, '0 0 100', 225, damage*4);
                if(trace_ent.phase==from.phase&&trace_ent.racename=="Borg")
                {
                                BorgShield(trace_ent);
                                return;
                }
                if (trace_ent.reflecttime > time)
                        {
                        if (from.reflecttime > time||(trace_ent.phase==from.phase&&from.racename=="Borg"))
                                return;
                        swap = trace_ent;
                        from = trace_ent;
                        trace_ent = swap;
                        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
                        WriteByte (MSG_BROADCAST, TE_LIGHTNING2);
                        WriteEntity (MSG_BROADCAST, from);
                        WriteCoord (MSG_BROADCAST, from.origin_x);
                        WriteCoord (MSG_BROADCAST, from.origin_y);
                        WriteCoord (MSG_BROADCAST, from.origin_z);
                        WriteCoord (MSG_BROADCAST, trace_ent.origin_x);
                        WriteCoord (MSG_BROADCAST, trace_ent.origin_y);
                        WriteCoord (MSG_BROADCAST, trace_ent.origin_z);
                        }
                T_Damage (trace_ent, from, from, damage);
	}
};


void(entity loser,vector dir) W_FireLightning =
{
        local   vector          org,vec;

     if (self.aflag != 33)
     {
	if (self.ammo_cells < 1)
	{
                self.weapon = W_BestWeapon ();
		W_SetCurrentAmmo ();
		return;
	}

// explode if under water
	if (self.waterlevel > 1)
	{
                self.effects = self.effects | EF_MUZZLEFLASH;
                if(self.energyabsorb)
                        {
                        T_RadiusDamageWater (self, self, 35*self.ammo_cells, self);
                        self.health=self.health + 35*self.ammo_cells;
                        if(self.health>self.max_health*2)
                                self.health=self.max_health*2;
                        }
                else T_RadiusDamageWater (self, self, 35*self.ammo_cells, world);
		self.ammo_cells = 0;
		W_SetCurrentAmmo ();
		return;
	}
	self.punchangle_x = -2;

	self.currentammo = self.ammo_cells = self.ammo_cells - 1;

        if(self.small)
                org = self.origin;
        else org = self.origin + '0 0 16';
        vec = (self.accuracy*(random() - 0.5)/10)*v_up + (self.accuracy*(random() - 0.5)/10)*v_right;
        traceline (org, org + vec + v_forward*600, TRUE, self);

     }
     else org = dir;

	if (self.t_width < time)
	{
                if(self.small)
                        sound (self, CHAN_WEAPON, "weapons/lhit.wav", 0.25, ATTN_NORM);
		sound (self, CHAN_WEAPON, "weapons/lhit.wav", 1, ATTN_NORM);
		self.t_width = time + 0.6;
	}

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_LIGHTNING2);
	WriteEntity (MSG_BROADCAST, self);
	WriteCoord (MSG_BROADCAST, org_x);
	WriteCoord (MSG_BROADCAST, org_y);
	WriteCoord (MSG_BROADCAST, org_z);
	WriteCoord (MSG_BROADCAST, trace_endpos_x);
	WriteCoord (MSG_BROADCAST, trace_endpos_y);
	WriteCoord (MSG_BROADCAST, trace_endpos_z);

if(self.small)
   if (self.aflag != 33)
        LightningDamage (self.origin, trace_endpos + v_forward*4, self, 6);
   else
        LightningDamage (self.origin, dir, self, 6);
else if (self.aflag != 33)
        LightningDamage (self.origin, trace_endpos + v_forward*4, self, 30);
   else
        LightningDamage (self.origin, dir, self, 30);
};


//=============================================================================
void() GrenadeTouch =
{
	if (other == self.owner)
		return;         // don't explode on owner
        if(other.reflecttime > time&&other.classname!="lightsaber")
              {
              GrenBounceBack(self.owner,other,self.speed);
              return;
              }

	if (other.takedamage == DAMAGE_AIM)
	{
                if(other.phase==self.owner.phase&&other.racename=="Borg")
                {
                        BorgShield(other);
                        EmptyExplode(other);
                }
                else GrenadeExplode();
		return;
	}
        if(self.small)
                sound (self, CHAN_WEAPON, "weapons/bounce.wav", 0.25, ATTN_NORM);  // bounce sound
	sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);  // bounce sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};
//=============================================================================
/* Looks like crap
void() Spike_Stick =
{
        self.origin=self.enemy.origin;
        if (self.alivetime<time||self.enemy.health<=0)
                remove(self);
        self.think = Spike_Stick;
        self.nextthink = time + 0.1;
};
*/
void() spike_touch =
{
local float multiplier;
	if (other == self.owner)
		return;

	if (other.solid == SOLID_TRIGGER)
		return; // trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

        if(other.reflecttime > time&&self.volume==0)
        {
              BounceBack(self.owner,other);
              return;
        }

// hit something that bleeds

        if((other.phase==self.owner.phase&&other.racename=="Borg")||!other.takedamage)
	{
                if(other.phase==self.owner.phase&&other.racename=="Borg")
                        BorgShield(other);

                WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		
		if (self.classname == "wizspike")
			WriteByte (MSG_BROADCAST, TE_WIZSPIKE);
		else if (self.classname == "knightspike")
			WriteByte (MSG_BROADCAST, TE_KNIGHTSPIKE);
                else if (self.classname == "spike")
			WriteByte (MSG_BROADCAST, TE_SPIKE);
                else    WriteByte (MSG_BROADCAST, TE_SUPERSPIKE);

		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}
        else
	{
                if (self.classname == "superspike")
                        multiplier = self.active;
                else if (self.classname == "shrapnel"||self.classname == "blades")
                        multiplier = 36;
                else if (self.classname == "spike")
                        multiplier = self.active;
                else if(self.classname == "wizspike" || self.classname == "knightspike")
                        multiplier = 9;
                else if (other.prottime > time)
                        multiplier = 0;
                
                spawn_touchblood (multiplier);
                T_Damage (other, self, self.owner, multiplier);
	}
        if(self.classname == "spike" || self.classname == "superspike")
                if (other.alive||deathmatch||coop||teamplay)
                        remove(self);
/*
                {
                        self.touch=SUB_Null;
                        self.enemy = other;
                        self.alivetime = time + 5;
                        Spike_Stick();
                }
*/
                else
                {
                self.active=self.active - 2;
                if(self.active < 0)
                        self.active = 0;
                self.volume=self.volume + 1;//hopefully prevents infinite bounces
                if(self.volume>=30)
                        remove(self);
                self.movetype = MOVETYPE_BOUNCE;
                Ricochet(self.origin,other);
                self.avelocity = '600 600 600';
                self.think = SUB_Remove;
                self.nextthink = time + 3;
                }
        else remove(self);
};

void() IceCubeThink =
{
        if(pointcontents(self.origin-'0 0 23')==CONTENT_LAVA||self.heatsee>=100)
                {
                self.heatsee=0;
                self.think=self.oldthink;
                self.nextthink=time;
                self.skin=self.oldskin;
                }

        if(pointcontents(self.origin)==CONTENT_WATER||pointcontents(self.origin)==CONTENT_SLIME)
                self.heatsee=self.heatsee + 1;
        else self.heatsee=0;

        if(pointcontents(self.origin-'0 0 36')!=CONTENT_SOLID)
                self.levitime=TRUE;
        else if (self.levitime)
                T_Damage(self,world,self.enemy,10);
        self.think=IceCubeThink;
        self.nextthink=time;
};

void(entity actor) discDrop;
void(entity loser) DropMelee=
{
                if(loser.saber.running)
                        if(loser.saber.classname=="lightsaber")
                                Drop(loser.saber);
                        else if(loser.saber.classname=="disc")
                                discDrop(loser.saber);
                if(loser.sword.running&&!loser.sword.inpain)
                        Drop(loser.sword);
                if(loser.batleth.running&&!loser.batleth.inpain)
                        Drop(loser.batleth);
};

void() FreezeTouch=
{
     if(pointcontents(self.origin)==CONTENT_SKY)
        remove(self);
     if(other.reflecttime > time&&other.classname!="lightsaber")
     {
              BounceBack(self.owner,other);
              return;
     }
     if(other.alive)
     {
        if(((other.skin!=2&&other.classname!="player")||(other.skin!=25&&other.classname=="player"))&&other.health>12)
                T_Damage(other,self,self.owner,3);
        if(random()<0.3)
        {
        sound(self,CHAN_AUTO,"weapons/frozen.wav",1,ATTN_NORM);
        if(other.classname!="player")
        {
                other.oldskin=other.skin;
                other.skin=2;
                if(other.health>0)
                        {
                        other.enemy=self.owner;
                        other.oldthink=other.think;
                        other.think=IceCubeThink;
                        other.nextthink=time;
//                        other.nextthink=time+30;
                        other.touch=SUB_Null;
//Prevent interruption? other.th_pain=SUB_Null;                        
                        }
                other.health=1;
        }
        else
        {
                DropMelee(other);
                other.oldskin=other.skin;
                other.skin=26;
                    other.o_angle=other.v_angle;
                other.pausetime = time + 20;
                other.attack_finished = time + 20;
                other.alivetime = time + 20;
                other.items=other.items + IT_QUAD;
                other.health=1;
                other.nextthink=time + 20;
//Prevent interruption? other.th_pain=SUB_Null;
        }
        if(other.flags&FL_FLY)
                other.flags = other.flags - FL_FLY;
        if (other.flags & FL_SWIM)
                other.flags = other.flags - FL_SWIM;
        if(other.flags&FL_ONGROUND)
                other.flags = other.flags - FL_ONGROUND;
        }
        remove(self);
     }
  else
     {
        if(self.small)
                sound(self,CHAN_AUTO,"weapons/tink1.wav",0.25,ATTN_NORM);
        else sound(self,CHAN_AUTO,"weapons/tink1.wav",1,ATTN_NORM);
/*
        if(random()<0.5)
                self.velocity_x=0 - (random()*300 + 100);
        else
                self.velocity_x=random()*300 + 100;
        if(random()<0.5)
                self.velocity_y=0 - (random()*300 + 100);
        else
                self.velocity_y=random()*300 + 100;
        if(self.flags&FL_ONGROUND)
        {
                self.velocity_z=random()*300 + 100;
                self.flags=self.flags-FL_ONGROUND;
*/
                self.movetype=MOVETYPE_BOUNCE;
/*
        }
        else
        {
        if(random()<0.5)
                self.velocity_z=0 - (random()*300 + 100);
        else
                self.velocity_z=random()*300 + 100;
        }
*/
        self.bloodloss=self.bloodloss + 1;
        if(self.bloodloss>9)
                remove(self);
     }
};

void()FreezeThink=
{
        if((pointcontents(self.origin)==CONTENT_WATER&&random()<0.3)||pointcontents(self.origin)==CONTENT_LAVA||(pointcontents(self.origin)==CONTENT_SLIME&&random()<0.5)||self.alivetime<time)
            {
            if(pointcontents(self.origin)==CONTENT_LAVA)
                    sound (self, CHAN_WEAPON, "player/slimbrn2.wav", 1, ATTN_NORM);
            remove(self);
            }
        self.think=FreezeThink;
        self.nextthink=time + 0.5;
};

void() ShrinkHit =
{
        if(other==self.owner)
                return;
       if(other.reflecttime > time&&other.classname!="lightsaber")
       {
              BounceBack(self.owner,other);
              return;
       }
        self.effects=EF_MUZZLEFLASH;
        if(other.takedamage&&(other.classname!="player"||other.small))
                if((other.flags&FL_MONSTER)&&other.alive&&other.classname!="rottweiler"&&other.classlabel!="dog")
                        Woof(other);
                else sprint(self.owner,"No effect!\n");
        else if (other.classname=="player")
        {
                other.shrink_time=time + 60;
                sprint(other,"Shrinking\n");
                spawn_tfog(other.origin); 
        }
        if(self.small)
                sound (self, CHAN_AUTO, "enforcer/enfstop.wav", 0.25, ATTN_NORM);
        else sound (self, CHAN_AUTO, "enforcer/enfstop.wav", 1, ATTN_NORM);
        remove(self);
};

/*

===============
launch_spike

Used for the player and the wiz & hknight
===============
*/
void(vector org,vector dir, entity cont,string type,float ox) launch_spike =
{
	newmis = spawn ();
        newmis.owner = cont;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;

	newmis.angles = vectoangles(dir);
	
	newmis.touch = spike_touch;
        newmis.classname = type;
        newmis.small=cont.small;
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
        if (type == "shrapnel")
                newmis.speed = 1400;
        else if (type == "knightspike")
                {
                newmis.speed = 300;
                setmodel (newmis, "progs/k_spike.mdl");
                }
        else if (type == "wizspike")
                {
                newmis.speed = 600;
		setmodel (newmis, "progs/w_spike.mdl");
                }
        else if (type == "snowball")
                {
                newmis.speed = 1000;
                if(cont.small)
                        setmodel (newmis, "progs/s_snowb.mdl");
                else setmodel (newmis, "progs/snowball.mdl");
                newmis.movetype=MOVETYPE_FLYMISSILE;
                newmis.touch=FreezeTouch;
                newmis.avelocity='-200 200 -200';
                newmis.think=FreezeThink;
                newmis.nextthink=time + 0.5;
                newmis.alivetime=time + 3;
                }
        else if (type == "shrinkball")
                {
                newmis.speed = 1000;
                if(cont.small)
                        setmodel (newmis, "progs/s_shrink.mdl");
                else setmodel (newmis, "progs/shrink.mdl");
                newmis.movetype=MOVETYPE_FLYMISSILE;
                newmis.touch=ShrinkHit;
                newmis.avelocity_x=random()*400 - 200;
                newmis.avelocity_y=random()*400 - 200;
                newmis.avelocity_z=random()*400 - 200;
                }
        else newmis.speed = 1000;

        if (type == "spike")
                if(cont.small)
                        setmodel (newmis, "progs/s_nail.mdl");
                else setmodel (newmis, "progs/spike.mdl");
        else if (type != "wizspike" && type != "knightspike"&&type!="snowball"&&type!="shrinkball")
                if(cont.small)
                        setmodel (newmis, "progs/s_s_spk.mdl");
                else setmodel (newmis, "progs/s_spike.mdl");

        setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
        if (type == "spike")
                {
                if(cont.small)
                        setorigin (newmis, org + '0 0 1');
                else setorigin (newmis, org + '0 0 16' + v_right*ox);
                newmis.active=9;
                }
        else if (type == "superspike")
                {
                if(cont.small)
                        setorigin (newmis, org + '0 0 1');
                else setorigin (newmis, org + '0 0 16');
                newmis.active=18;
                }
        else if (type == "snowball"||type=="shrinkball")
                if(cont.small)
                        setorigin (newmis, org + '0 0 1');
                else setorigin (newmis, org + '0 0 16');
        else setorigin (newmis, org);
        newmis.velocity = dir * newmis.speed;
};

void()FireFreeze=
{
	local vector    dir;
        local string type;
	
	makevectors (self.v_angle);
        if(self.classlabel=="Assassin"||self.racename=="Elf")
                dir = aim (self, 1000);
        else dir = normalize(v_forward);
        if (self.ammo_cells < 1)
	{
                self.weapon = W_BestWeapon ();
		W_SetCurrentAmmo ();
		return;
	}
        if(self.small)
                sound (self, CHAN_WEAPON, "hknight/hit.wav", 0.25, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "hknight/hit.wav", 1, ATTN_NORM);
        self.currentammo = self.ammo_cells = self.ammo_cells - 1;
        type = "snowball";
        launch_spike(self.origin+v_forward*8,dir,self,type,0);
};

void()FireShrink=
{
	local vector    dir;
        local string type;
	
	makevectors (self.v_angle);
        if(self.classlabel=="Assassin"||self.racename=="Elf")
                dir = aim (self, 1000);
        else dir = normalize(v_forward);
        if (self.ammo_cells < 5)
	{
                self.weapon = W_BestWeapon ();
		W_SetCurrentAmmo ();
		return;
	}
        if(self.small)
                sound (self, CHAN_WEAPON, "boss1/throw.wav", 0.25, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "boss1/throw.wav", 1, ATTN_NORM);
        self.currentammo = self.ammo_cells = self.ammo_cells - 5;
        type = "shrinkball";
        launch_spike(self.origin+v_forward*8,dir,self,type,0);
};

void(float ox) W_FireSpikes =
{
	local vector    dir;
        local string type;
	
	makevectors (self.v_angle);
        if(self.classlabel=="Assassin"||self.racename=="Elf")
                dir = aim (self, 1000);
        else dir = normalize(v_forward);
	if (self.ammo_nails < 1)
	{
                self.weapon = W_BestWeapon ();
		W_SetCurrentAmmo ();
		return;
	}
        self.attack_finished = time + 0.2 - self.attackspeed;
	self.punchangle_x = -2;
	if (self.ammo_nails >= 2 && self.weapon == IT_SUPER_NAILGUN)
	{
        if(self.small)
                sound (self, CHAN_WEAPON, "weapons/spike2.wav", 0.25, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "weapons/spike2.wav", 1, ATTN_NORM);
        self.currentammo = self.ammo_nails = self.ammo_nails - 2;
        type = "superspike";
        launch_spike(self.origin,dir,self,type,0);
        }
        else
        {
        if(self.small)
                sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 0.25, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);
        self.currentammo = self.ammo_nails = self.ammo_nails - 1;
        type = "spike";
        launch_spike(self.origin,dir,self,type,ox);
        }
};


void () FireDie =
{
        T_RadiusDamage (self, self.owner, (self.mass - 1)*125+25, world);

	self.origin = self.origin - 8*normalize(self.velocity);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	BecomeExplosion ();
        remove(self);
};

void() FireDamage =
{
        local float marked;

	self.wait = self.wait - 1;

        if (self.trigger_field.classname == "player" && self.owner.classname != "player")
                self.owner = self.trigger_field;

        if (self.trigger_field.waterlevel > 2 && self.trigger_field.watertype != CONTENT_LAVA)
            {    
            sound (self.owner, CHAN_WEAPON, "player/slimbrn2.wav", 1, ATTN_NORM);
            sprint(self.owner,self.trigger_field.netname);
            sprint(self.owner," saved his ass by jumping in the water!\n");
            self.trigger_field.effects = self.trigger_field.effects - self.trigger_field.effects;
            self.trigger_field.onfire = 0;
            remove(self);
            }

        if (self.trigger_field.waterlevel > 2 && self.trigger_field.watertype == CONTENT_LAVA)
            {    
            sprint(self.owner,self.trigger_field.netname);
            sprint(self.owner," jumped out of the frying pan into the fire!\n");
            self.trigger_field.effects = self.trigger_field.effects - self.trigger_field.effects;
            self.trigger_field.onfire = 0;
            FireDie();
            }
                
       if ((self.waterlevel > 2) || (self.watertype == CONTENT_WATER) || (self.watertype == CONTENT_SLIME) || (pointcontents(self.origin) == CONTENT_WATER) || (pointcontents(self.origin) == CONTENT_SLIME))
            {
            sound (self.owner, CHAN_WEAPON, "player/slimbrn2.wav", 1, ATTN_NORM);
            sprint(self.owner,"Fireball fizzled underwater\n");
            self.trigger_field.effects = self.trigger_field.effects - self.trigger_field.effects;
            self.trigger_field.onfire = 0;
            remove(self);
            }

        if (self.active != 5)
                {
                if ((self.wait < 1) || (self.trigger_field.health<=0))
                        {
                        self.trigger_field.effects = self.trigger_field.effects - self.trigger_field.effects;
                        self.trigger_field.onfire = 0;
                        remove(self);
                        }
                }
        else if (self.wait < 1 || self.trigger_field.health <= 6)
                {
                self.mass = 2;
                self.trigger_field.onfire = 0;
                self.trigger_field.effects = self.trigger_field.effects - self.trigger_field.effects;
                FireDie();
                }

        if (self.trigger_field.firesistime < time&&self.trigger_field.racename!="Draconian"&&self.trigger_field.fireresist!=1)
                {
                if(self.fireresist== -1)                
                        T_Damage (self.trigger_field, self, self.owner, 2*self.active*(self.trigger_field.onfire + 1));
                else T_Damage (self.trigger_field, self, self.owner, self.active*(self.trigger_field.onfire + 1));
//                if(self.trigger_field.onfire<1)
//                        spawn_touchblood(random()*10);
                }

        if(random()<0.5)
                SpawnFlame (self.origin);//This is causing an edict overflow hard crash...

        self.origin = self.trigger_field.origin + '0 0 6';
	self.nextthink = time + 0.05;
        self.think = FireDamage;
};

void() FireTouch2 =
{
                self.trigger_field.effects = EF_BRIGHTLIGHT;
                if(self.trigger_field.onfire<=0)
                        self.trigger_field.onfire = 1;
                self.think=FireDamage;
                self.nextthink=time;
};

void() FireTouch =
{
	local float     damg;

	if (other == self.owner)
		return;         // don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

		
        if(other.reflecttime > time&&other.classname!="lightsaber")
              {
              GrenBounceBack(self.owner,other,self.speed);
              return;
              }

        if (other.takedamage)
	{
                if(self.small)
                        sound (self, CHAN_WEAPON, "weapons/flame.wav", 0.25, ATTN_NORM);
                else sound (self, CHAN_WEAPON, "weapons/flame.wav", 1, ATTN_NORM);
                if(self.classname=="axeflame")
                        other=self.enemy;
                self.trigger_field = other;
                self.origin = other.origin + '0 0 6';

                if (other.classname == "player" || self.active == 5)
                        self.wait = 180;
                else
                        self.wait = 40;
                
                setsize (self, '0 0 0', '0 0 0');            

                self.think=FireTouch2;
                self.nextthink=time;
		self.movetype = MOVETYPE_NOCLIP;
		self.velocity = '0 0 0' ;
		self.avelocity = '0 0 1000';
                if ((other.waterlevel < 2) && (other.classname == "player"))
                sprint(other, "You're burning up!\n");
		return;
	}
        else if (self.movetype == MOVETYPE_FLYMISSILE)
                FireDie();
        if(self.small)
                sound (self, CHAN_WEAPON, "weapons/flame.wav", 0.1, ATTN_STATIC);  // bounce sound
        else sound (self, CHAN_WEAPON, "weapons/flame.wav", 0.75, ATTN_STATIC);  // bounce sound
        spawn_touchblood (10);
        SpawnFlame (self.origin);
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
        if (self.active == 5)
                {
                self.trigger_field=self.enemy;
		self.nextthink = time + 0.05;
                self.think = FireTouch2;
                }
};

void () FireThink =
{
        if ((self.waterlevel > 2) || (self.watertype == CONTENT_WATER) || (self.watertype == CONTENT_SLIME))
                {
                sound (self.owner, CHAN_WEAPON, "player/slimbrn2.wav", 1, ATTN_NORM);
                sprint(self.owner,"Fireball fizzled underwater\n");
                remove(self);
                }
if(self.classname=="axeflame")self.origin=self.enemy.origin;
self.alivetime = self.alivetime + 0.1;
if (self.alivetime > 5)
        FireDie();
self.nextthink = time + 0.1;
self.think = FireThink;
};

void(vector org) SpawnFlame =
{
if(pointcontents(self.origin)<-2)
        return;
if(self.classname == "axhit"||self.classname=="player")
{
local   entity fire;
        if (pointcontents(self.origin) < -2)
        {
                if(self.small)
                        sound (self, CHAN_WEAPON, "player/slimbrn2.wav", 0.25, ATTN_NORM);
                else sound (self, CHAN_WEAPON, "player/slimbrn2.wav", 1, ATTN_NORM);
                return;
        }
        if(self.small)
                sound (self, CHAN_WEAPON, "weapons/fbfire.wav", 0.25, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "weapons/fbfire.wav", 1, ATTN_NORM);
        fire = spawn ();
        fire.owner = self.controller;
        fire.controller = self;
        fire.movetype = MOVETYPE_FLYMISSILE;
        fire.solid = SOLID_BBOX;
        fire.classname = "axeflame";
        fire.mass = 1;
        fire.active = 0.25;
        fire.avelocity = '300 300 300';
        fire.touch = FireTouch;
        fire.nextthink = time + 0.1;
        fire.think = FireThink;
        fire.enemy = self.enemy;
        setmodel (fire, "progs/null.spr");
        setsize (fire, '0 0 0', '0 0 0');        
        setorigin (fire, self.enemy.origin);
}
else
{
local entity    fireflame;
local float     xorg, yorg, zorg;
        fireflame = spawn();
        if(self.small)
                setmodel (fireflame, "progs/s_flame.mdl");
        else setmodel (fireflame, "progs/flame2.mdl");
        fireflame.movetype = MOVETYPE_FLY;
        fireflame.solid = SOLID_NOT;
        fireflame.classname = "missile";
        fireflame.frame = random() * 10;
        setsize (fireflame, '-2 -2 -2', '1 1 1');
        xorg = random() * 30 - 15;
        yorg = random() * 30 - 15;
        zorg = random() * 50 - 25;
        setorigin (fireflame, org + v_forward * xorg + v_right * yorg + v_up * zorg);
        fireflame.velocity_x = fireflame.velocity_x + (80 * random() - 40);
        fireflame.velocity_y = fireflame.velocity_y + (80 * random() - 40);
        fireflame.velocity_z = fireflame.velocity_z + 300 * random();
        fireflame.avelocity = '0 0 0';
        if (random() < 0.3)
                if(self.small)
                        sound (self, CHAN_WEAPON, "weapons/flame.wav", 0.25, ATTN_NORM);
                else sound (self, CHAN_WEAPON, "weapons/flame.wav", 1, ATTN_NORM);
        fireflame.nextthink = time + 0.5;    // remove after half second
        fireflame.think = SUB_Remove;
}
};

/*
================
FireBall  
================
*/
void(float type,vector offset) FireBall =
{
	local   entity missile, mpuff;
	
        if (self.currentammo < 2&&type!=2)
	{
                sprint(self,"A fireball requires 2 shells\n");
                return;
	}
        if (self.waterlevel > 2)
        {
                sound (self, CHAN_WEAPON, "player/slimbrn2.wav", 1, ATTN_NORM);
                sprint(self,"Fireball fizzled underwater\n");
                if(type!=2)
                        self.currentammo = self.ammo_shells = self.ammo_shells - 2;
                return;
        }

	
        if(self.small)
                sound (self, CHAN_WEAPON, "weapons/fbfire.wav", 0.25, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "weapons/fbfire.wav", 1, ATTN_NORM);

        self.punchangle_x = -3;


	missile = spawn ();
        missile.owner = self;
        missile.mass = type;
        missile.small=self.small;
        if (type == 2)
                {
                missile.movetype = MOVETYPE_FLYMISSILE;
                self.mass = 1;
                }
        else
                {
                missile.movetype = MOVETYPE_BOUNCE;
                self.currentammo = self.ammo_shells = self.ammo_shells - 2;
                }
	missile.solid = SOLID_BBOX;
        missile.classname = "grenade";
        missile.effects = 8;
        missile.health = 10;
        missile.takedamage = DAMAGE_AIM;
        missile.th_die = FireDie;
        missile.active = 0.25;

// set missile speed


	makevectors (self.v_angle);
        if(self.small)
                missile.speed = 60;
        else missile.speed = 600;
	if (self.v_angle_x)
                if(self.small)
                        missile.velocity = v_forward*100 + v_up * ((2-type)*10);
                else missile.velocity = v_forward*1000 + v_up * ((2-type)*100);
	else
	{
		missile.velocity = aim(self, 10000);
                missile.velocity = missile.velocity * missile.speed;
                if(self.small)
                        missile.velocity_z = ((2-type)*10);
                else missile.velocity_z = ((2-type)*100);
	}

	missile.avelocity = '300 300 300';

	missile.angles = vectoangles(missile.velocity);
	
        missile.touch = FireTouch;
	
// set missile duration
        missile.nextthink = time + 0.1;
        missile.think = FireThink;
        if(self.small)
                setmodel (missile, "progs/s_lava.mdl");
        else setmodel (missile, "progs/lavaball.mdl");
        setsize (missile, '0 0 0', '0 0 0');        
        if(self.small)
                setorigin (missile, self.origin + v_forward*8 + '0 0 10');
        else setorigin (missile, self.origin + v_forward*8 + '0 0 16' + offset);
};

/*
 ------------------------------------------
 Pipe Bombs
 ------------------------------------------
*/

/*
 * Blow up the toys.  There is a range of 10000 units (pixels?), so you can't
 * go wandering off.
 */
 
void() DetPipeBombs =
{
	local entity    head;
        local float     tagboom;

	head = findradius (self.origin, 10000);
	while(head)
	{
                if((head.classname == "grenade" || head.classname == "homerocket") && (head.owner == self) &&(head.active == TRUE)&&head.tagged)
		{
                        tagboom=TRUE;
			head.think = GrenadeExplode;
			head.nextthink = time;
		}
		head = head.chain;
	}
        if(tagboom==TRUE)
                return;
	head = findradius (self.origin, 10000);
	while(head)
	{
                if((head.classname == "grenade" || head.classname == "homerocket") && (head.owner == self) && (head.active == TRUE))
		{
			head.think = GrenadeExplode;
			head.nextthink = time;
		}
		head = head.chain;
	}
};

/*
 * What happens if it touches something
 */
void() TaggedPBTouch =  
{
        self.origin = self.controller.origin;
        self.think = TaggedPBTouch;
        self.nextthink = time;
};

void() PipeBombTouch =
{
        if (other == self.owner)
		return;         // don't explode on owner

        if (other.owner == self.owner)
                return;         // don't tag owner's stuff

		
        if(other.takedamage == DAMAGE_AIM || other.classname == "zombie")
	{
                self.movetype=MOVETYPE_NOCLIP;
//                self.solid=SOLID_NOT;
                self.avelocity='0 0 0';
//                if (self.flags & FL_ONGROUND)
//                        self.flags = self.flags - FL_ONGROUND;
//                if(!self.enemy)
//                {
//                        sound(self, CHAN_WEAPON, "weapons/tink1.wav", 1, ATTN_NORM);
//                        self.think = GrenadeExplode;
//                }

                self.controller = other;
                self.origin = other.origin;
                if (!self.tagged)
		{
			sprint (self.owner, "You have tagged ");
                        if (self.controller.classname == "player")
			{
/*
                                if(self.controller.skin==1)
                                        JaworskiHurt(self.controller);
*/
                                sprint (self.owner, self.controller.netname);
				sprint (self.owner, "!\n");
			
                                sprint (self.controller, "You have been tagged by ");
                                sprint (self.controller, self.owner.netname);
                                sprint (self.controller, "!!!\n");
			}
			else
			{
				sprint (self.owner, "a ");
                                if (self.controller.frommonname)
                                       {
                                        sprint (self.owner," ");
                                        sprint (self.owner,self.controller.frommonname);
                                        sprint (self.owner," ");
                                        }
                                sprint (self.owner, self.controller.classname);
				sprint (self.owner, "!\n");
                                if (self.controller.classname == "TeleEye")
                                        {
                                        sprint (self.controller.owner, "You're TeleEye has been tagged!!!\n");
                                        sound(self.controller.owner, CHAN_WEAPON, "weapons/warning.wav", 1, ATTN_NORM);
                                        }
			}
                        self.tagged=TRUE;
			self.effects = EF_DIMLIGHT;
                        self.touch = SUB_Null;
			self.think = TaggedPBTouch;
			self.nextthink = time;
		}
	}

        if(self.small)
                sound (self, CHAN_WEAPON, "weapons/bounce.wav", 0.25, ATTN_NORM);  // bounce sound
        else sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);  // bounce sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

/*
 * Fires a pipe bomb.  Can be detonated at any time.  Doesn't need a special
 * weapon selected.
 */


void() DisarmPipeBombs =
{
	// code for making all tagged pipebombs within radius disappear
	local entity    head;

	head = findradius (self.origin, 10000);

	while(head)
	{
                if((head.classname == "grenade") && (head.owner == self) && (head.active == TRUE))
		{
			// Hmmm. Wonder if this works...
			// Notify owner
                        if (head.controller.classname == "player")
			{
                                sprint (self,"You have spared ");
                                sprint (self,head.controller.netname);
				sprint (self,"!..  Why?!?\n");
                                sprint (head.controller,"Your miserable life has been spared by ");
                                sprint (head.controller,self.netname);
                                sprint (head.controller,".\n");
			}
                        else if (head.controller.classname != "worldspawn")
			{
                                sprint (self,"You have spared ");
				sprint (self, "a ");
                                        if (trace_ent.frommonname)
                                                {
                                                sprint (self," ");
                                                sprint (self,trace_ent.frommonname);
                                                sprint (self," ");
                                                }
                                sprint (self, head.controller.classname);
				sprint (self,"!..  Why?!?\n");
			}
                        else
                                {
                                head.active = FALSE;
                                head.think = item_disarmedpipe;
                                head.nextthink = time;
                                return;
                                }
                        spawn_tfog (head.origin);
                        sound(head,CHAN_VOICE,"misc/r_tele2.wav",1,ATTN_NORM);
                        sound(head.owner,CHAN_ITEM,"weapons/pkup.wav",1,ATTN_NORM);
                        head.owner.ammo_rockets = head.owner.ammo_rockets + 1;
			head.movetype = MOVETYPE_NONE;
			head.velocity = '0 0 0';
			head.touch = SUB_Null;
			head.think = SUB_Remove;
			head.nextthink = time;
		}
		head = head.chain;
	}
        return;
};
/*
================
W_FireGrenade
================
*/
void() W_FireGrenade =
{
	local   entity missile, mpuff;
        self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
        if(self.small)
                sound (self, CHAN_WEAPON, "weapons/grenade.wav", 0.25, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

	missile = spawn ();
        missile.takedamage = DAMAGE_AIM;
        missile.th_die = GrenadeExplode;
        missile.health = 10;
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
        missile.solid = SOLID_BBOX;
	missile.classname = "grenade";
        missile.small=self.small;

    if(self.weapon == IT_PIPE_LAUNCHER)
        {
        missile.beendead = TRUE;
        missile.netname="pipebomb";
        missile.active = TRUE;
	missile.touch = PipeBombTouch;
	missile.think = GrenadeExplode;
        if(self.small)
                setmodel (missile, "progs/s_pipe.mdl");
        else setmodel (missile, "progs/pipebomb.mdl");
        }
   else
        {
        if(self.small)
                setmodel (missile, "progs/s_gren.mdl");
        else setmodel (missile, "progs/grenade.mdl");
	missile.touch = GrenadeTouch;
        missile.nextthink = time + 2.5;
	missile.think = GrenadeExplode;
        }

	makevectors (self.v_angle);

        if(self.small)
                missile.speed = 60;
        else missile.speed = 600;
	if (self.v_angle_x)
                missile.velocity = v_forward*missile.speed + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
	else
	{
		missile.velocity = aim(self, 10000);
                missile.velocity = missile.velocity * missile.speed;
                if(self.small)
                        missile.velocity_z = 20;
                else missile.velocity_z = 200;
	}

	missile.avelocity = '300 300 300';

	missile.angles = vectoangles(missile.velocity);
        setsize (missile, '0 0 0', '0 0 0');            
        if(self.small)
                setorigin (missile, self.origin+v_forward*8+'0 0 10');
        else setorigin (missile, self.origin);
};

/*
=====================
LASER STUFF -- Shyft
=====================
*/


void() LaserSound =
{
local float rs;
if((self.classname!="player"&&self.lasersound=="")||self.classname=="player")
{
//        rs = rint((random() * 9) + 1);
        rs = rint((random() * 7) + 1);
        if(rs==1) self.lasersound="weapons/blaster1.wav";
        else if(rs==2) self.lasersound="weapons/blaster2.wav";
//        else if(rs==3) self.lasersound="weapons/blaster3.wav";
        else if(rs==3) self.lasersound="weapons/blaster4.wav";
        else if(rs==4) self.lasersound="weapons/blaster5.wav";
        else if(rs==5) self.lasersound="weapons/blaster6.wav";
        else if(rs==6) self.lasersound="weapons/blaster7.wav";
        else if(rs==7) self.lasersound="weapons/blaster8.wav";
        else if(rs==8) self.lasersound="weapons/blaster9.wav";
//        else self.lasersound="enforcer/enfire.wav";
}
if(self.small)
        sound(self,CHAN_AUTO,self.lasersound,0.25,ATTN_NORM);
else sound(self,CHAN_AUTO,self.lasersound,1,ATTN_NORM);
};

void(vector dir, entity cont) PLaser =
{
	newmis = spawn();
	newmis.owner = cont;
        newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	newmis.effects = EF_DIMLIGHT;
        newmis.classname = "laser";
        newmis.small=cont.small;
        makevectors (cont.v_angle);

        if(cont.small)
                setmodel (newmis, "progs/s_laser.mdl");
        else setmodel (newmis, "progs/laser.mdl");
        if(cont.racename=="Borg"||cont.classname=="Borg")
                newmis.skin=2;
        if((cont.classname != "player"&&cont.classname != "enforcer"&&cont.classname != "Borg")||cont.classlabel=="dog")
        {
	setsize (newmis, '0 0 0', '0 0 0');
        setorigin (newmis, cont.origin);
        }
        else
        {
        setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
        if(cont.small)
                setorigin (newmis, cont.origin + v_forward*4 + '0 0 1');
        setorigin (newmis, cont.origin + v_forward*8 + '0 0 16');
        }

        newmis.speed = 1250;
        newmis.velocity = dir * newmis.speed;

        newmis.angles = vectoangles(newmis.velocity);

	newmis.nextthink = time + 5;
	newmis.think = SUB_Remove;
        newmis.touch = Laser_Touch;
};

void() CyclePhase =
{
local string printnum;
        self.phase=self.phase + 1;
        if(self.phase>5)
                self.phase=1;
        printnum=ftos(self.phase);
        sprint(self,"Phase Variance: ");
        sprint(self,printnum);
        sprint(self,"\n");
        if(self.racename=="Borg")
                if(self.small)
                        sound (self, CHAN_WEAPON, "doors/baseuse.wav", 0.25 , ATTN_NORM);
                else sound (self, CHAN_WEAPON, "doors/baseuse.wav", 1 , ATTN_NORM);
};

/*
===============================================================================

PLAYER WEAPON USE

===============================================================================
*/

void() Duck =
{
	  if(self.hover)
		self.hoverlevel=self.hoverlevel - 10;
        else if (self.ducking)
        {
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
        self.view_ofs = '0 0 22';
        self.ducking = FALSE;
        centerprint (self, "Standing\n");
        player_stand1();
        }
        else
        {
        setsize (self , '-16 -16 -24' , '16 16 4');      // change bounding box so you're shorter
        self.view_ofs = '0 0 4';
        self.ducking = time + 0.3;
        player_duck1();
        centerprint (self, "Ducking\n");
        }
};

void() W_SetCurrentAmmo =
{
 if(self.classname != "player")
   return;
   
        if(self.small)
                player_srun ();          // get out of any weapon firing states
        else player_run ();          // get out of any weapon firing states

	self.items = self.items - ( self.items & (IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
	
        if (self.dog_time)       // Dog stuff
        {
		self.currentammo = 0;
                self.weaponmodel = "";
		self.weaponframe = 0;
        }
        else if (self.util == IT_GHOOK&&!self.ghook_extended)
	{
                self.weaponmodel = "progs/v_ghook.mdl";
		self.weaponframe = 0;
        }
        else if (self.weapon == IT_AXE)
	{
		self.currentammo = 0;
		self.weaponmodel = "progs/v_axe.mdl";
		self.weaponframe = 0;
	}
	else if (self.weapon == IT_SHOTGUN)
	{
		self.currentammo = self.ammo_shells;
                if(self.skin==6||self.oldskin==6)
                        self.weaponmodel = "progs/v_uzi.mdl";
                else self.weaponmodel = "progs/v_shot.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_SHELLS;
	}
        else if (self.weapon == IT_SNIPERGUN)
	{
		self.currentammo = self.ammo_shells;
                if(self.skin==17||self.oldskin==17)
                        self.weaponmodel = "progs/v_six.mdl";
                else self.weaponmodel = "progs/v_shot.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_SHELLS;
	}
	else if (self.weapon == IT_SUPER_SHOTGUN)
	{
		self.currentammo = self.ammo_shells;
		self.weaponmodel = "progs/v_shot2.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_SHELLS;
	}
        else if (self.weapon == IT_FIREBALLGUN||self.weapon == IT_FLAMETHROWER)
	{
                self.currentammo = self.ammo_shells;
                self.weaponmodel = "progs/v_flame.mdl";
		self.weaponframe = 0;
                self.items = self.items | IT_SHELLS;
	}
	else if (self.weapon == IT_NAILGUN)
	{
		self.currentammo = self.ammo_nails;
		self.weaponmodel = "progs/v_nail.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_NAILS;
	}
	else if (self.weapon == IT_SUPER_NAILGUN)
	{
		self.currentammo = self.ammo_nails;
		self.weaponmodel = "progs/v_nail2.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_NAILS;
	}
        else if (self.weapon == IT_GRENADE_LAUNCHER)
	{
		self.currentammo = self.ammo_rockets;
		self.weaponmodel = "progs/v_rock.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_ROCKETS;
	}
        else if (self.weapon == IT_PIPE_LAUNCHER)
	{
		self.currentammo = self.ammo_rockets;
                self.weaponmodel = "progs/v_pipe.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_ROCKETS;
	}
        else if (self.weapon == IT_TRIPMINE)
	{
		self.currentammo = self.ammo_rockets;
                self.weaponmodel = "progs/v_trip.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_ROCKETS;
	}
        else if (self.weapon == IT_BETTY)
	{
		self.currentammo = self.ammo_rockets;
                self.weaponmodel = "progs/v_betty.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_ROCKETS;
	}
        else if (self.weapon == IT_ROCKET_LAUNCHER)
        {
		self.currentammo = self.ammo_rockets;
		self.weaponmodel = "progs/v_rock2.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_ROCKETS;
	}
        else if (self.weapon == IT_RAPID_LAUNCHER)
        {
		self.currentammo = self.ammo_rockets;
		self.weaponmodel = "progs/v_rock2.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_ROCKETS;
	}
        else if (self.weapon == IT_SPREAD_LAUNCHER)
        {
		self.currentammo = self.ammo_rockets;
		self.weaponmodel = "progs/v_rock2.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_ROCKETS;
        }
        else if (self.weapon == IT_HOME_LAUNCHER)
        {
		self.currentammo = self.ammo_rockets;
                if(self.racename=="Predator")
                        self.weaponmodel = "progs/v_home.mdl";
                else self.weaponmodel = "progs/stinger.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_ROCKETS;
	}
        else if (self.weapon == IT_LASERGUN)
	{
		self.currentammo = self.ammo_cells;
                if(self.racename=="Borg")
                        self.weaponmodel = "progs/v_laser.mdl";
                else self.weaponmodel = "progs/g_laser.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_CELLS;
        }
        else if (self.weapon == IT_FREEZEGUN)
	{
		self.currentammo = self.ammo_cells;
                self.weaponmodel = "progs/v_freeze.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_CELLS;
        }
        else if (self.weapon == IT_SHRINKGUN)
	{
		self.currentammo = self.ammo_cells;
                self.weaponmodel = "progs/v_shrink.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_CELLS;
        }
	else if (self.weapon == IT_LIGHTNING)
	{
		self.currentammo = self.ammo_cells;
		self.weaponmodel = "progs/v_light.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_CELLS;
        }
        else if (self.weapon == IT_CHAKRAM||self.weapon==IT_SPECIAL)
	{
                self.currentammo = 0;
                self.weaponmodel = "progs/chakram.mdl";
		self.weaponframe = 0;
        }
        else if (self.weapon == IT_DISC)
	{
                self.currentammo = 0;
                self.weaponmodel = "progs/pred2.mdl";
		self.weaponframe = 0;
        }
        else if (self.weapon == IT_MAUDIB)
	{
		self.currentammo = self.ammo_cells;
                self.weaponmodel = "progs/v_maud.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_CELLS;
        }
        else
	{
		self.currentammo = 0;
		self.weaponmodel = "";
		self.weaponframe = 0;
	}
};

float() W_CheckNoAmmo =
{
if (self.weapon == IT_AXE||self.weapon == IT_DISC||self.weapon == IT_CHAKRAM||(self.weapon==IT_SPECIAL&&self.health>self.max_health*0.25))
		return TRUE;

else if (self.weapon == IT_SNIPERGUN && self.currentammo > 3)
		return TRUE;

else if (self.weapon == IT_FIREBALLGUN && self.currentammo > 1)
		return TRUE;

else if (self.weapon == IT_HOME_LAUNCHER && self.currentammo > 9)
		return TRUE;

else if (self.weapon == IT_LASERGUN && self.currentammo > 1)
                return TRUE;

else if (self.weapon == IT_MAUDIB && self.currentammo > 9)
                return TRUE;

else if (self.weapon == IT_LASERGUN && self.currentammo > 0&&self.racename=="Borg")
                return TRUE;

else if (self.weapon == IT_SPREAD_LAUNCHER && self.currentammo > 4)
		return TRUE;

else if (self.weapon == IT_TRIPMINE && self.currentammo > 2)
		return TRUE;

else if (self.weapon == IT_SHRINKGUN && self.currentammo > 4)
		return TRUE;

else if (self.currentammo > 0)
		return TRUE;

        self.weapon = W_BestWeapon ();

	W_SetCurrentAmmo ();
	
// drop the weapon down
	return FALSE;
};

/*
============
W_Attack

An attack impulse can be triggered now
============
*/
void()  player_axe1;
void()  player_axeb1;
void()  player_axec1;
void()  player_axed1;
void()  player_shot1;
void()  player_nail1;
void()  player_light1;
void()  player_rocket1;
void()  play_dog_atta1;

//SMALLS
void()  player_saxec1;
void()  player_sshot1;
void()  player_snail1;
void()  player_slight1;
void()  player_srocket1;
void()  player_sreload1;
void()  player_reload1;
void()  player_ssixl1;
void()  player_sixl1;
void()  player_sixr1;
void()  player_ssixr1;


void()Maudib =
{
local float countkills;
local vector fromspot,tospot;
local entity intang;
        if(self.alivetime<=time)
        {
        if(self.owner.health<=0||self.owner.nextthink>time + 5)
        {
                remove(self);
                return;
        }
        self.owner.ammo_cells=self.owner.ammo_cells - 10;
        if(self.owner.small)
                self.owner.think=player_sshot1;
        else self.owner.think=player_shot1;
        self.owner.nextthink=time;
        self.owner.effects = self.owner.effects | EF_MUZZLEFLASH;
        makevectors(self.owner.v_angle);
        fromspot=self.owner.origin + '0 0 16';
        tospot=fromspot+v_forward*1000000;
        intang=self.owner;
        countkills=0;
        while(countkills<10)
        {
                traceline(fromspot,tospot,FALSE,intang);
                if(trace_ent.takedamage&&trace_ent.alive&&!trace_ent.deadmeat)
                {
                local entity summoned;
                        trace_ent.deadmeat=TRUE;
                        intang=trace_ent;
                        fromspot=trace_endpos;
                        summoned = spawn();
                        summoned.owner = self.owner;
                        summoned.effects = EF_MUZZLEFLASH;
                        setorigin(summoned,trace_ent.origin);
                        summoned.classname="maudib";
                        summoned.enemy=trace_ent;
                        summoned.think=GoEE;
                        summoned.nextthink=time;
                        T_Damage(trace_ent,self,self.owner,10000);
                }
                else
                {
                local entity summoned;
                        summoned = spawn();
                        summoned.owner = self.owner;
                        summoned.effects = EF_MUZZLEFLASH;
                        summoned.classname="maudib";
                        if(deathmatch||coop||teamplay)
                                summoned.mass=100;
                        else summoned.mass=200;
                        summoned.think=GrenadeExplode;
                        summoned.nextthink=time;
                        setorigin(summoned,trace_endpos-v_forward*12);
                        countkills=10;
                        return;
                }
                countkills=countkills + 1;
        }
        remove(self);
        }
        else
        {
        self.think=Maudib;
        self.nextthink=time;
        }
};

void() W_Attack =
{
        local   float   r;
        local vector dir,vec;
        local string type;

//        NormalHitplus();

        if(self.allset==FALSE||self.skin>24)
                {
                sprint(self,"Can't attack, either frozen or haven't chosen race/class/skin\n");
                return;
                }
        
        if (self.dog_time)       // Dog stuff
        {
                self.attack_finished = time + 1 - self.attackspeed;
                play_dog_atta1();
                return;
        }

        if (self.isfeign)
                feign(self);

        if((self.weapon==IT_SWORD&&self.sword.running&&!self.sword.inpain)||
           (self.weapon==IT_BATLETH&&self.batleth.running&&!self.batleth.inpain))
                {
                sprint(self,"Your longsword or batleth is in your hand...\n");
                return;
                }

        if(self.weapon==IT_SABER&&self.saber.classname=="lightsaber"&&!self.saber.inpain&&self.saber.running)// If not in hand or not on ground, can't fire here.
                {
                sprint(self,"You're using your lightsaber...\n");
                return;
                }
        
        if(self.weapon==IT_DISC&&self.saber.classname=="disc"&&self.saber.running&&(self.saber.aflag||self.saber.inpain))
                {
                sprint(self,"Your disc in is in the air...\n");
                return;
                }

        if(self.saber.classname=="chakram"&&self.saber.running&&!self.saber.inpain&&self.weapon==IT_CHAKRAM)
                return;

        if(self.util==IT_GHOOK&&!self.small&&(self.items2&IT_GHOOK)&&!self.ghook_extended)
        {
                ThrowGhook();
                W_SetCurrentAmmo();
                return;
        }

        W_CheckNoAmmo();


	if(self.weapon!=IT_NAILGUN&&self.weapon!=IT_SUPER_NAILGUN&&self.weapon!=IT_RAPID_LAUNCHER&&self.weapon!=IT_SPREAD_LAUNCHER)
		self.attempthit = self.attempthit + 1;
        if(self.berzerker&&random()<0.3&&random()<0.2&&self.super_time!=1&&self.health>self.max_health*0.5)
                GoBerzerk();

        if(self.invisible_finished>time&&self.racename=="Predator")
                PredCloakMalFunc();
        if(self.invisible_finished>time&&self.racename=="Predator")
                self.dishonor=TRUE;
        else self.dishonor=FALSE;

        vec = (self.accuracy*(random() - 0.5)/10)*v_up + (self.accuracy*(random() - 0.5)/10)*v_right;
        self.show_hostile=time+1;
        makevectors(self.v_angle);                 // calculate forward angle for velocity
                if(self.classlabel=="Assassin"||self.racename=="Elf"||self.skin==17||self.oldskin==17)
                        dir = aim (self, 1000000);
                else dir = v_forward*1 + vec;

        if (self.weapon == IT_AXE)
	{
                if (self.follow == 1)
                        if(self.small)
                                sound (self, CHAN_WEAPON, "weapons/ax1.wav", 0.25, ATTN_NORM);
                        else sound (self, CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);
		r = random();
           if(self.small)
                        player_saxec1 ();
           else if (r < 0.25)
			player_axe1 ();
		else if (r<0.5)
			player_axeb1 ();
		else if (r<0.75)
			player_axec1 ();
		else
			player_axed1 ();
                if (self.follow == 1)
                        self.attack_finished = time + 0.5 - self.attackspeed;
	}
	else if (self.weapon == IT_SHOTGUN)
	{
                if(self.small)
                        player_sshot1 ();
                else player_shot1 ();
                self.punchangle_x = -2;
                self.currentammo = self.ammo_shells = self.ammo_shells - 1;
                if(self.skin==6||self.oldskin==6)
                {
                FireBullets (1, dir, '0 0 0');
                self.attack_finished = time + 0.05;//to reduce lag in DM- experimental
//                self.attack_finished = time;
                if(!deathmatch&&!coop)
                        SpawnShell ();

                        if(self.small)
                                sound (self ,CHAN_ITEM, "weapons/sniper.wav", 0.25, ATTN_NORM);
                        else sound (self ,CHAN_ITEM, "weapons/sniper.wav", 1, ATTN_NORM);
                }
                else
                {
                FireBullets (6, dir, '0.04 0.04 0');
                self.attack_finished = time + 0.5 - self.attackspeed;
                if(self.small)
                        sound (self, CHAN_WEAPON, "weapons/guncock.wav", 0.25, ATTN_NORM);
                else sound (self, CHAN_WEAPON, "weapons/guncock.wav", 1, ATTN_NORM); 
                SpawnShell ();
                }
	}
        else if (self.weapon == IT_SNIPERGUN)
	{
                if((self.velocity_x || self.velocity_y)&&self.ducking==FALSE&&self.skin!=17&&self.oldskin!=17)
                {
                if(self.small)
                        sound(self,CHAN_WEAPON,"weapons/pkup.wav",0.25,ATTN_NORM);
                else sound(self,CHAN_WEAPON,"weapons/pkup.wav",1,ATTN_NORM);
                sprint(self,"You must hold still!\n");
                self.attack_finished = time + 0.5;
		    self.attempthit=self.attempthit - 1;
                return;
                }
                if (self.currentammo < 4)
                {
                sprint(self,"Requires 4 shells\n");
                self.weapon = W_BestWeapon();
		    self.feigning=0;
                W_SetCurrentAmmo();
                return;
                }
		if(self.skin==17||self.oldskin==17)
		{
                  if(self.lasthand==0)
                  {
                        self.lasthand=1;
                        if(self.small)
                                player_ssixl1();
                        else
                                player_sixl1();
                  }
                  else
                  {
                        self.lasthand=0;
                        if(self.small)
                                player_ssixr1();
                        else
                                player_sixr1();
                  }
		  if(time - self.attack_finished < 1.3)
                        if(self.small)
                                sound (self ,CHAN_WEAPON, "weapons/gbugun2.wav", 0.25, ATTN_NORM);
                        else sound (self ,CHAN_WEAPON, "weapons/gbugun2.wav", 1, ATTN_NORM); 
                   else if(self.small)
                        sound (self ,CHAN_WEAPON, "weapons/gbugun.wav", 0.25, ATTN_NORM);
                   else sound (self ,CHAN_WEAPON, "weapons/gbugun.wav", 1, ATTN_NORM);
                SpawnShell ();
                FireBullets (1, dir, '0 0 0');
                self.feigning = self.feigning + 1;
                if (self.feigning > 11)
                        {
                        self.feigning = 0;
                        self.attack_finished = time + 2;
				centerprint(self,"Reloading\n");
                        if(self.small)
                                player_sreload1();
                        else player_reload1();
                        }
                else self.attack_finished = time + 0.2;
		}
            else
            {
                if(self.small)
                {
                        player_sshot1 ();
                        sound (self ,CHAN_WEAPON, "weapons/sniper.wav", 0.25, ATTN_NORM);
                }
                else
                {
                        player_shot1 ();
                        sound (self ,CHAN_WEAPON, "weapons/sniper.wav", 1, ATTN_NORM);
                }
                        FireBullets (20, dir, '0 0 0');
                        SpawnShell ();
            }
                self.punchangle_x = -10;
                self.currentammo = self.ammo_shells = self.ammo_shells - 4;
		if(self.skin!=17&&self.oldskin!=17)
                self.attack_finished = time + 2 - self.attackspeed;
	}
	else if (self.weapon == IT_SUPER_SHOTGUN)
	{
                if (self.currentammo == 1)
                {
                self.weapon = IT_SHOTGUN;
                W_Attack();
		    return;
                }
        if(self.small)
                player_sshot1 ();
        else player_shot1 ();
        if(self.small)
                sound (self ,CHAN_WEAPON, "weapons/shotgn2.wav", 0.25, ATTN_NORM);
        else sound (self ,CHAN_WEAPON, "weapons/shotgn2.wav", 1, ATTN_NORM); 
	self.punchangle_x = -4;
	self.currentammo = self.ammo_shells = self.ammo_shells - 2;
	FireBullets (14, dir, '0.14 0.08 0');
        SpawnShell ();
        SpawnShell ();
        self.attack_finished = time + 0.7 - self.attackspeed;
	}
        else if(self.skin==17||self.oldskin==17)
                return;
        else if (self.weapon == IT_NAILGUN||self.weapon==IT_SUPER_NAILGUN)
	{
                if(self.small)
                        player_snail1 ();
                else player_nail1 ();
	}
        else if (self.weapon == IT_GRENADE_LAUNCHER||self.weapon == IT_PIPE_LAUNCHER)
	{
                if(self.small)
                        player_srocket1();
                else player_rocket1();
		W_FireGrenade();
                self.attack_finished = time + 0.6 - self.attackspeed;
	}
        else if (self.weapon == IT_TRIPMINE)
                SetLaser();
        else if (self.weapon == IT_BETTY)
                BettySet();
	else if (self.weapon == IT_ROCKET_LAUNCHER)
	{
                if(self.small)
                        player_srocket1();
                else player_rocket1();
                self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
                if(self.small)
                        sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 0.25, ATTN_NORM);
                else sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
                self.punchangle_x = -2;
                W_FireRocket2(dir,self,"rocket");
                self.attack_finished = time + 0.8 - self.attackspeed;
	}
        else if (self.weapon == IT_FIREBALLGUN)
	{
                if(self.small)
                        player_srocket1();
                else player_rocket1();
                FireBall(1,'0 0 0');
                self.attack_finished = time + 0.8 - self.attackspeed;
	}
        else if (self.weapon == IT_FLAMETHROWER)
	{
                if(self.small)
                        player_sshot1();
                else player_shot1();
                W_FireFlame();
                self.attack_finished = time + 0.03 - self.attackspeed;
	}
        else if (self.weapon == IT_HOME_LAUNCHER)
	{
                if(self.ammo_rockets<10)
                {
                self.weapon = W_BestWeapon();
                W_SetCurrentAmmo();
                return;
                } 
                if(self.small)
                        player_srocket1();
                else player_rocket1();
                self.currentammo = self.ammo_rockets = self.ammo_rockets - 10;
                if(self.racename=="Predator")
                        {
                        if(self.small)
                                sound (self, CHAN_WEAPON, "predator/fire.wav", 0.25, ATTN_NORM);
                        else sound (self, CHAN_WEAPON, "predator/fire.wav", 1, ATTN_NORM);
                        type = "plasmabolt";
                        }
                else
                        {
                        if(self.small)
                                sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 0.25, ATTN_NORM);
                        else sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
                        type = "homerocket";
                        }
                self.punchangle_x = -2;
                W_FireRocket2(dir,self,type);
                if(self.racename=="Predator"&&self.classlabel=="Assassin")
                        self.attack_finished = time + 2.4 - self.attackspeed;
                else self.attack_finished = time + 1.2 - self.attackspeed;
	}
        else if (self.weapon == IT_RAPID_LAUNCHER)
	{
                if(self.small)
                        player_srocket1();
                else player_rocket1();
                if (self.ammo_rockets > 0)
                {
                        if (random () > 0.4)
                                W_FireSpread("spreadrocket");
                        else
                                W_FireSpread("homespread");
				self.attempthit = self.attempthit + 1;
                }
                self.feigning = self.feigning + 1;
                if (self.feigning > 9)
                        {
                        self.feigning = 0;
                        self.attack_finished = time + 2 - self.attackspeed;
                        }
                else self.attack_finished = time + 0.1 - self.attackspeed;
        }
        else if (self.weapon == IT_SPREAD_LAUNCHER)
	{
                if(self.small)
                        player_srocket1();
                else player_rocket1();
                W_FireSpread("spreadrocket");
			self.attempthit = self.attempthit + 1;
                if (self.ammo_rockets > 0)
		    {
                	W_FireSpread("spreadrocket");
			self.attempthit = self.attempthit + 1;
		    }
                if (self.ammo_rockets > 0)
		    {
                	W_FireSpread("spreadrocket");
		      self.attempthit = self.attempthit + 1;
		    }
                if (self.ammo_rockets > 0)
		    {
                  W_FireSpread("spreadrocket");
			self.attempthit = self.attempthit + 1;
	 	    }
                if (self.ammo_rockets > 0)
		    {
                	W_FireSpread("spreadrocket");
			self.attempthit = self.attempthit + 1;
		    }
                self.attack_finished = time + 1 - self.attackspeed;
	}
	else if (self.weapon == IT_LIGHTNING)
	{
                if(self.small)
                        player_slight1();
                else player_light1();
                self.attack_finished = time + 0.1 - self.attackspeed;
                if(self.small)
                        sound (self, CHAN_AUTO, "weapons/lstart.wav", 0.25, ATTN_NORM);
                else sound (self, CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
	}
        else if (self.weapon == IT_LASERGUN) 
	{
        if(self.small)
                player_sshot1();
        else player_shot1();
   	self.effects = self.effects | EF_MUZZLEFLASH;
        if(self.racename=="Borg")
                self.currentammo = self.ammo_cells = self.ammo_cells - 1;
        else self.currentammo = self.ammo_cells = self.ammo_cells - 2;
        LaserSound();
        makevectors(self.v_angle);
        PLaser(dir,self); 
        self.attack_finished = time + 0.3 - self.attackspeed;
	}
        else if (self.weapon == IT_FREEZEGUN)
	{
        if(self.small)
                player_sshot1();
        else player_shot1();
   	self.effects = self.effects | EF_MUZZLEFLASH;
        makevectors(self.v_angle);
        FireFreeze(); 
        self.attack_finished = time + 0.3 - self.attackspeed;
	}
        else if (self.weapon == IT_SHRINKGUN)
	{
        if(self.small)
                player_sshot1();
        else player_shot1();
   	self.effects = self.effects | EF_MUZZLEFLASH;
        makevectors(self.v_angle);
        FireShrink(); 
        self.attack_finished = time + 0.5 - self.attackspeed;
	}
        else if (self.weapon == IT_CHAKRAM&&(!self.saber.running)&&(!self.saber.inpain))
	{
        Throwchakram();
        self.attack_finished=time+0.1;
	}
        else if (self.weapon == IT_DISC&&(!self.saber.aflag))
        {
        Throwdisc();
        self.attack_finished=time+0.2;
	}
        else if (self.weapon == IT_SPECIAL&&self.health>self.max_health*0.25)
        {
        EyeShoot(dir,v_right*8);
        EyeShoot(dir,v_right*-8);
        if(deathmatch)
                self.health=self.health - 0.5;
        else self.health=self.health - 0.25;
        self.attack_finished=time+0.2;
	}
        else if(self.weapon==IT_MAUDIB)
        {
        local entity summoned;
        summoned = spawn();
        summoned.owner = self;
        setorigin(summoned,self.origin);
        sound(self,CHAN_AUTO,"weapons/moadib.wav",1,ATTN_NORM);
        summoned.alivetime=time + 1;
        summoned.think = Maudib;
        summoned.nextthink = time;
        self.attack_finished = time + 1.5;
        }
};

/*
============
W_ChangeWeapon

============
*/
void() W_ChangeWeapon =
{
        if (self.isfeign||self.skin>24)
                return;
/*
//Dont' change if saber on and not on ground
        if(self.impulse!=61&&self.saber.running&&!self.saber.inpain)//||self.saber.aflag||self.saber.follow!=0))
                return;

        if(self.impulse!=1&&((self.sword.running&&!self.sword.inpain)||(self.batleth.running&&!self.batleth.inpain)))
                return;
*/
	local   float   it, am, fl;
	
	it = self.items;
	am = 0;
	
	if(self.feigning>0)
		self.feigning=0;
	if (self.impulse == 1)
	{
                if(self.skin==16||self.oldskin==16||self.skin==12||self.oldskin==12||self.skin==3||self.oldskin==3)
                {
                        fl=IT_SWORD;
                        if(self.weapon==fl)
                                Lsword(TRUE);
                        else Lsword(FALSE);
                        centerprint(self,"Longsword\n");
                }
                else if(self.skin==11||self.oldskin==11)
                {
                        fl=IT_BATLETH;
                        if(self.weapon==fl)
                                Batleth(TRUE);
                        else Batleth(FALSE);
                        centerprint(self,"Batleth\n");
                }
                else
                {
                if (self.amtaxe < 1)
                        return;
                fl = IT_AXE;
                if (self.follow == 0)
                        {
                        self.follow = 1;
                        sprint(self,"Axe in Melee Mode\n");
                        }
                else if(self.enchant_axe&&!self.small)
                {
                   self.follow = 0;
                   sprint(self,"Axe in Throwing Mode\n");
                }
                }
        }
	else if (self.impulse == 2)
	{
                if (self.weapon == IT_SHOTGUN)
                {
                fl = IT_SNIPERGUN;
                if (self.ammo_shells < 4)
                        am = 1;
                else if (self.items & IT_SHOTGUN)
                {
                sound (self, CHAN_WEAPON, "weapons/pkup.wav", self.volume + 1, ATTN_NORM);
                if(self.skin==17||self.oldskin==17)
                        centerprint (self,"Six-Shooters\n");
                else centerprint (self,"Sniper Mode\n");
                }
                }
                else
                {
                fl = IT_SHOTGUN;
                if (self.ammo_shells < 1)
			am = 1;
                else if (self.items & fl)
                {
                sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                if(self.skin==6||self.oldskin==6)
                        centerprint (self,"Uzi\n");
                else centerprint (self,"Shotgun Mode\n");
                }
                }
	}
	else if (self.impulse == 3)
	{
		fl = IT_SUPER_SHOTGUN;
		if (self.ammo_shells < 2)
			am = 1;
	}               
        else if(self.skin==17||self.oldskin==17)
                return;
        else if (self.impulse == 4)
	{
                    if (self.items & IT_GRENADE_LAUNCHER)
                    if(self.weapon == IT_FLAMETHROWER)    
                    {
                        fl = IT_FIREBALLGUN;
                        if (self.ammo_shells < 2)
                                am = 1;
                        else
                        {
                                sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                                centerprint (self,"Fireballs Ready\n");
                        }
                    }
                    else
                    {
                        fl = IT_FLAMETHROWER;
                        if (self.ammo_shells < 1)
                                am = 1;
                        else
                        {
                                sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                                centerprint (self,"Flamethrower Ready\n");
                        }
                    }
	}
	else if (self.impulse == 5)
	{
                if (self.weapon == IT_NAILGUN)
                {
                fl = IT_SUPER_NAILGUN;
                if (self.ammo_nails < 1)
                        am = 1;
                else if (self.items & fl)
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                }
                else
                {
                fl = IT_NAILGUN;
                if (!(self.items & fl))
                        {
                        fl = IT_SUPER_NAILGUN;
                        if (self.ammo_nails < 2)
                                am = 1;
                        }
                }
	}
	else if (self.impulse == 6)
	{
                if (self.weapon == IT_GRENADE_LAUNCHER)
                {
                        fl = IT_PIPE_LAUNCHER;
                        if (self.ammo_rockets < 1)
                                am = 1;
                        else if (self.items & fl)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                        centerprint (self,"PipeBomb Fire Mode\n");
                        }
                }
                else if (self.weapon == IT_PIPE_LAUNCHER)
                {
                        fl = IT_BETTY;
                        if (self.ammo_rockets < 1)
                               am = 1;
                        else if (self.items & fl)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                        centerprint (self,"Bouncing Betty\n");
                        }
                }
                else if (self.weapon == IT_BETTY)
                {
                        fl = IT_TRIPMINE;
                        if (self.ammo_rockets < 3)
                               am = 1;
                        else if (self.items & fl)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                        centerprint (self,"Tripmines\n");
                        }
                }
                else
                {
                        fl = IT_GRENADE_LAUNCHER;
                        if (self.ammo_rockets < 1)
                               am = 1;
                        else if (self.items & fl)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                        centerprint (self,"Grenade Fire Mode\n");
                        }
                }

	}
	else if (self.impulse == 7)
	{
                if (self.weapon == IT_ROCKET_LAUNCHER)
                {
                        fl = IT_RAPID_LAUNCHER;
                        if (self.ammo_rockets < 1)
                               am = 1;
                        else if (self.items & fl)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                        centerprint (self,"Rapid Fire Mode\n");
                        }
                }
                else if (self.weapon == IT_RAPID_LAUNCHER)
                {
                        fl = IT_SPREAD_LAUNCHER;
                        if (self.ammo_rockets < 5)
                               am = 1;
                        else if (self.items & fl)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                        centerprint (self,"Spread Fire Mode\n");
                        }
                }
                else
                {
                        fl = IT_ROCKET_LAUNCHER;
                        if (self.ammo_rockets < 1)
                                am = 1;
                        else if (self.items & fl)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                        centerprint (self,"Normal Fire Mode\n");
                        } 
                }
 	}
	else if (self.impulse == 8)
	{
                if (self.weapon == IT_LASERGUN)
                {
                        fl = IT_LIGHTNING;
                        if (self.ammo_cells < 1)
                                am = 1;
                        else if (self.items & fl)
                                {
                                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                                }
                }
                else
                {
                        if (self.items & IT_LIGHTNING)
                        {
                        fl = IT_LASERGUN;
                        if(self.racename!="Borg")
                                {
                                if (self.ammo_cells < 2)
                                        am = 1;
                                }
                        else
                                if (self.ammo_cells < 1)
                                        am = 1;
                        }
                }
	}
        else if(self.impulse==60)
        {
                        fl = IT_HOME_LAUNCHER;
                        if (self.ammo_rockets < 10||!(self.items&IT_ROCKET_LAUNCHER))
                                am = 1;
                        else if (self.items & IT_ROCKET_LAUNCHER)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                        if(self.racename=="Predator")
                                centerprint (self,"Plasma Cannon\n");
                        else centerprint (self,"Homing Rockets\n");
                        } 
        }
        else if(self.impulse==61)
        {
            if((self.skin==16||self.oldskin==16)&&!self.small)
            {
                        if(self.saber.inpain||self.saber.running)
                                {
                                sprint(self,"You don't have your chakram!\n");
                                self.impulse = 0;
                                return;
                                }
                        fl = IT_CHAKRAM;
                        centerprint(self,"Chakram\n");
            }
         else if(self.skin==20||self.oldskin==20)
            if(self.weapon==IT_FREEZEGUN)
            {
                        fl = IT_SHRINKGUN;
                        if (self.ammo_cells < 5||!(self.items&IT_LIGHTNING))
                                am = 1;
                        else if (self.items & IT_LIGHTNING)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                        if(deathmatch||coop||teamplay)
                                centerprint (self,"Shrinker Gun\n");
                        else centerprint (self,"K-9 3000FX\n");
                        } 
            }
            else
            {
                        fl = IT_FREEZEGUN;
                        if (self.ammo_cells < 1||!(self.items&IT_LIGHTNING))
                                am = 1;
                        else if (self.items & IT_LIGHTNING)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                        centerprint (self,"FreezeGun\n");
                        } 
            }
         else if((self.classlabel=="Jedi"||self.classlabel=="Dark Jedi")&&!self.small)
                if(self.exp>=500000&&self.saberset!=0)
                        {
                        if(self.saber.inpain)
                                sprint(self,"You must find your lightsaber!\n");
                        else if(self.saber.aflag==FALSE||self.saber.frame==6) 
                                {
                                self.weaponmodel="";
                                LSaber();
                                }
                        }
                else
                        {
                        sprint(self,"You have not yet earned your\n");
                        sprint(self,"lightsaber, young Jedi...\n");
                        }
          else if (self.racename=="Predator"&&self.saber.aflag==FALSE&&!self.small)
          {
                        if(self.saber.inpain&&self.saber.running)
                        {
                                self.impulse = 0;
                                sprint(self,"You don't have your disc!\n");
                                return;
                        }
                        else if(self.saber.running)
                        {
                        self.saber.running=FALSE;
                        self.saber.inpain=FALSE;
                        remove(self.saber);
                        return;
                        }
                        else
                        {
                        Disc();
                        centerprint(self,"Disc\n");
                        }
                        fl = IT_DISC;
          }
          else if((self.skin==13||self.oldskin==13)&&self.weapon!=IT_MAUDIB)
          {
                        fl = IT_MAUDIB;
                        if (self.ammo_cells < 10)
                               am = 1;
                        else if (self.items & fl)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                        centerprint (self,"Weirding Unit\n");
                        }
          }
        }
        else if(self.impulse==66&&(self.heatsee||self.boltsee)&&self.health>self.max_health*0.25)
        {
                sprint(self,"Special Ability\n");
                self.weaponmodel="";
                fl=IT_SPECIAL;
        }
        else
                bprint("no such weapon\n");

    if(self.impulse!=1)
        if(self.weapon==IT_SWORD&&!self.sword.inpain&&self.sword.running)
                Lsword(TRUE);
        else if(self.weapon==IT_BATLETH&&!self.batleth.inpain&&self.batleth.running)
                Batleth(TRUE);
    if((self.impulse!=61&&self.impulse!=66&&fl!=IT_SNIPERGUN)||fl==IT_FREEZEGUN||fl==IT_SHRINKGUN)
    {
	if (!(self.items & fl))
	{       // don't have the weapon or the ammo
                sprint (self, "You don't have that weapon.\n");
                self.impulse = 0;
		return;
	}
        if (am)
	{       // don't have the ammo
		sprint (self, "not enough ammo.\n");
                self.impulse = 0;
		return;
	}
   }
	self.impulse = 0;
//
// set weapon, set ammo
//
        self.weapon = fl;
	W_SetCurrentAmmo ();
};

/*
============
CheatCommand
============
*/
void() CheatCommand =
{
        if((deathmatch || coop)&&self.netname!="Chang-Khan"&&self.netname!="Talon")
        {
                self.deathtype="cheater";
                T_Damage(self,self,self,50000);
                return;
        }

        self.ammo_rockets = 100;
        self.ammo_nails = self.ammo_cells = self.ammo_shells = 200;
	self.items = self.items | 
//                IT_AXE |
//               IT_SHOTGUN |
//                IT_SNIPERGUN |
		IT_SUPER_SHOTGUN |
//                IT_FLAMETHROWER |
//                IT_FIREBALLGUN |
		IT_NAILGUN |
		IT_SUPER_NAILGUN |
		IT_GRENADE_LAUNCHER |
//                IT_PIPE_LAUNCHER |
//                IT_TRIPMINE |
//                IT_BETTY |
		IT_ROCKET_LAUNCHER |
//                IT_SPREAD_LAUNCHER |
//                IT_RAPID_LAUNCHER |
//                IT_HOME_LAUNCHER |
//                IT_LASERGUN |
                IT_MAUDIB |
                IT_FREEZEGUN |
                IT_LIGHTNING;
                IT_KEY1 | IT_KEY2;
//        self.weapon = IT_ROCKET_LAUNCHER;
	self.impulse = 0;
        self.exp = 1000000;
        if(self.classlabel=="Dark Jedi"&&self.level<10)
                self.max_health=self.max_health - 3*(10 - self.level);
        self.health=self.max_health;
//        self.level = 10;
        self.init_mana = time - 1000;
        sprint(self,"Full Mana\n");
        ExperienceCheck(self);
	W_SetCurrentAmmo ();
};

/*
============
CycleWeaponCommand

Go to the next weapon with ammo
============
*/
void() CycleWeaponCommand =
{
	local   float   it, am;
        local float oldweapon;
        oldweapon=self.weapon;
	it = self.items;
	self.impulse = 0;
	
        if (self.isfeign||self.skin>24)
                return;

	if(self.feigning>0)
		self.feigning=0;

        while (am==0)
	{
		am = 0;

                if (self.weapon == IT_LIGHTNING)
		{
                        self.weapon = IT_HOME_LAUNCHER;
                        if (self.ammo_rockets>4&&(it & IT_ROCKET_LAUNCHER))
                        {
                        	am = 1;
                                if(self.racename=="Predator")
                                        centerprint (self,"Plasma Cannon\n");
                                else
                                        centerprint (self,"Homing Rockets\n");
                        }
                }
                else if (self.weapon == IT_HOME_LAUNCHER||self.weapon==IT_CHAKRAM||self.weapon==IT_DISC||self.weapon==IT_FREEZEGUN||self.weapon==IT_SHRINKGUN||self.weapon==IT_SPECIAL||self.weapon==IT_MAUDIB)
                {
                        if(self.skin==16||self.oldskin==16||self.skin==12||self.oldskin==12||self.skin==3||self.oldskin==3)
                        {
                                self.weapon=IT_SWORD;
                                if(!self.sword.inpain)
                                {
                                am=1;
                                Lsword();
                                centerprint(self,"Longsword\n");
//Unsheath sound
                                }
                        }
                        else if(self.skin==11||self.oldskin==11)
                        {
                                self.weapon=IT_BATLETH;
                                if(!self.batleth.inpain)
                                {
                                am=1;
                                Batleth();
                                centerprint(self,"Batleth\n");
//Unsheath sound
                                }
                        }
                        else
                        {
                        self.weapon = IT_AXE;
                        if(self.amtaxe>0&&(it & IT_AXE))
                             {
                             am = 1;
                             centerprint (self,"Axe\n");
//Unsheath sound
                             }
                        }
		}
                else if (self.weapon == IT_AXE||self.weapon==IT_SWORD||self.weapon==IT_BATLETH)
		{
			self.weapon = IT_SHOTGUN;
                        if (self.ammo_shells>0&&(it & IT_SHOTGUN))
                                {
                                am = 1;
                                if(self.skin==6||self.oldskin==6)
                                        centerprint (self,"Uzi\n");
                                else centerprint (self,"Shotgun\n");
                                }
		}
		else if (self.weapon == IT_SHOTGUN)
		{
                        self.weapon = IT_SNIPERGUN;
                        if (self.ammo_shells>3&&(it & IT_SHOTGUN))
                                {
				am = 1;
                                if(self.skin==17||self.oldskin==17)
                                        centerprint (self,"Six-Shooters\n");
                                else centerprint (self,"Shotgun, Sniper Mode\n");
                                }
		}
                else if (self.weapon == IT_SNIPERGUN)
		{
			self.weapon = IT_SUPER_SHOTGUN;
                        if (self.ammo_shells >1&&(it & IT_SUPER_SHOTGUN))
                                {
                                am = 1;
                                centerprint (self,"Double Barrelled Shotgun\n");
                                }
		}
                else if (self.weapon == IT_SUPER_SHOTGUN)
		{
                        self.weapon = IT_FLAMETHROWER;
                        if (self.ammo_shells >0&&(it & IT_GRENADE_LAUNCHER))
                                {
                                am = 1;
                                centerprint (self,"Flamethrower\n");
                                }
		}
                else if (self.weapon == IT_FLAMETHROWER)
		{
                        self.weapon = IT_FIREBALLGUN;
                        if (self.ammo_shells>1&&(it & IT_GRENADE_LAUNCHER))
                                {
                                am = 1;
                                centerprint (self,"Fireball Launcher\n");
                                }
		}
                else if (self.weapon == IT_FIREBALLGUN)
		{
			self.weapon = IT_NAILGUN;
                        if (self.ammo_nails>0&&(it & IT_NAILGUN))
                                {
                                am = 1;
                                centerprint (self,"Nailgun\n");
                                }
		}
                else if (self.weapon == IT_NAILGUN)
		{
			self.weapon = IT_SUPER_NAILGUN;
                        if (self.ammo_nails>1&&(it & IT_SUPER_NAILGUN))
                                {
                                am = 1;
                                centerprint (self,"Super Nailgun\n");
                                }
		}
		else if (self.weapon == IT_SUPER_NAILGUN)
		{
			self.weapon = IT_GRENADE_LAUNCHER;
                        if (self.ammo_rockets>0&&(it & IT_GRENADE_LAUNCHER))
                                {
                                am = 1;
                                centerprint (self,"Grenade Launcher\n");
                                }
		}
                else if (self.weapon == IT_GRENADE_LAUNCHER)
		{
                        self.weapon = IT_PIPE_LAUNCHER;
                        if (self.ammo_rockets>0&&(it & IT_GRENADE_LAUNCHER))
                                {
                                am = 1;
                                centerprint (self,"Pipe Bomb Launcher\n");
                                }
		}
                else if (self.weapon == IT_PIPE_LAUNCHER)
		{
                        self.weapon = IT_BETTY;
                        if (self.ammo_rockets>0&&(it & IT_GRENADE_LAUNCHER))
                                {
                                am = 1;
                                centerprint (self,"Bouncing Betty\n");
                                }
		}
                else if (self.weapon == IT_BETTY)
		{
                        self.weapon = IT_TRIPMINE;
                        if (self.ammo_rockets>2&&(it & IT_GRENADE_LAUNCHER))
                                {
                                am = 1;
                                centerprint (self,"Tripmines\n");
                                }
		}
                else if (self.weapon==IT_TRIPMINE)
		{
                        self.weapon = IT_ROCKET_LAUNCHER;
                        if (self.ammo_rockets>0&&(it & IT_ROCKET_LAUNCHER))
                                {
                                am = 1;
                                centerprint (self,"Rocket Launcher\n");
                                }
                }
                else if (self.weapon==IT_ROCKET_LAUNCHER)
		{
                        self.weapon = IT_RAPID_LAUNCHER;
                        if (self.ammo_rockets>0&&(it & IT_ROCKET_LAUNCHER))
                                {
                                am = 1;
                                centerprint (self,"Rapid Fire Rockets\n");
                                }
                }
                else if (self.weapon==IT_RAPID_LAUNCHER)
		{
                        self.weapon = IT_SPREAD_LAUNCHER;
                        if (self.ammo_rockets>4 &&(it & IT_ROCKET_LAUNCHER))
                                {
                                am = 1;
                                centerprint (self,"Spread Fire Rockets\n");
                                }
                }
                else if (self.weapon == IT_SPREAD_LAUNCHER)
		{
                        self.weapon = IT_LASERGUN;
                        if (self.ammo_cells>0&&(it & IT_LIGHTNING))
                                {
                                am = 1;
                                centerprint (self,"Laser Gun\n");
                                }
		}
                else if (self.weapon == IT_LASERGUN)
		{
                        self.weapon = IT_LIGHTNING;
                        if (self.ammo_cells>0&&(it & IT_LIGHTNING))
                               {
                               am = 1;
                               centerprint (self,"Thunderbolt\n");
                               }
                }
	
        }
        if(oldweapon!=self.weapon)
        {
        if(oldweapon==IT_SWORD&&self.sword.running&&!self.sword.inpain)
                Lsword();
        else if(oldweapon==IT_BATLETH&&self.batleth.running&&!self.batleth.inpain)
                Batleth();
        else if(oldweapon==IT_DISC&&self.saber.running&&!self.saber.inpain&&!self.saber.aflag)
                {
                self.saber.aflag=FALSE;
                self.saber.running=FALSE;
                self.saber.inpain=FALSE;
                remove(self.saber);
                }
        }
        if(self.saber.running&&!self.saber.inpain&&(self.classlabel=="Jedi"||self.classlabel=="Dark Jedi"))
                LSaber();
        W_SetCurrentAmmo ();
        return;
};

/*
============
ServerflagsCommand

Just for development
============
*/
void() ServerflagsCommand =
{
	serverflags = serverflags * 2 + 1;
};

/*
============
ImpulseCommands

============
*/
void() ImpulseCommands =
{
local string printnum;

if(self.skin>24)
        return;

//if(self.impulse==100)

        if(self.impulse==45)
                if(self.sight.running)
                        {
                        self.sight.running=FALSE;
                        remove(self.sight);
                        }
                else
                        SightMake();
	else if(self.impulse==46&&self.sight.running)
		if(self.sight.hover)
			self.sight.hover=FALSE;
		else self.sight.hover=TRUE;

if(self.allset==FALSE)
{
        if(self.raceset==FALSE)
                selectrace();
        else if(self.classset==FALSE)
                selectclass();
        else if(self.skinset==FALSE)
                selectskin();
        else
                self.allset = TRUE;
self.impulse = 0;
return;
}
if((self.classlabel=="Jedi"||self.classlabel=="Dark Jedi")&&(!self.saberset)&&self.exp>=500000&&(self.impulse==140||self.impulse==142||self.impulse==52)&&!self.small)
        {
        selectsaber();
        self.impulse = 0;
        return;
        }
if(self.impulse==114&&!self.small&&!self.dog_finished)
{
local float itemkeep;
local entity head;
        sprint(self,"Race and Class reset...\n");
        self.allset=FALSE;

        if(deathmatch)
                self.exp=0;
        else self.exp=self.exp/2;
        self.level=0;
        if(self.frags>0)
                self.frags=0;
        self.race=0;
        self.class=0;
        self.raceset=FALSE;
        self.classset=FALSE;
        self.skinset=FALSE;
        self.saberset=FALSE;
        self.attempthit = 0;
        self.actualhit = 0;
/*Not necc?
        if(self.invisible_finished>time&&self.racename=="Predator")
                PredCloakMalFunc();
*/
        if(self.sword.running||self.sword.inpain)
        {
                self.sword.running=FALSE;
                self.sword.inpain=FALSE;
                remove(self.sword);
        }
        else if(self.batleth.running||self.batleth.inpain)
        {
                self.batleth.running=FALSE;
                self.batleth.inpain=FALSE;
                remove(self.batleth);
        }
        else if((self.saber.running||self.saber.follow!=0||self.saber.inpain)
        /*&&(self.classlabel=="Jedi"||self.classlabel=="Dark Jedi")*/)
        {
                self.saber.running=FALSE;
                self.saber.follow=0;
                self.saber.inpain=FALSE;
                self.saber.aflag=0;
                remove(self.saber);
        }
        if(self.racename=="Borg"&&self.charmed>1)
        {
        head=findradius(self.origin,10000);
        while(head)
                {
                if(head.racename=="Borg"&&head!=self&&head.controller==self)
                        head.controller=head;
                head=head.chain;
                }
        }
        self.racename="";
        self.hover=FALSE;
        self.speed=1;
        self.jumphite=6;
        self.mass=1;
        self.intel=0;
        self.endurence=100;
        self.damagetake=1;
        self.classlabel="";
        self.attackspeed = 0;
        self.health=50;
        self.max_health = self.health;
        self.accuracy=0;
        self.volume = 0;
        self.skin=0;
        self.hitplus=1;
        self.waterbreathe=FALSE;
        self.fireresist=0;
        self.slimeresist=FALSE;
        self.magicresist=FALSE;
        self.healthregen=FALSE;
        self.claws=FALSE;
        self.featherfall=FALSE;
        self.berzerker=FALSE;
        self.energyabsorb=FALSE;
        self.anyinvis=FALSE;
        self.nospells=FALSE;
        self.weakheart=FALSE;
        self.heatsee=FALSE;
        self.boltsee=FALSE;
        self.wallclimb=FALSE;
        self.weak=FALSE;
        self.super_time = 0;
        self.rad_time = 0;
        self.invisible_time = 0;
        self.invincible_time = 0;
        self.alivetime=0;
        self.pausetime=0;
        self.attack_finished=0;
        self.nextthink=time;
        self.climbing=FALSE;
        self.dangle=FALSE;
        if(self.skin>23)
        {
                self.skin=self.oldskin;
                self.oldskin=self.skin;
        }
        if(self.super_damage_finished)
                self.super_damage_finished = time - 1;
        if(self.radsuit_finished)
                self.radsuit_finished = time - 1;
        if(self.invincible_finished)
                self.invincible_finished = time - 1;
        if(self.invisible_finished)
                self.invisible_finished = time - 1;
        if(self.items&IT_JETPACK)
                itemkeep=itemkeep+IT_INVISIBILITY;
        if(self.items&IT_INVISIBILITY)
                itemkeep=itemkeep+IT_INVISIBILITY;
        if(self.items&IT_INVULNERABILITY)
                itemkeep=itemkeep+IT_INVULNERABILITY;
        if(self.items&IT_SUIT)
                itemkeep=itemkeep+IT_SUIT;
        if(self.items&IT_QUAD)
                itemkeep=itemkeep+IT_QUAD;
        self.items=self.items-self.items+itemkeep;
        self.items=self.items | IT_AXE | IT_SHOTGUN;// | IT_SNIPERGUN;
        self.ammo_rockets=0;
        self.ammo_nails=0;
        self.ammo_shells=25;
        self.ammo_cells=0;
        self.weapon=1;
        self.currentammo = self.ammo_shells;
        if(self.skin==6||self.oldskin==6)
                self.weaponmodel = "progs/v_uzi.mdl";
        else self.weaponmodel = "progs/v_shot.mdl";
        self.weaponframe = 0;
        self.items = self.items | IT_SHELLS;
        self.impulse = 0;
        return;
}
        else if (self.impulse == 150&&!self.small)
                if (self.dog_time)
                      {
                      self.impulse = 0;
                      return;
                      }
                else feign(self);
        else if(self.impulse==101)
           if(self.items2&IT_GHOOK)
                if(self.ghook_holdon&&self.util==IT_GHOOK)
                {
                        self.ghook_holdon=FALSE;
                        self.dangle=FALSE;
                }
                else
                {
                        self.util=IT_GHOOK;
                        if(!self.ghook_extended)
                                W_SetCurrentAmmo ();
                }
           else
                sprint(self,"You don't have a grappling hook!\n");
        else if(self.impulse >= 30 && self.impulse <=33 && self.racename=="Borg")
                BorgCommands();
        else if (self.impulse == 30 && self.newholo.active&&self.racename!="Borg")
                CheckHoloCommand();
        else if((self.impulse == 31&&self.racename!="Borg")||(self.impulse==40&&self.racename=="Borg"))
                HoloCam(self);
        else if (self.impulse == 32&&self.racename!="Borg")
                if (self.newholo.active == TRUE)
                        DetHolo();
                else
                {
                        sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                        sprint(self,"Holograph not active!\n");
                }
        else if (self.impulse == 33&&self.racename!="Borg")
                if (self.newholo.active == TRUE)
                        feign(self.newholo);
                else
                {
                        sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                        sprint(self,"Holograph not active!\n");
                }
        else if(self.isfeign)
                {
                        self.impulse = 0;
                        return;
                }
        else if (self.impulse == 40 && self.teleeyes.active)
                TeleEyes();
        else if(self.impulse == 120&&!self.small)
		    Player_Melee();
        else
                self.Kick_em = 0;

        if((self.impulse >= 1 && self.impulse <= 8)||self.impulse==60||self.impulse==61||self.impulse==66)
		W_ChangeWeapon ();

        else if (self.impulse == 9)
		CheatCommand ();
          else if(self.impulse == 55&&!self.small)
		if(self.items&IT_JETPACK)
			if(self.ammo_cells<=0)
			{
		            sound (self, CHAN_ITEM, "doors/basetry.wav", 1 , ATTN_NORM);
				sprint(self,"You don't have any fuel!\n");
				self.impulse=0;
				return;
			}	
			else if(!self.hover)
			{			
	                  sound (self, CHAN_AUTO, "weapons/jeton.wav", 1 , ATTN_NORM);
				sprint(self,"Jetpack activated\n");
				self.hoverlevel=60;
				self.velocity_z=self.velocity_z + 100;
				self.hover=TRUE;
				self.hoverstarttime=time;
			}
			else
			{
				sprint(self,"Jetpack deactivated\n");
				self.hover=FALSE;
			}
		else
		{
	            sound (self, CHAN_ITEM, "doors/basetry.wav", 1 , ATTN_NORM);
			sprint(self,"You don't have a jetpack!\n");
			self.impulse=0;
			return;
		}
          else if(self.impulse==56&&!self.small)
                if(self.items&IT_JETPACK)
		{
			sprint(self,"Jetpack Auto Airbrake");
			sound(self,CHAN_ITEM,"misc/secret.wav",1,ATTN_NONE);
			if(self.autojet)
			{
				self.autojet=FALSE;
				sprint(self," Disabled\n");
			}
			else
			{
				self.autojet=TRUE;
				sprint(self," Enabled\n");
			}
		}
		else sprint(self,"You don't have a jetpack!\n");
        else if(self.impulse==65&&!self.small)
                if(self.ammo_cells<10)
                {
                        sprint(self,"Not enough cells\n");
                        self.impulse=0;
                        sound (self, CHAN_BODY, "misc/talk.wav", 1, ATTN_NORM);
                        return;
                }
                else SetSentinel();
        else if (self.impulse == 10)
                CycleWeaponCommand ();
        else if (self.impulse == 11)
		ServerflagsCommand ();
//        else if (self.impulse == 20)
//                ThrowBackpackPartial();
//        else if (self.impulse == 21)
//                ThrowBackpackFull();
        else if (self.impulse == 22&&!self.small)
                Duck();
        else if ((self.impulse == 142||self.impulse==140)&&self.nospells!=TRUE)
                CycleSpell(141-self.impulse);
        else if (self.impulse == 70&&self.nospells!=TRUE)
                CycleSpellLevel(-1);
        else if (self.impulse == 71&&self.nospells!=TRUE)
                CycleSpellLevel(1);
        else if (self.impulse == 52)
                if(self.racename=="Predator")
                        ToggleCloak();
                else
                {
                if( (self.intel<1&&self.anyinvis!=TRUE) ||self.nospells)
                {
                sprint(self,"You cannot cast magical spells!\n");
                self.impulse=0;
                return;
                }
                if (time < self.alivetime)
                        {
                        sprint(self,"You may cast a spell in: ");
                        printnum=ftos(rint(self.alivetime-time));
                        sprint(self,printnum);
                        sprint(self," seconds\n");
                        self.impulse = 0;
                        return;
                        }
                self.mana = rint(time - self.init_mana);
                if (self.mana > self.exp/1000)
                        self.mana = self.exp/1000;
                if (self.mana >= self.spell||(self.spell==84&&(self.racename=="Predator"||self.anyinvis)))
                        Cast();
                else
                {
                sprint(self,"Not enough mana!\n");
                sprint(self,"Mana: ");
                printnum=ftos(self.mana);
                sprint(self,printnum);
                sprint(self,", this spell needs: ");
                printnum=ftos(self.spell);
                sprint(self,printnum);
                sprint(self,"\n");
                }
                }
        else if (self.impulse == 53&&self.nospells!=TRUE)
                PrintSpellName();
        else if(self.impulse==173&&(self.skin==17||self.oldskin==17))
                if(self.weapon==IT_SNIPERGUN)
                        if(self.feigning>0)
                        {
                                printnum=ftos(self.feigning);
                                if(self.small)
                                        player_sreload1();
                                else player_reload1();
                                sound (self, CHAN_WEAPON, "weapons/pkup.wav",1, ATTN_NORM);
                                sprint(self,"Reloaded ");
                                sprint(self,printnum);
                                sprint(self," bullets\n");
                                self.feigning=0;
                         }
                        else
                                centerprint(self,"Every chamber is already filled\n");
                else
                        centerprint(self,"You're not using the six-shooters!\n");
        else if(self.classlabel=="Jedi"&&self.impulse>169&&self.impulse<180)
                if(self.alivetime<time)
                {
                if(self.impulse==170&&self.exp>=50000)
                        {
                        sprint(self,"Pull\n");
                        self.spell=96;//attract
                        Cast();
                        }
                else if(self.impulse==171&&self.exp>=100000)
                        {
                        sprint(self,"Shove\n");
                        self.spell=100;//shove
                        Cast();
                        }
                else if(self.impulse==172&&self.exp>=150000)
                        {
                        sprint(self,"Resist Fire\n");
                        self.spell=32;//Ironskin or *resist fire or dispel magic?
                        SelfCast();
                        }
                else if(self.impulse==173&&self.exp>=200000)
                        {
                        sprint(self,"Dispel Magic (target)\n");
                        self.spell=184;//dispel (other)
                        Cast();
                        }
                else if(self.impulse==174&&self.exp>=250000)
                        {
                        sprint(self,"Protection From Explosion\n");
                        self.spell=92;//protect from explosion
                        SelfCast();
                        }
                else if(self.impulse==175&&self.exp>=300000)
                        {
                        sprint(self,"Impotence\n");
                        self.spell=84;//impotence
                        Cast();
                        }
                else if(self.impulse==176&&self.exp>=350000)
                        {
                        sprint(self,"Invisible\n");
                        self.spell=128;//spell of shadows
                        SelfCast();
                        }
                else if(self.impulse==177&&self.exp>=400000)
                        {
                        sprint(self,"Reflection\n");
                        self.spell=212;//reflect (self)
                        SelfCast();
                        }
                else if(self.impulse==178&&self.exp>=450000)
                        {
                        sprint(self,"Heal Self\n");
                        self.spell=204;//heal grievous
                        SelfCast();
                        }
                else if(self.impulse==179&&self.exp>=500000)
                        {
                        sprint(self,"Ambush\n");
                        self.spell=188;//ambush
                        SelfCast();
                        }
                else self.spell=0;
                if(self.spell!=0)
                        self.alivetime=time + self.impulse - 169;
                }
                else
                        {
                        sprint(self,"You may use your jedi powers in: ");
                        printnum=ftos(rint(self.alivetime-time));
                        sprint(self,printnum);
                        sprint(self," seconds\n");
                        self.impulse = 0;
                        return;
                        }
        else if(self.classlabel=="Dark Jedi"&&self.impulse>169&&self.impulse<180)
                if(self.alivetime<time)
                {
                if(self.impulse==170&&self.exp>=30000&&self.health>2)
                        {
                        sprint(self,"Pull\n");
                        self.spell=96;//attract
                        self.health=self.health - 2;
                        Cast();
                        }
                else if(self.impulse==171&&self.exp>=60000&&self.health>2)
                        {
                        sprint(self,"Shove\n");
                        self.spell=100;//shove
                        self.health=self.health - 2;
                        Cast();
                        }
                else if(self.impulse==172&&self.exp>=90000&&self.health>3)
                        {
                        sprint(self,"Hold\n");
                        self.spell=140;//hold monster
                        self.health=self.health - 3;
                        Cast();
                        }
                else if(self.impulse==173&&self.exp>=120000&&self.health>4)
                        {
                        sprint(self,"Suffocate\n");
                        self.spell=176;//suffocation
                        self.health=self.health - 4;
                        Cast();
                        }
                else if(self.impulse==174&&self.exp>=150000&&self.health>5)
                        {
                        sprint(self,"Quad Damage\n");
                        self.spell=208;//quad damage
                        self.health=self.health - 5;
                        SelfCast();
                        }
                else if(self.impulse==175&&self.exp>=180000&&self.health>5)
                        {
                        sprint(self,"Meteor Storm\n");
                        self.spell=196;//meteor swarm
                        self.health=self.health - 5;
                        Cast();
                        }
                else if(self.impulse==176&&self.exp>=210000&&self.health>5)
                        {
                        sprint(self,"Death Barrier\n");
                        self.spell=152;//death barrier
                        self.health=self.health - 5;
                        SelfCast();
                        }
                else if(self.impulse==177&&self.exp>=240000&&self.health>5)
                        {
                        sprint(self,"Reflection\n");
                        self.spell=212;//reflect (self)
                        self.health=self.health - 5;
                        SelfCast();
                        }
                else if(self.impulse==178&&self.exp>=270000&&self.health>10)
                        {
                        sprint(self,"Lightning\n");
                        self.spell=216;//lightning summon
                        self.health=self.health - 10;
                        Cast();
                        }
                else if(self.impulse==179&&self.exp>=300000&&self.health>20)
                        {
                        sprint(self,"Killing Word\n");
                        self.spell=220;//power word, kill
                        self.health=self.health - 20;
                        SelfCast();
                        }
                else self.spell=0;
                if(self.spell!=0)
                        self.alivetime=time + (self.impulse - 169)*2;
                }
                else
                        {
                        sprint(self,"You may use your jedi powers in: ");
                        printnum=ftos(rint(self.alivetime-time));
                        sprint(self,printnum);
                        sprint(self," seconds\n");
                        self.impulse = 0;
                        return;
                        }
        else if(self.impulse == 62)
	  DetPipeBombs();
        else if(self.impulse == 63)
	  DisarmPipeBombs();
        else if(self.impulse==113)
                ReviewStats();
        else if(self.impulse==180&&(self.racename=="TigerMan"||self.racename=="Predator"||self.claws||self.wallclimb))
                if(self.climbing==FALSE)
                        Climb();
                else
                        ClimbDrop();
        else if(self.impulse==112&&(self.classlabel=="Jedi"||self.classlabel=="Dark Jedi")&&self.saberset!=0&&!self.small)
                if(self.exp>=750000)
                        {
                        if(self.saber.running)
                                ThrowSaber();
                        else if(self.saber.inpain&&visible(self.saber)&&self.saber.follow==0)
                                SaberSummon();
                        else if(self.saber.follow==-1)
                                self.saber.follow=1;//Summon saber in mid-air
                        else if(!self.saber.running)
                                sprint(self,"Turn on your lightsaber first!\n");
                        }
                else
                        {
                        sprint(self,"You have not yet learned to throw\n");
                        sprint(self,"your lightsaber, young Jedi...\n");
                        }
        else if(self.impulse==182)
                CyclePhase();
        else if(self.impulse==183)
                ChuckHead();
	self.impulse = 0;
};

void() PlayerTouch =
{
if(other.classname=="player"&&other.small&&!self.small&&(other.flags&FL_ONGROUND))
{
        other.velocity_z=100;
        other.flags=other.flags-FL_ONGROUND;
        T_Damage(other,self,self,5000);
        self.v_angle=normalize(other.origin-self.origin);
        self.fixangle = 1;              // turn this way immediately
        sound(other,CHAN_AUTO,"weapons/squish.wav",1,ATTN_NORM);
}
else if(self.small&&!other.small&&other.alive&&(self.flags&FL_ONGROUND))
{
        self.v_angle=normalize(other.origin-self.origin);
        self.fixangle = 1;              // turn this way immediately
        if(other.classname!="player")
        {
                self.velocity_z=100;
                self.flags=self.flags-FL_ONGROUND;
                T_Damage(self,other,other,5000);
                sound(self,CHAN_AUTO,"weapons/squish.wav",1,ATTN_NORM);
        }
}
if((((other.classname=="longsword"||other.classname=="batleth")&&other.inpain )
        ||other.movetype==MOVETYPE_STEP
        || other.alive
        || other.classname=="anvil")&&(other.origin_z<self.origin_z - 10))
       {
       self.flags = self.flags + FL_ONGROUND;
       return;
       }
if(other.pausetime>time+3||
        other.nextthink>time+3||
        (other.movetype==MOVETYPE_STEP&&self.origin_z<other.origin_z+24)||
        (other.controller==self&&other.classname!="throwaxe"))//&&other.classname!="anvil"))&&!self.small)//Make it so can push anvil without it clinking
        {
        other.velocity_y = self.velocity_y/3;
        other.velocity_x = self.velocity_x/3;
        other.velocity_z = other.velocity_z + 1;
        if(other.flags & FL_ONGROUND)
                other.flags = other.flags - FL_ONGROUND;
        }
if(other.takedamage != DAMAGE_AIM)
   return;
if(self.onfire>0 && other.alive&&other.onfire<=0&&!self.small)
{
   other.onfire = self.onfire*0.5;
   self.enemy=other;
   SpawnFlame(other.origin);
}
else if(self.onfire==0&&other.onfire>0)
{
   self.onfire = other.onfire*0.5;
   self.enemy=self;
   SpawnFlame(self.origin);
}
};

/*
========
SuperDamageSound

Plays sound if needed
========
*/
void() SuperDamageSound =
{
	if (self.super_damage_finished > time)
	{
		if (self.super_sound < time)
		{
			self.super_sound = time + 1;
//                        sound (self, CHAN_BODY, "items/damage3.wav", 1, ATTN_NORM);
                        if(self.small)
                                sound (self, CHAN_BODY, "items/damage.wav", 0.25, ATTN_NORM);
                        else sound (self, CHAN_BODY, "items/damage.wav", 1, ATTN_NORM);
		}
	}
	return;
};

float() W_BestWeapon =
{
	local   float   it;
	
	it = self.items;

        if(self.weapon==IT_DISC||self.weapon==IT_SWORD||self.weapon==IT_BATLETH||self.weapon==IT_SABER||self.weapon==IT_CHAKRAM)
                return self.weapon;
        if(self.ammo_cells >= 10 && (it & IT_MAUDIB)&&(self.skin==13||self.oldskin==13))
                return IT_MAUDIB;
        if(self.ammo_shells >= 4 && (it & IT_SHOTGUN)&&(self.skin==17||self.oldskin==17))
                return IT_SNIPERGUN;
        if(self.ammo_shells >= 1 && (it & IT_SHOTGUN)&&(self.skin==6||self.oldskin==6))
                return IT_SHOTGUN;
        if(self.ammo_cells >= 1 && (it & IT_LIGHTNING) && self.waterlevel==0)
		return IT_LIGHTNING;
        if(self.ammo_nails >= 2 && (it & IT_SUPER_NAILGUN) )
		return IT_SUPER_NAILGUN;
        if(self.ammo_cells >= 1 && (it & IT_LIGHTNING))
                return IT_LASERGUN;
        if(self.ammo_rockets >= 10 && (it & IT_ROCKET_LAUNCHER))
                return IT_HOME_LAUNCHER;
        if(self.ammo_rockets >= 1 && (it & IT_ROCKET_LAUNCHER))
                return IT_ROCKET_LAUNCHER;
        if(self.ammo_rockets >= 1 && (it & IT_ROCKET_LAUNCHER))
                return IT_RAPID_LAUNCHER;
        if(self.ammo_rockets >= 5 && (it & IT_ROCKET_LAUNCHER))
                return IT_SPREAD_LAUNCHER;
        if(self.ammo_rockets >= 1 && (it & IT_GRENADE_LAUNCHER))
                return IT_GRENADE_LAUNCHER;
        if(self.ammo_rockets >= 1 && (it & IT_GRENADE_LAUNCHER))
                return IT_PIPE_LAUNCHER;
        if(self.ammo_rockets >= 3 && (it & IT_GRENADE_LAUNCHER))
                return IT_TRIPMINE;
        if(self.ammo_nails >= 1 && (it & IT_NAILGUN) )
		return IT_NAILGUN;
//        if(self.ammo_shells >= 4 && (it & IT_SHOTGUN) )
//                return IT_SNIPERGUN;
        if(self.ammo_shells >= 1 && (it & IT_GRENADE_LAUNCHER)&&self.waterlevel<3)
                return IT_FLAMETHROWER;
        if(self.ammo_shells >= 2 && (it & IT_GRENADE_LAUNCHER)&&self.waterlevel<3)
                return IT_FIREBALLGUN;
        if(self.ammo_shells >= 2 && (it & IT_SUPER_SHOTGUN) )
		return IT_SUPER_SHOTGUN;
        if(self.ammo_shells >= 1 && (it & IT_SHOTGUN) )
		return IT_SHOTGUN;
        if (self.items & IT_AXE&&self.amtaxe&&self.enchant_axe)
                {
                self.follow=0;
                return IT_AXE;
                }
        if (self.items & IT_AXE&&self.amtaxe)
                {
                self.follow=1;
                return IT_AXE;
                }
        return IT_SHOTGUN;
};
/*
============
W_WeaponFrame

Called every frame so impulse events can be handled as well as possible
============
*/
void() W_WeaponFrame =
{
	if (time < self.attack_finished)
		return;

	ImpulseCommands ();
	
// check for attack
	if (self.button0)
	{
                SuperDamageSound ();
		W_Attack ();
	}
};

// Throwing Axe
void() ThrowAxeThink =
{

if (self.active == 1)
{
        if(visible(self.controller))
        {
        if (self.effects == 0)
                self.effects = 8;
        else if (self.effects == 8)
                {
                self.effects = 4;
                sound(self, CHAN_WEAPON, "items/protect3.wav", 0.3, ATTN_NORM);
                sprint(self.controller,"Mjolnir Beckons....\n");
                self.allset = self.allset + 1;
                }
        else if (self.effects == 4)
                self.effects = 8;
        if (self.allset > 32)
                {
                        sound(self.controller, CHAN_ITEM, "weapons/pkup.wav",self.volume + 1, ATTN_NORM);
                        self.controller.amtaxe = self.controller.amtaxe + 1;
                        self.controller.follow = 1;
                        self.controller.impulse = 1;
                        sprint(self.controller,"Mjolnir has magically returned\n");
                        MagicEffect(self.controller);
                        remove(self);
                }
        }
        else self.effects = 0;
        self.nextthink = time + 0.5;
}
else
{
        if (self.active == -1)
        {
        local vector vtemp,dir;
          vtemp = self.controller.origin + '0 0 10';
          dir = normalize(vtemp - self.origin);
        if (self.watertype < -2)
             self.velocity = dir * 150;
        else self.velocity = dir * 375;
          self.angles = vectoangles(self.velocity);
        if (self.flags & FL_ONGROUND)// && self.follow == 0)
                {
                   self.avelocity = '500 0 0';
                   self.flags = self.flags - FL_ONGROUND;
//                   self.follow = 1;
                }
        }
        sound(self, CHAN_WEAPON, "weapons/woosh.wav", 0.3, ATTN_NORM);
        SpawnFlame(self.origin);
        self.nextthink = time + 0.2;
}
        if(self.controller.health<=0)
                {
                GrenadeExplode();
                remove(self);
                }
self.think = ThrowAxeThink;
};

void() AxeTouch =
{
local float clink, inertia;
  if (other == self.controller)
        {
                if (self.active!=0||self.bloodloss<time)
                {
                        sound(other, CHAN_ITEM, "weapons/pkup.wav",other.volume + 1, ATTN_NORM);
                        other.amtaxe = other.amtaxe + 1;
                        other.follow = 1;
                        other.impulse = 1;
                        remove(self);
                        return;
                }
                else return;
        }

  else if (other.takedamage)
  {
      if(self.velocity != VEC_ORIGIN && other != self.controller)
        if (self.active < 1)  
        {
              spawn_touchblood(40);
              SpawnChunk(self.origin, self.velocity);
              other.punchangle_x = -20;
              self.enemy = other;  
              if(other.health) 
              {
		  if (other.mass==0)
			inertia=1;
		  else inertia = other.mass;
              other.velocity_x = other.velocity_x + self.velocity_x*2 / inertia;
              other.velocity_y = other.velocity_y + self.velocity_y*2 / inertia;
              other.velocity_z = other.velocity_z + 100;
              other.flags = other.flags - FL_ONGROUND;
              }
              T_Damage(other, self, self.controller, 10);
              self.classname = "axhit";
              SpawnFlame();
              self.classname = "throwaxe";
        }
        else if (other.classname == "player"&&other.amtaxe==0)
        {
                sprint(self.controller,"Your axe was stolen by ");
                sprint(self.controller,other.netname);
                sprint(self.controller,"!\n");
                sprint(other,"You got ");
                sprint(other,self.controller.netname);
                sprint(other,"'s axe!\n");
                sound(other, CHAN_ITEM, "weapons/pkup.wav",other.volume + 1, ATTN_NORM);
                other.amtaxe = other.amtaxe + 1;
                other.follow = 1;
                other.impulse = 1;
                remove(self);
        }  
  }
  else
  {
    clink = random() * FL_SWIM;
    if (clink <= 1) 
      sound(self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
    else
      sound(self, CHAN_WEAPON, "weapons/tink1.wav", 1, ATTN_NORM);
  }

  if (self.active < 1)
       if (visible(self.controller))
               self.active = -1;
       else
       {
       if (self.active != 1)
        sprint(self.controller,"You lost your axe!\n");
       self.active = 1;
       self.effects = 0;
       self.avelocity = '300 300 300';
       setsize(self, '-3 -3 -5', '3 3 3');
       self.movetype = MOVETYPE_BOUNCE;
       }
};


void() W_ThrowAxe =
{
local entity missile;
  sound(self, CHAN_WEAPON, "weapons/woosh.wav", 1, ATTN_NORM);
  missile = spawn();
  missile.owner = missile;
  missile.controller = self;
  missile.classname = "throwaxe";
  missile.movetype = MOVETYPE_FLYMISSILE;
  missile.solid = SOLID_BBOX;
  makevectors(self.v_angle);
  missile.velocity = aim(self, 10000);
  missile.angles = vectoangles(missile.velocity);
  if (self.waterlevel > 2)
        missile.velocity = missile.velocity * 300;
  else
        missile.velocity = missile.velocity * 750;
  missile.touch = AxeTouch;
  missile.health = 100000;
  missile.takedamage = DAMAGE_AIM;
  missile.th_die = T_MissileTouch;
  missile.nextthink = time;
  missile.bloodloss = time+2;
  missile.think = ThrowAxeThink;
  setmodel(missile, "progs/throwaxe.mdl");
  setsize(missile,'-1 -2 -4','1 2 4');
//  setsize(missile, VEC_ORIGIN, VEC_ORIGIN);
  setorigin(missile, self.origin + v_forward * FL_SWIM + '0 0 16');
  missile.avelocity = '-500 0 0';
  missile.active = 0;
  missile.effects = 4;
  self.amtaxe = self.amtaxe - 1;
  if (self.amtaxe < 1)
        {
          self.follow = -1;
          self.impulse = 2;
          W_ChangeWeapon();
        }
};

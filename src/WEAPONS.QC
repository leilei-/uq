void (entity targ, entity inflictor, entity attacker, float damage) T_Damage;
void () player_run;
void(entity bomb, entity attacker, float rad, entity ignore) T_RadiusDamage;
void() W_Precache =
{
	precache_sound2 ("enforcer/enfire.wav");
	precache_sound2 ("enforcer/enfstop.wav");
        precache_model ("progs/laser.mdl"); 
        precache_model ("progs/backpack.mdl");
        precache_model ("progs/shelcase.mdl");
        precache_model ("progs/pipebomb.mdl"); 
        precache_model ("progs/v_pipe.mdl"); 
        precache_model ("progs/g_laser.mdl"); 
        precache_sound ("weapons/warning.wav");
        precache_sound ("weapons/teleeyes.wav");
        precache_sound ("weapons/lhit.wav");
        precache_model ("progs/lavaball.mdl");
        precache_sound ("misc/power.wav");
        precache_sound ("doors/basetry.wav");
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
        precache_sound ("weapons/pkup.wav");  
        precache_sound ("weapons/shellhit.wav"); 
        precache_sound ("player/tornoff2.wav");
        precache_sound ("player/slimbrn2.wav");
	precache_sound ("ambience/fire1.wav");
	precache_model ("progs/flame2.mdl");
        precache_sound ("zombie/z_miss.wav");
        precache_sound ("weapons/kick.wav");
        precache_sound ("weapons/slop.wav");
        precache_sound ("weapons/step1.wav");
        precache_sound ("weapons/step2.wav");
        precache_sound ("weapons/step3.wav");
        precache_sound ("weapons/step4.wav");
        precache_sound ("weapons/step5.wav");
        precache_sound ("weapons/step6.wav");
        precache_sound ("weapons/stepstop.wav");
        precache_sound ("demon/ddeath.wav");
        precache_sound ("items/inv3.wav");
        precache_sound ("items/r_item1.wav");
        precache_sound ("items/protect3.wav");
        precache_sound ("weapons/moadib.wav");
        precache_model("progs/throwaxe.mdl");
        precache_model("progs/null.spr");
        precache_sound("weapons/woosh.wav");
        precache_sound("weapons/taxhit1.wav");
        precache_sound("weapons/taxhit2.wav");
        precache_sound("weapons/taxhit3.wav");
};


/*
================
W_FireAxe
================
*/
void() W_FireAxe =
{
	local   vector  source;
	local   vector  org;

	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*64, FALSE, self);
	if (trace_fraction == 1.0)
		return;
	
	org = trace_endpos - v_forward*4;

	if (trace_ent.takedamage)
	{
		trace_ent.axhitme = 1;
		SpawnBlood (org, '0 0 0', 20);
                sound (self, CHAN_WEAPON, "zombie/z_miss.wav", 1, ATTN_NORM);
		T_Damage (trace_ent, self, self, 20);
	}
	else
        {       
		sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
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
void(vector org, vector vel, float damage) SpawnBlood =
{
	particle (org, vel*0.1, 73, damage*2);
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
	SpawnBlood (self.origin + vel*0.01, vel, damage);
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

entity  multi_ent;
float   multi_damage;

void() ClearMultiDamage =
{
	multi_ent = world;
	multi_damage = 0;
};

void() ApplyMultiDamage =
{
	if (!multi_ent)
		return;
	T_Damage (multi_ent, self, self, multi_damage);
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
                        sound (self,CHAN_AUTO,"weapons/ric1.wav",1,ATTN_NORM);
                else if (r > 91)
                        sound (self,CHAN_AUTO,"weapons/ric2.wav",1,ATTN_NORM);
                else if (r > 87)
                        sound (self,CHAN_AUTO,"weapons/ric3.wav",1,ATTN_NORM);

};

void(float damage, vector dir) TraceAttack =
{
	local   vector  vel, org;
	
	vel = normalize(dir + v_up*crandom() + v_right*crandom());
	vel = vel + 2*trace_plane_normal;
	vel = vel * 200;

	org = trace_endpos - dir*4;

	if (trace_ent.takedamage)
	{
                if (trace_ent.reflecttime > time)
                        Ricochet(org,trace_ent);
                else
                        SpawnBlood (org, vel*0.2, damage);
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
	local   vector  src;
	
	makevectors(self.v_angle);

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;

	ClearMultiDamage ();
	while (shotcount > 0)
	{
		direction = dir + crandom()*spread_x*v_right + crandom()*spread_y*v_up;

		traceline (src, src + direction*2048, FALSE, self);
		if (trace_fraction != 1.0)
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

        if (other.reflecttime > time)
              {
              BounceBack(self.owner,other);
              return;
              }

        damg = 20 + random()*10;
	
	if (other.health)
	{
		if (other.classname == "monster_shambler")
                        damg = damg * 0.5;      
		T_Damage (other, self, self.owner, damg );
	}

        T_RadiusDamage (self, self.owner, 50, other);

	self.origin = self.origin - 8*normalize(self.velocity);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	BecomeExplosion ();
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
          if((head.health > 0.1) && (head != self) && (head != self.owner) && !( (teamplay == 1) && (head.team > 0)&&(head.team == self.owner.team) ) && (head.classname != "door") && (head.classname != "misc_explobox") && !(head.items & IT_INVISIBILITY) && (head.beendead != TRUE) && (head.controller != self.owner))
	         {
                        if(self.touch == T_SpreadTouch && self.owner == head.owner)
                                break;
                        else
                        {
                        traceline(self.origin,head.origin,TRUE,self);
                        if ( (trace_fraction >= 1) && (vlen(head.origin - self.origin) < dist) )
                            {
                                selected = head;
                                dist = vlen(head.origin - self.origin);
                            }
                        }
                }
                head = head.chain;
        }

        if (selected != world)   
        {
                sprint (self.owner,"Homing->");
                if (selected.classname == "player")
                {
                        sprint (self.owner,selected.netname);
                        sprint(selected,"Warning!  ");
                        sprint(selected,self.owner.netname);
                        sprint(selected," has a lock on you!\n");
                }
                else sprint (self.owner,selected.classname);
                sprint (self.owner,"\n");
                sound(self, CHAN_WEAPON, "weapons/warning.wav", 1, ATTN_NORM);
        }
        
        return selected;
};

/*
===============
HomeThink by Vhold
The Think function for the Homing Missile
===============
*/
void() HomeThink =
{
	local vector dir, vtemp;

        if (!(self.enemy) || (self.enemy == world) || (self.enemy.health < 0.1) && (self.enemy.beendead != TRUE))
		self.enemy = HomeFindTarget();

        if (self.enemy != world) 
	{
		vtemp = self.enemy.origin + '0 0 10';
		dir = normalize(vtemp - self.origin);
                self.velocity = dir * 350;
                self.velocity_x = self.velocity_x + (random () * 150 - 75);
                self.velocity_y = self.velocity_y + (random () * 150 - 75);
                self.velocity_z = self.velocity_z + (random () * 150 - 75);
		self.angles = vectoangles(self.velocity);
                if ((self.flags & FL_ONGROUND) && self.follow == 0)
                   {
                   self.flags = self.flags - FL_ONGROUND;
                   self.follow = 1;
                   }
	}
        if (self.alivetime < time && self.classname == "homerocket")
                remove(self);
        self.nextthink = time + 0.2;
	self.think=HomeThink;
};

void()	s_explode1	=	[0,		s_explode2] {};
void()	s_explode2	=	[1,		s_explode3] {};
void()	s_explode3	=	[2,		s_explode4] {};
void()	s_explode4	=	[3,		s_explode5] {};
void()	s_explode5	=	[4,		s_explode6] {};
void()	s_explode6	=	[5,		SUB_Remove] {};

void() spike_touch;

void() BecomeExplosion =
{
	self.movetype = MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
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

        if (other.reflecttime > time)
              {
              BounceBack(self.owner,other);
              return;
              }

	damg = 100 + random()*20;
	
        if (other.health>0&&other.health<99999999)
	{
		if (other.classname == "monster_shambler")
			damg = damg * 0.5;	// mostly immune
		T_Damage (other, self, self.owner, damg );
                other.velocity_x = other.velocity_x + self.velocity_x;
                other.velocity_y = other.velocity_y + self.velocity_y;
                other.velocity_z = other.velocity_z + 100;
                if(other.flags&FL_ONGROUND)
                        other.flags = other.flags - FL_ONGROUND;
	}
        else if (self.classname == "homerocket")
        {
        sound(self,CHAN_WEAPON,"weapons/pkup.wav",1,ATTN_NORM);
        self.angles = vectoangles ('0 0 0' - self.velocity);
        self.enemy = world;
        self.velocity = '0 0 0';
        self.active = TRUE;
        return;
        }
	// don't do radius damage to the other, because all the damage
	// was done in the impact
	T_RadiusDamage (self, self.owner, 120, other);

	self.origin = self.origin - 8*normalize(self.velocity);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	BecomeExplosion ();
};

void() GrenadeExplode =
{
        if(self.classname=="throwaxe")
                T_RadiusDamage (self, self.owner, 200, world);
        else if(self.owner.classname=="ogre") 
           {
           T_RadiusDamage (self, self.owner, 40, world);
           sound (self, CHAN_VOICE, "weapons/r_exp3.wav", 1, ATTN_NORM);
           }
        else
                T_RadiusDamage (self, self.owner, 80, world);

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
        makevectors (cont.v_angle);
	missile.touch = T_MissileTouch;

// set missile speed    

        if (type == "homerocket") 
        {
        missile.speed = 350;
        missile.velocity = dir * missile.speed;
        missile.think = HomeThink;
        missile.nextthink = time + 0.2;
	missile.enemy = world;
        missile.controller = self;
        missile.alivetime = time + 180;
        }
        else
        {
        missile.speed = 1000;
        missile.velocity = dir * missile.speed;
	missile.nextthink = time + 5;
	missile.think = SUB_Remove;
        }
	missile.angles = vectoangles(missile.velocity);

        setmodel (missile, "progs/missile.mdl");
        setsize (missile, '0 0 0', '0 0 0');            
        setorigin (missile, cont.origin + v_forward*8 + '0 0 16');
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
        missile.speed = 500;
	missile.nextthink = time + 0.2;
        missile.classname = type;

        if (type == "spreadrocket")
        {
        missile.velocity = dir * missile.speed;
        missile.velocity_x = missile.velocity_x + (random() * 100 - 50);
        missile.velocity_y = missile.velocity_y + (random() * 100 - 50);
        missile.velocity_z = missile.velocity_z + (random() * 100 - 50);
        missile.touch = T_SpreadTouch;
        missile.think = SpreadThink;
        }
        else if (type == "homespread")
        {
        missile.velocity = dir * missile.speed;
        missile.velocity_x = missile.velocity_x + (random() * 100 - 50);
        missile.velocity_y = missile.velocity_y + (random() * 100 - 50);
        missile.velocity_z = missile.velocity_z + (random() * 100 - 50);
        missile.touch = T_SpreadTouch;
        missile.think = HomeThink;
        missile.enemy = world;
        }
	missile.angles = vectoangles(missile.velocity);
	setmodel (missile, "progs/missile.mdl");
        setsize (missile, '0 0 0', '0 0 0');
        setorigin (missile, cont.origin + v_forward*8 + '0 0 16');
};

void(string type) W_FireSpread =
{
local vector dir;
        dir = aim(self, 1000);
        self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
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
                T_RadiusDamageWater (waterloser, waterloser, self);
                remove (waterloser);
};

void (vector startpos) ThroughWater =
{
local vector endpos;
local float mover;
        mover = 600;
        while (mover)
        {
        mover = mover - 25;
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

        if (pointcontents(trace_endpos) == CONTENT_WATER || pointcontents(trace_endpos) == CONTENT_SLIME)
                ThroughWaterZap(trace_endpos);
        else if (trace_ent.watertype == CONTENT_WATER || trace_ent.watertype == CONTENT_SLIME)
                T_RadiusDamageWater (trace_ent, trace_ent, self);
        else if (trace_ent.takedamage)
	{
		particle (trace_endpos, '0 0 100', 225, damage*4);
                if (trace_ent.reflecttime > time)
                        {
                        if (from.reflecttime > time)
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
                else T_Damage (trace_ent, from, from, damage);
		if (self.classname == "player")
                        if (trace_ent.classname == "player")
                                trace_ent.velocity_z = trace_ent.velocity_z + 400;
	}
        else ThroughWater(p1);

        e1 = trace_ent;
	traceline (p1 + f, p2 + f, FALSE, self);
        if (trace_ent != e1 && trace_ent.takedamage)
	{
		particle (trace_endpos, '0 0 100', 225, damage*4);
                if (trace_ent.reflecttime > time)
                        {
                        if (from.reflecttime > time)
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
                if (trace_ent.reflecttime > time)
                        {
                        if (from.reflecttime > time)
                                return;
                        else swap = trace_ent;
                             from = trace_ent;
                             trace_ent = swap;
                        }
                T_Damage (trace_ent, from, from, damage);
	}
};


void(entity loser,vector dir) W_FireLightning =
{
	local   vector          org;

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
		T_RadiusDamage (self, self, 35*self.ammo_cells, world);
		self.ammo_cells = 0;
		W_SetCurrentAmmo ();
		return;
	}
	self.punchangle_x = -2;

	self.currentammo = self.ammo_cells = self.ammo_cells - 1;

	org = self.origin + '0 0 16';
	
	traceline (org, org + v_forward*600, TRUE, self);

     }
     else org = dir;

	if (self.t_width < time)
	{
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

   if (self.aflag != 33)
	LightningDamage (self.origin, trace_endpos + v_forward*4, self, 30);
   else
        LightningDamage (self.origin, dir, self, 30);

};


//=============================================================================
void() GrenadeTouch =
{
	if (other == self.owner)
		return;         // don't explode on owner
        if (other.reflecttime > time)
              {
              GrenBounceBack(self.owner,other,self.speed);
              return;
              }

	if (other.takedamage == DAMAGE_AIM)
	{
                GrenadeExplode();
		return;
	}
	sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);  // bounce sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};
//=============================================================================

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

        if (other.reflecttime > time)
        {
              BounceBack(self.owner,other);
              return;
        }

// hit something that bleeds

        if (other.takedamage)
	{
                if (self.classname == "superspike")
                        multiplier = 2;
                else if (self.classname == "shrapnel"||self.classname == "blades")
                        multiplier = 4;
                else if (self.classname == "spike" || self.classname == "wizspike" || self.classname == "knightspike")
                        multiplier = 1;
                else if (other.prottime > time)
                        multiplier = 0;
                
                spawn_touchblood (9*multiplier);
                T_Damage (other, self, self.owner, 9*multiplier);
	}
        else
	{
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
        else newmis.speed = 1000;

        if (type == "spike")
                setmodel (newmis, "progs/spike.mdl");
        else if (type != "wizspike" && type != "knightspike")
                setmodel (newmis, "progs/s_spike.mdl");

        setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
        if (type == "spike")
                setorigin (newmis, org + '0 0 16' + v_right*ox);
        else if (type == "superspike")       
                setorigin (newmis, org + '0 0 16');
        else setorigin (newmis, org);
        newmis.velocity = dir * newmis.speed;
};

void(float ox) W_FireSpikes =
{
	local vector    dir;
        local string type;
	
	makevectors (self.v_angle);
	dir = aim (self, 1000);
	if (self.ammo_nails < 1)
	{
		self.weapon = W_BestWeapon ();
		W_SetCurrentAmmo ();
		return;
	}
	self.attack_finished = time + 0.2;
	self.punchangle_x = -2;
	if (self.ammo_nails >= 2 && self.weapon == IT_SUPER_NAILGUN)
	{
	sound (self, CHAN_WEAPON, "weapons/spike2.wav", 1, ATTN_NORM);
        self.currentammo = self.ammo_nails = self.ammo_nails - 2;
        type = "superspike";
        launch_spike(self.origin,dir,self,type,0);
        }
        else
        {
	sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);
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
        local entity loser;
        local float marked;

	self.wait = self.wait - 1;
        if(self.classname == "fire")
                loser = self.enemy;
        else loser = self.trigger_field;

        loser.effects = 4;

        if (loser.classname == "player" && self.owner.classname != "player")
                self.owner = loser;

        if (loser.waterlevel > 2 && loser.watertype != CONTENT_LAVA)
            {    
            sound (self.owner, CHAN_WEAPON, "player/slimbrn2.wav", 1, ATTN_NORM);
            sprint(self.owner,loser.netname);
            sprint(self.owner," saved his ass by jumping in the water!\n");
            loser.effects = 0;
            remove(self);
            }

        if (loser.waterlevel > 2 && loser.watertype == CONTENT_LAVA)
            {    
            sprint(self.owner,loser.netname);
            sprint(self.owner," jumped out of the frying pan into the fire!\n");
            loser.effects = 0;
            FireDie();
            }
                
       if ((self.waterlevel > 2) || (self.watertype == CONTENT_WATER) || (self.watertype == CONTENT_SLIME) || (pointcontents(self.origin) == CONTENT_WATER) || (pointcontents(self.origin) == CONTENT_SLIME))
            {
            sound (self.owner, CHAN_WEAPON, "player/slimbrn2.wav", 1, ATTN_NORM);
            sprint(self.owner,"Fireball fizzled underwater\n");
            loser.effects = 0;
            remove(self);
            }


        if (self.active != 5)
                {
                if ((self.wait < 1) || (loser.health<=0))
                        {
                        loser.effects = 0;
                        remove(self);
                        }
                }
        else if (self.wait < 1 || loser.health <= 6)
                {
                self.mass = 2;
                loser.effects = 0;
                FireDie();
                }

        if (loser.firesistime < time)
                {
                T_Damage (loser, self, self.owner, self.active*(self.enemy.onfire + 1));
                spawn_touchblood(random()*10);
                }
        SpawnFlame (self.origin);

        self.origin = loser.origin + '0 0 6';
	self.nextthink = time + 0.05;
        self.think = FireDamage;
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

		
        if (other.reflecttime > time)
              {
              GrenBounceBack(self.owner,other,self.speed);
              return;
              }

        if (other.takedamage)
	{
                sound (self, CHAN_WEAPON, "weapons/flame.wav", 1, ATTN_NORM);
		self.trigger_field = other;
                if(self.classname=="axeflame")
                        other=self.enemy;
                self.origin = other.origin + '0 0 6';

                if (other.classname == "player" || self.active == 5)
                        self.wait = 180;
                else
                        self.wait = 40;
                
                setsize (self, '0 0 0', '0 0 0');            

		self.nextthink = time + 0.05;
                self.think = FireDamage;
		self.movetype = MOVETYPE_NOCLIP;
		self.velocity = '0 0 0' ;
		self.avelocity = '0 0 1000';
                if ((other.waterlevel < 2) && (other.classname == "player"))
                sprint(other, "You're burning up!\n");
		return;
	}
        else if (self.movetype == MOVETYPE_FLYMISSILE)
                FireDie();
        sound (self, CHAN_WEAPON, "weapons/flame.wav", 0.75, ATTN_STATIC);  // bounce sound
        spawn_touchblood (10);
        SpawnFlame (self.origin);
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
        if (self.active == 5)
                {
		self.nextthink = time + 0.05;
                self.think = FireDamage;
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
if(self.classname == "axhit")
{
local   entity fire;
        if (pointcontents(self.origin) < -2)
        {
                sound (self, CHAN_WEAPON, "player/slimbrn2.wav", 1, ATTN_NORM);
                return;
        }
        sound (self, CHAN_WEAPON, "weapons/fbfire.wav", 1, ATTN_NORM);
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
        setmodel (fireflame, "progs/flame2.mdl");
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
                sound (self, CHAN_WEAPON, "weapons/flame.wav", 1, ATTN_NORM);
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

	
        sound (self, CHAN_WEAPON, "weapons/fbfire.wav", 1, ATTN_NORM);

        self.punchangle_x = -3;


	missile = spawn ();
        missile.owner = self;
        missile.mass = type;
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
        missile.speed = 600;
	if (self.v_angle_x)
                missile.velocity = v_forward*1000 + v_up * ((2-type)*100);
	else
	{
		missile.velocity = aim(self, 10000);
                missile.velocity = missile.velocity * missile.speed;
                missile.velocity_z = ((2-type)*100);
	}

	missile.avelocity = '300 300 300';

	missile.angles = vectoangles(missile.velocity);
	
        missile.touch = FireTouch;
	
// set missile duration
        missile.nextthink = time + 0.1;
        missile.think = FireThink;
        setmodel (missile, "progs/lavaball.mdl");
        setsize (missile, '0 0 0', '0 0 0');        
        setorigin (missile, self.origin + v_forward*8 + '0 0 16' + offset);
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
		
	self.origin = self.enemy.origin;
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};
void() PipeBombTouch =
{
        if (other == self.owner)
		return;         // don't explode on owner

        if (other.owner == self.owner)
                return;         // don't tag owner's stuff

		
        if (other.reflecttime > time)
              {
              GrenBounceBack(self.owner,other,self.speed);
              return;
              }


        if(other.takedamage == DAMAGE_AIM || other.classname == "zombie")
	{
		if(!self.enemy)
		{
			sound(self, CHAN_WEAPON, "weapons/tink1.wav", 1, ATTN_NORM);
			self.think = GrenadeExplode;
		}

		self.enemy = other;
		self.origin = self.enemy.origin;
		if (self.effects != EF_DIMLIGHT)
		{
			sprint (self.owner, "You have tagged ");
			if (self.enemy.classname == "player")
			{
				sprint (self.owner, self.enemy.netname);
				sprint (self.owner, "!\n");
			
				sprint (self.enemy, "You have been tagged by ");
				sprint (self.enemy, self.owner.netname);
				sprint (self.enemy, "!!!\n");
			}
			else
			{
				sprint (self.owner, "a ");
                                if (self.enemy.frommonname)
                                       {
                                        sprint (self.owner," ");
                                        sprint (self.owner,trace_ent.frommonname);
                                        sprint (self.owner," ");
                                        }
				sprint (self.owner, self.enemy.classname);
				sprint (self.owner, "!\n");
                                if (self.enemy.classname == "TeleEye")
                                        {
                                        sprint (self.enemy.owner, "You're TeleEye has been tagged!!!\n");
                                        sound(self.enemy.owner, CHAN_WEAPON, "weapons/warning.wav", 1, ATTN_NORM);
                                        }
			}
			self.effects = EF_DIMLIGHT;
			self.think = TaggedPBTouch;
			self.touch = TaggedPBTouch;
			self.nextthink = time;
		}

	}

	sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);  // bounce sound
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
			if (head.enemy.classname == "player")
			{
                                sprint (self,"You have spared ");
				sprint (self,head.enemy.netname);
				sprint (self,"!..  Why?!?\n");
				sprint (head.enemy,"Your miserable life has been spared by ");
				sprint (head.enemy,self.netname);
				sprint (head.enemy,".\n");
			}
                        else if (head.enemy.classname != "worldspawn")
			{
                                sprint (self,"You have spared ");
				sprint (self, "a ");
                                        if (trace_ent.frommonname)
                                                {
                                                sprint (self," ");
                                                sprint (self,trace_ent.frommonname);
                                                sprint (self," ");
                                                }
				sprint (self, head.enemy.classname);
				sprint (self,"!..  Why?!?\n");
			}
                        else
                                {
                                head.active = FALSE;
                                head.nextthink = time;
                                head.think = item_disarmedpipe;
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
        sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

	missile = spawn ();
        missile.takedamage = DAMAGE_AIM;
        missile.th_die = GrenadeExplode;
        missile.health = 10;
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
        missile.solid = SOLID_BBOX;
	missile.classname = "grenade";

    if(self.weapon == IT_PIPE_LAUNCHER)
        {
        setsize (missile, '-3 -3 -3', '3 3 3');
        missile.beendead = TRUE;
        missile.active = TRUE; 
	missile.touch = PipeBombTouch;
	missile.think = GrenadeExplode;
        setmodel (missile, "progs/pipebomb.mdl");
        }
   else
        {
	setmodel (missile, "progs/grenade.mdl");
	missile.touch = GrenadeTouch;
        missile.nextthink = time + 2.5;
	missile.think = GrenadeExplode;
        setsize (missile, '0 0 0', '0 0 0');            
        }

	makevectors (self.v_angle);

        missile.speed = 600;
	if (self.v_angle_x)
		missile.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
	else
	{
		missile.velocity = aim(self, 10000);
		missile.velocity = missile.velocity * 600;
		missile.velocity_z = 200;
	}

	missile.avelocity = '300 300 300';

	missile.angles = vectoangles(missile.velocity);
        setorigin (missile, self.origin);
};

/*
=====================
LASER STUFF -- Shyft
=====================
*/

void() Laser_Touch; //Enforcer.qc Laser_touch() modified to change player dmg

void(vector dir, entity cont) PLaser = 
{
	newmis = spawn();
        newmis.owner = cont;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	newmis.effects = EF_DIMLIGHT;
        newmis.classname = "laser";
        makevectors (cont.v_angle);

	setmodel (newmis, "progs/laser.mdl");

        if (cont.classname != "player")
        {
	setsize (newmis, '0 0 0', '0 0 0');
        setorigin (newmis, cont.origin);
        }
        else
        {
        setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
        setorigin (newmis, cont.origin + v_forward*8 + '0 0 16');
        }

        newmis.speed = 600;
        newmis.velocity = dir * newmis.speed;

        newmis.angles = vectoangles(newmis.velocity);

	newmis.nextthink = time + 5;
	newmis.think = SUB_Remove;
        newmis.touch = Laser_Touch;
};
/*
===============================================================================

PLAYER WEAPON USE

===============================================================================
*/

void() Duck =
{
        if (self.ducking)
        {
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
        self.view_ofs = '0 0 22';
        self.ducking = FALSE;
        centerprint (self, "Standing\n");
        player_stand1();
        }
        else
        {
        setsize (self , '-16 -16 -24' , '16 16 4');      // change bounding bos so you're shorter
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
   
	player_run ();          // get out of any weapon firing states

	self.items = self.items - ( self.items & (IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
	

        if (self.dog_time)       // Dog stuff
        {
		self.currentammo = 0;
                self.weaponmodel = "";
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
		self.weaponmodel = "progs/v_shot.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_SHELLS;
	}
        else if (self.weapon == IT_SNIPERGUN)
	{
		self.currentammo = self.ammo_shells;
		self.weaponmodel = "progs/v_shot.mdl";
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
        else if (self.weapon == IT_FIREBALLGUN || self.weapon == IT_FLAMETHROWER)
	{
                self.currentammo = self.ammo_shells;
		self.weaponmodel = "progs/v_rock.mdl";
		self.weaponframe = 0;
                self.items = self.items | IT_CELLS;
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
		self.weaponmodel = "progs/v_rock2.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_ROCKETS;
	}
        else if (self.weapon == IT_LASERGUN)
	{
		self.currentammo = self.ammo_cells;
                self.weaponmodel = "progs/g_laser.mdl";
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
        else
	{
		self.currentammo = 0;
		self.weaponmodel = "";
		self.weaponframe = 0;
	}
};

float() W_BestWeapon =
{
	local   float   it;
	
	it = self.items;

	if(self.ammo_cells >= 1 && (it & IT_LIGHTNING) )
		return IT_LIGHTNING;
	else if(self.ammo_nails >= 2 && (it & IT_SUPER_NAILGUN) )
		return IT_SUPER_NAILGUN;
	else if(self.ammo_shells >= 2 && (it & IT_SUPER_SHOTGUN) )
		return IT_SUPER_SHOTGUN;
	else if(self.ammo_nails >= 1 && (it & IT_NAILGUN) )
		return IT_NAILGUN;
	else if(self.ammo_shells >= 1 && (it & IT_SHOTGUN) )
		return IT_SHOTGUN;
        else if (self.items & IT_AXE)
                return IT_AXE;
        return IT_SHOTGUN;
};

float() W_CheckNoAmmo =
{
if (self.weapon == IT_AXE)
		return TRUE;

else if (self.weapon == IT_SNIPERGUN && self.currentammo > 3)
		return TRUE;

else if (self.weapon == IT_FIREBALLGUN && self.currentammo > 1)
		return TRUE;

else if (self.weapon == IT_HOME_LAUNCHER && self.currentammo > 9)
		return TRUE;

else if (self.weapon == IT_SPREAD_LAUNCHER && self.currentammo > 4)
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

void() W_Attack =
{
        local   float   r;
        local vector dir;

        if (self.dog_time)       // Dog stuff
        {
                self.attack_finished = time + 1;
                play_dog_atta1();
                return;
        }

        if ((!W_CheckNoAmmo ())||(self.isfeign))
		return;

	makevectors     (self.v_angle);                 // calculate forward angle for velocity
	self.show_hostile = time + 1;   // wake monsters up

        if (self.weapon == IT_AXE)
	{
                if (self.follow == 1)
                        sound (self, CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);
		r = random();
		if (r < 0.25)
			player_axe1 ();
		else if (r<0.5)
			player_axeb1 ();
		else if (r<0.75)
			player_axec1 ();
		else
			player_axed1 ();
                if (self.follow == 1)
                        self.attack_finished = time + 0.5;
	}
	else if (self.weapon == IT_SHOTGUN)
	{
		player_shot1 ();
                sound (self, CHAN_WEAPON, "weapons/guncock.wav", 1, ATTN_NORM); 
                self.punchangle_x = -2;
                self.currentammo = self.ammo_shells = self.ammo_shells - 1;
                dir = aim (self, 100000);
                FireBullets (6, dir, '0.04 0.04 0');
                SpawnShell ();
		self.attack_finished = time + 0.5;
	}
        else if (self.weapon == IT_SNIPERGUN)
	{
                if (self.currentammo < 4)
                {
                sprint(self,"Requires 4 shells\n");
                return;
                }
		player_shot1 ();
                sound (self ,CHAN_WEAPON, "weapons/shotgn2.wav", 1, ATTN_NORM); 
                self.punchangle_x = -10;
                self.currentammo = self.ammo_shells = self.ammo_shells - 4;
                dir = aim (self, 1000000);
                FireBullets (20, dir, '0 0 0');
                SpawnShell ();
                self.attack_finished = time + 2;
	}
	else if (self.weapon == IT_SUPER_SHOTGUN)
	{
                if (self.currentammo == 1)
                {
                self.weapon = IT_SHOTGUN;
                W_Attack();
		return;
                }
        player_shot1 ();
	sound (self ,CHAN_WEAPON, "weapons/shotgn2.wav", 1, ATTN_NORM); 
	self.punchangle_x = -4;
	self.currentammo = self.ammo_shells = self.ammo_shells - 2;
	dir = aim (self, 100000);
	FireBullets (14, dir, '0.14 0.08 0');
        SpawnShell ();
        SpawnShell ();
        self.attack_finished = time + 0.7;
	}
	else if (self.weapon == IT_NAILGUN)
	{
		player_nail1 ();
	}
	else if (self.weapon == IT_SUPER_NAILGUN)
	{
		player_nail1 ();
	}
	else if (self.weapon == IT_GRENADE_LAUNCHER)
	{
		player_rocket1();
		W_FireGrenade();
		self.attack_finished = time + 0.6;
	}
        else if (self.weapon == IT_PIPE_LAUNCHER)
	{
		player_rocket1();
                W_FireGrenade();
		self.attack_finished = time + 0.6;
	}
	else if (self.weapon == IT_ROCKET_LAUNCHER)
	{
		player_rocket1();
                self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
                sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
                self.punchangle_x = -2;
                dir = aim(self, 1000);
                W_FireRocket2(dir,self,"rocket");
		self.attack_finished = time + 0.8;
	}
        else if (self.weapon == IT_FIREBALLGUN)
	{
		player_rocket1();
                FireBall(1,'0 0 0');
		self.attack_finished = time + 0.8;
	}
        else if (self.weapon == IT_FLAMETHROWER)
	{
                player_shot1();
                W_FireFlame();
                self.attack_finished = time + 0.03;
	}
        else if (self.weapon == IT_HOME_LAUNCHER && (self.ammo_rockets > 9))
	{
                player_rocket1();
                self.currentammo = self.ammo_rockets = self.ammo_rockets - 10;
                sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
                self.punchangle_x = -2;
                dir = aim(self, 1000);
                W_FireRocket2(dir,self,"homerocket");
                self.attack_finished = time + 1.2;
	}
        else if (self.weapon == IT_RAPID_LAUNCHER)
	{
		player_rocket1();
                if (self.ammo_rockets > 0)
                {
                        if (random () > 0.4)
                                W_FireSpread("spreadrocket");
                        else
                                W_FireSpread("homespread");
                }
                self.feigning = self.feigning + 1;
                if (self.feigning > 9)
                        {
                        self.feigning = 0;
                        self.attack_finished = time + 2;
                        }
                else self.attack_finished = time + 0.1;
        }
        else if (self.weapon == IT_SPREAD_LAUNCHER)
	{
		player_rocket1();
                W_FireSpread("spreadrocket");
                if (self.ammo_rockets > 0)
                W_FireSpread("spreadrocket");
                if (self.ammo_rockets > 0)
                W_FireSpread("spreadrocket");
                if (self.ammo_rockets > 0)
                W_FireSpread("spreadrocket");
                if (self.ammo_rockets > 0)
                W_FireSpread("spreadrocket");
                self.attack_finished = time + 1;
	}
	else if (self.weapon == IT_LIGHTNING)
	{
		player_light1();
		self.attack_finished = time + 0.1;
		sound (self, CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
	}
        else if (self.weapon == IT_LASERGUN)         //SHYFT ADD
	{
        player_shot1();
   	self.effects = self.effects | EF_MUZZLEFLASH;
        self.currentammo = self.ammo_cells = self.ammo_cells - 1;
        sound (self, CHAN_WEAPON, "enforcer/enfire.wav", 1, ATTN_NORM);
        dir = aim(self, 1000);
        PLaser(dir,self); 
        self.attack_finished = time + 0.2;
	}
};

/*
============
W_ChangeWeapon

============
*/
void() W_ChangeWeapon =
{
        if (self.isfeign)       // experimental
                return;

	local   float   it, am, fl;
	
	it = self.items;
	am = 0;
	
	if (self.impulse == 1)
	{
                if (self.amtaxe < 1)
                        return;
                fl = IT_AXE;
                if (self.follow == 0)
                        {
                        self.follow = 1;
                        sprint(self,"Axe in Melee Mode\n");
                        }
                else
                {
                   self.follow = 0;
                   sprint(self,"Axe in Throwing Mode\n");
                }
        }
	else if (self.impulse == 2)
	{
                if (self.weapon == IT_SHOTGUN)
                {
                fl = IT_SNIPERGUN;
                if (self.ammo_shells < 4)
                        am = 1;
                else if (self.items & fl)
                {
                sound (self, CHAN_WEAPON, "weapons/pkup.wav", 1, ATTN_NORM);
                centerprint (self,"Sniper Mode\n");
                }
                }
                else
                {
                fl = IT_SHOTGUN;
                if (self.ammo_shells < 1)
			am = 1;
                else if (self.items & fl)
                {
                sound (self, CHAN_WEAPON, "weapons/pkup.wav", 1, ATTN_NORM);
                centerprint (self,"Shotgun Mode\n");
                }
                }
	}
	else if (self.impulse == 3)
	{
		fl = IT_SUPER_SHOTGUN;
		if (self.ammo_shells < 2)
			am = 1;
	}               
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
                                sound (self, CHAN_WEAPON, "weapons/pkup.wav", 1, ATTN_NORM);
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
                                sound (self, CHAN_WEAPON, "weapons/pkup.wav", 1, ATTN_NORM);
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
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav", 1, ATTN_NORM);
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
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav", 1, ATTN_NORM);
                        centerprint (self,"PipeBomb Fire Mode\n");
                        }
                }
                else
                {
                        fl = IT_GRENADE_LAUNCHER;
                        if (self.ammo_rockets < 1)
                               am = 1;
                        else if (self.items & fl)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav", 1, ATTN_NORM);
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
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav", 1, ATTN_NORM);
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
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav", 1, ATTN_NORM);
                        centerprint (self,"Spread Fire Mode\n");
                        }
                }
                else if (self.weapon == IT_SPREAD_LAUNCHER)
                {
                        fl = IT_HOME_LAUNCHER;
                        if (self.ammo_rockets < 10)
                                am = 1;
                        else if (self.items & fl)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav", 1, ATTN_NORM);
                        centerprint (self,"Homing Fire Mode\n");
                        } 
                }
                else
                {
                        fl = IT_ROCKET_LAUNCHER;
                        if (self.ammo_rockets < 1)
                                am = 1;
                        else if (self.items & fl)
                        {
                        sound (self, CHAN_WEAPON, "weapons/pkup.wav", 1, ATTN_NORM);
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
                                        sound (self, CHAN_WEAPON, "weapons/pkup.wav", 1, ATTN_NORM);
                                }
                }
                else
                {
                        if (self.items & IT_LIGHTNING)
                        {
                        fl = IT_LASERGUN;
                        if (self.ammo_cells < 1)
                                am = 1;
                        }
                }
	}

	self.impulse = 0;
	
	if (!(self.items & fl))
	{       // don't have the weapon or the ammo
                sprint (self, "You don't have that weapon.\n");
		return;
	}
	
	if (am)
	{       // don't have the ammo
		sprint (self, "not enough ammo.\n");
		return;
	}

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
        if (deathmatch || coop)
		return;

	self.ammo_rockets = 100;
	self.ammo_nails = 200;
	self.ammo_shells = 100;
	self.items = self.items | 
		IT_AXE |
		IT_SHOTGUN |
		IT_SUPER_SHOTGUN |
		IT_NAILGUN |
		IT_SUPER_NAILGUN |
		IT_GRENADE_LAUNCHER |
		IT_ROCKET_LAUNCHER |
                IT_PIPE_LAUNCHER |
                IT_FIREBALLGUN |
                IT_SNIPERGUN |
                IT_LASERGUN |
                IT_HOME_LAUNCHER |
                IT_SPREAD_LAUNCHER |
                IT_RAPID_LAUNCHER |
		IT_KEY1 | IT_KEY2;

	self.ammo_cells = 200;
	self.items = self.items | IT_LIGHTNING;

	self.weapon = IT_ROCKET_LAUNCHER;
	self.impulse = 0;
        self.exp = 900000;
        self.init_mana = time - 900;
        sprint(self,"Full Mana\n");
	W_SetCurrentAmmo ();
};

/*
============
CycleWeaponCommand- temporarily deactivated

Go to the next weapon with ammo
============
void() CycleWeaponCommand =
{
	local   float   it, am;
	
	it = self.items;
	self.impulse = 0;
	
	while (1)
	{
		am = 0;

                if (self.weapon == IT_LIGHTNING)
                {
                        self.weapon = IT_AXE;
                        centerprint (self,"Axe\n");
		}
		else if (self.weapon == IT_AXE)
		{
			self.weapon = IT_SHOTGUN;
			if (self.ammo_shells < 1)
				am = 1;
                        else
                        centerprint (self,"Shotgun\n");
		}
		else if (self.weapon == IT_SHOTGUN)
		{
                        self.weapon = IT_SNIPERGUN;
                        if (self.ammo_shells < 4)
				am = 1;
                        else
                        centerprint (self,"Shotgun, Sniper Mode\n");
		}
                else if (self.weapon == IT_SNIPERGUN)
		{
			self.weapon = IT_SUPER_SHOTGUN;
			if (self.ammo_shells < 2)
				am = 1;
                        else if (it & IT_SUPER_SHOTGUN)
                                centerprint (self,"Double Barrelled Shotgun\n");
		}               
                else if (self.weapon == IT_SUPER_SHOTGUN && (it & IT_GRENADE_LAUNCHER))
		{
                        self.weapon = IT_FLAMETHROWER;
                        if (self.ammo_shells < 1)
				am = 1;
                        else centerprint (self,"Flamethrower\n");
		}
                else if (self.weapon == IT_FIREBALLGUN || self.weapon == IT_FLAMETHROWER)
		{
			self.weapon = IT_NAILGUN;
			if (self.ammo_nails < 1)
				am = 1;
                        else if (it & IT_NAILGUN)
                                centerprint (self,"Nailgun\n");
		}
                else if (self.weapon == IT_NAILGUN)
		{
			self.weapon = IT_SUPER_NAILGUN;
			if (self.ammo_nails < 2)
				am = 1;
                        else if (it & IT_SUPER_NAILGUN)
                                centerprint (self,"Super Nailgun\n");
		}
		else if (self.weapon == IT_SUPER_NAILGUN)
		{
			self.weapon = IT_GRENADE_LAUNCHER;
                        if (self.ammo_rockets < 1)
				am = 1;
                        else if (it & IT_GRENADE_LAUNCHER)
                                centerprint (self,"Grenade Launcher\n");
		}
                else if ((self.weapon > 15) && (self.weapon < 32))
		{
                        self.weapon = IT_ROCKET_LAUNCHER;
                        if (self.ammo_rockets < 1)
                                am = 1;
                        else if (it & IT_ROCKET_LAUNCHER)
                                centerprint (self,"Rocket Launcher\n");
                }
                else if ((self.weapon > 31) && (self.weapon < 64) && (it & IT_LIGHTNING))
		{
                        self.weapon = IT_LASERGUN;
			if (self.ammo_cells < 1)
				am = 1;
                        else if (it & IT_LIGHTNING)
                                centerprint (self,"Laser Gun\n");
		}
                else if (self.weapon == IT_LASERGUN)
		{
                        self.weapon = IT_LIGHTNING;
			if (self.ammo_cells < 1)
				am = 1;
                        else if (it & IT_LIGHTNING)
                               centerprint (self,"Thunderbolt\n");
                }
	
                if ((self.items & self.weapon) && am == 0)
                {                              
			W_SetCurrentAmmo ();
			return;
		}
	}
};
*/
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
        if (self.impulse == 150)
                if (self.dog_time)
                      return;
                else feign(self);
        else if (self.impulse == 30 && self.newholo.active)
                CheckHoloCommand();
        else if (self.impulse == 31)
                HoloCam(self);
        else if (self.impulse == 32)
                if (self.newholo.active == TRUE)
                DetHolo();
                else
                {
                sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                sprint(self,"Holograph not active!\n");
                }
        else if (self.impulse == 33)
                if (self.newholo.active == TRUE)
                feign(self.newholo);
                else
                {
                sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                sprint(self,"Holograph not active!\n");
                }
        else if(self.isfeign)
                return;
        else if (self.impulse == 40 && self.teleeyes.active)
                TeleEyes();
        else if(self.impulse == 120)
          self.Kick_em = 1;
	else
          self.Kick_em = 0;

        if (self.impulse >= 1 && self.impulse <= 8)
		W_ChangeWeapon ();

        else if (self.impulse == 9)
		CheatCommand ();
//        else if (self.impulse == 10)
//               CycleWeaponCommand ();
        else if (self.impulse == 11)
		ServerflagsCommand ();
        else if (self.impulse == 20||self.impulse == 21)
                DropBackpack();
        else if (self.impulse == 22)
                Duck();
        else if (self.impulse == 140 || self.impulse == 142)
                {
                self.skin = self.skin - (self.impulse - 141);
                if (self.skin < 0) self.skin = 23;
                else if (self.skin > 23) self.skin = 0;
                printnum=ftos(self.skin+1);
                centerprint(self,printnum);
                }
        else if (self.impulse == 50)
                CycleSpell(-1);
        else if (self.impulse == 51)
                CycleSpell(1);
        else if (self.impulse == 52)
                {
                if (time < self.alivetime)
                        {
                        self.impulse = 0;
                        return;
                        }
                self.mana = rint(time - self.init_mana);
                if (self.mana > self.exp/1000)
                        self.mana = self.exp/1000;
                if (self.mana >= self.spell)
                        if (self.silencetime < time)
                                Cast();
                        else
                        {
                        sprint(self,"You have been silenced, you may cast a spell in: ");
                        printnum=ftos(rint(self.silencetime-time));
                        sprint(self,printnum);
                        sprint(self," seconds\n");
                        }
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
        else if (self.impulse == 53)
                PrintSpellName();
        else if(self.impulse == 62)
	  DetPipeBombs();
        else if(self.impulse == 63)
	  DisarmPipeBombs();

	self.impulse = 0;
};

void() PlayerTouch =
{
 if(other.takedamage != DAMAGE_AIM)
   return;
 if(self.Kick_em)
{   
 // boot them in the rear!
 if(other.classname == "player")	// only advertise player kicking
 {
  bprint(self.netname);
  bprint(" gives ");
  bprint(other.netname);
  bprint(" the boot.\n");
 }
 if (other.classname == "head"||other.classname == "player")
 {
 other.velocity_x = other.velocity_x + self.velocity_x*2;
 other.velocity_y = other.velocity_y + self.velocity_y*2;
 other.velocity_z = other.velocity_z + 300 + (random() * 200); //     add lift
 }
 else
 {
 other.velocity_x = other.velocity_x + self.velocity_x/2;
 other.velocity_y = other.velocity_y + self.velocity_y/2;
 other.velocity_z = other.velocity_z + 50 + (random() * 100); //     add lift
 if(other.controller==self)
         T_Damage (other, self, self, 1);
 else T_Damage (other, self, self, 3);
 }
 sound (self, CHAN_WEAPON, "weapons/kick.wav", 1, ATTN_NORM);
 if(other.flags & FL_ONGROUND)
   other.flags = other.flags - FL_ONGROUND;
   return;
}
if ((other.classname == "corpse" || other.classname == "head" || other.alive)&&(other.origin_z<self.origin_z - 20))
       {
       self.flags = self.flags + FL_ONGROUND;
       return;
       }
if(other.pausetime>time+5||other.nextthink>time+5||(other.controller==self&&other.classname!="throwaxe"))
        {
        other.velocity_y = self.velocity_y/3;
        other.velocity_x = self.velocity_x/3;
        other.velocity_z = other.velocity_z + 1;
        if(other.flags&FL_ONGROUND)
                other.flags=other.flags-FL_ONGROUND;
        }
};
/*
========
SuperDamageSound

Plays sound if needed
========
void() SuperDamageSound =
{
	if (self.super_damage_finished > time)
	{
		if (self.super_sound < time)
		{
			self.super_sound = time + 1;
			sound (self, CHAN_BODY, "items/damage3.wav", 1, ATTN_NORM);
		}
	}
	return;
};
*/

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
//                SuperDamageSound ();
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
                self.aflag = self.aflag + 1;
                }
        else if (self.effects == 4)
                self.effects = 8;
        if (self.aflag > 32)
                {
                        sound(self.controller, CHAN_ITEM, "weapons/pkup.wav", 1, ATTN_NORM);
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
local float clink;
  if (other == self.controller)
        {
                if (self.active!=0||self.bloodloss<time)
                {
                        sound(other, CHAN_ITEM, "weapons/pkup.wav", 1, ATTN_NORM);
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
              T_Damage(other, self, self.controller, 10);
              other.velocity_x = other.velocity_x + self.velocity_x*2;
              other.velocity_y = other.velocity_y + self.velocity_y*2;
              other.velocity_z = other.velocity_z + 100;
              other.flags = other.flags - FL_ONGROUND;
              self.classname = "axhit";
              SpawnFlame();
              self.classname = "throwaxe";
        }
        else if (other.classname == "player")
        {
                sprint(self.controller,"Your axe was stolen by ");
                sprint(self.controller,other.netname);
                sprint(self.controller,"!\n");
                sprint(other,"You got ");
                sprint(other,self.controller.netname);
                sprint(other,"'s axe!\n");
                sound(other, CHAN_ITEM, "weapons/pkup.wav", 1, ATTN_NORM);
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

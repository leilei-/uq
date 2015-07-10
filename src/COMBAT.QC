.float floating;
void() T_MissileTouch;
void() info_player_start;
void(entity targ, entity attacker) ClientObituary;
void() monster_death_use;
void(entity inflictor, entity attacker, float dmg,entity ignore) T_RadiusDamage;

float(entity targ, entity inflictor) CanDamage =
{
        if (targ.movetype == MOVETYPE_PUSH)
	{
		traceline(inflictor.origin, 0.5 * (targ.absmin + targ.absmax), TRUE, self);
		if (trace_fraction == 1)
			return TRUE;
		if (trace_ent == targ)
                        return TRUE;
		return FALSE;
	}
	
	traceline(inflictor.origin, targ.origin, TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '15 15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '-15 -15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '-15 15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '15 -15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;

	return FALSE;
};

void(entity targ, entity attacker) Killed =
{
        local entity oself,printo;
        local string printnum;
	oself = self;
	self = targ;

        if (self.movetype == MOVETYPE_PUSH || self.movetype == MOVETYPE_NONE)
        {       // doors, triggers, etc
                self.th_die ();
                self = oself;
                return;
        }
	self.takedamage = DAMAGE_NO;
	self.touch = SUB_Null;

        if ((self.skin==1&&self.classname!="player")||(self.skin==21&&self.classname=="player"))
                self.health = -99;

        if (pointcontents(self.origin+'0 0 24') < -2 && pointcontents(self.origin+'0 0 24') > -5)
                      DeathBubbles (5);

        if (self.charmed && self.classname != "player")
                {
                self.controller.charmed = self.controller.charmed - 1;
                sprint(self.controller,"Your ");
                sprint(self.controller,self.classname);
                sprint(self.controller," has been killed!\n");
                self.charmed = FALSE;
                }

        if ((attacker.classname == "player" || attacker.charmed)&& (self.alive||self.classname=="zombie")&&self.controller!=attacker&&self!=attacker)
                {
                if(attacker.classname!="player")
                        printo = attacker.controller;
                else
                {
                printo=attacker;
                if(attacker.enemy == self)
                        attacker.enemy == world;                
                }
                sprint(printo,"Experience points: ");
                printnum=ftos(printo.exp);
                sprint(printo,printnum);
                sprint(printo,"\n");
                }

        if (attacker.charmed&&self.alive&&attacker.classname!="player")
                {
                sprint(attacker.controller,"Your ");
                sprint(attacker.controller,attacker.classname);
                sprint(attacker.controller," has killed a ");
                sprint(attacker.controller,self.classname);
                sprint(attacker.controller,"\n");
                }

	if (self.health < -99)
		self.health = -99;		// don't let sbar look bad if a player

        self.enemy = attacker;

	if (self.flags & FL_MONSTER)
	{
		killed_monsters = killed_monsters + 1;
		WriteByte (MSG_ALL, SVC_KILLEDMONSTER);
	}

        if(self.classname=="player")
                ClientObituary(self, attacker);

	monster_death_use();
        if(self.enemy.classname!="player")
                self.enemy=self;
        self.th_die();
	self = oself;
};

void(entity targ, entity inflictor, entity attacker, float damage) T_Damage=
{
	local	vector	dir;
        local   entity  oldself, swap,printo;
        local   float   save, expplus;
        local   float   take, r;

	if (!targ.takedamage)
		return;

        if (targ.classname == "player" && targ != attacker&&targ.alive)
                targ.enemy = attacker;

        if (targ.protmisstime > time && (inflictor.classname == "rocket" || inflictor.classname == "grenade" || inflictor.classname=="shalmissile" || inflictor.classname=="homespread" || inflictor.classname=="spreadrocket" || inflictor.classname=="homerocket"))
                {
                T_RadiusDamage(inflictor, attacker, damage, targ);
                return;
                }

  if (targ.axhitme != 1)
  {
        if (targ.reflecttime > time && inflictor == attacker && ((attacker.classname == "player"&&attacker.dog_time<time) || attacker.classname == "grunt"))
                if (attacker.reflecttime > time)
                        return;
                else
                {
                r = random();
                if (r > 0.7)
                        sound (targ,CHAN_WEAPON,"weapons/ric1.wav",1,ATTN_NORM);
                else if (r > 0.3)
                        sound (targ,CHAN_WEAPON,"weapons/ric2.wav",1,ATTN_NORM);
                else
                        sound (targ,CHAN_WEAPON,"weapons/ric3.wav",1,ATTN_NORM);
                swap = attacker;
                attacker = targ;
                inflictor = targ;
                targ = swap;
                SpawnBlood (targ.origin, targ.origin, damage);
                }
  }
  if(random()<0.5&&targ.alive&&attacker==inflictor&&((attacker.classname=="player"&&targ.axhitme)||attacker.classname=="knight"||attacker.classname=="hell knight"||attacker.classname=="ogre"||attacker.classname=="fiend"))
          {
          targ.woundmaker=attacker;
          targ.bloodloss = targ.bloodloss + 1;
          }

	if (!targ.takedamage)
		return;
	damage_attacker = attacker;

        if (attacker.super_damage_finished > time)
		damage = damage * 4;

	save = ceil(targ.armortype*damage);
	if (save >= targ.armorvalue)
	{
		save = targ.armorvalue;
		targ.armortype = 0;	// lost all armor
		targ.items = targ.items - (targ.items & (IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3));
	}
	
	targ.armorvalue = targ.armorvalue - save;
	take = ceil(damage-save);

	if (targ.flags & FL_CLIENT)
	{
		targ.dmg_take = targ.dmg_take + take;
		targ.dmg_save = targ.dmg_save + save;
		targ.dmg_inflictor = inflictor;
	}
        if ((inflictor != world) && (targ.movetype == MOVETYPE_WALK))
	{
		dir = targ.origin - (inflictor.absmin + inflictor.absmax) * 0.5;
		dir = normalize(dir);
		targ.velocity = targ.velocity + dir*damage*8;
	}
	if (targ.flags & FL_GODMODE)
		return;

	if (targ.invincible_finished >= time)
	{
		if (self.invincible_sound < time)
		{
			sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
			self.invincible_sound = time + 2;
		}
		return;
	}

        if ((teamplay == 1) && (targ.team > 0)&&(targ.team == attacker.team))
		return;
	targ.health = targ.health - take;
			
        if (inflictor.classname == "throwaxe")
        {
                if (targ.active != 2)
                        sound (targ, CHAN_WEAPON, "zombie/z_miss.wav", 1, ATTN_NORM);
                else
                {
                r = random();
                if (targ.health<=0)
                        sound (targ,CHAN_WEAPON,"weapons/taxhit1.wav",1,ATTN_NORM);
                else if (r > 0.4)
                        sound (targ,CHAN_WEAPON,"weapons/taxhit2.wav",1,ATTN_NORM);
                else
                        sound (targ,CHAN_WEAPON,"weapons/taxhit3.wav",1,ATTN_NORM);
                }
        }

        if ((attacker.classname == "player"||attacker.charmed) && (targ.alive||targ.classname=="zombie") && targ.controller != attacker)
        {
               if (targ.health <= 0)
                       expplus = take + targ.health;
               else if(targ.classname != "zombie")
                       expplus = take;
               else expplus = 0;
               if(attacker.classname!="player")
                       printo=attacker.controller;
               else printo=attacker;
               printo.exp = printo.exp + expplus*skill;
        }

        if (inflictor.classname == "spell")
                inflictor.mass = inflictor.mass + take;

	if (targ.health <= 0)
	{
                if ((attacker.classname == "player"||attacker.charmed) && (targ.alive)&&targ.controller!=attacker)
                        {
                        if(attacker.classname!="player")
                                printo=attacker.controller;
                        else printo=attacker;
                        printo.exp = printo.exp + expplus*skill*3;
                        }
                Killed (targ, attacker);
	}
        else
        {
        if (pointcontents(self.origin) < -2 && pointcontents(self.origin) > -5)
              if (random () < 0.2)
                      DeathBubbles (3);

	oldself = self;
	self = targ;

        if ((self.flags & FL_MONSTER) && attacker != world && self.skin == 0)
	{
		if (self != attacker && attacker != self.enemy)
		{
			if ( (self.classname != attacker.classname) 
                        || (self.classname == "grunt") || (attacker.charmed && (attacker.controller != self.controller)))
			{
				if (self.enemy.classname == "player")
					self.oldenemy = self.enemy;
				self.enemy = attacker;
				FoundTarget ();
			}
		}
	}

        if(self.skin==0||(self.classname=="player"&&self.skin!=25))
        if(self.th_pain)
	{
		self.th_pain (attacker, take);
		if (skill == 3)
			self.pain_finished = time + 5;		
	}

	self = oldself;
        }
};

void(entity inflictor, entity attacker, float damage, entity ignore) T_RadiusDamage =
{
        local   float   points;
        local   entity  head;
	local	vector	org;

        head = findradius(inflictor.origin, damage + 40);
	
	while (head)
	{
                if (head != ignore && head.protmisstime < time)
		{
			if (head.takedamage)
			{
                                if (head.classname == "player" && head != attacker)
                                        head.enemy = attacker;
				org = head.origin + (head.mins + head.maxs)*0.5;
				points = 0.5*vlen (inflictor.origin - org);
				if (points < 0)
					points = 0;
				points = damage - points;
				if (head == attacker)
					points = points * 0.5;
				if (points > 0)
				{
					if (CanDamage (head, inflictor))
					{	// shambler takes half damage from all explosions
                                                if (head.classname == "shambler")                                        
                                                        points = points * 0.5;
                                                T_Damage (head, inflictor, attacker, points);
                                        }
				}
			}
		}
		head = head.chain;
	}
};
void(entity inflictor, entity attacker, entity ignore) T_RadiusDamageWater =
{
        local   float   points;
        local   entity  head;
	local	vector	org;

        head = findradius(inflictor.origin, 666);
	
	while (head)
	{
		if (head != ignore)
		{
			if (head.takedamage)
			{
                                if (pointcontents(head.origin) == CONTENT_WATER || pointcontents(head.origin) == CONTENT_SLIME || head.floating) //  visible(inflictor)?
                                {
                                if (head.classname == "player" && head != attacker)
                                        head.enemy = attacker;
                                org = head.origin + (head.mins + head.maxs)*0.5;
				points = 0.5*vlen (inflictor.origin - org);
				if (points < 0)
                                        points = 1;
                                points = 666/points;
                                if (points < 1)
                                        points = 0;
				if (points > 0)
				{
                                        if (head.classname != "shambler")                                        
                                        {       // shambler takes no damage from lightning in water
                                                if (CanDamage (head, inflictor))
                                                        sprint (attacker,"Zapping");
                                                        sprint (attacker,head.classname);
                                                        sprint (attacker,"\n");
                                                        T_Damage (head, inflictor, attacker, points);
					}
				}
                                }
			}
		}
		head = head.chain;
	}
};
void(entity attacker, float damage) T_BeamDamage =
{
	local	float 	points;
	local	entity	head;
	
	head = findradius(attacker.origin, damage+40);
	
	while (head)
	{
		if (head.takedamage)
		{
			points = 0.5*vlen (attacker.origin - head.origin);
			if (points < 0)
				points = 0;
			points = damage - points;
			if (head == attacker)
				points = points * 0.5;
			if (points > 0)
			{
				if (CanDamage (head, attacker))
				{
                                        if (head.classname == "shambler")                                        
						T_Damage (head, attacker, attacker, points*0.5);
					else
						T_Damage (head, attacker, attacker, points);
				}
			}
		}
		head = head.chain;
	}
};

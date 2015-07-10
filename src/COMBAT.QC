.float floating;
void() T_MissileTouch;
void() info_player_start;
void(entity targ, entity attacker) ClientObituary;
void() monster_death_use;
void(entity inflictor, entity attacker, float dmg,entity ignore) T_RadiusDamage;
void() Ressurect;

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

void() RemovePowerups=
{
           if(self.small)
           {
                self.mass=self.mass*10;
                if(self.volume==-0.75)
                        self.volume= 0;
                self.speed=self.speed*4;
                self.max_health=self.max_health*4;
                self.jumphite=self.jumphite*10;
           }
        if(self.skin==25||other.skin==26)
                self.health = -99;
        if(self.skin>23)
                self.skin=self.oldskin;
        self.nextthink=time;
        self.pausetime = 0;
        self.attack_finished = 0;
        self.alivetime = 0;
	self.invisible_finished = 0;	// don't die as eyes
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
        self.climbing=FALSE;
        self.hover=FALSE;
        self.volume = 0;
        self.super_time = 0;
        self.rad_time = 0;
        self.invisible_time = 0;
        self.invincible_time = 0;
        self.impulse = 0;
};

void(entity targ, entity attacker,entity inflictor) Killed =
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

        if((self.classlabel=="Paladin")&&random()<0.2)
                self.ressurect=TRUE;

        if(self.classname=="player")
                RemovePowerups();

        if(self.classname!="chakram"&&self.classname!="disc"&&self.classname!="lightsaber")
        {
                self.takedamage = DAMAGE_NO;
                self.touch = SUB_Null;
        }

        if((attacker.skin==17||attacker.oldskin==17)&&(deathmatch||random()<0.2)&&self.alive)
	  {	  
		if(self.classname=="player")
			sprint(self,"I'm Good, you're Bad, and your mother's Ugly!\n");
		sprint(attacker,"Damn, I'm Good...\n");
		local float r;
		r=random()*3 + 1;
		if(r==1)
                sound(attacker,CHAN_AUTO,"weapons/gbu1.wav",1,ATTN_NONE);
		else if(r==2)
                sound(attacker,CHAN_AUTO,"weapons/gbu2.wav",1,ATTN_NONE);
		else if(r==3)
                sound(attacker,CHAN_AUTO,"weapons/gbu3.wav",1,ATTN_NONE);
		else
                sound(attacker,CHAN_AUTO,"weapons/gbu4.wav",1,ATTN_NONE);
	}
   if(attacker.waterlevel!=3)
        if(attacker.racename=="TigerMan"&&random()<0.2&&self.alive)
                sound(attacker,CHAN_VOICE,"tiger/angry.wav",1,ATTN_NONE);
        else if(attacker.skin==16&&random()<0.2&&random()<0.5&&self.alive)
                sound(attacker,CHAN_VOICE,"xena/femyell.wav",1,ATTN_NONE);

//        if(self.enemy.classname == "spell") self.enemy.enemy = self.enemy.owner;

        if ((self.skin==1&&self.classname!="player")||(self.skin==25&&self.classname=="player"))
                self.health = -99;

        if (pointcontents(self.origin+'0 0 24') < -2 && pointcontents(self.origin+'0 0 24') > -5)
                      DeathBubbles (5);

        if (self.charmed && self.classname != "player")
                {
                if(self.classname=="Borg")
                {
                sprint(self.controller,"Your Borg ");
                printnum=ftos(self.volume);
                sprint(self.controller,printnum);
                sprint(self.controller," of ");
                printnum=ftos(self.controller.charmed);
                sprint(self.controller,printnum);
                }
                else
                {
                self.controller.charmed = self.controller.charmed - 1;
                sprint(self.controller,"Your ");
                sprint(self.controller,self.classname);
                }
                sprint(self.controller," has been killed!\n");
                self.charmed = FALSE;
                }

        if ((attacker.classname == "player" || attacker.charmed||attacker.controller.classname=="player"||inflictor.controller.classname=="player")&& (self.alive||self.classname=="zombie")&&self.controller!=attacker&&self!=attacker)
                {
		    if(attacker.classname=="betty")
                        printo = attacker.controller;
			else if(inflictor.classname=="betty")
				printo = inflictor.controller;
                else if(attacker.classname!="player")
                        printo = attacker.controller;
                else
                {
                printo=attacker;
                if(attacker.enemy == self)
                        attacker.enemy == world;                
                }
                if(attacker.classlabel=="Dark Jedi"&&attacker.health>0)
                        {
                        attacker.health = attacker.health + 10;
                        if(attacker.health>attacker.max_health&&attacker.health<attacker.max_health+11)
                                attacker.health = attacker.max_health;
                        }
                if(printo.racename!="T-800"&&printo.racename!="Borg")
                        ExperienceCheck(printo);
                else if(printo.racename=="Borg"&&random()<0.2)
                        BorgSpeak(printo);
                }

        if (attacker.charmed&&self.alive&&attacker.classname!="player")
                {
                if(attacker.classname=="Borg")
                {
                sprint(attacker.controller,"Your Borg ");
                printnum=ftos(attacker.volume);
                sprint(attacker.controller,printnum);
                sprint(attacker.controller," of ");
                printnum=ftos(attacker.controller.charmed);
                sprint(attacker.controller,printnum);
                }
                else
                {
                sprint(attacker.controller,"Your ");
                sprint(attacker.controller,attacker.classname);
                }
                sprint(attacker.controller," has killed a ");
                sprint(attacker.controller,self.classname);
                sprint(attacker.controller,"\n");
                }

        if((self.skin==2&&self.classname!="player")||(self.skin==25&&(self.classname=="player"||self.classname=="corpse"||self.classname=="head")))
           {
                if(inflictor.classname=="fire")
                        if(self.classname=="player")
                                self.skin=self.oldskin;
                        else
                                self.skin=0;
                else
                {
                        sound(self,CHAN_AUTO,"weapons/fshatter.wav",1,ATTN_NORM);
                        self.health= -99;
                }
           }

	if (self.health < -99&&self.classname=="player")
		self.health = -99;		// don't let sbar look bad if a player

        self.enemy = attacker;

	if (self.flags & FL_MONSTER)
	{
		killed_monsters = killed_monsters + 1;
		WriteByte (MSG_ALL, SVC_KILLEDMONSTER);
	}
        if(!self.ressurect)
        {
	      self.th_stand = SUB_Null;
              self.th_walk = SUB_Null;
              self.th_run = SUB_Null;
              self.th_melee = SUB_Null;
              self.th_missile = SUB_Null;
              self.touch = SUB_Null;
	      self.alive = FALSE;
	      self.charmed = FALSE;
	      self.controller = self;
	      self.active = 0;
        }
              self.th_pain = SUB_Null;

        if(self.classname=="player"&&!self.ressurect)
           ClientObituary(self, attacker);

	monster_death_use();
        if(self.enemy.classname!="player"&&!self.ressurect)
                self.enemy=self;
        self.th_die();

        if(self.ressurect)
        {
                self.think=Ressurect;
                self.nextthink=time + 3;
        }
        else self = oself;
};

void(vector org) spawn_bounce =
{
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_TELEPORT);
	WriteCoord (MSG_BROADCAST, org_x);
	WriteCoord (MSG_BROADCAST, org_y);
	WriteCoord (MSG_BROADCAST, org_z);
};

void(entity targ, entity inflictor, entity attacker, float damage) T_Damage=
{
	local	vector	dir;
        local   entity  oldself, swap,printo;
        local   float   save, expplus;
        local   float   take, r;
        local   string  printnum;

     if(inflictor.classname=="player")
          inflictor.actualhit=inflictor.actualhit + 1;
     else if (!inflictor.alive&&inflictor.actualhit==0)
	if(inflictor.controller.classname=="player")
	{
		if(inflictor.classname!="player")
			inflictor.actualhit=1;
		inflictor.controller.actualhit=inflictor.controller.actualhit + 1;
	}
	else if(inflictor.owner.classname=="player")
	{
		if(inflictor.classname!="player")
			inflictor.actualhit=1;
		inflictor.owner.actualhit=inflictor.owner.actualhit + 1;
	}


        if(attacker.small||inflictor.small)
                damage=damage*0.1;

        if(targ.small)
                damage=damage*10;

        if (!targ.takedamage||(targ.magicresist&&inflictor.classname=="spell")||(!targ.allset&&targ.classname=="player"))
		return;

        if (targ.classname == "player" && targ != attacker&&targ.alive)
                targ.enemy = attacker;

        if (targ.protmisstime > time && (inflictor.classname == "rocket" || inflictor.classname == "grenade" || inflictor.classname=="shalmissile" || inflictor.classname=="homespread" || inflictor.classname=="spreadrocket" || inflictor.classname=="homerocket"||inflictor.classname=="shalmissile"))
                {
                T_RadiusDamage(inflictor, attacker, damage, targ);
                return;
                }

	if (targ.flags & FL_GODMODE)
		return;

	if (targ.invincible_finished >= time)
	{
		if (self.invincible_sound < time)
		{
//                        sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
                        sound (targ, CHAN_ITEM, "items/protect.wav", 1, ATTN_NORM);
			self.invincible_sound = time + 2;
		}
		return;
	}

  if(targ.racename!="T-800"&&
        targ.racename!="Borg"&&
        random()<0.5&&
        targ.alive&&
       (
        (attacker==inflictor&&
          (attacker.classname=="knight"||attacker.classname=="hell knight"||attacker.classname=="ogre"||attacker.classname=="fiend"||(attacker.classname=="shambler"&&attacker.volume==FALSE)))
        ||
        (targ.axhitme||
           inflictor.classname=="chakram"||
           inflictor.classname=="longsword"||
           inflictor.classname=="batleth") ) )
          {
          targ.woundmaker=attacker;
          targ.bloodloss = targ.bloodloss + 1;
          if(damage>targ.health)
                targ.decap=TRUE;
          }
        else targ.decap=FALSE;

	damage_attacker = attacker;

        if (attacker.super_damage_finished > time)
		damage = damage * 4;

        if(attacker.classlabel=="Paladin")
                damage=damage*0.75;
/*
        if(attacker.hitplus>0)
                else damage=damage*attacker.hitplus;
*/

	save = ceil(targ.armortype*damage);
	if (save >= targ.armorvalue)
	{
		save = targ.armorvalue;
		targ.armortype = 0;	// lost all armor
		targ.items = targ.items - (targ.items & (IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3));
	}
	
	targ.armorvalue = targ.armorvalue - save;
        if(targ.classname != "player")
                targ.damagetake=1;
        take = ceil(damage-save)*targ.damagetake;

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

        if ((teamplay == 1) && (targ.team > 0)&&(targ.team == attacker.team))
		return;
/*        if(take>targ.health*0.25&&targ.skin==1&&targ.classname=="player")
                        {
                        sound (targ, CHAN_VOICE, "jaworski/bastard.wav", 1, ATTN_NORM);
                        targ.zap_finished=time+1;
                        }
        if(((take>targ.health*0.5&&random()<0.2)||targ.health<=0)&&attacker.skin==1&&attacker.classname=="player")
                        {
                        sound (attacker, CHAN_VOICE, "jaworski/yes.wav", 1, ATTN_NORM);
                        attacker.zap_finished=time+0.5;
                        }
*/
        targ.health = targ.health - take;
	if(take>100)
		r=6;
	else if(take>80)
		r=5;
	else if(take>60)
		r=4;
	else if(take>40)
		r=3;
	else if(take>25)
		r=2;
	else if(take>10)
		r=1;
	else r=0;
	if(r)
		if(random()<0.5)
			if(random()<0.5)
				targ.punchangle_x=r;
			else
				targ.punchangle_x= 0 - r;
		else	if(random()<0.5)
				targ.punchangle_y=r;
			else
				targ.punchangle_y= 0 - r;

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

        if ((attacker.classname == "player"||attacker.charmed||attacker.controller.classname=="player"||inflictor.controller.classname=="player")&& 
(targ.alive||targ.classname=="zombie") && targ.controller != attacker)
        {
               if (targ.health <= 0)
                       expplus = take + targ.health;
               else if(targ.classname != "zombie")
                       expplus = take;
               else expplus = 0;
               if(attacker.classname=="betty"&&attacker.controller.classname=="player")
                       printo = attacker.controller;
               else if(inflictor.classname=="betty"&&inflictor.controller.classname=="player")
                       printo = inflictor.controller;
               else if(attacker.classname!="player")
                       printo=attacker.controller;
               else
                       printo=attacker;
               if(printo.racename=="Human")
                       printo.exp = printo.exp + expplus*skill/3.5;
               else if(printo.dishonor&&(!targ.invisible_time))
                       printo.exp = printo.exp - expplus*skill/5;
               else printo.exp = printo.exp + expplus*skill/5;
               if(printo.racename=="T-800"||printo.racename=="Borg")
                        printo.exp = 0;
        }

        if (inflictor.classname == "spell")
                inflictor.mass = inflictor.mass + take;

	if (targ.health <= 0)
	{
                if(random()<0.5&&attacker==inflictor&&((attacker.volume==FALSE&&attacker.classname=="shambler")||attacker.weapon==IT_LIGHTNING))
                        targ.health=-99;
                if(targ.classname=="player")
                        if((targ.health>-50&&random()<0.3&&targ.health<-10)||(inflictor.classname=="lightsaber"&&random()<0.5)
                        ||(inflictor.classname=="chakram"&&random()<0.4)
                        ||((targ.deadmeat||inflictor.classname=="disc")&&random()<0.8)
                        ||(random()<0.3&&attacker==inflictor&&((attacker.volume==FALSE&&attacker.classname=="shambler")||attacker.weapon==IT_LIGHTNING))
                        ||targ.deathtype=="cheater")
                                targ.decap=TRUE;
                if(targ.deadmeat)
                {
                        targ.deadmeat=FALSE;
                        if(targ.decap)
                                targ.decap=2;
                }
                targ.deadflag=DEAD_DEAD;
                if ((attacker.classname == "player"||attacker.charmed) && (targ.alive)&&targ.controller!=attacker)
                        {
                        if(attacker.classname!="player")
                                printo=attacker.controller;
                        else printo=attacker;
                        if(self.intel<1)
                                r=1;
                        else r=self.intel;
                        if(printo.dishonor&&(!targ.invisible_time))
                               printo.exp = printo.exp - expplus*skill*3*r/5;
                        else printo.exp = printo.exp + expplus*skill*3*r/5;
                        }
                if(targ.classname=="player")
                        if(attacker.charmed&&attacker.classname!="player")
                                targ.deathtype="charmed";                                
                        else if(inflictor.classname=="homerocket"||inflictor.classname=="homespread"||inflictor.classname=="spell"||inflictor.classname=="plasmabolt"||inflictor.classname=="lightsaber"||inflictor.classname=="chakram"||inflictor.classname=="disc"||inflictor.controller.classname=="sentinel"||inflictor.classname=="tripmine"||inflictor.classname=="betty")
                                targ.deathtype=inflictor.classname;
                if(targ.classname!="zombie")
                        if(targ.health<-35&&(inflictor.classname=="spike"||inflictor.classname=="superspike"||inflictor.classname=="laser"||attacker.weapon<4||attacker.weapon==128)&&inflictor.classname!="betty"&&inflictor.classname!="tripmine")
                                targ.health= -35;
                Killed (targ, attacker,inflictor);
	}
        else
        {
        if(targ.racename=="Borg"&&attacker.phase>0&&targ.classname=="player")
                {
                printnum=ftos(attacker.phase);
                sprint(targ,"Attacker's Phase Variance: ");
                sprint(targ,printnum);
                sprint(targ,"\n");
                sound (targ, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                }

        targ.deathtype="";
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

    if((self.skin!=1&&self.skin!=2)||(self.classname=="player"&&self.skin<24))
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
        local   float   points, inertia;
        local   entity  head;
	local	vector	org;

        if(attacker.small||inflictor.small)
                head = findradius(inflictor.origin, damage*0.25 + 4);
        else head = findradius(inflictor.origin, damage + 40);
	
        if(attacker.alive)
                attacker.hitplus = 1;
	while (head)
	{
                if (head != ignore && head.protmisstime < time)
		{
                        if (head.takedamage)// if not alive and :&&head.owner!=inflictor.owner&&head.controller!=inflictor.controller)
			{
                                if(head.classname==inflictor.classname&&(head.classname=="tripmine"||head.classname=="betty"||(head.owner.classname=="player"&&head.owner==inflictor.owner)))
                                        points=0;
                                else
                                {
                                if (head.classname == "player" && head != attacker)
                                        head.enemy = attacker;
				org = head.origin + (head.mins + head.maxs)*0.5;
                                points = 0.5*vlen(inflictor.origin - org);
                                if (points < 0)
					points = 0;
                                                                
                                if((attacker.small||inflictor.small)&& damage * 0.1 - points <= 0)
                                        points=0;
                                else points = damage - points;
				if (head == attacker)
                                        if(inflictor.classname=="maudib")
                                                points=0;
                                        else points = points * 0.5;
				if (points > 0)
				{
					if (CanDamage (head, inflictor))
					{	// shambler takes half damage from all explosions
                                                if (head.classname == "shambler")
                                                        points = points * 0.5;
                                                if((head.classname=="lightsaber"&&head.running)||head.classname=="monster_oldone"||head.classname=="monster_boss")
                                                        T_Damage (head, inflictor, attacker, points);
                                                else
                                                {
								if (head.mass==0)
									inertia = 1;
								else inertia = head.mass;
                                                head.velocity=head.velocity+normalize(head.origin-inflictor.origin)*(points*10/inertia);
                                                if(head.flags&FL_ONGROUND)
                                                        head.flags=head.flags-FL_ONGROUND;
                                                T_Damage (head, inflictor, attacker, points);
                                                }
                                        }
                                }
                                }
			}
		}
		head = head.chain;
	}
};
void(entity inflictor, entity attacker, float dam, entity ignore) T_RadiusDamageWater =
{
        local   float   points;
        local   entity  head;
	local	vector	org;

        head = findradius(inflictor.origin, dam);
	
	while (head)
	{
                if (head != ignore&&head.racename!="Bossk"&&head.skin!=13&&head.oldskin!=13&&head.classname!="shambler")
		{
			if (head.takedamage)
			{
                                if (pointcontents(head.origin - '0 0 16') == CONTENT_WATER || pointcontents(head.origin - '0 0 16') == CONTENT_SLIME || head.floating) //  visible(inflictor)?
                                {
                                if (head.classname == "player" && head != attacker)
                                        head.enemy = attacker;
                                org = head.origin + (head.mins + head.maxs)*0.5;
				points = 0.25 * vlen (inflictor.origin - org);
				if (points <= 64)
                                        points = 1;
                                points = dam/points;
                                if (points < 1)
                                        points = 0;
				if (points > 0)
                                        {
//Taking out because it requires line of sight
//But may cause someone in another pool of water
//to be hit illegally?                           if (CanDamage (head, inflictor))
                                                        if(other.energyabsorb)
                                                        {
                                                        stuffcmd (other, "bf\n");
                                                        other.health=other.health + points;
                                                        if(other.health>other.max_health*2)
                                                                other.health=other.max_health*2;
                                                        }
                                                        else
                                                        {
                                                        if(head.racename=="T-800"||head.racename=="Borg")
                                                                points=points*2;
                                                        head.deathtype="zap";
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

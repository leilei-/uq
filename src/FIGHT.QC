float   enemy_vis, enemy_infront, enemy_range;
float   enemy_yaw;
void() FoundTarget;
void() ogre_pull1;
/*
A monster is in fight mode if it thinks it can effectively attack its
enemy.
When it decides it can't attack, it goes into hunt mode.
*/

void() MonsterWaterMove =
{
	if(self.pain_finished<=time||random()<0.2)
	{
        if ((pointcontents(self.origin+'0 0 24') < -2 && pointcontents(self.origin+'0 0 24') > -5&&self.suff!=1) || self.suff>1)
	  {
	  	if(self.enemy==world)
			self.enemy=self;
		T_Damage(self,self.enemy,self.enemy,2);
		self.pain_finished=time;
		self.th_pain(self.enemy,2);
		if(self.health<=0)
			if(self.suff>0)
				sound (self, CHAN_VOICE, "weapons/heartatt.wav", 1, ATTN_NORM);
			else
				sound (self, CHAN_VOICE, "player/h2odeath.wav", 1, ATTN_NORM);
		else if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/drown1.wav", 1, ATTN_NORM);
		else if(random()<0.5)
			sound (self, CHAN_VOICE, "player/drown2.wav", 1, ATTN_NORM);
	  }
        if (pointcontents(self.origin - '0 0 24') == CONTENT_LAVA)
  	  {
		if(self.enemy==world)
			self.enemy=self;
            T_Damage (self,self.enemy, self.enemy, 5);
		}
        else if (pointcontents(self.origin - '0 0 24') == CONTENT_SLIME)
	  	{
		if(self.enemy==world)
			self.enemy=self;
            T_Damage (self,self.enemy, self.enemy, 1);
	  }
	}
	  if (pointcontents(self.origin+'0 0 24') < -2 && pointcontents(self.origin+'0 0 24') > -5)
	  {
              self.origin_z = self.origin_z + 2;
	        if(self.racename=="Borg")
	        {
      	    sound (self, CHAN_AUTO, "enforcer/enfstop.wav", 1, ATTN_NORM);
		    if(self.enemy==world)
				self.enemy=self;
	          T_Damage (self, self.enemy, self.enemy, 3);
                T_RadiusDamageWater(self, self, 128,self);
	          self.zap_finished = time + 0.5;
	        }
                  if(random()<0.2&&random()<0.2&&(self.flags&FL_MONSTER)&&self.takedamage&&self.alive&&self.health&&self.classname!="zombie" && self.classname!="rotfish"&&self.suff!=1)
	              DeathBubbles (1);
	  }
};

void()Bleed=
{
        if(self.pain_finished<=time&&self.alive)
                {
                SpawnBlood (self.origin+'0 0 12', '0 0 -64', self.bloodloss,self);
                if(random()<0.2)
                        {
                        if (self.bloodloss > 3 && self.classname == "player")
                                self.bloodloss = 3;
                        self.health = self.health - self.bloodloss;
                        self.pain_finished = time + 0.5;
                        if (self.health<=0)
                                Killed(self,self.woundmaker,self.woundmaker);
                        else if(random()<0.2&&random()<0.5)
                                self.th_pain(self.woundmaker,100);
                        }
                }
};

void() knight_attack =
{
	local float		len;
	
// decide if now is a good swing time
	len = vlen(self.enemy.origin+self.enemy.view_ofs - (self.origin+self.view_ofs));
	
	if (len<80)
		knight_atk1 ();
	else
		knight_runatk1 ();
};
//=============================================================================
float() CheckAnyAttack =
{
        local vector    spot1, spot2,vec; 
	local entity	targ;
	local float		chance;
	local float		enemy_yaw;

        if (self.charmed)
                if(self.enemy == self.controller)
                        return FALSE;
                else if (self.controller.enemy.alive&&self.controller.enemy!=self&&self.controller.enemy!=world)
                        if(visible(self.controller.enemy)||self.enemy==world||self.enemy==self.controller)
//                        {
                        self.enemy = self.controller.enemy;
//                        bprint("Attacking Controller's enemy\n");
//                        FoundTarget();
//                        }
                        else
//                        {
                        self.oldenemy=self.controller.enemy;
//                        bprint("Putting Controller's enemy in Que\n");
//                        }
//        bprint("Past Checkpoint 1\n");

        if ((!enemy_vis) || self.enemy.isfeign || (self.enemy.inpain == 2))
                return FALSE;

        if (self.enemy == self || (self.charmed && (self.enemy.controller == self.controller || self.enemy == world)))
                {
//                bprint("No Enemy\n");
                self.oldenemy = self.controller;
                self.enemy == self.controller;
                if(!FindTarget())
                return FALSE;
                }
//        bprint("Past Checkpoint 2\n");

        if (!self.enemy.alive&&self.enemy.classname!="holo")
                return FALSE;

	if ((pointcontents(self.origin+'0 0 24') < -2 && pointcontents(self.origin+'0 0 24') > -5) || self.suff>0)
	  {
		MonsterWaterMove();
	  	    if(random()<0.5)
			return FALSE;
	  }		

        if(self.bloodloss>0)
	  {
                Bleed();
	  	    if(random()<0.2)
			return FALSE;
	  }		

        if(self.phase==0||random()<0.2)
                self.phase = rint((random() * 4) + 1);

if (self.classname == "fiend")
{
	if (CheckDemonMelee ())
	{
		self.attack_state = AS_MELEE;
		return TRUE;
	}
	
	if (CheckDemonJump ())
	{
		self.attack_state = AS_MISSILE;
        sound (self, CHAN_VOICE, "demon/djump.wav", 1, ATTN_NORM);
		return TRUE;
	}
        return FALSE;
}
else if (self.classname == "rottweiler")
{
	if (CheckDogMelee ())
	{
		self.attack_state = AS_MELEE;
		return TRUE;
	}
	
	if (CheckDogJump ())
	{
		self.attack_state = AS_MISSILE;
		return TRUE;
	}
        return FALSE;
}
	if (time < self.attack_finished)
		return FALSE;

	targ = self.enemy;
	
	spot1 = self.origin + self.view_ofs;
	spot2 = targ.origin + targ.view_ofs;
if(self.classname=="shambler")
	if (vlen(spot1 - spot2) > 600)
		return FALSE;

	traceline (spot1, spot2, FALSE, self);

if (trace_ent != self.enemy&&trace_ent.controller!=self.enemy&&trace_ent.owner!=self.enemy&&(!self.enemy.ducking))
        if(self.classname=="scrag")
	{	// don't have a clear shot, so move to a side
		if (self.attack_state != AS_STRAIGHT)
		{
			self.attack_state = AS_STRAIGHT;
			wiz_run1 ();
		}
		return FALSE;
	}
        else return FALSE;           // don't have a clear shot

        if (trace_inopen && trace_inwater)
                return FALSE;           // don't have a clear shot
if (self.classname == "grunt")
{
		
	if (enemy_range == RANGE_FAR)
		return FALSE;
		
	if (enemy_range == RANGE_MELEE)
		chance = 0.9;
	else if (enemy_range == RANGE_NEAR)
		chance = 0.4;
	else if (enemy_range == RANGE_MID)
		chance = 0.05;
	else
		chance = 0;

	if (random () < chance)
	{
		self.th_missile ();
		SUB_AttackFinished (1 + random());
		if (random() < 0.3)
			self.lefty = !self.lefty;

		return TRUE;
	}
}
else if (self.classname == "ogre")
{
	if (enemy_range == RANGE_MELEE)
	{
		if (CanDamage (self.enemy, self))
		{
			self.attack_state = AS_MELEE;
			return TRUE;
		}
	}

		
        if (enemy_range == RANGE_FAR)
		return FALSE;

        if(self.ammo_rockets<1)
                if(self.lasthand>-1)
                        return FALSE;
                else
                {
                        ogre_pull1();
                        return;
                }
	else if (enemy_range == RANGE_NEAR)
		chance = 0.10;
	else if (enemy_range == RANGE_MID)
		chance = 0.05;
	else
		chance = 0;

	self.attack_state = AS_MISSILE;
	SUB_AttackFinished (1 + 2*random());
	return TRUE;
}
else if (self.classname == "shambler")
{

	if (enemy_range == RANGE_MELEE)
	{
		if (CanDamage (self.enemy, self))
		{
			self.attack_state = AS_MELEE;
			return TRUE;
		}
	}

// missile attack
	if (enemy_range == RANGE_FAR)
		return FALSE;
		
	self.attack_state = AS_MISSILE;
	SUB_AttackFinished (2 + 2*random());
	return TRUE;
}
else if (self.classname == "scrag")
{
	if (enemy_range == RANGE_FAR)
	{
		if (self.attack_state != AS_STRAIGHT)
		{
			self.attack_state = AS_STRAIGHT;
			wiz_run1 ();
		}
		return FALSE;
	}
		
	if (enemy_range == RANGE_MELEE)
		chance = 0.9;
	else if (enemy_range == RANGE_NEAR)
		chance = 0.6;
	else if (enemy_range == RANGE_MID)
		chance = 0.2;
	else
		chance = 0;

	if (random () < chance)
	{
		self.attack_state = AS_MISSILE;
		return TRUE;
	}

	if (enemy_range == RANGE_MID)
	{
		if (self.attack_state != AS_STRAIGHT)
		{
			self.attack_state = AS_STRAIGHT;
			wiz_run1 ();
		}
	}
	else
	{
		if (self.attack_state != AS_SLIDING)
		{
			self.attack_state = AS_SLIDING;
			wiz_side1 ();
		}
	}
}
else
{
	if (enemy_range == RANGE_MELEE)
	{	// melee attack
		if (self.th_melee)
		{
                        if (self.classname == "knight")
				knight_attack ();
			else
				self.th_melee ();
			return TRUE;
		}
	}
	
// missile attack
	if (!self.th_missile)
		return FALSE;
		
	if (enemy_range == RANGE_FAR)
		return FALSE;
		
	if (enemy_range == RANGE_MELEE)
	{
		chance = 0.9;
		self.attack_finished = 0;
	}
	else if (enemy_range == RANGE_NEAR)
	{
		if (self.th_melee)
			chance = 0.2;
		else
			chance = 0.4;
	}
	else if (enemy_range == RANGE_MID)
	{
		if (self.th_melee)
			chance = 0.05;
		else
			chance = 0.1;
	}
	else
		chance = 0;

	if (random () < chance)
	{
		self.th_missile ();
		SUB_AttackFinished (2*random());
		return TRUE;
	}
}
return FALSE;
};



/*
=============
ai_face

Stay facing the enemy
=============
*/
void() ai_face =
{
        if(self.classname=="player")
                return;
	self.ideal_yaw = vectoyaw(self.enemy.origin - self.origin);
	ChangeYaw ();
};

/*
=============
ai_charge

The monster is in a melee attack, so get as close as possible to .enemy
=============
*/
float (entity targ) visible;
float(entity targ) infront;
float(entity targ) range;

void(float d) ai_charge =
{
	ai_face ();	
	self.running=TRUE;
	movetogoal (d);		// done in C code...
};

void() ai_charge_side =
{
	local	vector	dtemp;
	local	float	heading;
	
// aim to the left of the enemy for a flyby

	self.ideal_yaw = vectoyaw(self.enemy.origin - self.origin);
	ChangeYaw ();

	makevectors (self.angles);
	dtemp = self.enemy.origin - 30*v_right;
	heading = vectoyaw(dtemp - self.origin);
	
	self.running=TRUE;
	walkmove(heading, 20);
};


/*
=============
ai_melee

=============
*/
void() ai_melee =
{
	local vector	delta;
	local float 	ldmg;

	if (!self.enemy)
		return;		// removed before stroke
		
	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 60)
		return;
		
	ldmg = (random() + random() + random()) * 3;
	T_Damage (self.enemy, self, self, ldmg);
};


void() ai_melee_side =
{
	local vector	delta;
	local float 	ldmg;

	if (!self.enemy)
		return;		// removed before stroke
		
	ai_charge_side();
	
	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 60)
		return;
	if (!CanDamage (self.enemy, self))
		return;
	ldmg = (random() + random() + random()) * 3;
	T_Damage (self.enemy, self, self, ldmg);
};

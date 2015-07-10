/* MAGIC by Mike Gummelt */
void() cast_touch;
void() TeleEyes;

void () PrintSpellName =
{
local string printnum;
//Level 1
        if (self.spell == 24)
                sprint(self,"HEAL LIGHT WOUNDS\n");
        else if (self.spell == 28)
                sprint(self,"IRONSKIN\n");
        else if (self.spell == 32)
                sprint(self,"RESIST FIRE\n");
        else if (self.spell == 36)
                sprint(self,"ILLUMINATION\n");
        else if (self.spell == 40)
                sprint(self,"FLESH TO STONE (animal)\n");
//Level 2
        else if (self.spell == 44)
                sprint(self,"DISPEL MAGIC (self)\n");
        else if (self.spell == 48)
                sprint(self,"SUMMON SCRAG\n");
        else if (self.spell == 52)
                sprint(self,"UNLOCK DOOR\n");
        else if (self.spell == 56)
                sprint(self,"CHARM ANIMAL\n");
        else if (self.spell == 60)
                sprint(self,"FLESH TO STONE (person)\n");
//Level 3
        else if (self.spell == 64)
                sprint(self,"FIREFLY SWARM\n");
        else if (self.spell == 68)
                sprint(self,"LEVITATION\n");
        else if (self.spell == 72)
                sprint(self,"DOPPLEGANGER\n");
        else if (self.spell == 76)
                sprint(self,"GIVE LIFEFORCE (target)\n");
        else if (self.spell == 80)
                sprint(self,"REFLECTIVE SHIELD (target)\n");
//Level 4
        else if (self.spell == 84)
                sprint(self,"IMPOTENCE\n");
        else if (self.spell == 88)
                if(self.enchant_axe==TRUE)
                        sprint(self,"LOONY TOONS\n");
                else sprint(self,"ENCHANT AXE\n");
        else if (self.spell == 92)
                sprint(self,"PROTECTION FROM EXPLOSIONS\n");
        else if (self.spell == 96)
                sprint(self,"MIND SHOVE\n");
        else if (self.spell == 100)
                sprint(self,"IRRESISTABLE ATTRACTION\n");
//Level 5
        else if (self.spell == 104)
                sprint(self,"AMPHIBIAN\n");
        else if (self.spell == 108)
                sprint(self,"SUMMON OGRE\n");
        else if (self.spell == 112)
                sprint(self,"DOG'S DAY (target)\n");
        else if (self.spell == 116)
                sprint(self,"CHARM PERSON\n");
        else if (self.spell == 120)
                sprint(self,"INCREASE MASS\n");
//Level 6
        else if (self.spell == 124)
                sprint(self,"HEAL SERIOUS WOUNDS\n");
        else if (self.spell == 128)
                sprint(self,"SPELL OF SHADOWS\n");
        else if (self.spell == 132)
                sprint(self,"PROTECTION FROM MAGIC\n");
        else if (self.spell == 136)
                sprint(self,"FISH OUT OF WATER\n");
        else if (self.spell == 140)
                sprint(self,"FLESH TO STONE (monster)\n");
//Level 7
        else if (self.spell == 144)
                sprint(self,"TELE-EYES\n");
        else if (self.spell == 148)
                sprint(self,"SUMMON FIEND\n");
        else if (self.spell == 152)
                sprint(self,"INVISIBLE DEATH BARRIER\n");
        else if (self.spell == 156)
                sprint(self,"FEEBLEMIND\n");
        else if (self.spell == 160)
                sprint(self,"CHARM MONSTER\n");
//Level 8
        else if (self.spell == 164)
                sprint(self,"SUMMON VORE\n");
        else if (self.spell == 168)
                sprint(self,"MEDUSA'S GAZE\n");
        else if (self.spell == 172)
                sprint(self,"PATH OF THE ARCHVILE\n");
        else if (self.spell == 176)
                sprint(self,"SUFFOCATION\n");
        else if (self.spell == 180)
                sprint(self,"WRATH OF THE ARCHVILE\n");
//Level 9
        else if (self.spell == 184)
                sprint(self,"DISPEL MAGIC (target)\n");
        else if (self.spell == 188)
                sprint(self,"AMBUSH\n");
        else if (self.spell == 192)
                sprint(self,"MASS CHARM\n");
        else if (self.spell == 196)
                sprint(self,"METEOR SWARM\n");
        else if (self.spell == 200)
                sprint(self,"SUMMON SHAMBLER\n");
//Level 10
        else if (self.spell == 204)
                sprint(self,"HEAL GRIEVEOUS WOUNDS\n");
        else if (self.spell == 208)
                sprint(self,"QUAD DAMAGE\n");
        else if (self.spell == 212)
                sprint(self,"REFLECTIVE SHIELD (self)\n");
        else if (self.spell == 216)
                sprint(self,"LIGHTNING SUMMONING\n");
        else if (self.spell == 220)
                sprint(self,"POWER WORD, KILL\n");
        sprint (self,"Level: ");
        printnum =ftos(self.splevel);
        sprint(self,printnum);
        sprint (self," Spell: ");
        printnum = ftos((self.spell - self.splevel * 20)/4);
        sprint(self,printnum);
        sprint (self,"\n");
        sprint(self,"Mana Needed: ");
        if(self.spell>215)
                printnum="ALL";
        else printnum = ftos(self.spell);
        sprint(self,printnum);
        sprint(self," Your Mana: ");
        self.mana = rint(time - self.init_mana);
        if (self.mana > self.exp/1000)
                self.mana = self.exp/1000;
        printnum=ftos(self.mana);
        sprint(self,printnum);
        sprint(self,"\n");
        sprint(self,"Experience points: ");
        printnum=ftos(rint(self.exp));
        sprint(self,printnum);
        sprint(self,"\n");
        return;
};

void (float way) CycleSpell =
{
local float maxspell,intl,expr;
        self.spell = (self.spell - self.splevel * 20)/4;
        self.spell = self.spell + way;
        intl=floor(self.intel);
        expr=floor(self.exp/250000);
        if(deathmatch)
                maxspell = intl;
        else maxspell = intl + expr;
        if (self.spell > 5)
                {
                self.spell = 1;
                self.splevel = self.splevel + 1;
                }
        else if (self.spell < 1)
                {
                self.spell = 5;
                self.splevel = self.splevel - 1;
                }
        if (self.splevel <= 0)
                if(self.anyinvis&&maxspell<4)
                        {
                        self.splevel = 4;
                        self.spell = 1;
                        }
                else if(maxspell>10)
                        self.splevel = 10;
                else if(maxspell>0)
                        self.splevel=maxspell;
                else self.splevel = 1;
        else if (self.splevel >= 11||self.splevel>maxspell)
                if(self.anyinvis&&maxspell<4)
                        {
                        self.splevel = 4;
                        self.spell = 1;
                        }
                else self.splevel = 1;
        self.spell = self.splevel * 20 + self.spell * 4;
        PrintSpellName();
        return;
};

void (float way) CycleSpellLevel =
{
local float maxspell,intl,expr;
        self.spell = (self.spell - self.splevel * 20)/4;
        self.splevel = self.splevel + way;
        intl=floor(self.intel);
        expr=floor(self.exp/250000);
        if(deathmatch)
                maxspell = intl;
        else maxspell = intl + expr;
        if (self.splevel <= 0)
                if(maxspell>10)
                        self.splevel = 10;
                else
                self.splevel=maxspell;
        else if (self.splevel == 11||self.splevel>maxspell)
                self.splevel = 1;
        self.spell = self.splevel * 20 + self.spell * 4;
        PrintSpellName();
        return;
};
void(entity spot) MagicEffect =
{
        spawn_tfog (spot.origin);
        sound(spot,CHAN_VOICE,"misc/r_tele5.wav",1,ATTN_NORM);
        return;
};

void() bright =
{
        local vector    vel;
        self.effects=6;
	self.think = flare_dim;
        self.nextthink = time + 15;
	sound (self, CHAN_WEAPON, "misc/power.wav", 1, ATTN_NORM);
	vel = '0 0 150';
	particle (self.origin+vel*0.01,vel,111,150);
        vel = '0 0 120';
	particle (self.origin+vel*0.01,vel,73,200);
};

void()sparkle=
{
particle(self.origin,'0 0 0',crandom()*255,random()*7+3);
self.think = sparkle;
self.nextthink = time+0.01;
};

void () Cast =
{
if(self.classlabel!="Jedi"&&self.classlabel!="Dark Jedi")
   {
        if(self.spell==64&&self.fireflies.alivetime>time)
                {
                sprint(self,"Fireflies are already on a sortie!\n");
                sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                return;
                }
       if(self.spell==216&&self.lightning.active)
                {
                sprint(self.owner,"Wait for previous Lightning spell to wear off...\n");
                return;
                }

        MagicalHitplus();
   }
        self.oldweaponmodel=self.weaponmodel;
        self.weaponmodel="progs/hand.mdl";
        self.weaponframe=0;
        self.attack_finished=time + 1;
        self.effects=self.effects + EF_MUZZLEFLASH;
        self.show_hostile = time + 1;   // wake monsters up
        if (self.spell>199||(((self.spell - (self.splevel*20)) /4 < 4) && self.spell != 52 && self.spell!=84 && self.spell!=184))
                if(self.spell==88)
                        {
                        if(self.enchant_axe!=TRUE)
                                {
                                SelfCast();
                                return;
                                }
                        }
                else
                {
                SelfCast();
                return;
                }
if(self.classlabel!="Jedi"&&self.classlabel!="Dark Jedi")
   {
        if (self.spell == 56 && self.charmed >= 10)
        {
                sprint(self,"You can't control more than ten monsters at a time\n");
                return;
        }
        self.alivetime = time + self.spell/20 - (self.intel/2);
        self.mana = rint(time - self.init_mana);
        if (self.mana > self.exp/1000)
                self.mana = self.exp/1000;
        self.init_mana = time - self.mana + self.spell;
   }
        if(random()<0.5)
                sound(self,CHAN_VOICE,"magic/castfar1.wav",1,ATTN_NORM);
        else
                sound(self,CHAN_VOICE,"magic/castfar2.wav",1,ATTN_NORM);

        if (self.spell == 196)
                {
                FireBall(2,'0 0 0');
                FireBall(2,'0 0 16');
                FireBall(2,'0 0 -16');
                FireBall(2,'0 16 0');
                FireBall(2,'0 -16 0');
                return;
                }
local   entity  missile;

	missile = spawn ();
	missile.hitplus = self.hitplus;
        missile.owner = self;
        missile.movetype = MOVETYPE_FLYMISSILE;
        missile.solid = SOLID_BBOX;
        missile.classname = "spell";
        if (self.spell == 216)
                missile.aflag = 33;
        else if (self.spell == 52)
                missile.classname = "magickey";
	makevectors (self.v_angle);
	missile.velocity = aim(self, 1000);
	missile.velocity = missile.velocity * 1000;
	missile.angles = vectoangles(missile.velocity);
        missile.spell = self.spell;

        missile.effects=8;

        if(self.spell==36)
                {
                missile.touch = flare_touch;
                missile.think = bright;
                missile.nextthink = time + 2;
                missile.classname = "flare";
                }
        else
                {
                missile.touch = cast_touch;
                if(self.classlabel!="Jedi"&&self.classlabel!="Dark Jedi")
                        {
                        missile.think = sparkle;
                        missile.nextthink = time;
                        }
                }

        setmodel (missile, "progs/null.spr");
        setsize (missile, '0 0 0', '0 0 0');
        if(self.small)
                setorigin (missile, self.origin + v_forward*4 + '0 0 4');
        else setorigin (missile, self.origin + v_forward*8 + '0 0 16');
};

void (entity loser) DispelMagic =
{
                MagicEffect(loser);
                loser.enchant_axe=loser.dog_finished=loser.suff=loser.levitime=loser.firesistime=loser.reflecttime=loser.protmisstime=loser.prottime=loser.archtime=loser.dog_time=loser.alivetime=loser.invisible_time=loser.super_time=loser.alivetime=loser.attack_finished=loser.invisible_finished = loser.super_damage_finished=0;
//                loser.mass = 1;
                loser.pausetime = 0;
                if (loser.suff > 0)
                       {
                       loser.air_finished = time + 12;
                       loser.suff = 0;
                       sound (loser, CHAN_VOICE, "player/gasp2.wav", 1, ATTN_NORM);
                       }
                sprint(loser,loser.netname);
                sprint(loser," is cleansed of all magic\n");
};

void (entity loser,float potent, entity printo) HoldWeak =
{
local string printnum;
        if (loser.active == -1 || (!loser.alive)||(loser.skin==1&&loser.classname!="player"))
                return;
        if (loser.health > 149*potent || (loser.active != potent && potent != 3)||loser.racename=="Dark Elf")
                {
                sprint (printo,"Spell had no effect!\n");
                remove(self);
                return;
                }
        MagicEffect(loser);
        printnum = ftos(150*potent - loser.health);
        if (loser.classname == "player")
                {
                DropMelee(loser);
                loser.oldskin=loser.skin;
                loser.skin=25;
		    loser.o_angle=loser.v_angle;	
                loser.pausetime = time + 10;
                loser.attack_finished = time + 10;
                loser.alivetime = time + 10;
                printnum="10";
                sprint (loser,"You have been held for 10 seconds!\n");
                sprint (printo,loser.netname);
                }
        else
                {
                loser.oldskin=loser.skin;
                loser.skin = 1;
                loser.nextthink = time + 150*potent - loser.health;
                sprint (printo,loser.classname);
                }
        if(loser.flags&FL_FLY)
                loser.flags = loser.flags - FL_FLY;
        if (loser.flags & FL_SWIM)
                loser.flags = loser.flags - FL_SWIM;
        if(loser.flags&FL_ONGROUND)
                loser.flags = loser.flags - FL_ONGROUND;
        sprint (printo," has been held for ");
        sprint(printo,printnum);
        sprint (printo," seconds!\n");
        return;
};

void (entity loser,float potent,entity printo) Charm =
{
        if (loser.active == -1)
                return;
        if (loser.active != potent && potent != 3)
                {
                sprint (printo,"Spell had no effect!\n");
                remove(self);
                return;
                }
        MagicEffect(loser);
        loser.charmed = TRUE;
        loser.controller = printo;
        loser.spawnflags = 0;
        loser.oldenemy = printo;
        if (printo.enemy != world && printo.enemy.alive)
                loser.enemy = printo.enemy;
        else loser.enemy = world;
        loser.follow = FALSE;
        printo.charmed = printo.charmed + 1;
        sprint (printo,loser.classname);
        sprint (printo," has been charmed!\n");
        return;
};

void (entity loser, entity winner) BounceBack =
{
local vector vtemp,dir;
local float dist;
        if(winner.classname=="lightsaber")
                {
                particle (winner.origin,'0 0 16'*0.1, 242, 10);
                winner.effects=EF_MUZZLEFLASH;
                }
        else MagicEffect(winner);
        dist = vlen(winner.origin - loser.origin);
        if (loser.reflecttime>time && dist < 200)
                {
                remove(self);
                return;
                }
        vtemp =loser.origin + '0 0 10';
        dir = normalize(vtemp - winner.origin);
        if (self.classname == "spike"
            ||self.classname=="snowball"
            ||self.classname=="shrinkball"
            ||self.classname=="superspike"
            ||self.classname=="knightspike"
            ||self.classname=="shrapnel")
                launch_spike(winner.origin,dir,winner,self.classname,0);
        else if (self.classname == "rocket"||self.classname=="homerocket")
                W_FireRocket2(dir,winner,"rocket");
        else if (self.classname == "wizspike")
                {
                launch_spike (winner.origin, dir, winner,"wizspike",0);
                newmis.velocity = dir*600;
                newmis.owner = winner;
		newmis.classname = "wizspike";
		setmodel (newmis, "progs/w_spike.mdl");
		setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
                }
        else if (self.classname == "plasmabolt")
                W_FireRocket2(dir,winner,"plasmabolt");
        else if (self.classname == "homespread")
                W_FireSpread2(dir,winner,"homespread");
        else if (self.classname == "spreadrocket")
                W_FireSpread2(dir,winner,"spreadrocket");
        else if (self.classname == "laser")
                PLaser(dir,winner); 
        remove(self);
};

void (entity loser, entity winner, float oldsp) GrenBounceBack =
{
        local vector dir;
                if(winner.classname=="lightsaber")
                        {
                        particle (winner.origin,'0 0 16'*0.1, 242, 10);
                        winner.effects=EF_MUZZLEFLASH;
                        }
                else MagicEffect(winner);
                self.owner = winner;
                self.enemy = loser;
                dir = normalize(loser.origin + '0 0 10' - winner.origin);
                self.velocity = '0 0 0' * 0;
                self.velocity = dir * oldsp;
                self.velocity_x = self.velocity_x + (random () * 150 - 75);
                self.velocity_y = self.velocity_y + (random () * 150 - 75);
                self.velocity_z = self.velocity_z + (random () * 150);
		self.angles = vectoangles(self.velocity);
};

void () Zap =
{
                if(self.owner.health<=0)
                        {
                        self.active=FALSE;
                        remove(self);
                        }
                self.origin = self.owner.origin;
                if (self.owner.enemy.health > 0)  self.enemy = self.owner.enemy;
                if (self.enemy.health > 0 && self.enemy != self.owner && visible(self.enemy) && self.enemy.owner!=self.owner)
                {
                        CastLightning();
                        sound (self, CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
                }
                else if (FindTarget())
                {
                     CastLightning();
                     sound (self, CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
                }
                if (self.alivetime < time || self.mass > 1000)
                        {
                        self.active=FALSE;
                        remove(self);
                        }
                self.think = Zap;
                self.nextthink = time + (random()*1);
};

void() AnvilThink =
{
if((self.flags & FL_ONGROUND)&&checkbottom(self)==FALSE)
        self.flags = self.flags - FL_ONGROUND;
if(self.alivetime<time)
        {
        self.think=SUB_Null;
        self.touch=SUB_Null;
        self.nextthink= -1;
        }
else
{
self.think=AnvilThink;
self.nextthink=time+0.1;
}
};

void() AnvilHit =
{
  if(other==self.controller)
         return;
local float clink;
  self.avelocity = '300 300 300';
  setsize (self,'-4 -8 -4','4 8 4');
  if (other.takedamage&&self.active!=TRUE)
  {
              spawn_touchblood(40);
              SpawnChunk(self.origin, self.velocity);
              other.punchangle_x = -20;
              T_Damage(other, self, self.controller, 30);
              sound(other, CHAN_AUTO, "weapons/anvilhit.wav", 1, ATTN_NORM);
              if(self.flags & FL_ONGROUND)
                      self.flags = self.flags - FL_ONGROUND;
              self.active=TRUE;
  }
  else if(other!=self.controller)// if(self.active==TRUE)
  {
  self.stepping=self.stepping+1;
  if(self.stepping>20)
        remove(self);
  clink = random() * FL_SWIM;
  if (clink <= 1) 
      sound(self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
  else
      sound(self, CHAN_WEAPON, "weapons/tink1.wav", 1, ATTN_NORM);
//  setsize(self, '-3 -3 -5', '3 3 3');
//  self.movetype = MOVETYPE_BOUNCE;
  }
};

void(entity loser) Woof=
{
local entity summoned;
                if(loser.reflecttime>time)
                        loser=self.owner;
                if(loser.racename=="Dark Elf")
                        {
                        sprint(self.owner,"The Dark Elf resisted your spell!\n");
                        return;
                        }
                if(loser.classname=="rottweiler"||loser.classlabel=="dog"||loser.dog_finished>time)
                        {
                        sprint(self.owner,"That's already a dog!\n");
                        return;
                        }
                if(loser.classname!="player")
                {
                        MagicEffect(loser);
                        summoned = spawn();
                        summoned.nospells=TRUE;
                        setorigin(summoned, loser.origin);
                        summoned.angles = loser.angles;
                        remove(loser);
                        if(loser.racename=="Borg")
                                summoned.think = monster_borgdog;
                        else summoned.think = monster_dog;
                        summoned.nextthink = time;
                }
                else
                {
                        MagicEffect(loser);
                        loser.health = 25;
                        loser.modelindex = modelindex_dog;
                        loser.dog_time = 1;
                        loser.dog_finished = time + 120;
                        loser.weaponmodel = "";
                        if(loser.racename=="Borg")
                        {
                                loser.oldskin=loser.skin;
                                loser.skin=3;
                        }
                        DogChange(loser);
                        loser.view_ofs = '0 0 4';
                }
                sound (loser, CHAN_VOICE, "dog/ddeath.wav", 1, ATTN_NORM);
};

void () cast_touch =
{
local string removeme;
local vector dir;
local entity summoned;
        if (other == self.owner||other.owner==self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

        if (other.active == -1)
                {
                sprint(self.owner,"Magic does not effect this monster!\n");
                return;
                }
if(self.owner.classlabel!="Jedi"&&self.owner.classlabel!="Dark Jedi")
  {
        if (other.prottime > time)
                {
                spawn_tfog (other.origin);
                sound(other,CHAN_AUTO,"enforcer/enfstop",1,ATTN_NORM);
                sprint(self.owner,other.netname);
                sprint(self.owner," is protected from magic");
                return;
                }
        if(other.classlabel=="Paladin")
                {
                self.owner.hitplus = self.owner.hitplus/2;
                if(random()<0.2)
                        {
                        MagicEffect(other);
                        sprint(self.owner,other.netname);
                        sprint(self.owner,", the Paladin has reflected your spell!\n");
                        other=self.owner;
                        }
                }
        if(other.magicresist&&random()<0.5)
                {
                MagicEffect(other);
                sprint(self.owner,other.netname);
                sprint(self.owner," has resisted your magic.\n");
                return;
                }
  }
        if (other.alive || self.aflag == 33||self.spell==88)
        {
        if (self.spell == 40)
            HoldWeak(other,1,self.owner);
        else if (self.spell == 60)
            HoldWeak(other,2,self.owner);
        else if (self.spell == 140)
            HoldWeak(other,3,self.owner);
        else if (self.spell == 80)
        {
                MagicEffect(other);
                other.reflecttime = time + 60;                        
                sprint (self.owner,other.classname);
                sprint (self.owner," is protected by a Reflect Shield for 1 minute!\n");
        }
        else if(self.spell == 88)
        {
                        summoned = spawn();
                        if(other.alive)
                                setorigin(summoned, other.origin+'0 0 128');
                        else setorigin(summoned, self.origin+'0 0 128');
                        setmodel(summoned,"progs/anvil.mdl");
                        summoned.solid = SOLID_BBOX;
                        summoned.movetype = MOVETYPE_BOUNCE;
                        setsize (summoned,'-1 -2 -4','1 2 4');
                        summoned.classname ="anvil";
                        summoned.controller = self.owner;
                        summoned.touch = AnvilHit;
                        summoned.think=AnvilThink;
                        summoned.nextthink=time+0.1;
                        summoned.alivetime=time+30;
        }
        else if (self.spell == 56)
            Charm(other,1,self.owner);
        else if (self.spell == 116)
            Charm(other,2,self.owner);
        else if (self.spell == 160)
            Charm(other,3,self.owner);
        else if (self.spell == 112)
            Woof(other);
        else if (self.spell == 120)
            {
            if (other.racename=="Dark Elf")
                {
                sprint (self.owner,"Dark Elf resisted your spell!\n");
                remove(self);
                return;
                }
            MagicEffect(other);
            other.mass = other.mass * 2;
            if(other.flags&FL_FLY)
                    other.flags = other.flags - FL_FLY;
            if(other.flags&FL_SWIM)
                    other.flags = other.flags - FL_SWIM;
            sprint(self.owner,other.netname);
            sprint(self.owner,"'s mass has been increased");
            sprint(self.owner,"\n");
            }
        else if (self.spell == 156)
        {
            MagicEffect(other);
            other.alivetime = time + 60;
            if (other.classname == "player")
                bprint(other.netname);
            else bprint(other.classname);
            bprint(" has been silenced for 1 minute\n");
        }
        else if (self.spell == 180)
        {
            self.touch = FireTouch;
            self.active = 5;
            sound(other,CHAN_WEAPON,"weapons/r_exp3.wav",1,ATTN_NORM);
            T_RadiusDamage (self, self.owner, 10, world);
            WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
            WriteByte (MSG_BROADCAST, TE_EXPLOSION);
            WriteCoord (MSG_BROADCAST, other.origin_x);
            WriteCoord (MSG_BROADCAST, other.origin_y);
            WriteCoord (MSG_BROADCAST, other.origin_z);
            other.movetype=MOVETYPE_BOUNCE;//???
            other.velocity_z = other.velocity_z + 1000;
            other.velocity_x = other.velocity_x + self.velocity_x*2;
            other.velocity_y = other.velocity_y + self.velocity_y*2;
            other.angles_x = random()*600;
            other.angles_y = random()*600;
            other.angles_z = random()*600;
            other.flags = other.flags - (other.flags & FL_ONGROUND);
            removeme = "NO";
            FireTouch();
        }
        else if (self.spell == 100 || self.spell == 96)
                {
                MagicEffect(other);
                if (self.spell == 96)
                        other.velocity = other.velocity + self.velocity*2 + '0 0 100';
                else
                        other.velocity = other.velocity - self.velocity*2 + '0 0 100';
                other.flags = other.flags - FL_ONGROUND;
                T_Damage (self.enemy, self, self.owner, 10);
                }
        else if (self.spell == 216 || self.aflag == 33)
                {
                self.owner.lightning = self;
                self.active=TRUE;
                self.solid = SOLID_NOT;
                self.movetype = MOVETYPE_NOCLIP;
                if (self.aflag != 33)
                        MagicEffect(other);
                self.aflag = 33;
                self.velocity = '0 0 0';
                self.enemy = other;
                if(deathmatch)
                        self.alivetime = time + 30;
                else self.alivetime = time + 10;
                self.follow = FALSE;
                self.charmed = TRUE;
                self.controller = self.owner;
                Zap();
                removeme = "NO";
                }
        else if (self.spell == 76)
        {
        MagicEffect(other);
        if (((other.health >= self.owner.health && other.bloodloss < 1) || self.owner.health < 11) || other.classname == "player")
                {
                sprint(self.owner,"Spell had no effect\n");
                removeme=ftos(other.health);
                sprint(self.owner,other.classname);
                sprint(self.owner,"'s health (");
                sprint(self.owner,removeme);
                sprint(self.owner,") is higher than yours\n");
                remove(self);
                return;
                }
        if(self.owner.health>other.health)
                other.health = self.owner.health;
        self.owner.health = self.owner.health - 10;
        other.bloodloss = 0;
        sprint(self.owner,other.classname);
        sprint(self.owner," has been healed\n");
        }
        else if (self.spell == 136)
        {
        MagicEffect(other);
        if(other.racename=="T-800"||other.racename=="Borg"||other.racename=="Dark Elf")
                {
                sprint(self.owner,"Spell had no effect...\n");
                return;
                }
        if(other.classname=="player")
                sprint(other,"You're a fish out of water!\n");
	  if(other.enemy==world)
		other.enemy=self.owner;
        other.suff = 1;
        }
        else if (self.spell == 176)
        {
        MagicEffect(other);
        if(other.racename=="T-800"||other.racename=="Borg"||other.racename=="Dark Elf")
                {
                sprint(self.owner,"Spell had no effect...\n");
                return;
                }
	  if(other.enemy==world)
		other.enemy=self.owner;
        other.suff = 2;
        other.air_finished = time;
        }
        else if (self.spell == 184)
                DispelMagic(other);
        else if (self.spell == 84)
        {
        if(other.racename=="Dark Elf")
        {
        sprint(self.owner,"The Dark Elf resisted your magic!\n");
        return;
        }
        MagicEffect(other);
        other.attack_finished = time + 30;
        other.alivetime = time + 30;
        if(other.classname=="player")
                {
                sprint(other,"You've been rendered Impotent!\n");
                sprint(other,"(Don't worry, it happens to the best of us...)\n");
                }
        }
        if (removeme != "NO") remove(self);
        }
        else
        {
        sprint(self.owner,"Magic missed...\n");
        remove(self);
        return;
        }
        MagicEffect(self);
        return;
};

void()Radiate=
{
                T_RadiusDamage(self,self.owner,120,world);
                if(self.alivetime < time)
                        {
                        MagicEffect(self);
                        remove(self);
                        }
                self.think = Radiate;
                self.nextthink = time + 0.2;
};

void()MassEffect=
{
local entity summoned;
local float hp,sum;
          if(self.owner.classlabel!="Jedi"&&self.owner.classlabel!="Dark Jedi")
                hp = self.owner.mana*10;
          else hp = self.owner.exp/500;
                summoned = findradius (self.owner.origin, 1000);
                if (hp <= summoned.health)
                {
                        if(self.owner.spell==220)
                                {
                                summoned.armorvalue=0;
                                summoned.armortype=0;
                                summoned.damagetake=1;
                                T_Damage(summoned,self,self.owner,summoned.health+summoned.health/2);
                                }
                }
                else while(summoned)
                {
                    if(summoned.controller != self.owner && summoned.alive && summoned != self.owner)
                    {
                        traceline (self.owner.origin, summoned.origin, FALSE, self.owner);
                        if (trace_ent.alive)
                        {
                                hp = hp - summoned.health;
                                sum = sum + summoned.health/10;
                                if (hp < 0)
                                {
                                if(self.owner.spell==220)
                                        {
                                        summoned.armorvalue=0;
                                        summoned.armortype=0;
                                        summoned.damagetake=1;
                                        T_Damage(summoned,self,self.owner,hp+summoned.health);
                                        }
                                else if(self.owner.spell==192)
                                        Charm(summoned,3,self.owner);
                                else if(self.owner.spell==168)
                                        HoldWeak(summoned,3,self.owner);
                                hp = 0;
                                break;
                                }
                                else
                                {
                                MagicEffect(summoned);
                                if(self.owner.spell==220)
                                        {
                                        summoned.armorvalue=0;
                                        summoned.armortype=0;
                                        summoned.damagetake=1;
                                        T_Damage(summoned,self,self.owner,summoned.health + random()*81 + 50);
                                        }
                                else if(self.owner.spell==192)
                                        Charm(summoned,3,self.owner);
                                else if(self.owner.spell==168)
                                        HoldWeak(summoned,3,self.owner);
                                }
                        }
                    }
                    summoned = summoned.chain;
                }
                self.mana = rint(time - self.init_mana);
                if (self.mana > self.exp/1000)
                        self.mana = self.exp/1000;
                self.init_mana = time - self.mana + sum;
                remove(self);
};
        
void() SelfCast =
{
local entity summoned;
local float hp,dist,magicdone;
local string summsg;
local vector dir,orient;
self.alivetime = time + self.spell/20 - (self.intel/2);
if(self.classlabel!="Jedi"&&self.classlabel!="Dark Jedi")
   {
        self.mana = rint(time - self.init_mana);
        if (self.mana > self.exp/1000)
                self.mana = self.exp/1000;
   }
   if (self.spell == 164 || self.spell == 148 || self.spell == 200 || self.spell == 108 || self.spell == 48)
        {
//        if(self.classlabel!="Jedi"&&self.classlabel!="Dark Jedi")
//           {
            if (self.charmed >= 10&&self.spell!=112)
                {
                        sprint(self,"You can't control more than ten monsters at a time\n");
                        return;
                }
                summoned = spawn();
                summoned.charmed = TRUE;
                summoned.controller = self;
                summoned.oldenemy = self.owner;
                summoned.enemy = world;
                summoned.follow = FALSE;
                self.charmed = self.charmed + 1;
                setorigin(summoned, self.origin + v_forward*128 + '0 0 16');
                summoned.angles = self.angles;
        if (pointcontents(summoned.origin) == CONTENT_SOLID)
                {
                sprint(self,"Find a more open area\n");
                summoned.think = SUB_Remove;
                summoned.nextthink = time;
                self.alivetime = time;
                return;
                }
        if (self.spell == 164)
                {
                hp = 400;
                summsg = "Vore Summoned by ";
                summoned.think = monster_shalrath;
                }
        else
          if (self.spell == 148)
                {
                hp = 300;
                summsg = "Fiend Summoned by ";
                summoned.think = monster_demon1;
                }
        else if (self.spell == 108)
                {
                hp = 200;
                summsg = "Ogre Summoned by ";
                summoned.think = monster_ogre;
                }
        else if (self.spell == 48)
                {
                summsg = "Scrag Summoned by ";
                summoned.think = monster_wizard;
                hp = 80;
                }
        else if (self.spell == 200)
                {
                hp = 600;
                summsg = "Shambler Summoned by ";
                summoned.think = monster_shambler;
                }
//        if (self.mana < hp)  too much penalty
        if (self.mana < self.spell)
                {
                sprint(self,"Not enough mana\n");
                return;
                }
        sprint(self,summsg);
        sprint (self,summoned.controller.netname);
        sprint (self,"!\n");
        MagicEffect(summoned);
        summoned.nextthink = time;
        magicdone=TRUE;
   }
     else if(self.spell == 188)
        {
                if(!self.enemy.alive)
                    {
      			if(deathmatch)
					summoned=find(world,classname,"player");
      	            else summoned = findradius(self.origin,100000000);
                        hp=0;
                        while(summoned)
                                {
                                    if(summoned!=self&&summoned.alive&&summoned!=world&&summoned.controller!=self&&(vlen(self.origin-summoned.origin)<hp||summoned.classname=="player"||hp==0))
				      {
					if(teamplay&&summoned.team==self.team)
						bprint("");
					else
					{
					makevectors(summoned.angles);
		                  if(pointcontents(summoned.origin - v_forward * 80 + '0 0 8')!=CONTENT_SOLID)
					if(pointcontents(summoned.origin - v_forward * 48 + '0 0 8')!=CONTENT_SOLID)
					if(pointcontents(summoned.origin - v_forward * 64 + '0 0 8')!=CONTENT_SOLID)
                              	{
							hp=vlen(self.origin-summoned.origin);
                                           self.enemy=summoned;
                                    }
					    }
					   }
                                    summoned = summoned.chain;
                                }
                        if(hp==0)
                                {
                                if(self.classlabel=="Jedi")
                                        self.spell=0;
                                self.alivetime=time;
                                sprint(self,"No one within range for a clear ambush...\n");
                                return;
                                }
                         sprint(self,"Found:  ");
                         if(self.enemy.classname=="player")
                                sprint(self,self.enemy.netname);
                         else sprint(self,self.enemy.classname);
                         sprint(self,"\n");
                    }
                makevectors(self.enemy.angles);
                dir = self.enemy.origin - v_forward * 64 + '0 0 8';
/*
                if(pointcontents(dir)==CONTENT_SOLID)
                        {
                        if(self.classlabel=="Jedi")
                                self.spell=0;
                        self.alivetime=time;
                        sprint(self,"Ambush destination is blocked!\n");
                        return;
                        }
*/
			spawn_tfog (dir - 32*v_forward);
			spawn_tdeath(dir, self);
			self.oldorigin=dir;
                setorigin(self,dir);
                    self.angles_y=self.enemy.angles_y;
		self.fixangle = 1;		// turn this way immediately
		self.teleport_time = time + 0.7;
		if (self.flags & FL_ONGROUND)
			self.flags = self.flags - FL_ONGROUND;
		self.velocity = v_forward * 300;
		self.flags = self.flags - self.flags & FL_ONGROUND;
              if(self.intel>10)
                self.init_mana = time - self.mana + self.spell - self.intel*2;
	      else self.init_mana = time - self.mana + self.spell;
              magicdone=TRUE;
        }
        else
        {
        if(self.spell>215)
                self.init_mana=time;
        else if(self.intel>10)
                self.init_mana = time - self.mana + self.spell - self.intel*2;
        else self.init_mana = time - self.mana + self.spell;
        }
        if(magicdone)
                return;
        if (self.spell == 220 || self.spell == 168 || self.spell == 192)
        {
                summoned = spawn();
                summoned.owner = self;
                setorigin(summoned,self.origin);
                if (self.spell == 220)        
                        {
                        sound(self,CHAN_AUTO,"weapons/moadib.wav",1,ATTN_NORM);
                        hp = 1;
                        }
                summoned.think = MassEffect;
                summoned.nextthink = time + hp;
        }
        else if(self.spell == 152)
        {
                summoned = spawn();
                summoned.owner = self;
                summoned.alivetime = time + 120;
                setorigin(summoned,self.origin);
                MagicEffect(summoned);
                sprint(self,"Death Barrier in place for 2 minutes\n");
                summoned.think = Radiate;
                summoned.nextthink = time + 1;
        }
        else
        {
        MagicEffect(self);
        if (self.spell == 144)
                TeleEyes();
        else if (self.spell == 72)
                CheckHoloCommand();
        else if (self.spell == 172)
                self.archtime = time + 30;
        else if (self.spell == 24)
        {
        if(self.bloodloss>0)
                {
                self.bloodloss = 0;
                sprint(self,"Wounds healed\n");
                }
        if(self.health<self.max_health/2)
                {
                self.health = self.health + 20 + rint(random()*10);
                if (self.health > self.max_health/2)
                        self.health = self.max_health/2;
                }
        }
        else if (self.spell == 124)
        {
        if(self.bloodloss>0)
                {
                self.bloodloss = 0;
                sprint(self,"Wounds healed\n");
                }
        if(self.health<self.max_health)
                {
                self.health = self.health + 40 + rint(random()*20);
                if (self.health > self.max_health)
                       self.health = self.max_health;
                }
        }
        else if (self.spell == 28)
        {
        self.armorvalue = self.armorvalue + 80 + rint(random()*40);
        if (self.armorvalue > 200)
                self.armorvalue = 200;
        }
        else if (self.spell == 204)
        {
        if(self.bloodloss>0)
                {
                self.bloodloss = 0;
                sprint(self,"Wounds healed\n");
                }
        if(self.health<self.max_health*2)
                {
                self.health = self.health + 80 + rint(random()*40);
                if (self.health >self.max_health*2)
                        self.health = self.max_health*2;
                }
        }
        else if (self.spell == 92)
        {
        self.protmisstime = time + 60;                        
        sprint (self,self.netname);
        sprint (self," is protected against explosions for 1 minute!\n");
        }
        else if (self.spell == 212)
        {
        if(self.classlabel=="Jedi")
                self.reflecttime = time + 7;
        else if(self.classlabel=="Dark Jedi")
                self.reflecttime = time + 3;
        else self.reflecttime = time + 60;
        sprint (self,self.netname);
        summsg=ftos(self.reflecttime-time);
        sprint (self," is protected by a Reflective Shield for \n");
        sprint (self,summsg);
        sprint (self," seconds!\n");
        }
        else if (self.spell == 128)
                {
                self.items = self.items | IT_INVISIBILITY;
                self.invisible_time = 1;
                if(self.anyinvis&&self.intel<4)
                        {
                        self.invisible_finished = time + 100000;
                        self.alivetime=time;
                        }
                else self.invisible_finished = time + 60;
                }
        else if (self.spell == 208)
                {
                self.items = self.items | IT_QUAD;
                self.super_time = 1;
                self.super_damage_finished = time + 30;
                }
        else if (self.spell == 32)
                {
                self.firesistime = time + 90;
                sprint(self,self.netname);
                sprint(self," is protected against fire for 90 seconds\n");
                }
        else if (self.spell == 68)
                {
//                self.movetype=MOVETYPE_FLY;//so-so, not as good as flymode
                self.levitime = time + 90;
                }
        else if (self.spell == 44)
                DispelMagic(self);
        else if (self.spell == 132)
                {
                self.prottime = time + 60;
                sprint(self,self.netname);
                sprint(self," is protected from magic for 1 minute\n");
                }
        else if(self.spell == 104)
        {
                self.air_finished = time + 600; // 10 minutes breathe under water
                self.dmg = 2;
                sprint(self,self.netname);
                sprint(self," can breathe under water for 10 minutes\n");
        }
        else if(self.spell == 88)
        {
                if(self.amtaxe<1)
                {
                        sprint(self,"You don't have an axe!\n");
                        return;
                }
                self.enchant_axe=TRUE;
        }
        else if(self.spell==64)
                summonfireflies();
        }
};

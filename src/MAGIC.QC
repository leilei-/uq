/* MAGIC by Mike Gummelt */
void() cast_touch;
void() SelfCast;
void() TeleEyes;
void() CastLightning;
void(vector dir,float dist,entity cont,entity targ) ShalMissile2;
void()monster_shalrath;
void()monster_demon1;
void() monster_ogre;
void() monster_shambler;
void() monster_wizard;
void() monster_dog;

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
                sprint(self,"SUMMON SCRAGS\n");
        else if (self.spell == 52)
                sprint(self,"PROTECT AGAINST EXPLOSIONS\n");
        else if (self.spell == 56)
                sprint(self,"CHARM ANIMAL\n");
        else if (self.spell == 60)
                sprint(self,"FLESH TO STONE (person)\n");
//Level 3
        else if (self.spell == 64)
                sprint(self,"HEAL SERIOUS WOUNDS\n");
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
                sprint(self,"SPELL OF SHADOWS\n");
        else if (self.spell == 88)
                sprint(self,"UNLOCK DOOR\n");
        else if (self.spell == 92)
                sprint(self,"QUAD DAMAGE\n");
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
                sprint(self,"HEAL GRIEVEOUS WOUNDS\n");
        else if (self.spell == 128)
                sprint(self,"REFLECTIVE SHIELD (self)\n");
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
                sprint(self,"SUMMON SHAMBLER\n");
        else if (self.spell == 188)
                sprint(self,"POWER WORD, KILL\n");
        else if (self.spell == 192)
                sprint(self,"MASS CHARM\n");
        else if (self.spell == 196)
                sprint(self,"METEOR SWARM\n");
        else if (self.spell == 200)
                sprint(self,"LIGHTNING SUMMONING\n");
        sprint (self,"Level: ");
        printnum =ftos(self.splevel);
        sprint(self,printnum);
        sprint (self," Spell: ");
        printnum = ftos((self.spell - self.splevel * 20)/4);
        sprint(self,printnum);
        sprint (self,"\n");
        sprint(self,"Mana Needed: ");
        if(self.spell==48)
                printnum="80";
        else if(self.spell==108)
                printnum="200";
        else if(self.spell==148)
                printnum="300";
        else if(self.spell==164)
                printnum="400";
        else if(self.spell==184)
                printnum="600";
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
        self.spell = (self.spell - self.splevel * 20)/4;
        self.spell = self.spell + way;
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
                self.splevel = 9;
        else if (self.splevel == 10)
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
        sound(self,CHAN_VOICE,"misc/r_tele4.wav",1,ATTN_NORM);
        if (((self.spell - (self.splevel*20)) /4 < 4) && self.spell != 88&&self.spell!=112)
                SelfCast();
        else
        {

        if (self.spell == 56 && self.charmed >= 10)
        {
                sprint(self,"You can't control more than ten monsters at a time\n");
                return;
        }
        self.alivetime = time + self.spell/20;
        self.mana = rint(time - self.init_mana);
        if (self.mana > self.exp/1000)
                self.mana = self.exp/1000;
        self.init_mana = time - self.mana + self.spell;

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
        missile.owner = self;
        missile.movetype = MOVETYPE_FLYMISSILE;
        missile.solid = SOLID_BBOX;
        missile.classname = "spell";
        if (self.spell == 200)
                missile.aflag = 33;
        else if (self.spell == 88)
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
                missile.think = sparkle;
                missile.touch = cast_touch;
                missile.nextthink = time;
                }

        setmodel (missile, "progs/null.spr");
        setsize (missile, '0 0 0', '0 0 0');
	setorigin (missile, self.origin + v_forward*8 + '0 0 16');
        }
};
void (entity loser,float potent, entity printo) HoldWeak =
{
local string printnum;
        if (loser.active == -1 || (!loser.alive)||(loser.skin==1&&loser.classname!="player"))
                return;
        if (loser.health > 149*potent || (loser.active != potent && potent != 3))
                {
                sprint (printo,"Spell had no effect!\n");
                remove(self);
                return;
                }
        MagicEffect(loser);
        printnum = ftos(150*potent - loser.health);
        if (loser.classname == "player")
                {
                other.speed=other.skin;
                other.skin=24;
                loser.pausetime = time + 150*potent - loser.health;
                loser.attack_finished = time + 150*potent - loser.health;
                loser.alivetime = time + 150*potent - loser.health;
                sprint (loser,"You have been held for ");
                sprint(loser,printnum);
                sprint (loser," seconds!\n");
                sprint (printo,loser.netname);
                }
        else
                {
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
        sprint (printo," has been charmed by ");
        sprint (printo,loser.controller.netname);
        sprint (printo,"!\n");
        return;
};

void (entity loser, entity winner) BounceBack =
{
local vector vtemp,dir;
local float dist;
        MagicEffect(winner);
        vtemp = loser.origin + '0 0 10';
        dir = normalize(vtemp - winner.origin);
        if (self.classname == "spike")
                launch_spike(winner.origin,dir,winner,"spike",0);
        else if (self.classname == "superspike")
                launch_spike(winner.origin,dir,winner,"superspike",0);
        else if (self.classname == "shrapnel")
                launch_spike(winner.origin,dir,winner,"shrapnel",0);
        else if (self.classname == "rocket")
                W_FireRocket2(dir,winner,"rocket");
        else if (self.classname == "knightspike")
                launch_spike (winner.origin, dir,winner,"knightspike",0);
        else if (self.classname == "wizspike")
                {
                launch_spike (winner.origin, dir, winner,"wizspike",0);
                newmis.velocity = dir*600;
                newmis.owner = winner;
		newmis.classname = "wizspike";
		setmodel (newmis, "progs/w_spike.mdl");
		setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
                }
        else if (self.classname == "shalmissile")
                {
                dist = vlen (loser.origin - winner.origin);
                ShalMissile2(dir,dist,winner,loser);
                }
        else if (self.classname == "homerocket")
                W_FireRocket2(dir,winner,"homerocket");
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

                MagicEffect(winner);
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
                        remove(self);
                self.origin == self.enemy.origin + '0 0 0';
                if (self.enemy.health <= 0 || (!self.enemy.alive))
                        {
                                self.origin = self.owner.origin;
                                if (self.owner.enemy.health > 0)  self.enemy = self.owner.enemy;
                        }
                if (self.enemy.health > 0 && self.enemy != self.owner)
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
                        remove(self);
                self.think = Zap;
                self.nextthink = time + (random()*1);
};

void () cast_touch =
{
local string removeme;
local vector dir;
local entity summoned;
        if (other == self.owner)
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
        if (other.prottime > time)
                {
                spawn_tfog (other.origin);
                sound(other,CHAN_AUTO,"enforcer/enfstop",1,ATTN_NORM);
                sprint(self.owner,other.netname);
                sprint(self.owner," is protected from magic");
                return;
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
        else if (self.spell == 56)
            Charm(other,1,self.owner);
        else if (self.spell == 116)
            Charm(other,2,self.owner);
        else if (self.spell == 160)
            Charm(other,3,self.owner);
        else if (self.spell == 112)
        {
                if(other.reflecttime>time)
                        other=self.owner;
                if(other.classname!="player")
                {
                        MagicEffect(other);
                        summoned = spawn();
                        setorigin(summoned, other.origin);
                        summoned.angles = other.angles;
                        remove(other);
                        summoned.think = monster_dog;
                        summoned.nextthink = time;
                }
                else
                {
                        MagicEffect(other);
                        other.health = 25;
                        other.modelindex = modelindex_dog;
                        other.dog_time = 1;
                        other.dog_finished = time + 120;
                        other.weaponmodel = "";
                        DogChange(other);
                        other.view_ofs = '0 0 4';
                }
                sound (other, CHAN_VOICE, "dog/ddeath.wav", 1, ATTN_NORM);
        }
        else if (self.spell == 120)
            {
            MagicEffect(other);
            other.mass = other.mass + 1;
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
            other.silencetime = time + 60;
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
        else if (self.spell == 200 || self.aflag == 33)
                {
                self.solid = SOLID_NOT;
                self.movetype = MOVETYPE_NOCLIP;
                if (self.aflag != 33)
                        MagicEffect(other);
                self.aflag = 33;
                self.velocity = '0 0 0';
                self.enemy = other;
                self.alivetime = time + 180;
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
        if(other.classname != "player")
                {
                sprint(self.owner,"Spell had no effect...\n");
                return;
                }
        sprint(other,"You're a fish out of water!\n");
        other.suff = 1;
        }
        else if (self.spell == 176)
        {
        MagicEffect(other);
        if(other.classname != "player")
                {
                sprint(self.owner,"Spell had no effect...\n");
                return;
                }
        other.suff = 2;
        other.air_finished = time;
        }
        if (removeme != "NO") remove(self);
        }
        else
        {
        remove(self);
        return;
        }
        MagicEffect(self);
        return;
};

float() SummonScrag2 =
{
local entity summoned;
        if (self.charmed >= 10)
                {
                sprint(self,"You can't spawn a second scrag\n");
                return 1;
                }
                summoned = spawn();
                summoned.charmed = TRUE;
                summoned.controller = self;
                summoned.oldenemy = self.owner;
                if (self.enemy != world && self.enemy.alive)
                        summoned.enemy = self.enemy;
                else summoned.enemy = world;
                self.charmed = self.charmed + 1;
                summoned.follow = FALSE;
                summoned.think = monster_wizard;
                setorigin(summoned, self.origin + v_forward*48 + '0 0 16');
                MagicEffect(summoned);
                summoned.nextthink = time;
                return 2;
};
void()Radiate=
{
                T_RadiusDamage(self,self,120,world);
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
                hp = self.owner.mana*10;
                summoned = findradius (self.owner.origin, 1000);
                if (hp <= summoned.health)
                {
                        if(self.owner.spell==188)
                                T_Damage(summoned,self.owner,self.owner,summoned.health+summoned.health/2);
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
                                if(self.owner.spell==188)
                                        T_Damage(summoned,self.owner,self.owner,hp+summoned.health);
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
                                if(self.owner.spell==188)
                                        T_Damage(summoned,self.owner,self.owner,summoned.health + random()*81 + 50);
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
local float hp;
local string summsg;
local vector dir;
        self.alivetime = time + self.spell/20;
        if (self.spell == 164 || self.spell == 148 || self.spell == 184 || self.spell == 108 || self.spell == 48)
            {
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
        else if (self.spell == 148)
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
                summsg = "Scrags Summoned by ";
                summoned.think = monster_wizard;
                hp = 80 * SummonScrag2();
                }
        else if (self.spell == 184)
                {
                hp = 600;
                summsg = "Shambler Summoned by ";
                summoned.think = monster_shambler;
                }
        if (self.mana < hp)
                {
                sprint(self,"Not enough mana\n");
                return;
                }
        sprint(self,summsg);
        sprint (self,summoned.controller.netname);
        sprint (self,"!\n");
        self.mana = rint(time - self.init_mana);
        if (self.mana > self.exp/1000)
                self.mana = self.exp/1000;
        self.init_mana = time - self.mana + hp;
        MagicEffect(summoned);
        summoned.nextthink = time;
        }
        else
        {
        self.mana = rint(time - self.init_mana);
        if (self.mana > self.exp/1000)
                self.mana = self.exp/1000;
        self.init_mana = time - self.mana + self.spell;
        if (self.spell == 188 || self.spell == 168 || self.spell == 192)
        {
                summoned = spawn();
                summoned.owner = self;
                setorigin(summoned,self.origin);
                if (self.spell == 188)        
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
        if(self.health<50)
                {
                self.health = self.health + 20 + rint(random()*10);
                if (self.health > 50)
                        self.health = 50;
                }
        }
        else if (self.spell == 64)
        {
        if(self.bloodloss>0)
                {
                self.bloodloss = 0;
                sprint(self,"Wounds healed\n");
                }
        if(self.health<100)
                {
                self.health = self.health + 40 + rint(random()*20);
                if (self.health > 100)
                       self.health = 100;
                }
        }
        else if (self.spell == 28)
        {
        self.armorvalue = self.armorvalue + 80 + rint(random()*40);
        if (self.armorvalue > 200)
                self.armorvalue = 200;
        }
        else if (self.spell == 124)
        {
        if(self.bloodloss>0)
                {
                self.bloodloss = 0;
                sprint(self,"Wounds healed\n");
                }
        if(self.health<200)
                {
                self.health = self.health + 80 + rint(random()*40);
                if (self.health > 200)
                        self.health = 200;
                }
        }
        else if (self.spell == 52)
        {
        self.protmisstime = time + 60;                        
        sprint (self,self.netname);
        sprint (self," is protected against explosions for 1 minute!\n");
        }
        else if (self.spell == 128)
        {
        self.reflecttime = time + 60;                        
        sprint (self,self.netname);
        sprint (self," is protected by a Reflect Shield for 1 minute!\n");
        }
        else if (self.spell == 84)
                {
                self.items = self.items | IT_INVISIBILITY;
                self.invisible_time = 1;
                self.invisible_finished = time + 90;
                }
        else if (self.spell == 92)
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
                {
                self.reflecttime = time;
                self.protmisstime = time;
                self.mass = 1;
                self.pausetime = 0;
                self.levitime = time;
                if (self.suff > 0)
                       {
                       self.air_finished = time + 12;
                       self.suff = 0;
                       sound (self, CHAN_VOICE, "player/gasp2.wav", 1, ATTN_NORM);
                       }
                if (self.invincible_time > time)
                {
                        self.items = self.items - IT_INVULNERABILITY;
                        self.invincible_time = 0;
                        self.invincible_finished = 0;
                }
                sprint(self,self.netname);
                sprint(self," is cleansed of all magic\n");
                }
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
        }
        }
};
/*---------------------------------------------
TeleEyes
---------------------------------------------*/

void (entity me) TeleEyesWarp =
{
 local vector	org;

        if (me.aflag == 666)
                HoloCam(me);

        me.teleeyes.solid = SOLID_NOT;
        me.teleeyes.takedamage = DAMAGE_NO;
        spawn_tfog (me.origin);

// spawn a tfog flash in front of the destination

        makevectors (me.teleeyes.mangle);
        org = me.teleeyes.origin;

	spawn_tfog (org);
        spawn_tdeath(me.teleeyes.origin, me);

	
// move the player and lock him down for a little while

//        if (!me.health)
//        {
//                me.velocity=(v_forward*me.velocity_x)+(v_forward*me.velocity_y);
//                me.oldorigin=me.teleeyes.origin;
//                setorigin (me, me.teleeyes.origin);
//                return;
//        }

        setorigin (me, me.teleeyes.origin);
        me.angles = me.teleeyes.mangle;

        me.teleport_time = time + 0.7;
        if (me.flags & FL_ONGROUND)
                me.flags = me.flags - FL_ONGROUND;
        me.flags = me.flags - me.flags & FL_ONGROUND;
        return;
};

void () TeleEyesDie =
{
        self.owner.isfeign = FALSE;
        TeleEyesWarp(self.owner);
        T_Damage (self.owner, self.enemy, self.enemy, self.owner.health + 100);
        self.active = FALSE;
        remove (self);
};

void(entity myself) ActivateEyes =
{
local entity tel;
        tel = spawn();
        tel.solid = SOLID_BBOX;
        tel.takedamage = DAMAGE_AIM;
        tel.health = 1;
        tel.movetype = MOVETYPE_NOCLIP;
        tel.origin = myself.origin;
        tel.angles = myself.angles;
        setsize (tel, '-3 -3 50', '3 3 53');
        setmodel (tel, "progs/eyes.mdl");
        tel.classname = "TeleEye";
        tel.owner=myself;
        myself.teleeyes = tel;
        stuffcmd (tel.owner, "bf\n");
        sprint(tel.owner,"TeleEyes Placed\n");
        sound (myself, CHAN_WEAPON, "weapons/teleeyes.wav",1, ATTN_NORM);
        tel.nextthink = time;
        tel.think = SUB_Null;
        tel.active = TRUE;
        tel.th_stand = SUB_Null;
        tel.th_walk = SUB_Null;
        tel.th_run = SUB_Null;
        tel.th_pain = SUB_Null;
        tel.th_melee = SUB_Null;
        tel.th_missile = SUB_Null;
        tel.th_die = TeleEyesDie;
        tel.beendead = TRUE;
};

void () TeleEyes =
{
        if (self.newholo.active)
        {
                sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                sprint(self,"Deactivate or Detonate Holograph first...\n");
		return;
	}
        if (self.mana < 10)
	{
                sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                sprint(self,"Mana is too low!\n");
		return;
	}
        if (self.teleeyes.active == FALSE)
                {
                ActivateEyes (self);
                return;
                }
        TeleEyesWarp(self);
        remove(self.teleeyes);
        self.teleeyes.active = FALSE;
        return;
};

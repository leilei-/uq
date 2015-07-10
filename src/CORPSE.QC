.float floatlevel;
void() CorpsePain =
{
if(self.onfire==0)
        SpawnMeatSpray (self.origin, crandom() * 100 * v_right);
};

void() CorpseMove = 
{
if(other.origin_z>self.origin_z + 10 && (!other.flags&FL_ONGROUND)&&other.health&&other.velocity_z<1)
        other.flags=other.flags + FL_ONGROUND;

if(other.takedamage != DAMAGE_AIM)     // not living
 {
        self.velocity = '0 0 0';
        return;
 }

if(other.archtime > time&&other.charmed<10)
{
local entity summoned;
summoned = spawn();
summoned.charmed = TRUE;
summoned.controller = other;
summoned.oldenemy = other;
if (other.enemy != world && other.enemy.alive)
        summoned.enemy = other.enemy;
else summoned.enemy = world;
other.charmed = other.charmed + 1;
summoned.follow = FALSE;
summoned.think = self.initthink;
setorigin(summoned, self.origin + v_up*16);
        MagicEffect(summoned);
summoned.nextthink = time + 1;
remove(self);
}

if (other.classname == "corpse")
{
 self.velocity_x = other.velocity_x;
 self.velocity_y = other.velocity_y;
}
else
{
 self.velocity_x = other.velocity_x/3;
 self.velocity_y = other.velocity_y/3;
 if (other.classname == "player" && self.origin_z > other.origin_z && other.velocity_z > 0)
        self.velocity_z = other.velocity_z;
 self.velocity = self.velocity + '0 0 7';
}

if (self.flags & FL_ONGROUND)
  self.flags = self.flags - FL_ONGROUND;

if (self.floating)
        self.floatlevel = (random() * 4) + 12;
};

void() CorpseDie =
{
 local float i;
 local float j;
if((self.skin!=2&&self.classname!="player")||(self.skin!=25&&self.classname=="player")||self.classname=="corpse")
        sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
 // MakeSolidCorpse() sets netname to the head model
 i = 0;
 while(i<3)
 {
  j = random();
  if(j > 0.6)
    ThrowGib ("progs/gib3.mdl", self.health);
  else if(j > 0.3)
    ThrowGib ("progs/gib3.mdl", self.health);
  else
    ThrowGib ("progs/gib3.mdl", self.health);
  i = i + 1;
 }
if(!self.decap)
        ThrowSolidHead (self.netname, self.health, self.classname);
else
        remove(self);
};

void() CorpseOnlyDie =
{
 local float i;
 local float j;

 sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
 // MakeSolidCorpse() sets netname to the head model
 i = 0;
 while(i<3)
 {
  j = random();
  if(j > 0.6)
    ThrowGib ("progs/gib3.mdl", self.health*5);
  else if(j > 0.3)
    ThrowGib ("progs/gib3.mdl", self.health*5);
  else
    ThrowGib ("progs/gib3.mdl", self.health*5);
  i = i + 1;
 }
if(!self.decap)
        ThrowSolidHead (self.netname, self.health*5, self.frommonname);
else
        remove(self);
};

void() Spurt =
{
local float bloodleak;
                makevectors(self.angles);
                bloodleak=rint(random()*5) + 3;
                SpawnBlood (self.origin+v_forward*24+'0 0 -22', '0 0 -5'+ v_forward*(random()*20 + 20), bloodleak,self);
                sound (self, CHAN_AUTO, "weapons/slop.wav", 0.3, ATTN_NORM);
                if (self.alivetime < time||self.watertype==CONTENT_LAVA)
                        T_Damage(self,world,world,self.health);
                self.think=Spurt;
                self.nextthink=time + random()*5 + 0.5;
};

void () CorpseThink =
{
if(!deathmatch&&!coop&&!teamplay)
{
local float cbob_z, cbob_x, cbob_y;
        if ((self.watertype == CONTENT_WATER) || (self.watertype == CONTENT_SLIME))
        {
                self.floating = TRUE;
                setsize (self, '-16 -16 0', '16 16 12');
                self.origin_z = self.origin_z + 8;
                if (!(self.flags & FL_ONGROUND))
                        self.flags = self.flags + FL_ONGROUND;
                self.hite = self.origin_z;
        }
        else if (self.floating)
                {
                if (self.origin_z < self.hite + self.floatlevel)
                        self.origin_z = self.origin_z + 1;
                else if ( (self.origin_z >= self.hite + self.floatlevel) && (random() > 0.7) )
                        self.origin_z = self.origin_z - (random() * 10)/4;
                if (random() > 0.5)
                        {
                        cbob_z = self.angles_z + (random()*14) - 7;
                        if (cbob_z > 7)                        
                                cbob_z = 7;
                        if (cbob_z < -7)                        
                               cbob_z = -7;
                        self.angles_z = cbob_z;
                        }
                if (random() > 0.5)
                        {
                        cbob_x = self.angles_x + (random()*14) - 7;
                        if (cbob_x > 7)                        
                                cbob_x = 7;
                        if (cbob_x < -7)                        
                                cbob_x = -7;
                        self.angles_x = cbob_x;
                        }
                if (random() > 0.5)
                        {
                        cbob_y = self.angles_y + (random()*14) - 7;
                        if (cbob_y > 7)
                                cbob_y = 7;
                        if (cbob_y < -7)                        
                                cbob_y = -7;
                        self.angles_y = cbob_y;
                        }        
                if (random() > 0.5)
                        self.origin_x = self.origin_x + (random () * 4 - 2);
                        self.origin_y = self.origin_y + (random () * 4 - 2);
                }
self.think = CorpseThink;
self.nextthink = time + 0.5;
}
else
{
self.think = CorpseThink;
self.nextthink = time + 3;
}
if (self.alivetime < time||self.watertype==CONTENT_LAVA)
        T_Damage(self,self,self,self.health);
};

/*
 * This uses entity.netname to hold the head file (for CorpseDie())
 * hack so that we don't have to set anything outside this function.
 */

void(string headmdl, string frommon) MakeSolidCorpse =
{
// Make a gibbable corpse, change the size so we can jump on it
        self.th_stand = SUB_Null;
	self.th_walk = SUB_Null;
	self.th_run = SUB_Null;
	self.th_pain = CorpsePain;
	self.th_melee = SUB_Null;
	self.th_missile = SUB_Null;
        if(self.classname=="T-800")
                self.th_die = GrenadeExplode;
        else self.th_die = CorpseOnlyDie;
	self.touch = CorpseMove;
        self.beendead = TRUE;
        self.health = 25;
// DAMAGE_AIM so that grenades don't bounce off like they do for DAMAGE_YES
	self.takedamage = DAMAGE_AIM;
	self.solid = SOLID_BBOX;
	self.movetype = MOVETYPE_STEP;
        if(skill<3&&(!deathmatch))
                setsize (self, '-16 -16 -23', '16 16 -8');
        else setsize (self, '-16 -16 -23', '16 16 -3');//Allows step-over, but can't walk on or jump off them
        if (self.flags & FL_ONGROUND)
                self.flags = self.flags - (self.flags & FL_ONGROUND);
        self.flags = self.flags & (!FL_MONSTER);
	  self.running=FALSE;
        self.classname = "corpse";
        self.alive = FALSE;
        self.charmed = FALSE;
        self.controller = self;
        self.active = 0;
	self.netname = headmdl;
        self.floatlevel = (random()* 4) + 12;
        self.frommonname = frommon;
        self.onfire = FALSE;
        if(deathmatch||teamplay)
                self.alivetime = time + (random()*40) + 100; // decompose after @ 2 minutes
        else self.alivetime = time + (random()*10) + 55; // decompose after @ 1 minute
        if(self.decap)
        {
                self.owner=self;
                self.think=Spurt;
                self.nextthink=time + random()*3 + 1;
        }
        else CorpseThink();
};

.float hite;

void() HeadPain =
{
 spawn_touchblood (10);
};

void() HeadMove = 
{
 local float dir;
if(other.origin_z>self.origin_z + 10 && (!other.flags&FL_ONGROUND)&&other.health&&other.velocity_z<1)
        other.flags=other.flags + FL_ONGROUND;

 if(other.takedamage != DAMAGE_AIM)	// not living
   return;

if (other.classname == "player")
{
self.angles_x = self.angles_x + other.velocity_y/7;
self.angles_z = self.angles_z + other.velocity_x/7;
if (self.origin_z > other.origin_z && other.velocity_z > 0)
        self.velocity_z = other.velocity_z;
self.alivetime = self.alivetime + (self.alivetime - time);
}

 self.velocity_x = other.velocity_x;
 self.velocity_y = other.velocity_y;
 // no z or we can push the corpse into the ground

self.velocity = self.velocity + '0 0 7';       // add lift
 
if (self.flags & FL_ONGROUND)
   self.flags = self.flags - FL_ONGROUND;
};

void () HeadThink =
{
local float hbob;
        if(self.flags&FL_ONGROUND)
                self.Kick_em=FALSE;
/*
        if ((self.watertype == CONTENT_WATER) || (self.watertype == CONTENT_SLIME))
        {
                self.floating = TRUE;
                setsize (self, '-8 -8 -12', '8 8 4');        // 24==56
                self.origin_z = self.origin_z + 4;
                if (!(self.flags & FL_ONGROUND))
                        self.flags = self.flags + FL_ONGROUND;
                self.hite = self.origin_z;
        }
        if (self.floating)
        {
                if (random() > 0.2)
                        self.angles_z = self.angles_z + (random()*6) - 3;
                if (random() > 0.2)
                        self.angles_x = self.angles_x + (random()*6) - 3;
                if (random() > 0.2)
                        self.angles_y = self.angles_y + (random()*6) - 3;
                if (random() > 0.3)
                        {
                        hbob = self.origin_z + (random()*4 - 2);
                        if (hbob > self.hite + 2)
                                hbob = self.hite + 2;
                        if (hbob < self.hite - 2)
                                hbob = self.hite - 2;
                        self.origin_z = hbob;
                        }
                if (random() > 0.5)
                        self.origin_x = self.origin_x + (random () * 4 - 2);
                        self.origin_y = self.origin_y + (random () * 4 - 2);

         }
*/
if ((self.alivetime<time&&(!deathmatch))||self.watertype == CONTENT_LAVA)
        HeadDeath();
self.think = HeadThink;
self.nextthink = time + 0.5;
};

/*
 * This uses entity.netname to hold the head file (for CorpseDie())
 * hack so that we don't have to set anything outside this function.
 */


void(string gibname, float dm, string frommon) ThrowSolidHead =
{
       setmodel (self, gibname);
       self.th_stand = SUB_Null;
       self.th_walk = SUB_Null;
       self.th_run = SUB_Null;
       self.th_melee = SUB_Null;
       self.th_missile = SUB_Null;
       self.th_pain = HeadPain;
       self.frame = 0;
       self.beendead = TRUE;
       self.movetype = MOVETYPE_STEP;
       self.takedamage = DAMAGE_AIM;
       self.solid = SOLID_BBOX;                
       if(skill<3&&(!deathmatch))
               setsize (self, '-8 -8 -12', '8 8 4');
       else setsize (self, '-8 -8 -12', '8 8 10');//Allows step-over, but can't walk on or jump off them
       if(dm != -666)
               self.velocity = VelocityForDamage (dm);
       self.flags = self.flags - (self.flags & FL_ONGROUND);
       self.health = 10;
       self.th_die = HeadDeath;
       self.flags = self.flags & (!FL_MONSTER);
	 self.running=FALSE;
       self.angles_z = random()*600;
       self.angles_x = random()*600;
       self.angles_y = random()*600;
       self.classname = "head"; 
       self.frommonname = frommon;
       self.charmed = FALSE;
       self.controller = self;
       self.alive = FALSE;
       self.active = 0;
       self.touch = HeadMove;
       self.onfire = FALSE;
       self.alivetime = time + 25 + (random()*10); // decompose after 30 seconds
       if(!deathmatch&&!coop&&!teamplay)
       {
       self.think = HeadThink;
       self.nextthink = time + 0.5;
        }
        else
        {
       self.think = SUB_Null;
       self.nextthink = -1;
         }
};

void() headgo=
{
        self.skin=rint(random()*24)+1;        
        ThrowSolidHead("progs/h_player.mdl",-666,"Clay Pigeon");
};

void() ChuckHead=
{
local entity claypigeon;
local float forwardspeed,upspeed;
        sound (self, CHAN_AUTO, "weapons/hoverpop.wav", 1, ATTN_NORM);
        makevectors(self.v_angle);
        claypigeon=spawn();
        claypigeon.think=headgo;
        claypigeon.nextthink=time;
        claypigeon.movetype=MOVETYPE_BOUNCE;
        forwardspeed=rint(random()*500) + 500;
        upspeed=rint(random()*200) + 200;
        claypigeon.velocity=normalize(v_forward)*forwardspeed + normalize(v_up)*upspeed;
        setorigin(claypigeon,self.origin+v_forward*48+'0 0 16');
        claypigeon.avelocity_x=rint(random()*360);
        claypigeon.avelocity_y=rint(random()*360);
        claypigeon.avelocity_z=rint(random()*360);
        claypigeon.Kick_em=TRUE;
};

void()  b_explode1      =       [0,             b_explode2] {T_RadiusDamage (self, self.owner, self.bloodloss, world);self.bloodloss=self.bloodloss - 2;
        if(pointcontents(self.origin)==CONTENT_SOLID)
                remove(self);
};
void()  b_explode2      =       [1,             b_explode3] {T_RadiusDamage (self, self.owner, self.bloodloss, world);self.bloodloss=self.bloodloss - 2;
        if(pointcontents(self.origin)==CONTENT_SOLID)
                remove(self);
};
void()  b_explode3      =       [2,             b_explode4] {T_RadiusDamage (self, self.owner, self.bloodloss, world);self.bloodloss=self.bloodloss - 2;
        if(pointcontents(self.origin)==CONTENT_SOLID)
                remove(self);
};
void()  b_explode4      =       [3,             b_explode5] {T_RadiusDamage (self, self.owner, self.bloodloss, world);self.bloodloss=self.bloodloss - 2;
        if(pointcontents(self.origin)==CONTENT_SOLID)
                remove(self);
};
void()  b_explode5      =       [4,             b_explode6] {T_RadiusDamage (self, self.owner, self.bloodloss, world);self.bloodloss=self.bloodloss - 2;
        if(pointcontents(self.origin)==CONTENT_SOLID)
                remove(self);
};
void()  b_explode6      =       [5,             ShaBoom] {T_RadiusDamage (self, self.owner, self.bloodloss, world);self.bloodloss=self.bloodloss - 2;
        if(pointcontents(self.origin)==CONTENT_SOLID)
                remove(self);
};

void() ShaBoom =
{
        if(pointcontents(self.origin)==CONTENT_SOLID)
                remove(self);
        if(self.small)
                SmallExplosion();
        T_RadiusDamage (self, self.owner, self.bloodloss, world);

        self.bloodloss=self.bloodloss - 2;
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

        b_explode1();
};

void() FireExplosion=
{
local entity boommissile;
        boommissile=spawn();
        boommissile.owner=self.controller;
        boommissile.movetype=MOVETYPE_NOCLIP;
        boommissile.solid=SOLID_NOT;
        boommissile.velocity=self.v_angle*3;
        boommissile.think=ShaBoom;
        boommissile.nextthink=time;
        boommissile.bloodloss=100;
        boommissile.classname="tripmine";
        setorigin(boommissile,self.origin);
        setmodel (boommissile, "progs/s_explod.spr");
        GrenadeExplode();
        remove(self);
};

void () LaserTripped =
{
        self.takedamage=DAMAGE_NO;
        if(self.small)
                sound(self,CHAN_AUTO,"weapons/lock.wav",0.25,ATTN_NORM);
        else sound(self,CHAN_AUTO,"weapons/lock.wav",1,ATTN_NORM);
        self.effects=EF_BRIGHTLIGHT;
        self.think=FireExplosion;
        self.nextthink=time + 0.1;
};

/*
void() LaserTouch =
{
        if(other==self.owner)
                return;
        if(other.takedamage)
                {
                self.owner.think=LaserTripped;
                self.owner.nextthink=time;
                }
        particle (self.origin,'0 0 0', 73, 1);
        remove(self);
};
*/

void() LaserThink =
{
local entity tripsight;
        if(self.active==FALSE)
                {
//                sound (self, CHAN_BODY, "weapons/beep6.wav", 1, ATTN_NORM);
                if(self.small)
                        sound (self, CHAN_BODY, "misc/talk.wav", 0.25, ATTN_NORM);
                else sound (self, CHAN_BODY, "misc/talk.wav", 1, ATTN_NORM);
                self.controller=self.owner;
                self.owner=self;
                self.skin=1;
                self.active=TRUE;
                }
        traceline (self.origin, self.origin + self.v_angle*10000, FALSE, self);
        particle (trace_endpos,'0 0 0', 73, 1);
        if (trace_fraction == 1.0)
		return;

        if (trace_ent.velocity!='0 0 0'||trace_ent.health>0||trace_ent.takedamage)//movetype==MOVETYPE_WALK||trace_ent.movetype==MOVETYPE_WALK||trace_ent.movetype==MOVETYPE_WALK)
                self.think=LaserTripped;
        else self.think=LaserThink;
        self.nextthink=time;
/*
        tripsight=spawn();
        tripsight.movetype=MOVETYPE_FLYMISSILE;
        tripsight.solid=SOLID_BBOX;
        tripsight.touch=LaserTouch;
        tripsight.velocity=self.v_angle*4;
        tripsight.owner=self;
        setsize(tripsight,'-1 -1 -1','1 1 1');
        setmodel(tripsight,"progs/null.spr");
        setorigin(tripsight,self.origin);
*/
};

void() TripTouch =
{
        if(other.takedamage&&other.alive&&other!=self.owner)
                GrenadeExplode();
        else
        {
        if(self.small)
                sound(self,CHAN_WEAPON,"weapons/setlaser.wav",0.25,ATTN_NORM);
        else sound(self,CHAN_WEAPON,"weapons/setlaser.wav",1,ATTN_NORM);
        self.v_angle='0 0 0' - self.velocity;
        self.angles = vectoangles (self.v_angle);
        self.movetype=MOVETYPE_NONE;
        self.velocity='0 0 0';
        setsize(self,'-3 -3 -6','3 3 6');
        self.touch=SUB_Null;
        self.think=LaserThink;
        self.nextthink=time + 1;
        }
};

void() SetLaser =
{
     if(self.exp<250000&&self.racename!="T-800")
        {
        traceline (self.origin, self.origin + v_forward*36, TRUE, self);
	if (trace_fraction == 1.0)
                return;
        if(pointcontents(self.origin+v_forward*37)!=CONTENT_SOLID)
                return;
        }
        else
        {
                if(self.small)
                        sound(self,CHAN_WEAPON,"weapons/hoverpop.wav",0.25,ATTN_NORM);
                else sound(self,CHAN_WEAPON,"weapons/hoverpop.wav",1,ATTN_NORM);
                player_rocket1();
        }
        self.ammo_rockets=self.ammo_rockets - 3;
        newmis=spawn();
        newmis.owner=self;

        newmis.movetype=MOVETYPE_FLYMISSILE;
        newmis.solid=SOLID_BBOX;
        newmis.health=25;
        newmis.takedamage=DAMAGE_AIM;

        newmis.th_die=GrenadeExplode;
        newmis.classname="tripmine";
        makevectors(self.v_angle);
        newmis.small=self.small;
        newmis.touch=TripTouch;
        newmis.think=SUB_Null;
        newmis.nextthink= -1;

        newmis.velocity=normalize(v_forward)*250;
        newmis.angles = vectoangles ('0 0 0' - newmis.velocity);

        if(self.small)
        {
                setmodel (newmis, "progs/s_trip.mdl");
                setorigin(newmis,self.origin+v_forward*4+'0 0 2');
        }
        else
        {
                setmodel (newmis, "progs/tripmine.mdl");
                setorigin(newmis,self.origin+v_forward*4+'0 0 16');
        }
        setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
        self.attack_finished=time + 0.5;
};

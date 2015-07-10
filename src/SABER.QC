/*=============================
SWINGING SABER CODE
===============================*/
void() ThrowSaberBounce;
void() ThrowSaberThink;
void() SaberHit;
void() SaberActivate;
void() SaberDeactivate;
void() swordHit;
void() swordfall;
void() batlethHit;
void() DropWait=
{
                if(self.levitime<time)
                {
                        self.controller=self.owner;
                        self.owner=self;
                        if(self.classname=="longsword")
                        {
                                self.think=swordfall;
                                self.nextthink=time;
                        }        
                        else
                        {
                                self.think=SUB_Null;
                                self.nextthink=-1;
                        }
                }
                else
                {
                self.think=DropWait;
                self.nextthink=time;
                }
};

void(entity actor) Drop =
{
//              Note: Make it shut off and fall to the ground.  If picked up, you
//              lost it, but only another jedi can use it.                
                if(self.health<=0&&self.classname!="player")
                        actor=self;
                if(actor.flags&FL_ONGROUND)
                        actor.flags=actor.flags-FL_ONGROUND;
                actor.velocity_z=300;
                if(!actor.inpain&&(actor.classname=="longsword"||actor.classname=="batleth"))
                {
                        if(actor.classname=="longsword")
                                actor.touch=swordHit;
                        else
                                actor.touch=batlethHit;
                        actor.health=75;
                        actor.levitime=time + 1;
                        actor.think=DropWait;
                        actor.nextthink=time;
                 }
                actor.inpain=TRUE;
                setsize(actor,'-4 -4 -4','4 4 8');
                actor.avelocity = '-300 -300 -300';
                actor.movetype=MOVETYPE_BOUNCE;
                if(actor.classname=="lightsaber")
                {
                        actor.active=FALSE;
                        actor.health=1000;
                        actor.follow=0;
                        sound (self, CHAN_WEAPON, "weapons/saberoff.wav", 1, ATTN_NORM);
                        actor.alivetime=time;
                        actor.think=SaberDeactivate;
                        actor.nextthink=time;
                        actor.controller.impulse=10;
                }
};

void(entity actor) SaberResize=
{
local vector sizemin,sizemax;
local float  saberpitch,saberyaw;
        if(actor.angles_y<0)
                saberyaw=360+actor.angles_y;
        else saberyaw=actor.angles_y;
        if(saberyaw>325||saberyaw<=35)
                {
//                if(saberyaw==0)
//                        bprint("Due North (0)\n");
//                else bprint("North\n");
                sizemin_y= -3;
                sizemax_y= 3;
                sizemin_x= 0;
                sizemax_x= 48;
                }
        else if(saberyaw>35&&saberyaw<=55)
                {
//                if(saberyaw==45)
//                        bprint("Due North East (45)\n");
//                else bprint("North East\n");
                sizemin_y= 0;
                sizemax_y= 36;
                sizemin_x= 0;
                sizemax_x= 36;
                }
        else if(saberyaw>55&&saberyaw<=125)
                {
//                if(saberyaw==90)
//                        bprint("Due East (90)\n");
//                else bprint("East\n");
                sizemin_y= 0;
                sizemax_y= 48;
                sizemin_x= -3;
                sizemax_x= 3;
                }
        else if(saberyaw>125&&saberyaw<=145)
                {
//                if(saberyaw==135)
//                        bprint("Due South East (135)\n");
//                else bprint("South East\n");
                sizemin_y= 0;
                sizemax_y= 36;
                sizemin_x= -36;
                sizemax_x= 0;
                }
        else if(saberyaw>145&&saberyaw<=215)
                {
//                if(saberyaw==180)
//                        bprint("Due South (180)\n");
//                else bprint("South\n");
                sizemin_y= -3;
                sizemax_y= 3;
                sizemin_x= -48;
                sizemax_x= 0;
                }
        else if(saberyaw>215&&saberyaw<=235)
                {
//                if(saberyaw==225)
//                        bprint("Due South West (225)\n");
//                else bprint("South West\n");
                sizemax_y= 0;
                sizemin_y= -36;
                sizemax_x= 0;
                sizemin_x= -36;
                }
        else if(saberyaw>235&&saberyaw<=305)
                {
//                if(saberyaw==270)
//                        bprint("Due West (270)\n");
//                else bprint("West\n");
                sizemin_y= -48;
                sizemax_y= 0;
                sizemin_x= -3;
                sizemax_x= 3;
                }
        else if(saberyaw>305&&saberyaw<=325)
                {
//                if(saberyaw==315)
//                        bprint("Due North West (315)\n");
//                else bprint("North West\n");
                sizemin_y= -36;
                sizemax_y= 0;
                sizemin_x= 0;
                sizemax_x= 36;
                }
        saberpitch=fabs(actor.angles_z);
        if(saberpitch>=88&&saberpitch<=92)
                {
                sizemin_z=-4;
                sizemax_z=4;
                }
        else if(saberpitch>92)
                {
                sizemin_z=0 - (saberpitch - 90);
                sizemax_z=0;
                }
        else if(saberpitch<88)
                {
                sizemax_z=90-saberpitch;
                sizemin_z=0;
                }
        setsize(actor,sizemin,sizemax);
};

void() SaberKill =
{
        self.v_angle_z=self.angles_z - 75;
        self.v_angle_y=self.angles_y;
        self.v_angle_x=0;
        makevectors(self.v_angle);
        traceline (self.origin, self.origin + v_forward*64, FALSE, self);
        if (trace_fraction == 1.0)
		return;

//        particle (trace_endpos,'0 0 0', 242, 1);

        if (trace_ent.takedamage&&trace_ent!=self.controller&&trace_ent.classname!="lightsaber")
                {
                self.enemy=trace_ent;
                self.isfeign=TRUE;
                SaberHit();
                }
        else
                self.isfeign=FALSE;
};

void() SaberThink =
{
        makevectors (self.owner.v_angle);
        setorigin(self,self.owner.origin+v_forward*24+'0 0 8');
        if(time-self.alivetime<0.8)
                SaberActivate();


   if(time-self.alivetime>0.4)
   {
        self.avelocity='0 0 0';
        self.velocity='0 0 0';
        if(!self.owner.button0)
                {
                self.angles_z= self.owner.v_angle_z;
                self.angles_x= self.owner.angles_x;
                self.angles_y= self.owner.angles_y;
                self.angles= self.angles + '-75 0 0';
                }
        else
                {
                self.angles_z= self.owner.v_angle_z - 75;
                self.angles_x= 0 - self.owner.v_angle_x;
                self.angles_y= 0 - self.owner.v_angle_y;
                }
        }
        SaberResize(self);

        self.reflecttime=time + 1000;
        self.health=1000;
        if(self.attack_finished<=time)
                SaberKill();
        if(self.zap_finished<time)
                {
                if((random()<0.1)||(self.owner.button0&&random()<0.3))
                        sound (self, CHAN_WEAPON, "weapons/saberhup.wav", 1, ATTN_NORM);
                else sound (self, CHAN_WEAPON, "weapons/saberhum.wav", 1, ATTN_NORM);
//                if(self.frame>0&&time-self.alivetime>=0.8)
//                        self.effects=EF_DIMLIGHT;
                self.zap_finished=time + 0.25;
                }
        self.think=SaberThink;
        self.nextthink=time;
};

void() SaberHit =
{
local float damage;
        if(self.isfeign)
                {
                other=self.enemy;
                self.isfeign=FALSE;
                }
        if(other==self.controller&&self.levitime<=time)
        {
        if(other.small)
                return;
        other.weapon=IT_SABER;
        self.follow=0;
        self.running=TRUE;
        sound(other, CHAN_ITEM, "weapons/pkup.wav", 1, ATTN_NORM);
        self.effects=self.effects-self.effects;
        if(self.inpain)
                {
                self.effects=EF_MUZZLEFLASH;
                self.movetype=MOVETYPE_FLYMISSILE;
                sound(self, CHAN_AUTO, "weapons/saberon.wav", 1, ATTN_NORM);
                self.alivetime=time;
                }
//      Go to activation frames, SaberOn()-do a delay on nextthink and activation sound
        other.weaponmodel="";
        self.inpain=FALSE;
        self.avelocity='0 0 0';
        self.velocity='0 0 0';
        self.owner=self.controller;
        self.think=SaberThink;
        self.nextthink=time;
        }

        if(other==self.owner||other==self.controller)
                return;

        if(self.inpain)
        {
        damage = random() * FL_SWIM;
        if (damage <= 1) 
                sound(self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
        else
                sound(self, CHAN_WEAPON, "weapons/tink1.wav", 1, ATTN_NORM);
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
        }
        else
        {
        self.oldenemy=other;
        if(other.classname=="lightsaber")
        {
        if(random()<0.5)
                sound (self, CHAN_WEAPON, "weapons/saberhit.wav", 1, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_NORM);
        if(random()<0.1&&random()<0.1&&other.running)
                Drop(other);             
        particle ((other.origin + self.origin)*0.5,'0 0 8'*0.1, 242, 10);
        self.zap_finished=time + 0.1;
        self.effects=EF_MUZZLEFLASH;
        self.attack_finished=time + 0.2;
        }
        else if(((other.alive||other.classname=="head"||other.classname=="corpse")&&other.health>0&&self.attack_finished<=time)||(self.running==FALSE&&other.takedamage))
        {
        sound (self, CHAN_WEAPON, "weapons/saberhit.wav", 1, ATTN_NORM);
        self.effects=EF_MUZZLEFLASH;
        self.zap_finished=time + 0.4;
        SpawnBlood (other.origin, '0 0 0', 10,other);
        if(other.classname=="player")
                damage=other.max_health*0.25;
        else damage=75;
        if(!self.running)
                damage=damage*0.5;
        if(self.owner==self)
                T_Damage(other,self,self.controller,damage);
        else T_Damage(other,self,self.owner,damage);
        self.attack_finished=time + 0.15;
        }
        if(!self.running)
                {
                if(random()<0.5)
                        sound (self, CHAN_WEAPON, "weapons/saberhit.wav", 1, ATTN_NORM);
                else sound (self, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_NORM);
                particle (self.origin,'0 0 8'*0.1, 242, 10);
                self.effects=EF_DIMLIGHT;
                ThrowSaberBounce();
                }
        }
};

void() SaberSummon =
{
                 self.saber.follow=1;
                 sound(self.saber, CHAN_AUTO, "weapons/woosh.wav", 1, ATTN_NORM);
                 self.saber.movetype=MOVETYPE_FLYMISSILE;
                 self.saber.velocity_z = self.saber.velocity_z + 100;
                 if (self.saber.flags & FL_ONGROUND)
                         self.saber.flags = self.saber.flags - FL_ONGROUND;
                 self.saber.think=ThrowSaberThink;
                 self.saber.nextthink=time + 0.2;
};

void() SaberActivate =
{
        self.owner.weapon=IT_SABER;
        if(time-self.alivetime>=0.6)
                self.frame=6;                
        else if(time-self.alivetime>=0.5)
                self.frame=5;               
        else if(time-self.alivetime>=0.4)
                self.frame=4;                
        else if(time-self.alivetime>=0.3)
                self.frame=3;                
        else if(time-self.alivetime>=0.2)
                self.frame=2;                
        else if(time-self.alivetime>=0.1)
                {
                self.effects=self.effects+EF_MUZZLEFLASH;
                self.frame=1;
                }
        else
                self.frame=0;
};

void() SaberDeactivate =
{
        makevectors (self.owner.v_angle);
        self.owner.weapon=IT_SHOTGUN;
        if(self.movetype==MOVETYPE_FLYMISSILE)
                setorigin(self,self.owner.origin+v_forward*24+'0 0 8');

        if(time-self.alivetime>=1&&self.frame==0)
                if(self.movetype==MOVETYPE_FLYMISSILE)
                        {
                        self.running=FALSE;
                        self.aflag=FALSE;
                        remove(self);
                        }
                else
                        {
                        self.think=SUB_Null;
                        self.nextthink=-1;
                        }
        else if(time-self.alivetime>=0.6)
                {
                self.effects=self.effects-self.effects;
                self.frame=0;
                }
        else if(time-self.alivetime>=0.5)
                self.frame=1;               
        else if(time-self.alivetime>=0.4)
                self.frame=2;                
        else if(time-self.alivetime>=0.3)
                self.frame=3;                
        else if(time-self.alivetime>=0.2)
                self.frame=4;                
        else if(time-self.alivetime>=0.1)
                self.frame=5;
        else
                self.frame=6;
        self.think=SaberDeactivate;
        self.nextthink=time;
};

void() LSaber =
{
        if(self.saber.running)
                {
                sound (self, CHAN_WEAPON, "weapons/saberoff.wav", 1, ATTN_NORM);
                self.saber.avelocity='100 0 0';
                self.saber.alivetime=time;
                self.saber.think=SaberDeactivate;
                self.saber.nextthink=time;
                }
        else if(self.saber.follow!=0&&(!self.saber.inpain))
                Drop(self.saber);
        else
        {
        self.saber=spawn();
        self.saber.aflag=TRUE;
        self.saber.frame=0;
        self.saber.classname="lightsaber";
        self.saber.movetype=MOVETYPE_FLYMISSILE;
        self.saber.solid=SOLID_BBOX;
        self.saber.takedamage = DAMAGE_AIM;
        self.saber.health=10000;
        self.saber.th_die=Drop;
        makevectors (self.v_angle);
        self.saber.avelocity='100 0 0';
        self.saber.angles=self.v_angle + '-135 0 0';
        self.saber.skin=self.saberset - 1;
        self.saber.controller=self.saber.owner=self;
        self.saber.touch=SaberHit;
        setmodel(self.saber,"progs/lsaber.mdl");
        SaberResize(self.saber);
//        setsize(self.saber,'-4 -4 0', '4 96 24');
        self.saber.running=TRUE;
        setorigin(self.saber,self.origin+v_forward*12+'0 0 8');
        sound (self, CHAN_WEAPON, "weapons/saberon.wav", 1, ATTN_NORM);
        self.saber.alivetime=time;
        self.saber.think=SaberThink;
        self.saber.nextthink=time;
        }
};

void() selectsaber =
{
local string printnum;
if (self.impulse == 140||self.impulse==142)
{
        self.saber.skin = self.saber.skin + self.impulse - 141;
        if(self.saber.skin>3)
                self.saber.skin=0;
        else if(self.saber.skin<0)
                self.saber.skin=3;
}
else if(self.impulse==52)
{
        sound (self, CHAN_VOICE,"misc/secret.wav", 1, ATTN_NORM);
        self.saberset=self.saber.skin + 1;
        self.saber.running=FALSE;
        self.saber.aflag=FALSE;
        self.saber.frame=0;
        remove(self.saber);
}
};

void(entity printo) showsaber =
{
        printo.saber=spawn();
        printo.saber.effects=EF_MUZZLEFLASH;
        printo.saber.movetype=MOVETYPE_FLY;
        printo.saber.solid=SOLID_BBOX;
        printo.saber.avelocity='0 -100 0';
        printo.saber.frame=6;
        setmodel(printo.saber,"progs/lsaber.mdl");
        setsize(printo.saber,'2 2 0', '2 40 12');
        makevectors (printo.v_angle);
        setorigin(printo.saber,printo.origin+v_forward*36+'0 0 12');
        sound (printo, CHAN_WEAPON, "weapons/saberon.wav", 1, ATTN_NORM);
};

/*=============================
THROWING SABER CODE
===============================*/
void() ThrowSaberBounce =
{
local entity head;
local vector vtemp,dir;
//        self.velocity='0 0 0';
//        self.movetype=MOVETYPE_BOUNCE;
//        self.movetype=MOVETYPE_FLYMISSILE;
        self.enemy=world;
        head = findradius(self.origin, 1000);
        while(head)
        {
          if(visible2ent(head,self.controller)&&head.takedamage&&head!=self&&head!=self.controller&&head!=self.oldenemy&&head.health>0&&visible(head)&&(head.alive||head.classname=="head"||head.classname=="corpse"))
                {
                vtemp = head.origin + '0 0 10';
                dir = normalize(vtemp - self.origin);
                self.velocity = dir * 700;
                self.enemy=head;
                return;
                }
                head = head.chain;
        }
        self.follow=1;
};

void() ThrowSaberThink =
{
        if (self.follow == 1||self.enemy!=world)
        {
        local vector vtemp,dir;
        if(self.follow==1)
                {
                vtemp = self.controller.origin;
                self.angles=self.controller.v_angle + '-90 0 0';
                self.avelocity='0 0 0';
                }
        else
        {
        vtemp = self.enemy.origin;
        if(self.enemy.health<0||(!visible(self.enemy)))
                ThrowSaberBounce();
        }
        dir = normalize(vtemp - self.origin);
        self.velocity = dir * 350;
//        self.angles = vectoangles(self.velocity);
        if (self.flags & FL_ONGROUND)
                {
                   self.avelocity = '500 0 0';
                   self.flags = self.flags - FL_ONGROUND;
                }
        }
//        if(self.attack_finished<=time)
//                SaberKill();
        if(!self.inpain)//change to frame number check
                sound(self, CHAN_WEAPON, "weapons/saberhup.wav", 1, ATTN_NORM);

        if(self.controller.health<=0||self.controller.small)
                Drop(self);

        self.think = ThrowSaberThink;
        self.nextthink = time + 0.267;
};

void() ThrowSaber =
{
  setsize(self.saber,'-4 -4 -4','4 4 8');
  sound(self, CHAN_AUTO, "weapons/woosh.wav", 1, ATTN_NORM);
  makevectors(self.v_angle);
  self.saber.velocity = normalize(v_forward*1);
  self.saber.angles = vectoangles(self.saber.velocity);
  self.saber.velocity = self.saber.velocity * 700;
  self.saber.movetype=MOVETYPE_FLYMISSILE;
  self.saber.follow= -1;
  self.saber.controller=self;
  self.saber.owner=self.saber;
  self.saber.running=FALSE;
  self.saber.avelocity = '-300 -300 -300';
  self.saber.levitime = time + 0.5;
  self.saber.enemy=world;
  self.saber.oldenemy=world;
  self.saber.effects=EF_DIMLIGHT;
  self.saber.think=ThrowSaberThink;
  self.saber.nextthink=time;
  setorigin(self.saber,self.origin+v_forward*60+'0 0 8');
};

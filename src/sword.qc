/*=============================
SWINGING sword CODE
===============================*/
void() swordHit;
void(entity actor) swordResize=
{
local vector sizemin,sizemax;
local float  swordpitch,swordyaw;
        if(actor.angles_y<0)
                swordyaw=360+actor.angles_y;
        else swordyaw=actor.angles_y;
        if(swordyaw>325||swordyaw<=35)
                {
//                if(swordyaw==0)
//                        bprint("Due North (0)\n");
//                else bprint("North\n");
                sizemin_y= -3;
                sizemax_y= 3;
                sizemin_x= 0;
                sizemax_x= 48;
                }
        else if(swordyaw>35&&swordyaw<=55)
                {
//                if(swordyaw==45)
//                        bprint("Due North East (45)\n");
//                else bprint("North East\n");
                sizemin_y= 0;
                sizemax_y= 36;
                sizemin_x= 0;
                sizemax_x= 36;
                }
        else if(swordyaw>55&&swordyaw<=125)
                {
//                if(swordyaw==90)
//                        bprint("Due East (90)\n");
//                else bprint("East\n");
                sizemin_y= 0;
                sizemax_y= 48;
                sizemin_x= -3;
                sizemax_x= 3;
                }
        else if(swordyaw>125&&swordyaw<=145)
                {
//                if(swordyaw==135)
//                        bprint("Due South East (135)\n");
//                else bprint("South East\n");
                sizemin_y= 0;
                sizemax_y= 36;
                sizemin_x= -36;
                sizemax_x= 0;
                }
        else if(swordyaw>145&&swordyaw<=215)
                {
//                if(swordyaw==180)
//                        bprint("Due South (180)\n");
//                else bprint("South\n");
                sizemin_y= -3;
                sizemax_y= 3;
                sizemin_x= -48;
                sizemax_x= 0;
                }
        else if(swordyaw>215&&swordyaw<=235)
                {
//                if(swordyaw==225)
//                        bprint("Due South West (225)\n");
//                else bprint("South West\n");
                sizemax_y= 0;
                sizemin_y= -36;
                sizemax_x= 0;
                sizemin_x= -36;
                }
        else if(swordyaw>235&&swordyaw<=305)
                {
//                if(swordyaw==270)
//                        bprint("Due West (270)\n");
//                else bprint("West\n");
                sizemin_y= -48;
                sizemax_y= 0;
                sizemin_x= -3;
                sizemax_x= 3;
                }
        else if(swordyaw>305&&swordyaw<=325)
                {
//                if(swordyaw==315)
//                        bprint("Due North West (315)\n");
//                else bprint("North West\n");
                sizemin_y= -36;
                sizemax_y= 0;
                sizemin_x= 0;
                sizemax_x= 36;
                }
        swordpitch=fabs(actor.angles_z);
        if(swordpitch>=88&&swordpitch<=92)
                {
                sizemin_z=-4;
                sizemax_z=4;
                }
        else if(swordpitch>92)
                {
                sizemin_z=0 - (swordpitch - 90);
                sizemax_z=0;
                }
        else if(swordpitch<88)
                {
                sizemax_z=90-swordpitch;
                sizemin_z=0;
                }
        setsize(actor,sizemin,sizemax);
};

void() swordKill =
{
        self.v_angle_z=self.angles_z - 75;
        self.v_angle_y=self.angles_y;
        self.v_angle_x=0;
        makevectors(self.v_angle);
        traceline (self.origin, self.origin + v_forward*64, FALSE, self);
        if (trace_fraction == 1.0)
		return;

//        particle (trace_endpos,'0 0 0', 242, 1);

        if (trace_ent.takedamage&&trace_ent!=self.controller&&trace_ent.classname!="lightsword")
                {
                self.enemy=trace_ent;
                self.isfeign=TRUE;
                swordHit();
                }
        else
                self.isfeign=FALSE;
};

void() SwordSound=
{
local float r;
        if(self.zap_finished>time)
                return;
        else self.zap_finished=time + 0.4;
        r = rint((random() * 2) + 1);
        if(r==1)
                sound (self, CHAN_WEAPON, "hknight/slash1.wav", 1, ATTN_NORM);
        else if(r==2)
                sound (self, CHAN_WEAPON, "knight/sword1.wav", 1, ATTN_NORM);
        else
                sound (self, CHAN_WEAPON, "knight/sword2.wav", 1, ATTN_NORM);
};

void() CalculateForce =
{
local float changex,changey,changez;
        self.speed=0;
        self.friction=0;
        if(self.origin!=self.wallspot)
                self.speed=vlen(self.origin-self.wallspot);
        self.wallspot=self.origin;
        if(self.angles!=self.o_angle)
        {
                changex=fabs(self.o_angle_x - self.angles_x);
                changey=fabs(self.o_angle_y - self.angles_y);
                changez=fabs(self.o_angle_z - self.angles_z);
                self.friction=(changex + changey + changez)/3;
        }
        self.o_angle=self.angles;
//To cap damage if heavy lag
        self.speed=self.speed*(time-self.injury_time)*4;
        self.friction=self.friction*(time-self.injury_time)*4;
        if(self.friction>30)
                SwordSound();
        self.injury_time=time;
};

void() swordfall =
{
        if(self.velocity=='0 0 0')
        {
                if(self.angles_x>0)
                        self.angles_x=random()* 180;
                if(self.angles_z>0)
                        self.angles_z=random()* 180;
                self.think=SUB_Null;
                self.nextthink=-1;
        }
        else
        {
                self.think=swordfall;
                self.nextthink=time;
        }
};

void() MeleeUpDown=
{
        makevectors (self.owner.v_angle);
        setorigin(self,self.owner.origin+v_forward*24+'0 0 8');
        if(self.alivetime<time)
        {
                self.running=FALSE;
                remove(self);
        }
        else
        {
        self.think=MeleeUpDown;
        self.nextthink=time;
        }
};

void() NormalHitplus =
{
        if(deathmatch)
        {
        if(self.classlabel=="Warrior")
                self.hitplus=1.66;
        else if(self.classlabel=="Assassin")
                self.hitplus=1.33;
        else if(self.classlabel!="Mutant")
                self.hitplus = 1;
        }
        else
        {
        if(self.classlabel=="Warrior")
                self.hitplus=1.5 + self.exp/400000;
        else if(self.classlabel=="Assassin")
                self.hitplus=1.25 + self.exp/500000;
        else if(self.classlabel=="Mage")
                {
                self.hitplus=0.5 + self.exp/250000;
                if (self.hitplus > 1)
                        self.hitplus=1;
                }
        else
                {
                if(self.classlabel!="Mutant")
                        self.hitplus = 1;
                if(self.exp>500000)
                        self.hitplus=self.hitplus+(self.exp - 500000)/500000;
			if(self.hitplus>1&&self.classlabel=="Paladin")
                        self.hitplus=1;
                else if (self.hitplus > 1.33)
                        self.hitplus=1.33;
                }
        }
};

void() swordThink =
{
        makevectors (self.owner.v_angle);
        setorigin(self,self.owner.origin+v_forward*24+'0 0 8');
        self.velocity='0 0 0';

if(self.owner.skin<25)
{
   if(time-self.alivetime>0.4)
   {
        self.avelocity='0 0 0';
        if(!self.owner.button0)
                {
                if(self.button0)
                {
                        SwordSound();
                        self.stepping=TRUE;
                }
                else self.stepping=FALSE;
                self.angles_z= self.owner.v_angle_z;
                self.angles_x= self.owner.angles_x;
                self.angles_y= self.owner.angles_y;
                self.angles= self.angles + '-75 35 -10';
                }
        else
                {
                if(!self.button0)
                {
                        SwordSound();
                        self.stepping=TRUE;
                }
                else self.stepping=FALSE;
                self.angles_z= self.owner.v_angle_z - 75;
                self.angles_x= 0 - self.owner.v_angle_x;
                self.angles_y= 0 - self.owner.v_angle_y;
                }
        self.button0=self.owner.button0;
        CalculateForce();
        }
}
else self.stepping=FALSE;
        swordResize(self);

        self.health=75;
        if(self.attack_finished<=time)
                swordKill();
        self.oldorigin=self.origin;     //Not necc?
        self.think=swordThink;
        self.nextthink=time;
};

void() swordHit =
{
local float damage;
        if(self.isfeign)
                {
                other=self.enemy;
                self.isfeign=FALSE;
                }
        if(other==self.controller&&self.inpain&&other!=world)
        {
        if(other.small)
                return;
        other.weapon=IT_SWORD;
        self.movetype=MOVETYPE_FLYMISSILE;
        sound(self, CHAN_AUTO, "weapons/unsheath.wav", 1, ATTN_NORM);
        self.alivetime=time;
        setsize(self.sword,'-4 -4 0', '4 4 48');  //causes error?
        other.weaponmodel="";
        self.avelocity='0 0 0';
        self.inpain=FALSE;
        self.velocity='0 0 0';
        self.owner=self.controller;
        self.controller=world;
        self.think=swordThink;
        self.nextthink=time;
        }

        if(other==self.owner||other==self.controller)
                return;

        if(self.inpain)
        {
        damage = random() * FL_SWIM;
        if (damage <= 1) 
                sound(self, CHAN_AUTO, "player/axhit2.wav", 1, ATTN_NORM);
        else
                sound(self, CHAN_AUTO, "weapons/tink1.wav", 1, ATTN_NORM);
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
        }
        else
        {
        self.oldenemy=other;
        if(other.classname=="longsword"||other.classname=="batleth"||other.classname=="chakram"||other.classname=="disc")
        {
//        if(random()<0.5)
//Have two, randomize sound (self, CHAN_WEAPON, "weapons/clash.wav", 1, ATTN_NORM);
        if(random()<0.1&&random()<0.1&&(other.running||other.classname=="longsword"||other.classname=="batleth"))
                Drop(other);             
        particle ((other.origin + self.origin)*0.5,'0 0 8'*0.1, 242, 10);
        self.zap_finished=time + 0.1;
        self.attack_finished=time + 0.2;
        }
        else if(((other.alive||other.classname=="head"||other.classname=="corpse")&&other.health>0&&self.attack_finished<=time))
        {
        if(self.speed==0&&self.friction==0&&self.stepping==0)
                return;
        if(random()<0.5)
                sound (self, CHAN_AUTO, "shambler/smack.wav", 1, ATTN_NORM);
        else sound (self, CHAN_AUTO, "demon/dhit2.wav", 1, ATTN_NORM);
        NormalHitplus();
        if(self.speed==0)
                self.speed=1;
        if(self.friction==0)
                self.friction=1;
        damage=(random()*10 + 5)*self.speed/10*self.friction/10*self.hitplus*(self.stepping + 1);
        if(damage>60)
                damage=60;
        if(other.classname!="player")
                damage=damage*2;
        SpawnBlood (other.origin, '0 0 0', damage,other);
        if(self.inpain&&self.velocity!='0 0 0')
                T_Damage(other,self,self.controller,damage*0.2);
        else T_Damage(other,self,self.owner,damage);
        self.attack_finished=time + 0.45;
        }
        }
};

void(float fromchange) Lsword =
{
        if(self.sword.inpain)
        {
                sprint(self,"Go get your longsword first!\n");
                return;
        }
        if(self.sword.running)
                {
                if(self.sword.alivetime>time)
                        return;
//                sound (self, CHAN_WEAPON, "weapons/sheath.wav", 1, ATTN_NORM);
                
                self.sword.avelocity='100 0 0';
                self.sword.alivetime=time + 0.75;
                self.sword.think=MeleeUpDown;
                self.sword.nextthink=time;
//                if(self.weapon==IT_SWORD||fromchange)
//                        self.impulse=10;
                }
        else
        {
        self.sword=spawn();
        self.sword.aflag=TRUE;
        self.sword.frame=0;
        self.sword.classname="longsword";
        self.sword.movetype=MOVETYPE_FLYMISSILE;
        self.sword.solid=SOLID_BBOX;
        self.sword.takedamage = DAMAGE_AIM;
        self.sword.health=300;
        self.sword.th_die=Drop;
        makevectors (self.v_angle);
        self.sword.avelocity='100 0 0';
        self.sword.angles=self.v_angle + '-135 45 15';
        self.sword.controller=self.sword.owner=self;
        self.sword.touch=swordHit;
        setmodel(self.sword,"progs/lsword.mdl");
        swordResize(self.sword);
        setsize(self.sword,'-4 -4 0', '4 4 48');  //causes error?
        self.sword.running=TRUE;
        setorigin(self.sword,self.origin+v_forward*12+'0 0 8');
        sound (self, CHAN_WEAPON, "weapons/unsheath.wav", 1, ATTN_NORM);
        self.sword.wallspot=self.sword.origin;
        self.sword.o_angle=self.sword.angles;
        self.sword.alivetime=time;
        self.sword.think=swordThink;
        self.sword.nextthink=time;
        }
};

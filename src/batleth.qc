/*=============================
SWINGING batleth CODE
===============================*/
void() batlethHit;
void(entity actor) batlethResize=
{
local vector sizemin,sizemax;
local float  batlethpitch,batlethyaw;
        if(actor.angles_y<0)
                batlethyaw=360+actor.angles_y;
        else batlethyaw=actor.angles_y;
        if(batlethyaw>325||batlethyaw<=35)
                {
//                if(batlethyaw==0)
//                        bprint("Due North (0)\n");
//                else bprint("North\n");
                sizemin_y= -3;
                sizemax_y= 3;
                sizemin_x= -20;
                sizemax_x= 20;
                }
        else if(batlethyaw>35&&batlethyaw<=55)
                {
//                if(batlethyaw==45)
//                        bprint("Due North East (45)\n");
//                else bprint("North East\n");
                sizemin_y= -15;
                sizemax_y= 15;
                sizemin_x= -15;
                sizemax_x= 15;
                }
        else if(batlethyaw>55&&batlethyaw<=125)
                {
//                if(batlethyaw==90)
//                        bprint("Due East (90)\n");
//                else bprint("East\n");
                sizemin_y= -20;
                sizemax_y= 20;
                sizemin_x= -3;
                sizemax_x= 3;
                }
        else if(batlethyaw>125&&batlethyaw<=145)
                {
//                if(batlethyaw==135)
//                        bprint("Due South East (135)\n");
//                else bprint("South East\n");
                sizemin_y= -15;
                sizemax_y= 15;
                sizemin_x= -15;
                sizemax_x= 15;
                }
        else if(batlethyaw>145&&batlethyaw<=215)
                {
//                if(batlethyaw==180)
//                        bprint("Due South (180)\n");
//                else bprint("South\n");
                sizemin_y= -3;
                sizemax_y= 3;
                sizemin_x= -20;
                sizemax_x= 20;
                }
        else if(batlethyaw>215&&batlethyaw<=235)
                {
//                if(batlethyaw==225)
//                        bprint("Due South West (225)\n");
//                else bprint("South West\n");
                sizemax_y= 15;
                sizemin_y= -15;
                sizemax_x= 15;
                sizemin_x= -15;
                }
        else if(batlethyaw>235&&batlethyaw<=305)
                {
//                if(batlethyaw==270)
//                        bprint("Due West (270)\n");
//                else bprint("West\n");
                sizemin_y= -20;
                sizemax_y= 20;
                sizemin_x= -3;
                sizemax_x= 3;
                }
        else if(batlethyaw>305&&batlethyaw<=325)
                {
//                if(batlethyaw==315)
//                        bprint("Due North West (315)\n");
//                else bprint("North West\n");
                sizemin_y= -20;
                sizemax_y= 20;
                sizemin_x= -20;
                sizemax_x= 20;
                }
        batlethpitch=fabs(actor.angles_z);
        if(batlethpitch>=88&&batlethpitch<=92)
                {
                sizemin_z=-4;
                sizemax_z=4;
                }
        else if(batlethpitch>92)
                {
                sizemin_z=0 - (batlethpitch - 90);
                sizemax_z=90-batlethpitch;
                }
        else if(batlethpitch<88)
                {
                sizemax_z=90-batlethpitch;
                sizemin_z=0 - (batlethpitch - 90);
                }
        setsize(actor,sizemin,sizemax);
};

void() batlethKill =
{
        self.v_angle_z=self.angles_z - 75;
        self.v_angle_y=self.angles_y;
        self.v_angle_x=0;
        makevectors(self.v_angle);
        traceline (self.origin, self.origin + v_forward*64, FALSE, self);
        if (trace_fraction == 1.0)
		return;

//        particle (trace_endpos,'0 0 0', 242, 1);

        if (trace_ent.takedamage&&trace_ent!=self.controller&&trace_ent.classname!="lightbatleth")
                {
                self.enemy=trace_ent;
                self.isfeign=TRUE;
                batlethHit();
                }
        else
                self.isfeign=FALSE;
};

void() GoBerzerk=
{
                sprint(self,"You're going berzerk!!!\n");
                if(self.racename=="TigerMan")
                        sound(self,CHAN_VOICE,"tiger/angry.wav",1,ATTN_NONE);
                else if(self.skin==16||self.oldskin==16)
                        sound(self,CHAN_VOICE,"xena/femyell.wav",1,ATTN_NONE);
                self.items=self.items + IT_QUAD;
                self.super_time = 1;
                self.super_damage_finished = time + 5;
                self.health=self.health - 10;
};

void() batlethThink =
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
                self.angles= self.angles + '-75 -60 10';
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
                self.angles= self.angles + '0 +60 -10';
                }
        self.button0=self.owner.button0;
        CalculateForce();
        }
     }
     else self.stepping=FALSE;
        batlethResize(self);

        self.health=75;
        if(self.attack_finished<=time)
                batlethKill();
        self.oldorigin=self.origin;     //Not necc?
        self.think=batlethThink;
        self.nextthink=time;
};

void() batlethHit =
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
        other.weapon=IT_DISC;
        self.movetype=MOVETYPE_FLYMISSILE;
        sound(self, CHAN_AUTO, "weapons/unsheath.wav", 1, ATTN_NORM);
        self.alivetime=time;
        setsize(self.batleth,'-4 -4 -20 ', '4 10 20'); //causes error?
        other.weaponmodel="";
        self.inpain=FALSE;
        self.avelocity='0 0 0';
        self.velocity='0 0 0';
        self.owner=self.controller;
        self.controller=world;
        self.think=batlethThink;
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
        self.effects=EF_MUZZLEFLASH;
        self.attack_finished=time + 0.2;
        }
        else if(((other.alive||other.classname=="head"||other.classname=="corpse")&&other.health>0&&self.attack_finished<=time)||(self.running==FALSE&&other.takedamage))
        {
        if(self.speed==0&&self.friction==0&&self.stepping==0)
                return;
        if(self.berzerker&&random()<0.3&&random()<0.2&&self.super_time!=1&&self.health>self.max_health*0.5)
                GoBerzerk();
        if(random()<0.5)
                sound (self, CHAN_AUTO, "shambler/smack.wav", 1, ATTN_NORM);
        else sound (self, CHAN_AUTO, "demon/dhit2.wav", 1, ATTN_NORM);
        NormalHitplus();
        if(self.speed==0)
                self.speed=1;
        if(self.friction==0)
                self.friction=1;
        damage=(random()*5 + 10)*self.speed/10*self.friction/10*self.hitplus*(self.stepping + 1);
        if(damage>75)
                damage=75;
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

void(float fromchange) Batleth =
{
        if(self.batleth.inpain)
        {
                sprint(self,"Go get your batleth first!\n");
                return;
        }
        if(self.batleth.running)
                {
                if(self.batleth.alivetime>time)
                        return;
//                sound (self, CHAN_WEAPON, "weapons/sheath.wav", 1, ATTN_NORM);
                self.batleth.avelocity='100 0 0';
                self.batleth.alivetime=time + 0.75;
                self.batleth.think=MeleeUpDown;
                self.batleth.nextthink=time;
//                if(self.weapon==IT_BATLETH||fromchange)
//                        self.impulse=10;
                }
        else
        {
        self.batleth=spawn();
        self.batleth.frame=0;
        self.batleth.classname="batleth";
        self.batleth.movetype=MOVETYPE_FLYMISSILE;
        self.batleth.solid=SOLID_BBOX;
        self.batleth.takedamage = DAMAGE_AIM;
        self.batleth.health=75;
        self.batleth.th_die=Drop;
        makevectors (self.v_angle);
        self.batleth.avelocity='100 0 0';
        self.batleth.angles=self.v_angle + '-135 -60 10';
        self.batleth.controller=self.batleth.owner=self;
        self.batleth.touch=batlethHit;
        setmodel(self.batleth,"progs/batleth.mdl");
        batlethResize(self.batleth);
        setsize(self.batleth,'-4 -4 -20 ', '4 10 20'); //causes error?
        self.batleth.running=TRUE;
        setorigin(self.batleth,self.origin+v_forward*12+'0 0 8');
        sound (self, CHAN_WEAPON, "weapons/unsheath.wav", 1, ATTN_NORM);
        self.batleth.wallspot=self.batleth.origin;
        self.batleth.o_angle=self.batleth.angles;
        self.batleth.alivetime=time;
        self.batleth.think=batlethThink;
        self.batleth.nextthink=time;
        }
};

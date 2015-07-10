/*=============================
disc CODE
===============================*/
void() ThrowdiscThink;
void() discThink =
{
        makevectors(self.controller.v_angle);
        setorigin(self,self.controller.origin+v_forward*24+'0 0 16');
        self.velocity='0 0 0';
        self.avelocity='0 0 0';
        self.think=discThink;
        self.nextthink=time;
};

void() discFind=
{
        if(visible2ent(self,self.controller))
                {
                centerprint(self.controller,"There's your disc!\n");
                sound (self.controller, CHAN_AUTO, "misc/talk.wav", 1, ATTN_NORM);
                }
        self.think=discFind;
        self.nextthink=time + 1;
};

void(entity actor) discDrop =
{
        actor.effects=actor.effects-actor.effects;
        actor.velocity_z=actor.velocity_z + 100;
        actor.bloodloss=0;
        actor.health=100000;
        actor.follow=0;
        actor.inpain=TRUE;
        actor.running=FALSE;
        actor.avelocity = '-300 -300 -300';
        actor.movetype=MOVETYPE_BOUNCE;
        actor.think=discFind;
        actor.nextthink=time;
};

void() discreadyDrop =
{
        discDrop(self);
};

void() discHit =
{
        if(self.controller!=world&&other==self.controller&&self.levitime<=time)
        {
        if(self.small)
                return;
        other.weapon=IT_DISC;
        self.follow=0;
        self.running=FALSE;
        self.inpain=FALSE;
        self.velocity='0 0 0';
        self.avelocity='0 0 0';
        self.health=100;
        self.angles=other.v_angle + '-90 0 0';
        self.effects=self.effects-self.effects;
        sound(other, CHAN_ITEM, "weapons/pkup.wav", 1, ATTN_NORM);
        other.impulse=61;
        self.aflag=FALSE;
        self.bloodloss=0;
        self.owner=self.controller;
        remove(self);
        }

        if(other==self.owner||(self.controller!=world&&other==self.controller))
                return;

    if(self.inpain==TRUE)
    {
        if(random()<0.3)
                sound (self, CHAN_WEAPON, "weapons/ric1.wav", 1, ATTN_NORM);
        else if(random()<0.3) sound (self, CHAN_WEAPON, "weapons/ric2.wav", 1, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "weapons/ric3.wav", 1, ATTN_NORM);
        particle (self.origin,'0 0 16'*0.1, 242, 10);
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
    }
    else
    {
        self.oldenemy=other;
        if(self.attack_finished<=time&&other.takedamage)
        {
        local float damage;
                sound (self, CHAN_WEAPON, "predator/pdischit.wav", 1, ATTN_NORM);
                other.punchangle_x = -10;
                other.punchangle_y = -10;
                self.zap_finished=time + 0.4;
                spawn_touchblood(40);
                SpawnBlood (other.origin, '0 0 0', 10,other);
                T_Damage(other,self,self.controller,100);
                self.attack_finished=time + 0.2;
                self.bloodloss=0;
        }
        else if(self.aflag)
        {
                self.bloodloss=self.bloodloss + 1;
                self.oldenemy=world;
                if(self.bloodloss>6)
                        discDrop(self);
        }
        if(random()<0.3)
                sound (self, CHAN_WEAPON, "weapons/ric1.wav", 1, ATTN_NORM);
        else if(random()<0.3) sound (self, CHAN_WEAPON, "weapons/ric2.wav", 1, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "weapons/ric3.wav", 1, ATTN_NORM);
        particle (self.origin,'0 0 16'*0.1, 242, 10);
        self.follow=1;
    }
};

/*=============================
THROWING disc CODE
===============================*/

void() ThrowdiscThink =
{
        if ((self.enemy.alive==FALSE&&(vlen(self.enemy.origin-self.owner.origin)<256))||self.enemy.isfeign||!(self.enemy) || (self.enemy == world) || (self.enemy.health <=0) && (self.enemy.beendead != TRUE)||(!visible(self.enemy))||(self.enemy.invisible_finished>=time)||self.enemy==world)
		self.enemy = HomeFindTarget();

        if (self.follow == 1 || self.enemy != world)
        {
        local vector vtemp,dir;
        if(self.follow==1)
                {
                if(!visible(self.controller))
                        discDrop(self);
                vtemp = self.controller.origin;
                self.angles=self.controller.v_angle + '-90 0 0';
                }
        else
                vtemp = self.enemy.origin;
        dir = normalize(vtemp - self.origin);
        if(self.velocity!=dir*450)
                self.velocity = (self.velocity + dir*450 + dir*450)*0.33;
        self.angles = vectoangles(self.velocity)+'-90 0 0';
        if (self.flags & FL_ONGROUND)
                {
                   self.avelocity = '0 -200 0';
                   self.flags = self.flags - FL_ONGROUND;
                }
        }
        if(!self.inpain&&self.message_time<=time)
                {
                sound(self, CHAN_WEAPON, "predator/pdischum.wav", 0.3, ATTN_NORM);
                self.message_time=time + 1.8;
                }

        if(self.controller.health<=0&&self.follow==1)
                discDrop(self);

        self.think = ThrowdiscThink;
        self.nextthink = time + 0.2;
};

void() ThrowdiscInit =
{
        self.effects= EF_DIMLIGHT;
        makevectors(self.controller.v_angle);
        setorigin(self,self.controller.origin+v_forward*24+'0 0 16');
        if(self.alivetime<=time)
        {
        self.aflag=TRUE;
        setorigin(self,self.origin+v_forward*48+'0 0 16');
        self.controller=self.owner;
        self.owner=self;
        self.velocity = normalize(v_forward)*450;
        self.think=ThrowdiscThink;
        self.effects= EF_BRIGHTLIGHT;
        self.nextthink=time;
        }
        else
        {
        self.think=ThrowdiscInit;
        self.nextthink=time + 0.1;
        }
};

void() Throwdisc =
{
        makevectors(self.v_angle);
        sound(self, CHAN_AUTO, "predator/pdiscgo.wav", 1, ATTN_NORM);
        if(random()<0.5)
                self.saber.avelocity='0 -200 0';
        else self.saber.avelocity='0 200 0';
        self.saber.angles=self.v_angle + '-90 0 0';
        self.saber.levitime = time + 0.5;
        self.saber.enemy=world;
        self.saber.oldenemy=world;

        self.saber.think=ThrowdiscInit;
        self.saber.alivetime = time + 0.5;
        self.saber.nextthink=time + 0.1;
};


void() Disc =
{
        makevectors(self.v_angle);
        self.saber=spawn();
        self.saber.classname="disc";
        self.saber.movetype=MOVETYPE_FLYMISSILE;
        self.saber.solid=SOLID_BBOX;
        self.saber.touch=discHit;
        self.saber.running=TRUE;
        makevectors (self.v_angle);
        self.saber.angles=self.v_angle + '-90 0 0';
        self.saber.takedamage = DAMAGE_AIM;
        self.saber.health=1000;
        self.saber.th_die=discreadyDrop;
        self.saber.follow= -1;
        self.saber.controller=self;
        self.saber.owner=self;
        self.saber.aflag=FALSE;
        self.saber.v_angle = normalize(v_forward*1);
        
        self.saber.think=discThink;
        self.saber.nextthink=time;

        setsize(self.saber,'-1 -1 -1', '1 1 1');
        setmodel(self.saber,"progs/pred2.mdl");
        setorigin(self.saber,self.origin+v_forward*24+'0 0 16');
};

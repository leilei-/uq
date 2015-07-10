/*
Grappling Hook
by Michael Gummelt
*/

void() GhookHit;

void () LoseLinks =
{
        local entity link;

        while (self.speed)
        {
                link = find(world,netname,"link");
                if(link.owner==self)
                {
                        remove (link);
                        self.speed=self.speed - 1;
                }
        }
};

void() NewEnemy =
{
local entity link,lastlink;
local float numlinks;
        if(other.classname!="player"||!visible2ent(other,self.owner))
                return;

        remove(self.enemy);
        sound(other, CHAN_ITEM, "weapons/tink1.wav", 1, ATTN_NORM);
        self.owner.owner=other;
        if(!other.items2&IT_GHOOK)
                other.items2=other.items2+IT_GHOOK;
        other.util=IT_GHOOK;
        other.ghook_extended=self.owner.ghook_extended;
        other.ghook_attached=self.owner.ghook_attached;
        other.ghook_holdon=self.owner.ghook_holdon;
        other.ghook_dropped=self.owner.ghook_dropped;

        numlinks=self.owner.speed;
        lastlink=world;
        while (numlinks)
        {
                link=find(lastlink,netname,"link");
                if(link.owner==self.owner)
                {
#ifdef FLOODY_TEXT
                        bprint("found a link\n");
#endif
                        if(link.classname=="lastlink")
                                link.hover=FALSE;
                        link.enemy=other;
                        link.solid=SOLID_NOT;
                        link.touch=SUB_Null;
                        link.movetype=MOVETYPE_NOCLIP;
                        if(lastlink!=world)
                                lastlink.netname="link";
                        lastlink=link;
                        lastlink.netname="oldlink";
                        numlinks = numlinks - 1;
                }
        }
        if(lastlink!=world)
                lastlink.netname="link";
};

void () LinkThink =
{
        if((!visible2ent(self.enemy,self.owner)&&self.classname=="lastlink"&&self.owner.active)||self.hover)
        {
        local vector swingspot;
                if(!self.hover)
                {
                local entity link,lastlink;
                local float numlinks;
                        self.owner.owner.items2=self.owner.owner.items2-IT_GHOOK;
                        self.owner.owner.util=0;
                        self.owner.ghook_extended=self.owner.owner.ghook_extended;
                        self.owner.ghook_attached=self.owner.owner.ghook_attached;
                        self.owner.ghook_holdon=self.owner.owner.ghook_holdon;
                        self.owner.ghook_dropped=self.owner.owner.ghook_dropped;
                        self.owner.owner=self.owner;
                        self.owner.touch=GhookHit;
                        self.hover=TRUE;
                        self.solid=SOLID_BBOX;
                        self.movetype=MOVETYPE_FLY;
                        self.touch=NewEnemy;
                        self.enemy=spawn();
                        self.enemy.angles='0 0 0';
                        setsize(self.enemy,'0 0 0','0 0 0');
                        traceline(self.owner.origin,self.owner.origin - '0 0 300',TRUE,self);
                        self.o_angle=trace_endpos;
                        self.wallspot=trace_endpos;
                        numlinks=self.owner.speed;
                        lastlink=world;
                        setsize(self,'-1 -1 -1','1 1 1');
                        while (numlinks)
                        {
                                link=find(lastlink,netname,"link");
                                if(link.owner==self.owner)
                                {
#ifdef FLOODY_TEXT
                                bprint("found a link\n");
#endif
                                link.enemy=self.enemy;
                                link.movetype=MOVETYPE_FLY;
                                link.solid=SOLID_BBOX;
                                link.touch=NewEnemy;
                                setsize(link,'-1 -1 -1','1 1 1');
                                if(lastlink!=world)
                                        lastlink.netname="link";
                                lastlink=link;
                                lastlink.netname="oldlink";
                                numlinks = numlinks - 1;
                                }
                        }
                        if(lastlink!=world)
                                lastlink.netname="link";
                }
                swingspot_x=swingspot_x+random()*6 - 3;
                swingspot_y=swingspot_y+random()*6 - 3;
                if(vlen((self.wallspot+swingspot)-self.o_angle)>20)
                        swingspot='0 0 0' - swingspot;
                self.wallspot=self.wallspot+swingspot;
                setorigin(self.enemy,self.wallspot);
        }
        makevectors (self.enemy.angles);
        setorigin (self, self.owner.origin + ( ( ( self.enemy.origin + 
                (v_up * 16 * (!self.enemy.button2)) + (v_forward * 16) ) - self.owner.origin ) *
                ( self.weapon ) ) );
        self.nextthink = time + 0.01;
};

entity (entity from, entity to, float numlinks) MakeLinks =
{
        local entity link, prevlink;
        local float linknum;

        linknum = numlinks;
        numlinks = numlinks + 1;
        prevlink = world;
        while (linknum > 0)
        {
                link = spawn();

                link.goalentity = prevlink;
                prevlink = link;

                link.owner = from;
                link.enemy = to;
                link.weapon = linknum / numlinks;
                link.movetype = MOVETYPE_NOCLIP;
                link.solid = SOLID_NOT;
                link.angles_z = 51 * linknum;
                link.angles_y = 41 * linknum;
                link.angles_x = 31 * linknum;
                link.avelocity = '310 410 510';
                setmodel (link, "progs/link.mdl");
                setsize (link, '0 0 0', '0 0 0');
                makevectors (to.angles);
                setorigin (link, from.origin + ( ( ( to.origin 
                        + (v_up * 16 * (!to.button2)) + ( v_forward * 16 ) ) - from.origin )
                        * ( link.weapon ) ) );
                if(linknum==numlinks - 1)
                        link.classname="lastlink";
                else link.classname="link";
                link.netname="link";
                link.think = LinkThink;
                link.nextthink = time + 0.01;
                linknum = linknum - 1;
        }
        return link;
};

void() DeactivateGhook =
{
        sound(self.owner, CHAN_ITEM, "weapons/pkup.wav", 1, ATTN_NORM);
        self.owner.ghook_dropped=FALSE;
        self.owner.ghook_extended=FALSE;
        self.owner.ghook_holdon=FALSE;
        self.owner.ghook_attached=FALSE;
        self.owner.dangle=FALSE;
        self.owner.util=0;
        self.owner.attack_finished=time+0.5;
        LoseLinks ();
        remove(self);
};

void() Retract =
{
local vector dir;
local float dist;
#ifdef FLOODY_TEXT
        bprint("retracting\n");
#endif
        if(self.movetype!=MOVETYPE_BOUNCE)
                self.movetype=MOVETYPE_BOUNCE;
        makevectors (self.owner.angles);
        dir = self.owner.origin - ( self.origin + (v_up * 32) - (v_forward * 16));
        dist = vlen (dir);
        if (dist <= 100)
                dir = normalize(dir) * dist * 10;  
        if (dist > 100 )
                dir = normalize(dir) * 1000;  
        self.velocity = dir;
        if(self.velocity_z<30)
        self.velocity_z=50;
//        self.velocity=normalize(self.owner.origin-self.origin)*500;
        if(self.flags&FL_ONGROUND)
                self.flags=self.flags-FL_ONGROUND;
        if(vlen(self.origin-self.owner.origin)<36&&self.owner!=self)
                DeactivateGhook();
        self.think=Retract;
        self.nextthink=time;
};

void() PullMeUp =
{
local float dist;
local vector dir;
        makevectors (self.angles);
        dir = self.ghook_spot - ( self.origin + (v_up * 16 *
                        (!self.button2)) + (v_forward * 16));
        dist = vlen (dir);
        if (dist <= 100)
                dir = normalize(dir) *dist* 10;  
        if (dist > 100 )
                dir = normalize(dir) * 1000;  
        self.velocity = (self.velocity+dir)*0.5;
//        if(self.velocity!=normalize(self.ghook_spot-self.origin)*350)
//                self.velocity=(self.velocity+normalize(self.ghook_spot-self.origin)*500)*0.5;
        if(self.flags&FL_ONGROUND)
                self.flags=self.flags-FL_ONGROUND;
        self.dangle=TRUE;
        self.wallspot=self.ghook_spot;
        self.wallspot_z=self.origin_z;
};

void() WaitRetract =
{
        if(vlen(self.owner.origin-self.origin)<36&&self.owner!=self)
                DeactivateGhook();
        if(self.owner.button2)
                self.think=Retract;
        else if(!self.owner.alive&&(deathmatch||coop)&&self.owner!=self)
                self.think=DeactivateGhook;
        else self.think=WaitRetract;
        if(!self.solid)
                self.solid=SOLID_BBOX;
        self.nextthink=time;
};

void() GhookDrop =
{
local float dist;
local vector dir;
#ifdef FLOODY_TEXT
        bprint("Dropped\n");
#endif
        if(vlen(self.origin-self.owner.origin)<36&&self.owner!=self)
                DeactivateGhook();
        self.owner.ghook_dropped=TRUE;
        self.owner.ghook_attached=FALSE;
        self.solid=SOLID_NOT;
        self.touch = GhookHit;
        if(self.health<=0)
        {
                self.health=999999999;
                self.th_die=SUB_Null;
        }
        if(self.movetype!=MOVETYPE_BOUNCE)
                self.movetype=MOVETYPE_BOUNCE;
        if(self.owner==self)
                dir = normalize('0 0 0' - self.angles)*50;
        else
        {
        makevectors (self.owner.angles);
        dir = self.owner.origin - ( self.origin + (v_up * 32) - (v_forward * 16));
        dist = vlen (dir);
        if (dist <= 100)
                dir = normalize(dir) * dist * 10;  
        if (dist > 100 )
                dir = normalize(dir) * 100;  
        }
        self.velocity = dir;
//        self.velocity_x=self.velocity_x+random()*200+100;
//        self.velocity_y=self.velocity_x+random()*200+100;
//        self.velocity_z=random()*100+200;
        if(self.flags&FL_ONGROUND)
                self.flags=self.flags-FL_ONGROUND;
        if(!self.owner.alive&&(deathmatch||coop)&&self.owner!=self)
                self.think=DeactivateGhook;
        else self.think=WaitRetract;
        self.nextthink=time + 0.2;
};

void() HoldThink =
{
        if(vlen(self.origin-self.owner.origin)<36&&self.owner!=self)
                DeactivateGhook();
        setorigin (self, self.enemy.origin + self.enemy.mins +(self.enemy.size * 0.5));
//        self.enemy.velocity='0 0 0';
        self.velocity = '0 0 0';
        if(self.enemy.v_angle!=self.o_angle)
                self.enemy.v_angle=self.o_angle;
        if(self.owner!=self&&(!self.owner.alive||!self.owner.ghook_holdon||!self.enemy.alive))
                self.think=GhookDrop;
#ifdef GRAPPLE_STUN
        else self.think=HoldThink;
        if(random()<0.2&&random()<0.2)
        {
                self.enemy.think=self.enemy.th_pain;
                self.effects=EF_MUZZLEFLASH;
                particle (self.origin, v_forward*50+v_up*15, 242, 10);
        }
	if (self.t_width < time)
	{
		sound (self, CHAN_WEAPON, "weapons/lhit.wav", 1, ATTN_NORM);
		self.t_width = time + 0.6;
	}
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_LIGHTNING2);
        WriteEntity (MSG_BROADCAST, self.owner);
        WriteCoord (MSG_BROADCAST, self.owner.origin_x);
        WriteCoord (MSG_BROADCAST, self.owner.origin_y);
        WriteCoord (MSG_BROADCAST, self.owner.origin_z);
        WriteCoord (MSG_BROADCAST, self.origin_x);
        WriteCoord (MSG_BROADCAST, self.origin_y);
        WriteCoord (MSG_BROADCAST, self.origin_z);
        if(self.enemy.nextthink<time+1)
                self.enemy.nextthink=time + 1;
        if(self.enemy.attack_finished<time+1)
                self.enemy.attack_finished=time + 1;
        if(self.enemy.pausetime<time+1)
                self.enemy.pausetime=time + 1;
        if(self.enemy.alivetime<time+1)
                self.enemy.alivetime=time+1;
        if(self.owner.button2&&self.owner.weapon==IT_GHOOK)
        {
        local float dist;
        local vector dir;
        makevectors (self.angles);
        dir = self.owner.origin - (self.origin + (v_up * 32) - (v_forward * 16));
        dist = vlen (dir);
        if (dist <= 100)
                dir = normalize(dir) *dist* 10;  
        if (dist > 100 )
                dir = normalize(dir) * 1000;  
        dir=dir + '0 0 100';
        self.enemy.velocity = dir;
        if(self.enemy.flags&FL_ONGROUND)
                self.enemy.flags=self.enemy.flags-FL_ONGROUND;
        }
        else if(self.enemy.velocity)
                self.enemy.velocity='0 0 0';

        self.nextthink=time;
#else
	else self.think=GhookDrop;	// leilei - TODO properly drop this and don't stun.


#endif

};

void(entity bound) Grab=
{
        sound(self, CHAN_AUTO, "zombie/z_miss.wav", 1, ATTN_NORM);
        setorigin (self, bound.origin);
        T_Damage (other, self, self.owner, 10 );
        SpawnBlood (self.origin, self.velocity, 10,other);
        self.velocity = '0 0 0';
        self.avelocity = '0 0 0';
        self.origin=bound.origin;
        self.enemy=bound;
        self.o_angle=bound.v_angle;

        self.think=HoldThink;
        self.nextthink=time;
};

void() StayHere =
{
        if(vlen(self.origin-self.owner.origin)<36&&self.owner!=self&&!self.owner.ghook_holdon)
                DeactivateGhook();
        if((!self.owner.alive&&self.owner!=self)||!self.owner.ghook_holdon)
                self.think=GhookDrop;
        else self.think=StayHere;
        self.origin=self.wallspot;
        self.velocity='0 0 0';
        self.avelocity='0 0 0';
        self.nextthink=time;
        self.owner.ghook_spot=self.origin;
};

void(vector stickhere) Latch=
{
        sound(self, CHAN_AUTO, "player/axhit2.wav", 1, ATTN_NORM);
        self.owner.ghook_attached=TRUE;
        self.wallspot=stickhere;
        self.velocity='0 0 0';
        self.movetype=MOVETYPE_NONE;
        self.avelocity='0 0 0';
        self.think=StayHere;
        self.nextthink=time;
};

void() GhookHit =
{
        if(other==self.owner)
                return;

        self.active=TRUE;
        if(!self.owner.ghook_dropped&&self.owner.ghook_holdon)
        {
        self.touch = SUB_Null;
        if(other.health&&other.alive&&other!=self.enemy&&self.owner.ghook_holdon)
                Grab(other);
        else if(self.owner.ghook_holdon)
                Latch(self.origin);
        }
        else if(!self.owner.ghook_attached&&self.velocity!='0 0 0'&&!self.owner.ghook_holdon)
        {
        if (random()<0.5) 
                sound(self, CHAN_AUTO, "player/axhit2.wav", 1, ATTN_NORM);
        else
                sound(self, CHAN_AUTO, "weapons/tink1.wav", 1, ATTN_NORM);
        particle (self.origin, v_forward*50+v_up*15, 242, 10);
        }
};

void() ThrowGhook =
{
local float vertical;
local entity ghook;
        ghook=spawn();
        makevectors(self.v_angle);
        vertical = self.v_angle_z - 90;
        if(vertical<1)
                vertical = 1;
        sound(self, CHAN_AUTO, "weapons/woosh.wav", 1, ATTN_NORM);
        ghook.movetype=MOVETYPE_BOUNCE;
        ghook.solid=SOLID_BBOX;
        ghook.takedamage=DAMAGE_AIM;
        ghook.health=50;
        ghook.th_die=GhookDrop;
        ghook.touch=GhookHit;
        ghook.classname="ghook";
        ghook.enemy=world;
        ghook.speed=8;
        ghook.active=FALSE;
        self.ghook_dropped=FALSE;//dropped
        self.ghook_holdon=TRUE;//is off if player wants to detach it.
        self.ghook_extended=TRUE;//is not in player's hands
        self.ghook_attached=FALSE;//latched onto wall
        ghook.owner=self;

        ghook.velocity = aim(self, 1000);
        ghook.velocity = ghook.velocity * 1000 + v_up*vertical*100;
        ghook.avelocity_z=random()*400 - 200;
        ghook.angles = vectoangles(ghook.velocity);
        setmodel(ghook,"progs/ghook.mdl");
        setorigin (ghook, self.origin + (v_forward*16) + '0 0 16' );
        setsize(ghook,'-1 -1 -1','1 1 1');

        ghook.goalentity = MakeLinks (ghook, self, ghook.speed);
        self.attack_finished=time + 0.5;
        self.impulse=0;
};



void() float=
{
self.oldenemy.origin=self.origin;
self.oldenemy.flags=self.oldenemy.flags - FL_ONGROUND;
if(pointcontents(self.origin+'0 0 40')==CONTENT_SKY)
        setorigin(self,self.origin - '0 0 1');
if(self.oldenemy.health<=0||self.controller.health<=0||self.enemy.alive==FALSE)
        self.alivetime=time - 1;
if (self.alivetime < time)
        {
        self.active=FALSE;
        remove(self);
        }
self.think=float;
self.nextthink=time;
};

void() fireflyreturn =
{
if(other == self.enemy)
{
setsize (self, '-2 -2 -24', '2 2 40');
self.solid = SOLID_NOT;
self.movetype = MOVETYPE_FLY;
self.velocity='0 0 0';
self.velocity_z= self.velocity_z + 100;
self.th_stand = SUB_Null;
self.th_walk = SUB_Null;
self.th_run = SUB_Null;
self.touch = SUB_Null;
self.oldenemy.avelocity_z = random() * 600;
self.oldenemy.avelocity_y = random() * 600;
self.oldenemy.avelocity_x = random() * 600;
self.think = float;
}
};

void()grabthestupidfuckingbastard=
{
self.oldenemy = self.enemy;
self.oldenemy.origin=self.origin;
self.active=TRUE;
self.enemy = self.controller;
self.touch = fireflyreturn;
};

void() fireflytouch =
{
if(other != self.enemy)
        return;
grabthestupidfuckingbastard();
};

void() fflythink =
{
local vector dir, vtemp;
        if(self.active)
                self.oldenemy.origin=self.origin;
        vtemp = self.enemy.origin + '0 0 10';
        dir = normalize(vtemp - self.origin);
        self.velocity = dir * 350;
        self.velocity_x = self.velocity_x + (random () * 150 - 75);
        self.velocity_y = self.velocity_y + (random () * 150 - 75);
        self.velocity_z = self.velocity_z + (random () * 150 - 75);
        if(vlen(self.origin - self.enemy.origin)<48&&self.active==FALSE)
                grabthestupidfuckingbastard();
        if (self.alivetime<time||self.controller.health<=0||self.enemy.health<=0||self.enemy.alive==FALSE)
        {
        self.alivetime=time - 1;
        self.active=FALSE;
        remove(self);
        }
        self.nextthink = time + 0.2;
        self.think=fflythink;
};

void() fireflystart =
{
        self.solid = SOLID_BBOX;
        self.movetype = MOVETYPE_NOCLIP;
        setmodel (self, "progs/null.spr");
        self.effects = EF_BRIGHTFIELD;
        self.alive = FALSE;
	setsize (self, '-16 -16 -24', '16 16 40');
        self.alivetime = time + 300;
        self.classname ="firefly";
        self.touch = fireflytouch;
        self.flags = self.flags | FL_FLY;
        self.nextthink = time;
        self.think=fflythink;
};

void() summonfireflies =
{
local entity loser;
                self.fireflies = spawn();
                if(self.enemy.health<=0||(!self.enemy.alive))
                {
                loser = find(self,classname,"player");
                if(deathmatch&&loser.classname=="player")
                         self.fireflies.enemy=loser;                                
                else
                        {
                        self.alivetime=time;
                        sprint(self,"No enemies...\n");
                        return;
                        }
                }
                else self.fireflies.enemy = self.enemy;
                self.fireflies.controller = self;
                setorigin(self.fireflies, self.origin + '0 0 16');
                self.fireflies.think = fireflystart;
                self.fireflies.nextthink=time;
};

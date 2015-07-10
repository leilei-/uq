void()RestoreController;
void()PlayerDie;
void() clone_pain =
{
T_Damage(self.owner,self,self,0);
self.owner.dmg_take = self.dmg_take;
self.owner.dmg_save = self.dmg_save;
self.owner.dmg_inflictor = self.dmg_inflictor;
self.owner.health = self.health;
self.owner.armorvalue = self.armorvalue;
self.owner.armortype = self.armortype;
player_pain();
};

void() CloneDie =
{
local entity    play;
        play = self.owner;
        self = play.hoverbomb;
        other = world;
        sprint(play,"about to touch ");
        sprint(play,play.classname);
        sprint(play,"\n");
        if (play.classname != "player") RestoreController();

        self = play;

        PlayerDie();
};

void() RestoreController =
{
        if (other == self.controller.clone) other = self.controller;
        self.controller.classname = "player";
        self.controller.weaponmodel = self.controller.clone.weaponmodel;
        self.controller.weaponframe = 0;
        setmodel(self.controller, self.controller.clone.model);
        self.controller.frame = self.controller.clone.frame;
        self.controller.takedamage = DAMAGE_AIM;
        self.controller.solid = SOLID_SLIDEBOX;
        self.controller.view_ofs = '0 0 22';
        setsize (self.controller, VEC_HULL_MIN, VEC_HULL_MAX);
        self.controller.origin = self.controller.clone.origin;
        self.controller.velocity = self.controller.clone.velocity;
        self.controller.armorvalue = self.controller.clone.armorvalue;
        self.controller.armortype = self.controller.clone.armortype;
        self.controller.flags = self.controller.flags - self.controller.flags && FL_NOTARGET;
        self.controller.v_angle = self.controller.clone.v_angle;
        self.controller.angles = self.controller.clone.angles;
        self.controller.health = self.controller.clone.health;
        self.controller.flags = self.controller.clone.flags;
        self.controller.invisible_time = self.controller.clone.invisible_time;
        self.controller.invisible_finished = self.controller.clone.invisible_finished;
        self.controller.invincible_time = self.controller.clone.invincible_time;
        self.controller.invincible_finished = self.controller.clone.invincible_finished;
        self.controller.super_time = self.controller.clone.super_time;
        self.controller.super_damage_finished = self.controller.clone.super_damage_finished;
        self.controller.rad_time = self.controller.clone.rad_time;
        self.controller.radsuit_finished = self.controller.clone.radsuit_finished;
        self.controller.waterlevel = 0;
        self.controller.watertype = self.controller.clone.watertype;
        SetViewAngle(self.controller,self.controller.clone.v_angle);
        setmodel(self.controller.clone,"progs/null.spr");
        self.controller.clone.solid = SOLID_NOT;
        self.controller.clone.takedamage = DAMAGE_NO;
	self.origin = self.origin - 8*normalize(self.velocity);
};

void()CloneController=
{
        self.controller.clone.armorvalue = self.controller.armorvalue;
        self.controller.clone.armortype = self.controller.armortype;
        self.controller.clone.health = 100;
        self.controller.flags = self.controller.flags || FL_NOTARGET;
        self.controller.clone.origin = self.controller.origin;
        self.controller.clone.angles = self.controller.angles;
        self.controller.clone.v_angle = self.controller.v_angle;
        setmodel(self.controller.clone,self.controller.model);
        self.controller.clone.frame = self.controller.frame;
        self.controller.clone.takedamage = DAMAGE_AIM;
        self.controller.clone.health = self.controller.health;
        self.controller.clone.max_health = self.controller.max_health;
        self.controller.clone.solid = SOLID_SLIDEBOX;
        self.controller.clone.weaponmodel = self.controller.weaponmodel;
        self.controller.clone.th_pain = clone_pain;
        self.controller.clone.th_die = CloneDie;
        self.controller.clone.colormap = self.controller.colormap;
        self.controller.clone.weapon = self.controller.weapon;
        self.controller.clone.movetype = MOVETYPE_STEP;
        self.controller.clone.velocity = self.controller.velocity;
        self.controller.clone.nextthink = self.controller.nextthink;
        self.controller.clone.think = self.controller.think;
        self.controller.clone.effects = self.controller.effects | EF_DIMLIGHT;
        self.controller.clone.flags = self.controller.flags;
        self.controller.clone.waterlevel = self.controller.waterlevel;
        self.controller.clone.watertype = self.controller.watertype;
        self.controller.clone.invisible_time = self.controller.invisible_time;
        self.controller.clone.invisible_finished = self.controller.invisible_finished;
        self.controller.clone.invincible_time = self.controller.invincible_time;
        self.controller.clone.invincible_finished = self.controller.invincible_finished;
        self.controller.clone.super_time = self.controller.super_time;
        self.controller.clone.super_damage_finished = self.controller.super_damage_finished;
        self.controller.clone.rad_time = self.controller.rad_time;
        self.controller.clone.radsuit_finished = self.controller.radsuit_finished;
        setsize (self.controller.clone, VEC_HULL_MIN, VEC_HULL_MAX);
        setmodel(self.controller, "progs/null.spr");
        setsize(self.controller, '0 0 0', '0 0 0');
        self.controller.solid = SOLID_NOT;
        self.controller.view_ofs = '0 0 0';
        self.controller.weaponmodel = "";
        self.controller.classname = "gplayer";
        setorigin(self.controller,self.controller.origin +v_forward*1000);
};
void() HoverBombThink =
{
local float hoverspeed;

        hoverspeed=(time - self.alivetime)*10;
        if(hoverspeed>250)
                hoverspeed=250;

//        if(self.controller.aflag==666)
//        {
        local entity temp;
        temp = self;
        self = self.controller.clone;
        droptofloor();
        self = temp;
        self.angles = self.owner.v_angle;
        makevectors(self.angles);
/*
        makevectors(self.controller.v_angle);
        self.v_angle=self.controller.v_angle;
*/
        self.velocity=normalize(v_forward)*hoverspeed;
        self.angles_x = 0-self.angles_x;
        makevectors(self.angles);
        self.owner.origin = self.origin - normalize(self.velocity)*5;
//        }

        if(random()<0.2)
                {
                  self.avelocity_x=rint(random()*359)+1;
                  self.avelocity_y=rint(random()*359)+1;
                  self.avelocity_z=rint(random()*359)+1;
                  local float rs;
//                  rs = rint((random() * 5) + 1);
                  rs = rint((random() * 2) + 1);
                  if(rs==1) self.lasersound="weapons/beep1.wav";
//                  else if(rs==2) self.lasersound="weapons/beep2.wav";
//                  else if(rs==3) self.lasersound="weapons/beep3.wav";
//                  else if(rs==4) self.lasersound="weapons/beep4.wav";
                  else if(rs==2) self.lasersound="weapons/beep5.wav";
//                  else self.lasersound="weapons/beep6.wav";
                  else self.lasersound="misc/talk.wav";
                  sound(self,CHAN_AUTO,self.lasersound,1,ATTN_NORM);
                  self.skin=rs;
                  self.ow_finished=time+0.3;
                  self.effects=EF_MUZZLEFLASH;
                }

        if(self.ow_finished<=time)
                self.skin=0;

        if(self.message_time<time)
        {
                sound(self,CHAN_WEAPON,"weapons/hoverhum.wav",1,ATTN_NORM);
                self.message_time=time + 0.5;
        }

        self.think=HoverBombThink;
        self.nextthink=time;
};

void() HoverBoom =
{
//        if(self.controller.aflag==666)
//                HoloCam(self.controller);

        self.velocity='0 0 0';
        self.running=FALSE;
        self.th_die=SUB_Null;

        T_RadiusDamage (self, self.controller, 100, world);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

        s_explode1();
        remove(self);
};

void() HoverTouch =
{
        RestoreController();
        if(other==self.controller)
                {
//                if(self.controller.aflag==666)
//                        HoloCam(self.controller);
                self.velocity='0 0 0';
                self.running=FALSE;
                self.th_die=SUB_Null;
                sound(self.controller,CHAN_ITEM,"weapons/pkup.wav",1,ATTN_NORM);
                self.controller.ammo_rockets=self.controller.ammo_rockets + 5;
                remove(self);
                }
        else HoverBoom();
};

void() HoverActivate =
{
        if(self.alivetime>time)
        {
        if(random()<0.3)
                {
                  self.avelocity_x=rint(random()*359)+1;
                  self.avelocity_y=rint(random()*359)+1;
                  self.avelocity_z=rint(random()*359)+1;
                  local float rs;
//                  rs = rint((random() * 5) + 1);
                  rs = rint((random() * 2) + 1);
                  if(rs==1) self.lasersound="weapons/beep1.wav";
//                  else if(rs==2) self.lasersound="weapons/beep2.wav";
//                  else if(rs==3) self.lasersound="weapons/beep3.wav";
//                  else if(rs==4) self.lasersound="weapons/beep4.wav";
                  else if(rs==2) self.lasersound="weapons/beep5.wav";
//                  else self.lasersound="weapons/beep6.wav";
                  else self.lasersound="misc/talk.wav";
                  sound(self,CHAN_AUTO,self.lasersound,1,ATTN_NORM);
                  self.skin=rs;
                  self.ow_finished=time + 0.1;
                }
        if(self.ow_finished<=time)
                self.skin=0;
        self.think=HoverActivate;
        self.nextthink=time + 0.1;
        }
        else
        {
        makevectors(self.controller.v_angle);
        self.velocity=normalize(v_forward)*10;
        self.angles=self.controller.v_angle;
        CloneController();
        self.alivetime=time - 0.5;
        self.touch=HoverTouch;
        self.think=HoverBombThink;
        self.nextthink=time + 0.5;
//        HoloCam(self.controller);
        }
};

void() HoverWait =
{
        if(self.velocity=='0 0 0')
                {
                self.movetype=MOVETYPE_FLYMISSILE;
                self.velocity='0 0 10';
                if (self.flags & FL_ONGROUND)
                   self.flags = self.flags - FL_ONGROUND;
                sound(self,CHAN_AUTO,"weapons/hovergo.wav",1,ATTN_NORM);
                setsize(self,'-2 -2 -2','2 2 2');
                self.avelocity='0 0 0';
                self.effects=EF_MUZZLEFLASH;
                self.touch=SUB_Null;
                self.alivetime=time + 2.5;
                self.think=HoverActivate;
                self.nextthink=time + 0.5;
                }
        else
        {
        self.think=HoverWait;
        self.nextthink=time;
        }
};

void() HoverBounce =
{
	sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);  // bounce sound
};

void() FireHoverBomb =
{
        if(self.hoverbomb.running)
                {
                self.hoverbomb.think=HoverBoom;
                self.hoverbomb.nextthink=time;
                return;
                }
        player_rocket1();
        self.ammo_rockets=self.ammo_rockets - 5;
        sound (self, CHAN_WEAPON, "weapons/hoverpop.wav", 1, ATTN_NORM);
        makevectors(self.v_angle);

        self.hoverbomb=spawn();
        self.hoverbomb.movetype=MOVETYPE_BOUNCE;
        self.hoverbomb.solid=SOLID_BBOX;
        self.hoverbomb.takedamage=DAMAGE_AIM;
        self.hoverbomb.health=100;
        self.hoverbomb.touch=HoverBounce;
        self.hoverbomb.th_die=HoverBoom;

        self.hoverbomb.running=TRUE;
        self.hoverbomb.owner=self.hoverbomb;
        self.hoverbomb.controller=self;

        self.hoverbomb.effects=EF_MUZZLEFLASH;
        self.hoverbomb.angles=self.v_angle;
        self.hoverbomb.velocity=v_forward*100+v_up*25;
        self.hoverbomb.avelocity_x=rint(random()*359)+1;
        self.hoverbomb.avelocity_y=rint(random()*359)+1;
        self.hoverbomb.avelocity_z=rint(random()*359)+1;
        self.hoverbomb.think=HoverWait;
        self.hoverbomb.nextthink=time;

        setmodel(self.hoverbomb,"progs/hover.mdl");
        setorigin(self.hoverbomb,self.origin+v_forward*48+'0 0 16');
        setsize(self.hoverbomb,'-2 -2 -10','2 2 2');
};


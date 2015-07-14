/* RACES, CLASSES, etc... by Michael Gummelt */
void()PlaySkinThink=
{
self.skin=self.owner.skin;
self.colormap=self.owner.colormap;
if(self.owner.allset||self.owner.impulse==114)
        {
        self.owner=self;
        self.think=SUB_Remove;
        if(self.owner.impulse==114)
                self.nextthink=time;
        else self.nextthink=time + 2;
        }
else
        {
        self.think=PlaySkinThink;
        self.nextthink=time;
        }
};

void() showplayskin =
{
        self.saber=spawn();
        self.saber.movetype=MOVETYPE_FLY;
        self.saber.solid=SOLID_NOT;
        self.saber.avelocity='0 -200 0';
        self.saber.frame=18;
        self.saber.owner=self;
        setmodel(self.saber,"progs/player.mdl");
        makevectors (self.v_angle);
        setorigin(self.saber,self.origin+v_forward*64+'0 0 1');
        self.saber.think=PlaySkinThink;
        self.saber.nextthink=time;
        
};

void() SetFriction =
{
// NOTE:  If use 1 player mode, use sv_maxspeed instead, only use
//        friction & mod speed for coop or multiplayer?
//        Or can different people on a server use different sv_maxspeeds?
        if(self.speed<0.3)
                self.speed= 0.3;
        if((self.speed<0.6&&self.speed>=0.5)||self.friction==8)
                {
                self.friction=8;
                cvar_set("sv_friction","8");
                localcmd("sv_friction 8\n");
                }
        else if((self.speed<0.5&&self.speed>=0.4)||self.friction==9)
                {
                self.friction=9;
                cvar_set("sv_friction","9");
                localcmd("sv_friction 9\n");
                }
        else if((self.speed<0.4&&self.speed>=0.3)||self.friction==10)
                {
                self.friction=10;
                cvar_set("sv_friction","10");
                localcmd("sv_friction 10\n");
                }
        else
        {
                self.friction=7;
                cvar_set("sv_friction","7");
                localcmd("sv_friction 7\n");
        }
};

void() showskin =
{
if(self.skin==0)
        centerprint(self,"Mike Gummelt\n");
else if(self.skin==1)
        {
        centerprint(self,"Mike Jaworski\n");
#ifdef JAWORSKI
        if(self.skinset)
                sound (self, CHAN_VOICE, "jaworski/whoohoo.wav",1, ATTN_NORM);

#endif
        }
else if(self.skin==2)
        centerprint(self,"Draconian\n");
else if(self.skin==3)
        {
        centerprint(self,"White Knight\n");
        if(deathmatch||self.allset!=TRUE)
        {
        self.armortype = 0.8;
        self.armorvalue = 200;
        self.items=self.items+IT_ARMOR3;
        if(self.mass<1.4)
                self.mass=self.mass + 0.2;
        }
//Armor (full,regen), slow, sword
        }
else if(self.skin==4)
        centerprint(self,"Elf\n");
else if(self.skin==5)
        centerprint(self,"Terminator\n");
else if(self.skin==6)
	{
        centerprint(self,"Punisher\n");
        if(deathmatch||self.allset!=TRUE)
        {
        self.ammo_rockets = 5;
        self.ammo_shells = 25;
        self.ammo_nails = 25;
        self.ammo_cells = 25;
	self.items = self.items | 
		IT_SUPER_SHOTGUN |
		IT_NAILGUN |
		IT_SUPER_NAILGUN |
		IT_GRENADE_LAUNCHER |
		IT_ROCKET_LAUNCHER |
                IT_LIGHTNING;
        self.armortype = 0.6;
        self.armorvalue = 150;
        self.items=self.items+IT_ARMOR2;
        }
        if(self.weapon==1)
                self.weaponmodel = "progs/v_uzi.mdl";
        self.nospells=TRUE;
	}
else if(self.skin==7)
        {
        centerprint(self,"Ninja\n");
	  if(self.wallclimb!=TRUE)
		self.wallclimb=TRUE;
        }
else if(self.skin==8)
        centerprint(self,"Camouflage\n");
else if(self.skin==9)
        centerprint(self,"Talon\n");
else if(self.skin==10)
        centerprint(self,"Predator\n");
else if(self.skin==11)
        {
        centerprint(self,"Klingon\n");
        if(deathmatch||self.allset!=TRUE)
        {
        self.armortype = 0.3;
        self.armorvalue = 100;
        self.items=self.items+IT_ARMOR1;
        }
//Batleth, some armor, perf face
        }
else if(self.skin==12)
        {
        centerprint(self,"Valkyrie\n");
        if(deathmatch||self.allset!=TRUE)
        {
        self.armortype = 0.6;
        self.armorvalue = 150;
        self.items=self.items+IT_ARMOR2;
        }
//sword, armor
        }
else if(self.skin==13)
{
        centerprint(self,"Fremen\n");
//Armor, fireresist, slimeresist, grappling hook, maudibgun
        if(deathmatch||self.allset!=TRUE)
        {
        self.armortype = 0.3;
        self.armorvalue = 100;
        if(!self.items&IT_ARMOR1)
                self.items=self.items + IT_ARMOR1;
        if(!self.items2&IT_GHOOK)
                self.items2=self.items2 + IT_GHOOK;//gives ghook
        }
        self.slimeresist=TRUE;
        self.fireresist=TRUE;
        self.waterbreathe=TRUE;
        if(self.speed>0.75)
                self.speed=0.75;
}
else if(self.skin==14)
        centerprint(self,"Bossk\n");
else if(self.skin==15)
        {
        centerprint(self,"Jules Winfield\n");
//      Sound: time to get into character
        self.accuracy=0;
        }
else if(self.skin==16)
     {
        centerprint(self,"Xena\n");
        if(self.skinset)
            sound(self,CHAN_VOICE,"xena/femyell.wav",1,ATTN_NONE);
     	if(self.jumphite<10)
           	self.jumphite=10;
        if(self.speed>0.7)
                self.speed=0.7;
 	if(self.wallclimb!=TRUE)
		self.wallclimb=TRUE;
        if(deathmatch||!self.allset)
        {
                self.armortype = 0.3;
                self.armorvalue = 100;
        if(!self.items&IT_ARMOR1)
                self.items=self.items+IT_ARMOR1;
        if(!self.items2&IT_GHOOK)
                self.items2=self.items2 + IT_GHOOK;//gives ghook
        }
     }
else if(self.skin==17)
	{
        centerprint(self,"Gunslinger\n");
	if(self.skinset)
		sound(self,CHAN_AUTO,"weapons/gbu1.wav",1,ATTN_NONE);
        self.nospells=TRUE;
	}
else if(self.skin==18)
        centerprint(self,"Drow\n");
else if(self.skin==19)
        centerprint(self,"Chang-Khan\n");
else if(self.skin==20)
	  {        
	  centerprint(self,"Duke Nukem\n");
        if(self.jumphite<10)
     	          self.jumphite=10;
//        if(!self.items&IT_FREEZEGUN)
//                self.items=self.items+IT_FREEZEGUN;// gives freezegun and shrinkgun
	  }
else if(self.skin==21)
	{
        centerprint(self,"Boba Fett\n");
	if(!self.items&IT_JETPACK)
	  self.items=self.items + IT_JETPACK;
	  if(self.ammo_cells<100)
		self.ammo_cells = 100;
	  }
else if(self.skin==22)
        centerprint(self,"Borg\n");
else if(self.skin==23)
        {
        centerprint(self,"Han Solo\n");
        if(deathmatch||self.allset!=TRUE)
        {
        self.ammo_cells = 100;
        self.items = self.items + IT_LIGHTNING;
        }
        }
//start with blaster
if(self.skinset&&deathmatch)
        ExperienceCheck(self);
};

void(string skinname) ChoosePrint =
{
        if(!self.allset)
                centerprint(self,skinname);
        else
                sprint(self,skinname);
};

void() showskin2 =
{
local string printnum;
if(!self.allset&&self.skin!=9&&self.skin!=11&&self.skin!=13&&self.skin!=18)
        localcmd("color 1 6\n");
if(self.skin==0)
        ChoosePrint("Mike Gummelt\n");
else if(self.skin==1)
        ChoosePrint("Mike Jaworski\n");
else if(self.skin==2)
        ChoosePrint("Draconian\n");
else if(self.skin==3)
        ChoosePrint("White Knight\n");
else if(self.skin==4)
        ChoosePrint("Elf\n");
else if(self.skin==5)
        ChoosePrint("Terminator\n");
else if(self.skin==6)
        ChoosePrint("Punisher\n");
else if(self.skin==7)
        ChoosePrint("Ninja\n");
else if(self.skin==8)
        ChoosePrint("Camouflage\n");
else if(self.skin==9)
        ChoosePrint("Talon\n");
else if(self.skin==10)
        ChoosePrint("Predator\n");
else if(self.skin==11)
        ChoosePrint("Klingon\n");
else if(self.skin==12)
        ChoosePrint("Valkyrie\n");
else if(self.skin==13)
        ChoosePrint("Fremen\n");
else if(self.skin==14)
        ChoosePrint("Bossk\n");
else if(self.skin==15)
        ChoosePrint("Jules Winfield\n");
else if(self.skin==16)
        ChoosePrint("Xena\n");
else if(self.skin==17)
        ChoosePrint("Gunslinger\n");
else if(self.skin==18)
        ChoosePrint("Drow\n");
else if(self.skin==19)
        ChoosePrint("Chang-Khan\n");
else if(self.skin==20)
        ChoosePrint("Duke Nukem\n");
else if(self.skin==21)
        ChoosePrint("Boba Fett\n");
else if(self.skin==22)
        ChoosePrint("Borg\n");
else if(self.skin==23)
        ChoosePrint("Han Solo\n");
if(self.skinset&&deathmatch)
        ExperienceCheck(self);
};

void() showclass =
{
local float special,weakness,speclimit,weaklimit;
if(self.class==1)
{
        self.classlabel="Warrior";
        self.speed=self.speed - 0.05;
        self.attackspeed = 0.1;
        self.jumphite=self.jumphite + 1;
        if(!self.allset)
                {
                self.health=self.health + 30;
                self.max_health = self.health;
                }
        self.mass=self.mass + 0.2;
        self.intel=self.intel - 2;
        self.damagetake=self.damagetake - 0.1;
        self.accuracy=0.1;
}
else if(self.class==2)
{
        self.classlabel="Warlock";
        self.accuracy=0.2;
        self.attackspeed = 0.05;
        if(!self.allset)
                self.max_health = self.health;
}
else if(self.class==3)
{
        self.classlabel="Mage";
        self.speed=self.speed + 0.1;
        self.jumphite=self.jumphite - 0.5;
        self.attackspeed = -0.15;
        if(!self.allset)
                {
                self.health=self.health - 10;
                self.max_health = self.health;
                }
        self.intel=self.intel + 5;
        self.damagetake=self.damagetake + 0.1;
        self.accuracy=0.3;
}
else if(self.class==4)
{
//Miraculous Reincarnation- gain back full health- hear "hallelujah"
        self.classlabel="Paladin";
        self.speed=self.speed - 0.05;
        self.jumphite=self.jumphite + 0.5;
        self.mass=self.mass + 0.1;
        if(!self.allset)
                {
                self.health=self.health + 20;
                self.max_health = self.health;
                }
        self.intel=self.intel + 3;
        self.damagetake=self.damagetake - 0.3;
        self.accuracy=0.1;
}
else if(self.class==5)
{
        self.classlabel="Assassin";
        self.speed=self.speed - 0.1;
        self.attackspeed = 0.2;
        self.jumphite=self.jumphite + 1;
        self.intel = self.intel + 1;
        if(!self.allset)
                {
                self.health=self.health - 10;
                self.max_health = self.health;
                }
        self.damagetake=self.damagetake + 0.1;
        self.accuracy=0;
        self.volume = -1;
}
else if(self.class==6&&self.allset!=TRUE)
{
// NOTE: Stop from mutating every time you start a new level!
        self.classlabel="Mutant";
        self.speed=self.speed + random()*0.4 - 0.2;
        self.attackspeed = random()*0.3 - 0.15;
        self.jumphite=self.jumphite + rint(random()*4) - 2;
        self.intel = self.intel +rint(random()*10) - 5;
        self.health=self.health + rint(random()*60) - 30;
        self.max_health = self.health;
        self.damagetake=self.damagetake + random()*0.6 - 0.3;
        if(self.damagetake< 0.5)
                self.damagetake= 0.5;
        self.accuracy=random()*0.2;
        self.hitplus = self.hitplus + random()*0.6 - 0.3;
        if(self.hitplus< 0.75)
                self.hitplus= 0.75;
        self.mass = self.mass + random()*0.4 - 0.2;
}
else if(self.class==7||self.class==8)
{
        if(self.class==7)
                self.classlabel="Jedi";
        else self.classlabel="Dark Jedi";
//        stuffcmd(self,"exec jedi.cfg\n");
        self.speed=self.speed - 0.1;
//        self.jumphite=1;
        self.intel = self.intel + 10;
        if(!self.allset)
                {
                if(self.class==7)
                        self.health=self.health + 10;
                self.max_health = self.health;
                }
        self.damagetake=self.damagetake - 0.2;
        self.accuracy=0;
        self.featherfall=TRUE;
        self.nospells=TRUE;
}
        sprint(self,"Class:  ");
        sprint(self,self.classlabel);
        sprint(self,"\n");
speclimit=rint(random()*2) + 2;
weaklimit=rint(random()*1) + 1;
if(self.class==6&&self.allset!=TRUE)
{
//Special Abilities
    while(special<speclimit)
    {
        if(random()<0.1&&self.racename!="Bossk"&&self.waterbreathe!=TRUE)
                {
                sprint(self,self.netname);
                sprint(self," can breathe under water for 5 minutes!\n");
                self.waterbreathe=TRUE;
                special=special+1;
                }
        else if(random()<0.1&&self.racename!="Draconian"&&self.fireresist!=1)
                {
                sprint(self,self.netname);
                sprint(self," is totally resistant to fire!\n");
                self.fireresist=1;
                special=special+1;
                }
        else if(random()<0.1&&self.slimeresist!=TRUE)
                {
                sprint(self,self.netname);
                sprint(self," is immune to slime!\n");
                self.slimeresist=TRUE;
                special=special+1;
                }
        else if(random()<0.1&&self.magicresist!=TRUE)
                {
                sprint(self,self.netname);
                sprint(self," is resistant to magic!\n");
                self.magicresist=TRUE;
                special=special+1;
                }
        else if(random()<0.1&&self.healthregen!=TRUE&&special<speclimit - 1)
                {
                sprint(self,self.netname);
                sprint(self," constantly regenerates health!\n");
                self.healthregen=TRUE;
                special=special+2;
                }
        else if(random()<0.1&&self.racename!="TigerMan"&&self.racename!="Predator"&&self.racename!="Draconian"&&self.claws!=TRUE&&special<speclimit - 1)
                {
                sprint(self,self.netname);
                sprint(self," has grown claws!\n");
                self.claws=TRUE;
                special=special+2;
                }
        else if(random()<0.1&&self.racename!="TigerMan"&&self.racename!="Predator"&&self.racename!="Draconian"&&self.claws!=TRUE&&self.wallclimb!=TRUE)
                {
                sprint(self,self.netname);
                sprint(self," can climb walls!\n");
                self.wallclimb=TRUE;
                special=special+1;
                }
        else if(random()<0.1&&self.racename!="TigerMan"&&self.featherfall!=TRUE)
                {
                sprint(self,self.netname);
                sprint(self," can fall without damage or acceleration!\n");
                self.featherfall=TRUE;
                special=special+1;
                }
        else if(random()<0.1&&self.berzerker!=TRUE&&special<speclimit - 1)
                {
                sprint(self,self.netname);
                sprint(self," is a berzerker!\n");
                self.berzerker=TRUE;
                special=special+2;
                }
        else if(random()<0.1&&self.energyabsorb!=TRUE)
                {
                sprint(self,self.netname);
                sprint(self," can absorb energy attacks!\n");
                self.energyabsorb=TRUE;
                special=special+1;
                }
        else if(random()<0.1&&self.racename!="Predator"&&self.nospells!=TRUE&&self.anyinvis!=TRUE&&special<speclimit - 1)
                {
                sprint(self,self.netname);
                sprint(self," can turn invisible at will!\n");
                self.anyinvis=TRUE;
                special=special+2;
                }
        else if(random()<0.1&&self.heatsee!=TRUE&&self.boltsee!=TRUE&&special<speclimit - 1)
                {
                sprint(self,self.netname);
                sprint(self," has heat vision!\n");
                self.items=self.items|IT_SPECIAL;
                self.heatsee=TRUE;
                special=special+2;
                }
        else if(random()<0.1&&self.boltsee!=TRUE&&self.heatsee!=TRUE&&special<speclimit - 1)
                {
                sprint(self,self.netname);
                sprint(self," can shoot forcebolts from his eyes!\n");
                self.boltsee=TRUE;
                self.items=self.items|IT_SPECIAL;
                special=special+2;
                }
     }
//Weaknesses
while(weakness<weaklimit)
    {
        if(random()<0.2&&self.weakheart!=TRUE)
                {
                sprint(self,self.netname);
                sprint(self," has a weak heart!\n");
                self.weakheart=TRUE;
                weakness=weakness+1;
                }
        else if(random()<0.2&&self.speed<1.1)
                {
                sprint(self,self.netname);
                sprint(self," is not a fast guy.\n");
                self.attackspeed = 0;
                self.speed = 1.5;
                self.mass = 1;
                weakness=weakness+1;
                }
        else if(random()<0.2&&self.weak!=TRUE)
                {
                sprint(self,self.netname);
                sprint(self," can't carry a lot of weight!\n");
                self.weak=TRUE;
                weakness=weakness+1;
                }
        else if(random()<0.2&&self.fireresist!=1&&self.fireresist!= -1&&self.racename!="Draconian")
                {
                sprint(self,self.netname);
                sprint(self," is extremely vulnerable to fire!\n");
                self.fireresist= -1;
                weakness=weakness+1;
                }
        else if(random()<0.2&&self.anyinvis!=TRUE&&self.racename!="Predator"&&self.nospells!=TRUE)
                {
                sprint(self,self.netname);
                sprint(self," cannot cast spells!\n");
                self.nospells=TRUE;
                weakness=weakness+1;
                }
    }
}
        if(self.racename=="Elf")
                self.accuracy=0;
        SetFriction();
};

void() showrace =
{
if(self.race==1)
{
        self.racename="Human";
        if(self.class!=6)
        {
        self.speed=1;
        self.jumphite=6;
        self.mass=1;
        self.intel=10;
        self.damagetake=1;
        }
        if(!self.allset)
        {
        self.health=100;
        self.exp = 100000;
        }
}
else if(self.race==2)
{
        self.racename="TigerMan";
        if(self.class!=6)
        {
        self.speed= 0.6;
        self.jumphite=15;
        self.mass=1.2;
        self.intel=3;
        self.damagetake=0.8;
        }
        if(!self.allset)
                {
                self.health=130;
                self.skin=9;
                }
        self.air_finished = time + 6;
        self.fireresist=-1;
        self.claws=TRUE;
}
else if(self.race==3)
{
        self.racename="Elf";
        if(self.class!=6)
        {
        self.speed= 0.9;
        self.jumphite=7;
        self.mass=0.9;
        self.intel=15;
        self.damagetake=1.1;
        }
        if(!self.allset)
                {
                self.health=90;
                self.armortype = 0.8;
                self.armorvalue = 200;
                self.items=self.items+IT_ARMOR3;
                }
        self.skin=4;
        self.skinset=TRUE;
        sprint(self,"Skin PreSet to: ");
        showskin2();
}
else if(self.race==4)
{
        self.racename="Dark Elf";
        if(self.class!=6)
        {
        self.speed=1;
        self.jumphite=6;
        self.mass=0.8;
        self.intel=25;
        self.damagetake=1.2;
        self.accuracy=0;
        }
        self.slimeresist=TRUE;
        if(!self.allset)
                self.health=85;
        self.skin=18;
        self.skinset=TRUE;
        sprint(self,"Skin PreSet to: ");
        showskin2();
}
else if(self.race==5)
{
        self.racename="Draconian";
        if(self.class!=6)
        {
        self.speed= 1.3;
        self.jumphite=5;
        self.mass=1.1;
        self.intel=7;
        self.damagetake=0.8;
        }
        if(!self.allset)
                self.health=130;
        self.skin=2;
        self.skinset=TRUE;
	  self.wallclimb=TRUE;
        sprint(self,"Skin PreSet to: ");
        showskin2();
}
else if(self.race==6)
{
        self.racename="Bossk";
        if(self.class!=6)
        {
        self.speed= 1.2;
        self.jumphite=7;
        self.mass=1.1;
        self.intel=6;
        self.damagetake=0.85;
        }
        self.air_finished = time + 300;
        if(!self.allset)
                self.health=115;
        self.skin=14;
        self.skinset=TRUE;
        sprint(self,"Skin PreSet to: ");
        showskin2();
}
else if(self.race==7)
{
        self.racename="Predator";
        if(self.class!=6)
        {
        self.speed= 0.5;
        self.jumphite=15;
        self.mass=1.4;
        self.intel= -2;
        self.damagetake=0.7;
        }
        if(!self.allset)
                self.health=130;
        self.items = self.items | IT_INVISIBILITY | IT_ROCKET_LAUNCHER;
        sound (self, CHAN_AUTO, "predator/cloak.wav", 1, ATTN_NORM);
        self.spell=84;
        self.claws=TRUE;
        self.invisible_time = 1;
        self.invisible_finished = time + 15;
        self.skin=10;
        self.skinset=TRUE;
        self.nospells=TRUE;
        sprint(self,"Skin PreSet to: ");
        showskin2();
}
else if(self.race==8)
{
        self.racename="T-800";
        self.speed= 0.8;
        self.jumphite=7;
        self.mass=1.3;
        self.intel= -10;
        self.damagetake=0.6;
        self.skin=5;
        self.skinset=TRUE;
        self.nospells=TRUE;
        if(!self.allset)
                {
                self.health=175;
                self.max_health = self.health;
                }
        if(deathmatch||self.allset!=TRUE)
        {
        self.ammo_rockets = 5;
        self.ammo_shells = 25;
        self.ammo_nails = 25;
        self.ammo_cells = 25;
	self.items = self.items | 
		IT_SUPER_SHOTGUN |
		IT_NAILGUN |
		IT_SUPER_NAILGUN |
		IT_GRENADE_LAUNCHER |
		IT_ROCKET_LAUNCHER |
                IT_LIGHTNING;
        self.armortype = 0.6;
        self.armorvalue = 150;
        self.items=self.items+IT_ARMOR2;
        }
        sprint(self,"Skin PreSet to: ");
        showskin2();
        self.classset=TRUE;
        self.classlabel="Terminator";
        self.attackspeed = 0.15;
        self.accuracy=0;
        SetFriction();
}
else if(self.race==10)
{
        self.racename="Borg";
        self.charmed=1;
        self.borgview=1;
        self.speed= 1.1;
        self.jumphite=5.5*1.3;
        self.mass=1.3;
        self.intel= -10;
        self.damagetake=0.75;
        self.skin=5;
        self.skinset=TRUE;
        self.nospells=TRUE;
        sound(self,CHAN_VOICE,"borg/werborg.wav",1,ATTN_NONE);
        if(!self.allset)
                {
                self.health=100;
                self.max_health = self.health;
                }
        if(deathmatch||self.allset!=TRUE)
        {
        self.ammo_cells = 200;
        self.items = self.items | IT_LIGHTNING;
        }
        sprint(self,"Skin PreSet to: ");
        self.skin=22;
        showskin2();
        self.classset=TRUE;
        self.class=1;
        self.classlabel="Drone";
        self.attackspeed = 0.2;
        self.accuracy=0;
        self.healthregen=TRUE;
        self.nospells=TRUE;
        self.lightning=spawn();
        SetFriction();
}
else if(self.race==9)
{
        self.racename="Klingon";
        self.speed= 0.85;
        self.jumphite=7;
        self.mass=1.2;
        if(!self.allset)
                self.health=120;
        self.intel=3;
        self.berzerker=TRUE;
        self.healthregen=TRUE;
        self.damagetake=0.75;
        self.skin=11;
        self.skinset=TRUE;
        sprint(self,"Skin PreSet to: ");
        showskin2();
}
        sprint(self,"Race:  ");
        sprint(self,self.racename);
        sprint(self,"\n");
if(self.racename=="Borg"||self.racename=="T-800")
        {
        sprint(self,"Class:  ");
        sprint(self,self.classlabel);
        sprint(self,"\n");
        }
if(deathmatch||teamplay)
        self.exp = 1000000;
};

void() selectrace=
{
local string printnum;
if (!self.ishuman){	// leilei - selecting hack for bots
		if (!self.raceset && !self.race){
			self.race = random() & 10;
			self.race = self.owner.botrace - 1;
                //	showplayskin();
			self.impulse = 142;
			}
		else if (!self.raceset)
			self.impulse = 52;
		}
if (self.impulse == 140 || self.impulse == 142 || !self.ishuman)
{
        if(self.race==0)
                showplayskin();
        self.race = self.race - self.impulse + 141;
        if(self.race>10)
                self.race=1;
        else if(self.race<1)
                self.race=10;
if(self.race==1)
        centerprint(self,"Human\n");
else if(self.race==2)
        centerprint(self,"TigerMan\n");
else if(self.race==3)
        centerprint(self,"Elf\n");
else if(self.race==4)
        centerprint(self,"Dark Elf\n");
else if(self.race==5)
        centerprint(self,"Draconian\n");
else if(self.race==6)
        centerprint(self,"Bossk\n");
else if(self.race==7)
        centerprint(self,"Predator\n");
else if(self.race==8)
        centerprint(self,"T-800\n");
else if(self.race==9)
        centerprint(self,"Klingon\n");
else if(self.race==10)
        centerprint(self,"Borg\n");
}
if((self.impulse==52&&self.race!=0) || !self.ishuman)
{
	sound (self, CHAN_VOICE,"misc/secret.wav", 1, ATTN_NORM);
	self.raceset=TRUE;
	showrace();
}



};

void() selectclass=
{
local string printnum;
if (self.impulse == 140 || self.impulse == 142 || !self.ishuman)
{
self.class = self.class - self.impulse + 141;

if (!self.ishuman){	// leilei - selecting hack for bots
		if (!self.classset && !self.class){
			self.class = random() & 8;
			//self.class = self.owner.botclass;
                	showplayskin();
			self.impulse = 140;
			}
		else if (!self.classset)
			self.impulse = 52;
		}
if(self.class>8)
        self.class=1;
else if(self.class<1)
        self.class=8;

if((self.class==2||self.class==4)&&self.racename!="Human")
        self.class = self.class - self.impulse + 141;
if(self.racename=="T-800"||self.racename=="Predator"||self.racename=="Klingon")
        if(self.class==3 || self.class==4)
                if(self.impulse==140)
                        self.class=5;
                else self.class=1;
        else if(self.class==6||self.class==7||self.class==8)
                if(self.impulse==140)
                        self.class=1;
                else self.class=5;
/*
if((self.racename=="Predator"||self.racename=="Klingon")&&(self.class==7||self.class==8))
                if(self.impulse==140)
                        self.class=1;
                else self.class=6;
*/
if(self.class>8)
        self.class=1;
else if(self.class<1)
        self.class=8;

if(self.class==1)
        centerprint(self,"Warrior\n");
else if(self.class==2)
        centerprint(self,"Warlock\n");
else if(self.class==3)
        centerprint(self,"Mage\n");
else if(self.class==4)
        centerprint(self,"Paladin\n");
else if(self.class==5)
        centerprint(self,"Assassin\n");
else if(self.class==6)
        centerprint(self,"Mutant (take your chances!)\n");
else if(self.class==7)
        centerprint(self,"Jedi\n");
else if(self.class==8)
        centerprint(self,"Dark Jedi\n");
}
if((self.impulse==52&&self.class!=0) || !self.ishuman)
{
sound (self, CHAN_VOICE,"misc/secret.wav", 1, ATTN_NORM);
showclass();
self.classset=TRUE;
}


};

void() selectskin=
{
local string printnum;
local float ok;
if (!self.ishuman){	// leilei - selecting hack for bots
		if (!self.skinset){
			self.skin = random() & 20;
			self.skin = self.botskin - 1;
			self.impulse = 142;
			}
		else if (!self.skinset)
			self.impulse = 52;
		}
		if (self.impulse == 140 || self.impulse == 142 || !self.ishuman)
{
                self.skin = self.skin - (self.impulse - 141);
                while(ok==FALSE)
                {
                if(
                ((self.skin==19||self.skin==9)&&self.racename!="TigerMan")||
                (self.skin==2&&self.racename!="Draconian")||
                (self.skin==14&&self.racename!="Bossk")||
                (self.skin==10&&self.racename!="Predator")||
                (self.skin==5&&self.racename!="T-800")||
                (self.skin==4&&self.racename!="Elf")||
                (self.skin==11&&self.racename!="Klingon")||
                (self.skin==6&&self.classlabel!="Assassin"&&self.classlabel!="Warrior")||
                ((self.skin==13||self.skin==12||self.skin==11||self.skin==3)&&(self.classlabel=="Jedi"||self.classlabel=="Dark Jedi"))||
                (self.skin==17&&(self.classlabel=="Jedi"||self.classlabel=="Dark Jedi")&&self.classlabel!="Warrior"&&self.classlabel!="Assassin")||
                (self.skin==18&&self.racename!="Dark Elf")||
                (self.skin==22&&self.racename!="Borg")||
                (self.skin==16&&(self.racename!="Human"||self.classlabel!="Warrior"))||
                (self.skin==20&&(self.racename!="Human"||self.classlabel=="Jedi"||self.classlabel=="Dark Jedi"))
                )
                        {
                        ok=FALSE;
                        self.skin = self.skin - (self.impulse - 141);
                        }
                else if(self.racename=="TigerMan"&&self.skin!=9&&self.skin!=19)
                        {
                        ok=FALSE;
                        self.skin = self.skin - (self.impulse - 141);
                        if (self.skin < 0) self.skin = 19;
                                else if (self.skin > 23) self.skin = 9;
                        }
                else ok=TRUE;
                }
                if (self.skin < 0) self.skin = 23;
                else if (self.skin > 23) self.skin = 0;
                self.saber.skin=self.skin;
                showskin2();
}
if(self.impulse==52 || !self.ishuman)
{
sound (self, CHAN_VOICE,"misc/secret.wav", 1, ATTN_NORM);
self.skinset=TRUE;
showskin();
}


};

//Predator Cloak Malfunctions
void() PredCloakMalFunc =
{
                if(random()<0.3)
                {
                sprint(self,"Cloak Malfunctioning!\n");
                sound (self, CHAN_AUTO, "predator/cloak2.wav", 1, ATTN_NORM);
                sound (self, CHAN_AUTO, "enforcer/enfstop.wav", 1, ATTN_NORM);
                spawn_bounce (self.origin);
                self.invisible_finished = time;
/*
                        if(vis2ent(damage_attacker,self)&&self.playvisspecial==FALSE&&damage_attacker.classname=="player")
                        {
                        self.playvisspecial=TRUE;
                        sound (damage_attacker, CHAN_VOICE, "predator/ugly.wav", 1, ATTN_NORM);
                        }
*/
                }
};

void(string on_off)Spritz=
{
                if(on_off=="on")
                {
                self.frame = 0;
		self.modelindex = modelindex_eyes;
                self.cloakzap = self.cloakzap + 1;
                }
                else
                {
                self.modelindex = modelindex_player;    // don't use eyes
                spawn_bounce (self.origin);
                }
                sound (self, CHAN_AUTO, "enforcer/enfstop.wav", 1, ATTN_NORM);
                stuffcmd (self, "bf\n");
};

void() Player_Claw =
{
	local	vector	source;
	local	vector	org;
        local   float   ldmg;

        if(self.racename=="TigerMan")
                sound (self, CHAN_VOICE, "tiger/attack.wav", 1, ATTN_NORM);
        sound (self, CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);        

        source = self.origin + '0 0 4';
        makevectors (self.angles);
	traceline (source, source + v_forward*64, FALSE, self);
        if (!trace_ent.takedamage)
                traceline (source, source + v_forward*64 - v_up*64 + v_right*30, FALSE, self);
        if (!trace_ent.takedamage)
                traceline (source, source + v_forward*64 + v_up*64 - v_right*30, FALSE, self);
        if (!trace_ent.takedamage)
                traceline (source, source + v_forward*64 - v_up*64 - v_right*30, FALSE, self);
        if (!trace_ent.takedamage)
                traceline (source, source + v_forward*64 + v_up*64 + v_right*30, FALSE, self);

	if (trace_fraction == 1.0)
		return;
	
	org = trace_endpos - v_forward*4;
	if (trace_ent.takedamage)
	{
            sound (self, CHAN_WEAPON, "demon/dhit2.wav", 1, ATTN_NORM);
                ldmg = 40 + 10*random();
                if(self.racename=="TigerMan"&&self.health<self.max_health&&(trace_ent.classname=="head"||trace_ent.classname=="corpse")&&trace_ent.frommonname!="T-800")
                        {
                        if(trace_ent.classname=="head")
                                self.health=self.health + 1;
                        else if(trace_ent.classname=="corpse")
                                self.health=self.health + 5;
                        if(self.health>self.max_health)
                                self.health=self.max_health;
                        }
                T_Damage (trace_ent, self, self, ldmg); 
                if(trace_ent.racename=="T-800")
                        SpawnBlood (trace_ent.origin, '0 0 0', 20,trace_ent);
                else SpawnMeatSpray (self.origin + v_forward*16 , v_up*(random()*400 - 200) + v_forward*(random()*200 - 100) + v_right*(random()*400 - 200));
	}
        if(self.racename=="TigerMan"&&self.jumpin)
                        return;
        self.attack_finished = time + 1 - self.attackspeed;
};

void () Player_Melee =
{
  local   vector  source;
     if(self.claws)
        Player_Claw();
     else
	{
        self.Kick_em = 1;
        source = self.origin + '0 0 4';
        makevectors (self.angles);
	  traceline (source, source + v_forward*64, FALSE, self);
        if (!trace_ent.takedamage)
                traceline (source, source + v_forward*64 - v_up*64 + v_right*30, FALSE, self);
        if (!trace_ent.takedamage)
                traceline (source, source + v_forward*64 + v_up*64 - v_right*30, FALSE, self);
        if (!trace_ent.takedamage)
                traceline (source, source + v_forward*64 - v_up*64 - v_right*30, FALSE, self);
        if (!trace_ent.takedamage)
                traceline (source, source + v_forward*64 + v_up*64 + v_right*30, FALSE, self);

        if (trace_fraction == 1.0||(!trace_ent.alive&&trace_ent.classname!="corpse"&&trace_ent.classname!="head")||trace_ent==world)
		return;
	 // boot them in the rear!
	if(self.racename!="Borg"||(!trace_ent.alive&&!deathmatch)||trace_ent.classname=="player")
	{
		 if(trace_ent.classname == "player")	// only advertise player kicking
		 {
			  bprint(self.netname);
			  bprint(" gives ");
			  bprint(trace_ent.netname);
			  bprint(" the boot.\n");
		 }
		 if (trace_ent.classname == "head"||self.skin==16||self.oldskin==16)
		 {
	    		 if(trace_ent.classname=="head")
				 trace_ent.Kick_em = TRUE;
			 trace_ent.velocity_x = trace_ent.velocity_x + self.velocity_x*2;
			 trace_ent.velocity_y = trace_ent.velocity_y + self.velocity_y*2;
			 trace_ent.velocity_z = trace_ent.velocity_z + 300 + (random() * 200); //     add lift
		 }
		 else
		 {
			 trace_ent.velocity_x = trace_ent.velocity_x + self.velocity_x/2;
			 trace_ent.velocity_y = trace_ent.velocity_y + self.velocity_y/2;
			 trace_ent.velocity_z = trace_ent.velocity_z + 50 + (random() * 100); //     add lift
			 if(trace_ent.controller==self)
			         T_Damage (trace_ent, self, self, 1);
			 else T_Damage (trace_ent, self, self, 3);
		 }
		 sound (self, CHAN_WEAPON, "weapons/kick.wav", 1, ATTN_NORM);
		 if(trace_ent.flags & FL_ONGROUND)
			   trace_ent.flags = trace_ent.flags - FL_ONGROUND;
		 return;
	}
        else if(((deathmatch||teamplay)&&trace_ent.classname=="corpse"&&trace_ent.racename!="Borg"&&!trace_ent.decap)||(trace_ent.alive&&(trace_ent.classname=="enforcer"||trace_ent.classname=="grunt"||trace_ent.classname=="ogre"||trace_ent.classname=="zombie"||trace_ent.classname=="knight"||trace_ent.classname=="hell knight"||trace_ent.classname=="rottweiler"))&&/*self.charmed<10&&*/self.ammo_cells>=10)
        {
        sound(self,CHAN_VOICE,"borg/assimilt.wav",1,ATTN_NONE);
        self.ammo_cells=self.ammo_cells - 10;
        local entity newborg;
        local string printnum;
        newborg=spawn();
        setorigin(newborg,trace_ent.origin);
        newborg.colormap=self.colormap;
        newborg.angles=trace_ent.angles;
        if(newborg.angles_x!=0)
                newborg.angles_x=0;
        if(newborg.angles_z!=0)
                newborg.angles_z=0;
        if(trace_ent.classname=="rottweiler"||(trace_ent.frommonname=="rottweiler"&&trace_ent.classname=="corpse"))
                newborg.think=monster_borgdog;
        else
        {
        newborg.think=monster_borg;
        if(trace_ent.skin==1&&trace_ent.classname=="corpse"&&trace_ent.netname=="progs/h_player.mdl")
                newborg.skin=7;
        else if(trace_ent.skin==0&&trace_ent.classname=="corpse"&&trace_ent.netname=="progs/h_player.mdl")
                newborg.skin=8;
        else
                newborg.skin=rint(random()*5) + 3;
        }
        remove(trace_ent);
        newborg.charmed=TRUE;
        newborg.controller=self;
        newborg.oldenemy = self;
        newborg.enemy = world;
        newborg.follow = FALSE;
        self.charmed = self.charmed + 1;
        newborg.volume=self.charmed;
        newborg.nextthink=time;
        sprint(self,"Borg ");
        printnum=ftos(newborg.volume);
        sprint(self,printnum);
        sprint(self," of ");
        printnum=ftos(self.charmed);
        sprint(self,printnum);
        sprint(self," is functional.\n");
        return;
        }
else if(trace_ent.racename=="Borg")
        {
        sound(trace_ent,CHAN_VOICE,"misc/r_tele1.wav",1,ATTN_NORM);
        trace_ent.effects=EF_BRIGHTFIELD;
        trace_ent.think=SUB_Remove;
        trace_ent.nextthink=time + 0.5;
	  if(self.ammo_cells<241)
	        self.ammo_cells=self.ammo_cells + 10;
	  else
		  self.ammo_cells=250;
//        self.charmed=self.charmed - 1;
        return;
        }
}
if(trace_ent.takedamage&&self.racename=="TigerMan"&&self.jumpin)
        Player_Claw();
};

void() MagicalHitplus =
{
        if(deathmatch)
        {
        if(self.classlabel=="Mage")
                self.hitplus=1.5;
        else if(self.classlabel!="Mutant")
                self.hitplus = 1;
        }
        else
        {
        if(self.classlabel=="Mage")
                self.hitplus=1.25 + self.exp/500000;
        else if (self.classlabel=="Warrior"||self.classlabel=="Paladin")
                {
                self.hitplus=0.5 + self.exp/250000;
                if (self.hitplus > 1)
                        self.hitplus=1;
                }
        else self.hitplus = 1;
        }
};

void() ReviewStats =
{
local string printnum;
        sprint(self,"\n\n\n\n");
        sprint(self,"Name:  ");
        sprint(self,self.netname);
        sprint(self,"\n");
        sprint(self,"Race:  ");
        sprint(self,self.racename);
        sprint(self,"\n");
        sprint(self,"Level:  ");
        printnum=ftos(self.level);
        sprint(self,printnum);
        sprint(self,"\n");
        sprint(self,"Class:  ");
        sprint(self,self.classlabel);
        sprint(self,"\n");
        sprint(self,"Skin: ");
        showskin2();
        sprint(self,"Maximum Health: ");
        printnum=ftos(self.max_health);
        sprint(self,printnum);
        sprint(self,"\nExperience: ");
        printnum=ftos(self.exp);
        sprint(self,printnum);
        sprint(self,"\nMana: ");
        printnum=ftos(time-self.init_mana);
        sprint(self,printnum);
        sprint(self,"\nIntellect: ");
        printnum=ftos(self.intel);
        sprint(self,printnum);
        sprint(self,"\nSpeed: ");
        printnum=ftos(125 - self.speed*100);
        sprint(self,printnum);
        sprint(self,"\nJump Height: ");
        printnum=ftos(self.jumphite*14/self.mass);
        sprint(self,printnum);
        sprint(self,"\nToughness: ");
        printnum=ftos(200-self.damagetake*100);
        sprint(self,printnum);
        sprint(self,"\nAttack Speed: ");
        printnum=ftos((0.8 + self.attackspeed)*100);
        sprint(self,printnum);
        sprint(self,"\nNormal Attack Multiplier: ");
        NormalHitplus();
        printnum=ftos(self.hitplus);
        sprint(self,printnum);
        sprint(self,"\nMagical Attack Multiplier: ");
        MagicalHitplus();
        printnum=ftos(self.hitplus);
        sprint(self,printnum);
        sprint(self,"\nMass: ");
        printnum=ftos(self.mass*100);
        sprint(self,printnum);
        sprint(self,"\nAim: ");
        printnum=ftos(100-self.accuracy*250);
        sprint(self,printnum);
        sprint(self,"\n");
        sprint(self,"Hit Record: \n");
        sprint(self,"Attempted: ");
        printnum=ftos(self.attempthit);
        sprint(self,printnum);
        sprint(self,"\n");
        sprint(self,"Successful: ");
        printnum=ftos(self.actualhit);
        sprint(self,printnum);
        sprint(self,"\n");
        sprint(self,"Accuracy: ");
	  if(self.attempthit>0)
	        printnum=ftos(self.actualhit/self.attempthit*100);
        else printnum = ftos(0);
        sprint(self,printnum);
        sprint(self,"%\n");
        sprint(self,"Special Abilities:\n");
        sprint(self,self.netname);
        sprint(self,"...\n");
        if(self.classlabel=="Assassin")
                sprint(self,"...is stealthy and quiet!\n");
        if(self.racename=="Elf"||self.classlabel=="Assassin")
                sprint(self,"...has perfect accuracy!\n");
        if(self.racename=="Dark Elf")
                sprint(self,"...is resistant to any transmutation!\n");
        if(self.waterbreathe==TRUE||self.racename=="Bossk")
                sprint(self,"...can breathe under water for 5 minutes!\n");
        if(self.fireresist==1||self.racename=="Draconian")
                sprint(self,"...is totally resistant to fire!\n");
         if(self.slimeresist==TRUE)
                sprint(self,"...is immune to slime!\n");
         if(self.magicresist==TRUE)
                sprint(self,"...is resistant to magic!\n");
         if(self.healthregen==TRUE)
                sprint(self,"...constantly regenerates health!\n");
         if(self.claws==TRUE)
                sprint(self,"...has claws!\n");
         if(self.claws||self.wallclimb)
                sprint(self,"...can climb walls!\n");
         if(self.featherfall==TRUE||self.racename=="TigerMan")
                sprint(self,"...can fall without damage!\n");
         if(self.berzerker==TRUE)
                sprint(self,"...is a berzerker!\n");
         if(self.energyabsorb==TRUE)
                sprint(self,"...can absorb energy attacks!\n");
         if(self.anyinvis==TRUE||self.racename=="Predator")
                sprint(self,"...can turn invisible at will!\n");
         if(self.heatsee==TRUE)
                sprint(self,"...has heat vision!\n");
         if(self.boltsee==TRUE)
                if(self.skin==16||self.skin==12)
                        sprint(self,"...can shoot forcebolts from her eyes!\n");
                else
                        sprint(self,"...can shoot forcebolts from his eyes!\n");
sprint(self,"Weakness:\n");
        if(self.nospells==TRUE||self.racename=="T-800")
                sprint(self,"...cannot cast spells!\n");
         if(self.speed>=1.5)
                sprint(self,"...is not a fast guy.\n");
         if(self.weakheart==TRUE)
                sprint(self,"...has a weak heart!\n");
         if(self.weak==TRUE)
                sprint(self,"...can't carry a lot of weight!\n");
        if(self.fireresist== -1)
                sprint(self,"...is extremely vulnerable to fire!\n");
};

#ifdef JAWORSKI
void(entity speaker) JaworskiHurt =
{
local float rs;
        if(self.watertype==CONTENT_LAVA)
                {
                if(self.zap_finished<time)
                        {
                        sound (speaker, CHAN_VOICE,"jaworski/keitel.wav", 1, ATTN_NORM);
                        self.zap_finished=time+2;
                        }
                }
        else if(self.ow_finished<=time)
        {
        rs = rint((random() * 10) + 1);
        speaker.noise = "";
        if (rs > 8)
                speaker.noise = "jaworski/ow1.wav";
        else if (rs > 5)
                speaker.noise = "jaworski/ow2.wav";
        else if (rs > 2)
                speaker.noise = "jaworski/ow4.wav";
        else
                speaker.noise = "jaworski/ow3.wav";
        sound (speaker, CHAN_VOICE, speaker.noise, 1, ATTN_NORM);
        self.zap_finished=time + 0.5;
        self.ow_finished=time + 0.5;
        }
};
#endif

void(vector dir) Trace =
{
        local   vector  vel, org;
        local string printmsg;

        vel = normalize(dir);
	vel = vel + 2*trace_plane_normal;
	vel = vel * 200;

	org = trace_endpos - dir*4;

        particle (org,'0 0 0', 73, 1);

        if (trace_ent.takedamage||(self.zap_finished>time&&self.lockentity.alive))
	{
                if(trace_ent.takedamage)
                        {
                        self.lockentity=trace_ent;
                        self.zap_finished=time+3;
                        }
                if(self.message_time<time)
                        {
                        sound (self, CHAN_BODY, "weapons/lock.wav", 1, ATTN_NORM);
                        sprint(self,"Positive Lock on: ");
                        if(self.lockentity.classname=="player")
                                sprint(self,self.lockentity.netname);
                        else sprint(self,self.lockentity.classname);
                        sprint(self,"!\n");
                        if(self.lockentity.classname=="player")
                        {
                        sprint(self.lockentity,"Warning!  ");
                        sprint(self.lockentity,self.owner.netname);
                        sprint(self.lockentity," has you targeted!\n");
                        sound (self.lockentity, CHAN_AUTO, "misc/talk.wav", 1, ATTN_NORM);
                        }
                        self.message_time=time + 1;
                        }
	}
        else if(self.zap_finished<time||self.lockentity.alive!=TRUE)
                self.lockentity=world;
};

void() LaserSight =
{
        local   vector  src,vec,dir;
	
        dir = aim (self, 100000);
	makevectors(self.v_angle);

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
        traceline (src, src + dir*2048, FALSE, self);
        if (trace_fraction != 1.0)
                Trace (dir);
};

void (entity printo) ExperienceCheck =
{
local string printnum;
local float expperlevel,oldlevel;
        if(printo.classlabel=="Dark Jedi")
                expperlevel=30000;
        else if(printo.classlabel=="Jedi")
                expperlevel=50000;
        else
                expperlevel=100000;
        oldlevel=printo.level;
        printo.level=floor(printo.exp/expperlevel);
        if(printo.level>oldlevel)
                        {
                        sound (printo, CHAN_VOICE, "misc/secret.wav", 1, ATTN_NORM);
                        centerprint(printo,"You have gained a level.\n");
                        if(printo.classlabel=="Jedi"||printo.classlabel=="Dark Jedi")
                                {
                                if(printo.exp>=250000&&printo.exp<280000)
                                        {
                                        sprint(printo,"You have learned to levitate!\n");
                                        self.jumphite = 1;
                                        }
                                if((!printo.saberset)&&printo.exp>=500000)
                                        showsaber(printo);
                                if(printo.exp>=750000&&printo.exp<780000)
                                        sprint(printo,"You have learned to throw your saber!\n");
                                }
                        if(printo.classlabel=="Dark Jedi")
                                printo.max_health=printo.max_health - 3*(printo.level-oldlevel);
                        }
        sprint(printo,"Experience points: ");
        printnum=ftos(printo.exp);
        sprint(printo,printnum);
        sprint(printo,"\n");
};

void(vector dir, vector offset) EyeShoot =
{
        sound(self,CHAN_AUTO,"enforcer/enfire.wav",1,ATTN_NORM);
	newmis = spawn();
        newmis.owner = self;
        newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	newmis.effects = EF_DIMLIGHT;
        newmis.classname = "laser";
        if(self.heatsee)
                {
                newmis.netname="heat";
                newmis.touch=FlameTouch;
                }
        else
                {
                newmis.netname="force";
                newmis.touch=Laser_Touch;
                }
        makevectors (self.v_angle);

	setmodel (newmis, "progs/laser.mdl");
        setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
        setorigin (newmis, self.origin + v_forward*8 + '0 0 24'+ offset);

        newmis.speed = 1250;
        newmis.velocity = dir * newmis.speed;

        newmis.angles = vectoangles(newmis.velocity);

	newmis.nextthink = time + 5;
	newmis.think = SUB_Remove;
};

void(entity actor) BorgSpeak =
{
local float r;
                                r=rint(random()*2) + 1;
                                if(r==1)
                                        sound(actor,CHAN_VOICE,"borg/resist.wav",1,ATTN_NONE);
                                else if(r==2)
                                        sound(actor,CHAN_VOICE,"borg/assimilt.wav",1,ATTN_NONE);
                                else
                                        sound(actor,CHAN_VOICE,"borg/werborg.wav",1,ATTN_NONE);
};

void(entity actor) CheckBorgCommands =
{
        if(actor.frommonname=="Advance"&&vlen(actor.origin-actor.controller.lightning.origin)<48)
                actor.frommonname="Guard";
        if(!actor.controller.alive)
                actor.frommonname="Patrol";
        if(actor.frommonname=="Guard")
                {
                actor.oldenemy=actor.controller;
                actor.enemy=world;
                actor.follow=FALSE;
                actor.movetarget=actor;
                actor.goalentity=actor;
                actor.think=actor.th_stand;
                actor.nextthink=time;
                }
        else if(actor.frommonname=="Patrol")
                {
                actor.oldenemy=actor.controller;
                actor.enemy=actor.controller;
                actor.follow=TRUE;
                actor.movetarget=actor.controller;
                actor.goalentity=actor.controller;
                actor.think=actor.th_walk;
                actor.nextthink=time;
                }
        else if(actor.frommonname=="Escort")
                {
                actor.oldenemy=actor.controller;
                actor.enemy=actor.controller;
                actor.follow=TRUE;
                actor.movetarget=actor.controller;
                actor.goalentity=actor.controller;
                actor.think=actor.th_run;
                actor.nextthink=time;
                }
        else if(actor.frommonname=="Advance")
                {
                actor.enemy=actor.oldenemy=actor.movetarget=actor.goalentity=actor.controller.lightning;
                actor.follow=FALSE;
                actor.think=actor.th_run;
                actor.nextthink=time;
                }
};

void(entity actor) SetBorgAction =
{
        if(self.impulse==30)
                        actor.frommonname="Guard";
        else if(self.impulse==31)
                        actor.frommonname="Patrol";
        else if(self.impulse==32)
                        actor.frommonname="Escort";
        else if(self.impulse==33)
                if(actor.controller.sight.running)          
                        {
                        actor.frommonname="Advance";
                        remove(actor.controller.lightning);
                        actor.controller.lightning=spawn();
                        setorigin(actor.controller.lightning,actor.controller.sight.origin);
                        }
                else
                        {
                        sprint(actor.controller,"Activate your Targeting Sight first\n");
                        return;
                        }
        sound (actor, CHAN_WEAPON, "doors/baseuse.wav", 1 , ATTN_NORM);
        CheckBorgCommands(actor);
};

void() BorgCommands =
{
local entity head;
        if(self.impulse==30)
                sprint(self,"Command: Guard\n");
        else if(self.impulse==31)
                sprint(self,"Command: Patrol\n");
        else if(self.impulse==32)
                sprint(self,"Command: Escort\n");
        else if(self.impulse==33)
                sprint(self,"Command: Advance\n");
        if(self.charmed<2)
                {
                sprint(self,"You are the only Borg in your Unit\n");
                return;
                }
   if(self.aflag==666)
   {
   SetBorgAction(self.borgsee);
   }
   else
   {
   head=findradius(self.origin,10000);
   while(head)
        {
        if(head.racename=="Borg"&&head!=self&&head.controller==self)
                SetBorgAction(head);
        head=head.chain;
        }
    }
};
/*
void() TempSetAll =
{
if(temp1&"Human")
        self.race=1;
else if(temp1&"TigerMan")
        self.race=2;
else if(temp1&"DarkElf")
        self.race=4;
else if(temp1&"Elf")
        self.race=3;
else if(temp1&"Bossk")
        self.race=5;
else if(temp1&"Draconian")
        self.race=6;
else if(temp1&"Predator")
        self.race=7;
else if(temp1&"T-800")
        self.race=8;
else if(temp1&"Klingon")
        self.race=9;
else if(temp1&"Borg")
        self.race=10;

if(temp1&"Warrior")
        self.class=1;
else if(temp1&"Warlock")
        self.class=2;
else if(temp1&"Mage")
        self.class=3;
else if(temp1&"Paladin")
        self.class=4;
else if(temp1&"Assassin")
        self.class=5;
else if(temp1&"Mutant")
        self.class=6;
else if(temp1&"DarkJedi")
        self.class=8;
else if(temp1&"Jedi")
        self.class=7;

if(temp1&"ChangKhan")
        self.skin=1;
else if(temp1&"MikeJaworski")
        self.skin=2;
else if(temp1&"")
        self.skin=3;
else if(temp1&"Elf")
        self.skin=4;
else if(temp1&"Bossk")
        self.skin=5;
else if(temp1&"Draconian")
        self.skin=6;
else if(temp1&"Predator")
        self.skin=7;
else if(temp1&"T-800")
        self.skin=8;
else if(temp1&"Klingon")
        self.skin=9;
else if(temp1&"Borg")
        self.skin=10;
if(temp1&"Human")
        self.skin=11;
else if(temp1&"TigerMan")
        self.skin=12;
else if(temp1&"DarkElf")
        self.skin=13;
else if(temp1&"Elf")
        self.skin=14;
else if(temp1&"Bossk")
        self.skin=15;
else if(temp1&"Draconian")
        self.skin=16;
else if(temp1&"Predator")
        self.skin=17;
else if(temp1&"T-800")
        self.skin=18;
else if(temp1&"Klingon")
        self.skin=19;
else if(temp1&"Borg")
        self.skin=20;
if(temp1&"Human")
        self.skin=21;
else if(temp1&"TigerMan")
        self.skin=22;
else if(temp1&"DarkElf")
        self.skin=23;
else if(temp1&"Elf")
        self.skin=24;
else if(temp1&"Bossk")
        self.skin=25;
};
*/

float (float overhead) SolidAbove =
{
local vector endpos;
local float mover;
        mover = overhead;
        makevectors(self.angles);
        while (mover)
        {
        mover = mover - 5;
        endpos = self.origin + v_up *(overhead - mover);
        if (pointcontents(endpos) == CONTENT_SOLID)
                return TRUE;
        }
        return FALSE;
};

float() LongFall =
{
        traceline (self.origin, self.origin-'0 0 500', TRUE, self);   // see through other monsters
	if (trace_inopen && trace_inwater)
		return FALSE;			// sight line crossed contents
        else if(trace_fraction==1.0&&(pointcontents(trace_endpos)>-3||pointcontents(trace_endpos)<-5))
                return TRUE;
        else return FALSE;
};

void() ToggleCloak=
{
     if(self.invisible_time!=0)
     {
               sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
               sprint(self,"Deactivating Cloak\n");
               self.invisible_finished=time;
               if(self.attack_finished<time + 0.5)
                       self.attack_finished=time + 0.5;
               return;
     }
     else
     {
                sprint(self,"Activating Cloak\n");
                self.items = self.items | IT_INVISIBILITY;
                self.invisible_time = 1;
                self.invisible_finished = time + 100000;
                self.alivetime=time;
                sound (self, CHAN_AUTO, "predator/cloak.wav", 1, ATTN_NORM);
     }
};

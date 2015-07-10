void() BettyWait =
{
        if(self.air_finished <= time)
        {
                if(self.small)                
                        sound(self,CHAN_AUTO,"weapons/lock.wav",0.25,ATTN_NORM);
                else sound(self,CHAN_AUTO,"weapons/lock.wav",1,ATTN_NORM);
		    self.hover=TRUE;
                GrenadeExplode();
        }
        else
        {
	  self.solid=SOLID_NOT;
        particle (self.origin, '0 0 -100', 242, random()*5);
        self.think= BettyWait;
        self.nextthink=time;
        }
};

void() BettyPop =
{
        if(self.small)
                sound(self,CHAN_AUTO,"weapons/hoverpop.wav",0.25,ATTN_NORM);
        else sound(self,CHAN_AUTO,"weapons/hoverpop.wav",1,ATTN_NORM);
        self.effects=EF_BRIGHTLIGHT;
	  self.movetype=MOVETYPE_FLYMISSILE;
	  setsize(self,'0 0 0','0 0 0');
        self.velocity_z = 100;
	  if(self.flags&FL_ONGROUND)
	        self.flags = self.flags - FL_ONGROUND;
	  self.angles = '-90 0 0';
        self.avelocity_y = random() * 300 + 300;
        self.air_finished = time + 0.5;
        self.think= BettyWait;
        self.nextthink=time;
};

void() BettyLay =
{
        if(self.velocity == '0 0 0')
//                if(self.pain_finished>time)
              {
                self.movetype=MOVETYPE_FLYMISSILE; 
            	self.angles = '90 0 0';
            	self.avelocity = '0 0 0';
			if(self.ow_finished<=time)
				self.owner=self;
			if(self.owner!=self)
				self.controller=self.owner;
	      }
/* Time limit- took off
		else
		{
                  sound(self,CHAN_AUTO,"weapons/lock.wav",1,ATTN_NORM);
			GrenadeExplode();
			remove(self);
		}
*/
	else if(self.ow_finished<=time&&!self.bloodloss)
	{
		if(self.owner.classname=="player")
		{
			sprint(self.owner,"Betty failed to set\n");
			self.owner.ammo_rockets=self.owner.ammo_rockets + 1;
		}
		else if(self.controller.classname=="player")
		{
			sprint(self.controller,"Betty failed to set\n");
			self.controller.ammo_rockets=self.controller.ammo_rockets + 1;
		}
		remove(self);
	}

	traceline(self.origin,self.origin+'0 0 24',FALSE,self);
	if(trace_fraction!=0&&trace_ent!=self.owner&&trace_ent.solid&&trace_ent!=world&&trace_ent!=self)
	{
	        if(!self.bloodloss)
		  {
                if(self.small)
                        sound(self,CHAN_WEAPON,"weapons/setlaser.wav",0.25,ATTN_NORM);
                else sound(self,CHAN_WEAPON,"weapons/setlaser.wav",1,ATTN_NORM);
		    self.skin=1;
			bprint("Betty Armed by ");
		    if(trace_ent.classname=="player")
			    bprint(trace_ent.netname);
		    else bprint(trace_ent.classname);
		    bprint("\n");
		  }
		if(!(trace_ent.flags&FL_ONGROUND))
			trace_ent.flags=trace_ent.flags + FL_ONGROUND;
      	self.bloodloss = TRUE;
		self.alivetime=time + 0.1;
	}
	
	if(self.bloodloss&&self.alivetime<=time)
		self.think=BettyPop;
	else self.think=BettyLay;
	self.nextthink=time;
};

void() BettyArmed =
{
        if(other.solid!=SOLID_BBOX&&other.solid!=SOLID_SLIDEBOX)
        {
                if(other==world&&self.velocity!='0 0 0')
                        if(self.small)
                                sound(self,CHAN_WEAPON,"weapons/bounce.wav",0.5,ATTN_NORM);
                        else sound(self,CHAN_WEAPON,"weapons/bounce.wav",1,ATTN_NORM);
                return;
        }
        if(!self.bloodloss)
	{
                if(self.small)
                        sound(self,CHAN_WEAPON,"weapons/setlaser.wav",0.25,ATTN_NORM);
                else sound(self,CHAN_WEAPON,"weapons/setlaser.wav",1,ATTN_NORM);
			self.skin=1;
		      bprint("Betty Armed by ");
		      if(other.classname=="player")
			    bprint(other.netname);
		      else bprint(other.classname);
			bprint("\n");
	}
	if(!(other.flags&FL_ONGROUND))
		other.flags=other.flags + FL_ONGROUND;
      self.bloodloss = TRUE;
	self.alivetime=time + 0.1;
};

void() BettySet =
{
	  self.attack_finished=time + 0.2;
        self.ammo_rockets=self.ammo_rockets - 1;
        newmis = spawn();
        newmis.owner=self;

        newmis.movetype=MOVETYPE_BOUNCE;
        newmis.solid=SOLID_BBOX;
        newmis.health=25;
        newmis.takedamage=DAMAGE_AIM;

        newmis.th_die=GrenadeExplode;
        newmis.classname="betty";
        makevectors(self.v_angle);
        newmis.touch=BettyArmed;
        newmis.think=BettyLay;
        newmis.nextthink=time;
        newmis.velocity= '0 0 20';
        newmis.small=self.small;
        newmis.angles = '90 0 0';
	  newmis.hover=FALSE;
        newmis.bloodloss=FALSE;
	  newmis.ow_finished=time + 3;
//          newmis.pain_finished = time + 180;
	  newmis.skin=0;

        if(self.small)
        {
                setmodel (newmis, "progs/s_trip.mdl");
                setsize (newmis, '-1 -1 -1','1 1 1');
                setorigin(newmis,self.origin+'0 0 4');
        }
        else
        {
                setmodel (newmis, "progs/tripmine.mdl");
                setorigin(newmis,self.origin+'0 0 16');
                setsize (newmis, '-4 -4 -2','4 4 3');
        }
};

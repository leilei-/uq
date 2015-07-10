void() SentinelScan =
{
local entity head;
        head = findradius(self.origin,2000);
        while(head)
        {
                if(head.takedamage&&
			visible(head)&&
			head!=self &&
                        head!=self.controller&&
			head.controller!=self.controller&&
			head.health>0 &&
			head.owner!=self.controller &&
			head!=self.enemy &&
			head!=self.oldenemy)
                  {
	                  self.oldenemy=self.enemy;
                        self.enemy=head;
                        return;
                  }
                head = head.chain;
        }
	  self.enemy=world;
};

void() SentinelThink =
{
if(self.flags&FL_ONGROUND)
	self.flags=self.flags - FL_ONGROUND;
if(self.velocity!='0 0 0'&&self.enemy!=world)
	{
local vector vel;
        newmis.effects=EF_DIMLIGHT;
        if(self.velocity_x>0)
        {
		  vel = '0 0 0';
		    vel_x = 0 - self.velocity_x;
                particle (self.origin,vel*10, 242, random()*self.velocity_x + 1);
                self.velocity_x=self.velocity_x - 1;
        }
        if(self.velocity_x< 0)
        {
		  vel = '0 0 0';
		    vel_x = 0 - self.velocity_x;
                particle (self.origin,vel*10, 242, random()* vel_x + 1);
                self.velocity_x=self.velocity_x + 1;
        }
        if(self.velocity_y>0)
        {
		  vel = '0 0 0';
		    vel_y = 0 - self.velocity_y;
                particle (self.origin,vel*10, 242, random() * self.velocity_y + 1);
                self.velocity_y=self.velocity_y - 1;
        }
        if(self.velocity_y<0)
        {
		  vel = '0 0 0';
		    vel_y = 0 - self.velocity_y;
                particle (self.origin,vel*10, 242, random()* vel_y + 1);
                self.velocity_y=self.velocity_y + 1;
        }
        if(self.velocity_z>0)
        {
		  vel = '0 0 0';
		    vel_z = 0 - self.velocity_z;
                particle (self.origin,vel*10, 242, random() * self.velocity_z + 1);
                self.velocity_z=self.velocity_z - 1;
        }
        if(self.velocity_z<0)
        {
		  vel = '0 0 0';
		    vel_z = 0 - self.velocity_z;
                particle (self.origin,vel*10, 242, random()* vel_z + 1);
                self.velocity_z=self.velocity_z + 1;
        }
	  if(self.ow_finished<=time)
        {
     			sound(self,CHAN_ITEM,"weapons/jethover.wav",1,ATTN_NORM);
			self.ow_finished=time + 1;
	  }	
	}        
      else newmis.effects=0;

      if(random()<0.5)
	SentinelScan();

      if(self.enemy==world)
		if(self.oldenemy.health>0)
	            self.enemy=self.oldenemy;
      
	if(self.enemy.health<=0)
		self.enemy=world;
        

     if(self.enemy!=world&&visible(self.enemy)&&(self.enemy.running||self.enemy.velocity!='0 0 0'))
        {
//                ai_face();
                self.avelocity='0 0 0';
                if(self.attack_finished<=time/*&&FacingIdeal()*/)
      	          {
				local vector offset;
			     bprint("Sentinel Attacking ");
			    if(self.enemy.classname=="player")
				    bprint(self.enemy.netname);
			    else bprint(self.enemy.classname);
			     bprint("\n");
                        self.attack_finished=time + 0.2;
                        self.effects = self.effects | EF_MUZZLEFLASH;
                        makevectors(self.angles);
                        LaserSound();
				self.ammo_cells=self.ammo_cells - 1;
				if(self.origin_z >= self.enemy.origin_z)
					offset='0 0 -7';
				else offset='0 0 7';
                        PLaser(normalize((self.enemy.origin + offset) - self.origin),self); 
            	    }
        }
        else
	  {
	 	if(self.air_finished<=time)
	        {
                sound(self,CHAN_AUTO,"buttons/airbut1.wav",1,ATTN_NORM);
                self.air_finished=time + random()*5 + 0.5;
                self.avelocity_z = random()*360 - 180;
      	  }
              if(visible(self.controller)&&vlen(self.origin-self.controller.origin)>30)
		{
			makevectors(self.controller.v_angle);
			self.velocity=(self.velocity*2 + normalize((self.controller.origin - v_forward*24 + v_up*24) - self.origin)*50) * 0.33;
	    	     if(self.ow_finished<=time)
		      {
     				sound(self,CHAN_ITEM,"weapons/jethover.wav",1,ATTN_NORM);
				self.ow_finished=time + 1;
	                  particle (self.origin,'0 0 0' - self.velocity, 242, 5);
			}
                }
	  }
	  if(self.ammo_cells<=0)
		if(vlen(self.origin-self.controller.origin)>100)
			self.think = GrenadeExplode;
		else
		{
			spawn_tfog(self.origin);
			self.think=SUB_Remove;
		}
	  else self.think=SentinelThink;
        self.nextthink=time + 0.2;
};

void() SentinelTouch =
{
	if(other==world)
		return;
	if(!(other.flags&FL_ONGROUND))
		other.flags=other.flags + FL_ONGROUND;
};

void() SetSentinel =
{
        self.ammo_cells=self.ammo_cells - 10;
        newmis = spawn();
        newmis.owner=newmis;
	  newmis.controller=self;

        newmis.movetype=MOVETYPE_FLYMISSILE;
        newmis.solid=SOLID_BBOX;
        newmis.health=100;
        newmis.takedamage=DAMAGE_AIM;
        newmis.th_die=GrenadeExplode;
        newmis.classname="sentinel";
        makevectors(self.v_angle);
        newmis.think=SentinelThink;
        newmis.nextthink=time;
	  newmis.touch=SentinelTouch;
        newmis.velocity= v_forward*30;
        newmis.angles = self.v_angle;
	  newmis.ammo_cells=100;

        newmis.enemy=world;
        newmis.oldenemy=world;
        newmis.avelocity = '100 100 100';

        setmodel (newmis, "progs/hover.mdl");
        setsize (newmis, '-4 -4 -4','4 4 4');
        setorigin(newmis,self.origin+v_forward*48+'0 0 16');
};



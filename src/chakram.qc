/*=============================
chakram CODE
===============================*/
void() ThrowchakramBounce;
void() ThrowchakramThink;
void() CycleWeaponCommand;
void(float damage) spawn_touchblood;

void() chakramFind=
{
        if(visible2ent(self,self.controller))
                {
                centerprint(self.controller,"There's your chakram!\n");
                sound (self.controller, CHAN_AUTO, "misc/talk.wav", 1, ATTN_NORM);
                }
        self.think=chakramFind;
        self.nextthink=time + 1;
};

void() chakramDrop =
{
        self.velocity_z=self.velocity_z + 100;
        self.health = 100000;
        self.bloodloss=0;
        self.follow=0;
        self.inpain=TRUE;
        self.running=FALSE;
        self.avelocity_x = random()*600 - 300;
        self.avelocity_y = random()*600 - 300;
        self.avelocity_z = random()*600 - 300;
        self.movetype=MOVETYPE_BOUNCE;
        self.think=chakramFind;
        self.nextthink=time;
};

void(entity receptor) chakramPickUp =
{
        if(self.small)
                return;
        self.follow=0;
        self.running=FALSE;
        self.inpain=FALSE;
        self.health=100;
        if(receptor==self.controller&&receptor.weapon<65)
                receptor.weapon=IT_CHAKRAM;
        sound(receptor, CHAN_ITEM, "weapons/pkup.wav", 1, ATTN_NORM);
        receptor.impulse=61;
        self.bloodloss=0;
        remove(self);
};

void() chakramHurt =
{
//  Note: in future, make the velocity change according to angle of hit
      self.wallspot=self.controller.origin + '0 0 10';
	self.velocity_x = self.velocity_x + random()*500; 
	self.velocity_y = self.velocity_y + random()*500; 
	self.velocity_z = self.velocity_z + random()*500; 
	self.avelocity_x = self.avelocity_x + random()*500; 
	self.avelocity_y = self.avelocity_y + random()*500; 
	self.avelocity_z = self.avelocity_z + random()*500; 
        if(random()<0.3)
                sound (self, CHAN_WEAPON, "weapons/ric1.wav", 1, ATTN_NORM);
        else if(random()<0.3) sound (self, CHAN_WEAPON, "weapons/ric2.wav", 1, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "weapons/ric3.wav", 1, ATTN_NORM);
        particle (self.origin,'0 0 16'*0.1, 242, 10);
        self.effects=EF_MUZZLEFLASH;
};

void() chakramHit =
{
        if(self.controller!=world&&other==self.controller&&self.levitime<=time)
	  chakramPickUp(other);

        if(other==self.owner||(self.controller!=world&&other==self.controller))
                return;

    if(self.inpain==TRUE)
    {
        if(random()<0.2)
                sound (self, CHAN_WEAPON, "weapons/ric1.wav", 1, ATTN_NORM);
        else if(random()<0.3) 
	      sound(self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
        else if(random()<0.3) 
	      sound(self, CHAN_WEAPON, "weapons/tink1.wav", 1, ATTN_NORM);
        else if(random()<0.2) 
			sound (self, CHAN_WEAPON, "weapons/ric2.wav", 1, ATTN_NORM);
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
                other.punchangle_x = -10;
                other.punchangle_y = -10;
                if(other.health) 
                      {
                      other.velocity_x = other.velocity_x + self.velocity_x/3;
                      other.velocity_y = other.velocity_y + self.velocity_y/3;
                      other.velocity_z = other.velocity_z + 100;
                      other.flags = other.flags - FL_ONGROUND;
                      }
                self.zap_finished=time + 0.4;
                spawn_touchblood(40);
                SpawnBlood (other.origin, '0 0 0', 10,other);
                if(other.classname=="zombie")
                        damage=rint(random()*40) + 20;
                else damage=rint(random()*10) + 10;
                T_Damage(other,self,self.controller,damage);
                self.attack_finished=time + 0.2;
                self.bloodloss=0;
        }
        else 
	  {
		if(visible(self.controller))
			self.wallspot=self.origin;
		self.bloodloss=self.bloodloss + 1;
		self.oldenemy=world;
	  }

        if(random()<0.3)
                sound (self, CHAN_WEAPON, "weapons/ric1.wav", 1, ATTN_NORM);
        else if(random()<0.3) sound (self, CHAN_WEAPON, "weapons/ric2.wav", 1, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "weapons/ric3.wav", 1, ATTN_NORM);
        particle (self.origin,'0 0 16'*0.1, 242, 10);
        self.effects=EF_MUZZLEFLASH;
        ThrowchakramBounce();
    }
};

/*=============================
THROWING chakram CODE
===============================*/
void() ThrowchakramBounce =
{
local entity head;
local vector vtemp,dir;
local float ovel_x, ovel_y, ovel_z, nvel_x,nvel_y,nvel_z,newvelnotset,samevel;
   self.enemy=world;

   if (self.bloodloss>=self.mass)
        {                
        if(!visible(self.controller)||!self.controller.alive||self.bloodloss>=2*self.mass)
           {
                traceline(self.origin,self.wallspot,TRUE,self);
                if(trace_fraction == 1&&self.bloodloss<3*self.mass&&self.controller.alive)
                        vtemp = self.wallspot;
	          else
		    {
				self.think=chakramDrop;
				self.nextthink=time;
		    }
           }
	  else 
	      vtemp = self.controller.origin + '0 0 10';
        self.angles=self.controller.v_angle + '-90 0 0';
        self.velocity= '0 0 0';
        self.velocity = normalize(vtemp - self.origin);
        self.velocity = self.velocity * 500;
        self.o_angle = self.velocity;
        }
   else
	{
        head = findradius(self.origin, 1000);
        while(head)
        {
          if(head.takedamage&&head!=self&&head!=self.controller&&head!=self.oldenemy&&head.health>0&&visible(head)&&head.alive&&head.inpain!=2)
                {
                vtemp = head.origin + '0 0 10';
	          self.velocity= '0 0 0';
                self.velocity = normalize(vtemp - self.origin);
                self.velocity = self.velocity * 500;
		    self.o_angle = self.velocity;
                self.enemy=head;
		    self.oldenemy=head;
                return;
                }
                head = head.chain;
        }
        self.enemy=world;
            self.bloodloss=self.bloodloss + 1;
		ovel_x = self.velocity_x;		
		ovel_y = self.velocity_y;		
		ovel_z = self.velocity_z;		
		newvelnotset=TRUE;
		while(newvelnotset)
		{
			samevel = 0;
			if(random()>0.5)
				nvel_x = random()*250 + 500;
			else		
				nvel_x = 0 - random()*250 - 500;
                        if((ovel_x < 0 && nvel_x < 0)||(ovel_x >= 0 && nvel_x >= 0))
				samevel=samevel + 1;
			if(random()>0.5)
				nvel_y = random()*250 + 500;
			else		
				nvel_y = 0 - random()*250 - 500;
                        if((ovel_y < 0 && nvel_y < 0)||(ovel_y >= 0 && nvel_y >= 0))
				samevel=samevel + 1;
			nvel_z = random()*300 - 150;
                        if((ovel_z < 0 && nvel_z < 0)||(ovel_z >= 0 && nvel_z >= 0))
				nvel_z = 0 - nvel_z;
			if(samevel<2)
				newvelnotset=FALSE;
		}
		self.velocity_x = nvel_x;
		self.velocity_y = nvel_y;
		self.velocity_z = nvel_z;
	      self.o_angle = self.velocity;
        }
        self.angles = vectoangles(self.velocity)+'-90 0 0';
        if (self.flags & FL_ONGROUND)
                {
                   self.flags = self.flags - FL_ONGROUND;
                   self.avelocity = '0 -200 0';
		       self.velocity_x = self.o_angle_x;
		       self.velocity_y = self.o_angle_y;
			 self.velocity_z = 200;
                }
};

void() ThrowchakramThink =
{
	if(pointcontents(self.origin)==CONTENT_SOLID)
		chakramPickUp(self.controller);

// End homing code
// Homing Code
        if (self.enemy != world)
        {
        local vector vtemp,dir;
	        vtemp = self.enemy.origin;
	        dir = normalize(vtemp - self.origin);
	        self.velocity = dir * 500;
	        self.angles = vectoangles(self.velocity)+'-90 0 0';
	  }
	  else self.velocity = normalize(self.o_angle) * 500;

	  if (self.flags & FL_ONGROUND)
        {
           	 self.avelocity = '0 -200 0';
             self.flags = self.flags - FL_ONGROUND;
	       self.velocity_x = self.o_angle_x;
	       self.velocity_y = self.o_angle_y;
		 self.velocity_z = 200;
	  }
        sound(self, CHAN_WEAPON, "weapons/woosh.wav", 0.3, ATTN_NORM);
        if(!self.controller.alive||self.velocity=='0 0 0')
	  {
		self.think=chakramDrop;
		self.nextthink=time;
	  }
	  else
	  {
        	self.think = ThrowchakramThink;
	      self.nextthink = time + 0.2;
	  }
};

void() Throwchakram =
{
        self.saber=spawn();
        self.saber.classname="chakram";
        self.saber.movetype=MOVETYPE_FLYMISSILE;
        self.saber.solid=SOLID_BBOX;
        self.saber.touch=chakramHit;
//        self.saber.takedamage=DAMAGE_NO;
        self.saber.takedamage=DAMAGE_AIM;
        self.saber.th_die=chakramDrop;
	  self.saber.th_pain=chakramHurt;
        self.saber.health=300;
        self.saber.running=TRUE;
        sound(self, CHAN_AUTO, "weapons/woosh.wav", 1, ATTN_NORM);
        makevectors (self.v_angle);
        self.saber.velocity = normalize(v_forward*1);
        self.saber.angles=self.v_angle + '-90 0 0';
        self.saber.velocity = self.saber.velocity*500;
	  self.saber.o_angle = self.saber.velocity;
        if(random()<0.5)
                self.saber.avelocity='0 -200 0';
        else self.saber.avelocity='0 200 0';
        self.saber.follow= -1;
        self.saber.controller=self;
        self.saber.owner=self.saber;
        self.saber.levitime = time + 0.5;
        self.saber.enemy=world;
        self.saber.oldenemy=world;
        self.saber.mass = random()*5 + 2;
        self.saber.wallspot=self.origin + '0 0 10';

        self.saber.think=ThrowchakramThink;
        self.saber.nextthink=time;

        setsize(self.saber,'-1 -1 -1', '1 1 1');
        setmodel(self.saber,"progs/chakram.mdl");
        setorigin(self.saber,self.origin+v_forward*48+'0 0 16');
};

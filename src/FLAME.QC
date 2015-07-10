/*
================
FlameTouch
================
*/
void () FlameTouch =
{
        local   float   rn;

        if (other.takedamage)
        {
                rn = random();
                // 50% chance
                if (rn <= 0.5)
                        {
                        if(other.onfire)
                                other.onfire = other.onfire + 1;
                        remove(self);
                        }
                other.onfire = other.onfire + 1;
                self.wait = 160;
                self.enemy = other;
                self.active = 0.25;
                self.think = FireDamage;
                self.nextthink = time;
                self.solid = SOLID_NOT;
                setmodel (self,"");
        }
        else if (other.classname == "worldspawn")
        {
                self.velocity = '0 0 0';
        }
};

/*
================
W_FireFlame
================
*/
void() W_FireFlame =
{
        local   entity flame;
        local   float rn;

        if (self.waterlevel > 2)
        {
//                makevectors (self.v_angle);

                rn = random();
                if (rn < 0.5)
                        sound (self, CHAN_WEAPON, "misc/water1.wav", 1, ATTN_NORM);
                else
                        sound (self, CHAN_WEAPON, "misc/water2.wav", 1, ATTN_NORM);
                return;
        }

        // Take away a shell
        self.currentammo = self.ammo_shells = self.ammo_shells - 1;

        sound (self, CHAN_WEAPON, "hknight/hit.wav", 1, ATTN_NORM);

        flame = spawn ();
        flame.owner = self;
        flame.movetype = MOVETYPE_FLYMISSILE;
        flame.solid = SOLID_BBOX;
        flame.classname = "fire";
		
// set flame speed    

	makevectors (self.v_angle);

        flame.velocity = (aim(self, 10000)* 400)+'0 0 32' + v_right * (random()*16 - 8);
        flame.effects = 8;
        flame.touch = FlameTouch;
	
        flame.think = SUB_Remove;
        flame.nextthink = time + 1.5;

        setmodel (flame, "progs/flame2.mdl");
        setsize (flame, '0 0 0', '0 0 0');            
        setorigin (flame, self.origin + v_forward * 32 + v_up * (random()*16 - 8) + '0 0 16');
};

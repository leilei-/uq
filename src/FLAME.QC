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
                if (rn <= 0.5||other.onfire>=1)
                        {
                        if(other.onfire)
                                other.onfire = other.onfire + 0.1;
                        remove(self);
                        }
                other.onfire = other.onfire + 0.1;
                if(self.owner.movetype==MOVETYPE_NONE)
                        self.wait = 20;
                else self.wait = 60;
                self.trigger_field = other;
                self.active = 0.1;
                self.think = FireTouch2;
                self.nextthink = time;
                self.solid = SOLID_NOT;
                setmodel (self,"progs/flame2.mdl");
        }
        else
        {
                if(self.netname=="heat")
                        {
                        SpawnFlame(self.origin);
                        if(self.movetype==MOVETYPE_FLY)
                                remove(self);
                        }
                else
                        {
                        self.velocity = '0 0 0';
                        self.velocity_z = random()*24 + 24;
                        }
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

    if(self.movetype!=MOVETYPE_NONE)
    {
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
    }
    else if((random()>=0.1&&random()>=0.2)||(!other.takedamage))
        return;
        sound (self, CHAN_WEAPON, "hknight/hit.wav", 1, ATTN_NORM);

        flame = spawn ();
        flame.owner = self;
        flame.movetype = MOVETYPE_FLYMISSILE;
        flame.solid = SOLID_BBOX;
        flame.classname = "fire";
        flame.small=self.small;         
// set flame speed    

        if(self.movetype==MOVETYPE_NONE)
        {
                flame.velocity='0 0 100';
                setorigin (flame, self.origin + '0 0 16');
        }
        else
        {
                makevectors (self.v_angle);
                flame.velocity = normalize(v_forward)*400+'0 0 32' + v_right * (random()*16 - 8);
                if(self.small)
                        setorigin (flame, self.origin + v_forward * 4 + v_up * 1 + '0 0 1');
                else setorigin (flame, self.origin + v_forward * 32 + v_up * (random()*16 - 8) + '0 0 16');
        }

//        flame.effects = 8;
        flame.touch = FlameTouch;
	
        flame.think = SUB_Remove;
        flame.nextthink = time + 1.5;

        if(self.small)
                setmodel (flame, "progs/s_flame.mdl");
        else setmodel (flame, "progs/flame2.mdl");
        setsize (flame, '0 0 0', '0 0 0');            
};

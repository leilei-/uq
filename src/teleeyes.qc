/*---------------------------------------------
TeleEyes
---------------------------------------------*/

void (entity me) TeleEyesWarp =
{
 local vector	org;

        if (me.aflag == 666)
                HoloCam(me);

        me.teleeyes.solid = SOLID_NOT;
        me.teleeyes.takedamage = DAMAGE_NO;
        spawn_tfog (me.origin);

// spawn a tfog flash in front of the destination

        makevectors (me.teleeyes.mangle);
        org = me.teleeyes.origin;

	spawn_tfog (org);
        spawn_tdeath(me.teleeyes.origin, me);

	
// move the player and lock him down for a little while

//        if (!me.health)
//        {
//                me.velocity=(v_forward*me.velocity_x)+(v_forward*me.velocity_y);
//                me.oldorigin=me.teleeyes.origin;
//                setorigin (me, me.teleeyes.origin);
//                return;
//        }

        setorigin (me, me.teleeyes.origin);
        me.angles = me.teleeyes.mangle;

        me.teleport_time = time + 0.7;
        if (me.flags & FL_ONGROUND)
                me.flags = me.flags - FL_ONGROUND;
        me.flags = me.flags - me.flags & FL_ONGROUND;
        return;
};

void () TeleEyesDie =
{
        self.owner.isfeign = FALSE;
        TeleEyesWarp(self.owner);
        T_Damage (self.owner, self.enemy, self.enemy, self.owner.health + 100);
        self.active = FALSE;
        remove (self);
};

void(entity myself) ActivateEyes =
{
local entity tel;
        tel = spawn();
        tel.solid = SOLID_BBOX;
        tel.takedamage = DAMAGE_AIM;
        tel.health = 1;
        tel.movetype = MOVETYPE_NOCLIP;
        tel.origin = myself.origin;
        tel.angles = myself.angles;
        setsize (tel, '-3 -3 50', '3 3 53');
        setmodel (tel, "progs/eyes.mdl");
        tel.classname = "TeleEye";
        tel.owner=myself;
        myself.teleeyes = tel;
        stuffcmd (tel.owner, "bf\n");
        sprint(tel.owner,"TeleEyes Placed\n");
        sound (myself, CHAN_WEAPON, "weapons/teleeyes.wav",1, ATTN_NORM);
        tel.nextthink = time;
        tel.think = SUB_Null;
        tel.active = TRUE;
        tel.th_stand = SUB_Null;
        tel.th_walk = SUB_Null;
        tel.th_run = SUB_Null;
        tel.th_pain = SUB_Null;
        tel.th_melee = SUB_Null;
        tel.th_missile = SUB_Null;
        tel.th_die = TeleEyesDie;
        tel.beendead = TRUE;
};

void () TeleEyes =
{
        if (self.newholo.active)
        {
                sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                sprint(self,"Deactivate or Detonate Holograph first...\n");
		return;
	}
        if (self.mana < 10)
	{
                sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                sprint(self,"Mana is too low!\n");
		return;
	}
        if (self.teleeyes.active == FALSE)
                {
                ActivateEyes (self);
                return;
                }
        TeleEyesWarp(self);
        remove(self.teleeyes);
        self.teleeyes.active = FALSE;
        return;
};

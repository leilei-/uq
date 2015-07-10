void() SightThink =
{
	local vector org;

        if(!self.hover)
	          self.effects=0;
        else
                self.effects=EF_BRIGHTLIGHT;

        makevectors(self.owner.v_angle);
        if(self.owner.racename=="Borg"&&self.owner.aflag==666)
                org = self.owner.borgsee.origin + v_forward*64 + v_up*16;
        else org = self.owner.origin + v_up*16;

        traceline (org, org + v_forward*2048, FALSE, self);

        if (trace_fraction == 1.0)
	{
                // move sight inside player if can't hit anything
        	setorigin(self, self.owner.origin );
		return;
	}

        // check if target is damageable and set proper skin
        if (trace_ent.takedamage&&trace_ent.owner!=self.owner&&trace_ent.controller!=self.owner)
                {
                if(self.message_time<time)
                        {
                        sound(self.owner,CHAN_AUTO,"weapons/beep1.wav",0.3,ATTN_NORM);
                        self.message_time=time + 0.5;
                        }
                self.skin=1;
                }
	else
                self.skin=0;

	// move sight at line of sight collision
	self.angles = vectoangles(v_forward);
        setorigin(self, trace_endpos );

	// mark think to update sight position
        self.think = SightThink;
	self.nextthink = time + 0.05;
};

void() SightMake =
{
        self.sight = spawn ();
        self.sight.owner = self;
        self.sight.movetype = MOVETYPE_NOCLIP;
        self.sight.solid = SOLID_NOT;
        self.sight.running=TRUE;

        setmodel (self.sight, "progs/cross2.mdl");
        self.sight.skin=0;
        self.sight.classname = "laser sight";

        setorigin( self.sight, self.origin );

        self.sight.think = SightThink;
        self.sight.nextthink = time + 0.05;
};

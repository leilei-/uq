float () crandom;   // prototype
void() ShellHit =
{
	if (self.deadflag)                       // flag to stop repetitive loop sounds
		return;
	else
	{
		if (self.ltime > (time - 0.2))   // if last shell hit sound occured < than 2 frames ago
		{
        		self.deadflag = TRUE;    // mark shell as dead
			return; 
		}
		else   	
		{
                        if(self.small)
                                sound (self, CHAN_WEAPON, "weapons/shellhit.wav", 0.25, ATTN_NORM);
                        else sound (self, CHAN_WEAPON, "weapons/shellhit.wav", 1, ATTN_NORM);
			self.ltime = time;       // mark the time of the last sound
		}
	}
};

void() DropShell =
{
	self.movetype = MOVETYPE_BOUNCE;
	self.solid = SOLID_BBOX;
        if(self.small)
                setmodel (self, "progs/s_shell.mdl");
        else setmodel (self, "progs/shelcase.mdl");
	setsize (self, VEC_ORIGIN, VEC_ORIGIN);   
        makevectors (self.owner.v_angle);
	setorigin (self, self.owner.origin + v_forward * 10 - v_right*10);	
        if(self.small)
                self.velocity = v_forward*3 + crandom()*v_forward*3 + v_up*22 + crandom()*v_up - v_right*5 + crandom()*v_right*2;
        else self.velocity = v_forward*30 + crandom()*v_forward*30 + v_up*220 + crandom()*v_up*10 - v_right*50 + crandom()*v_right*20;
        self.avelocity_x = crandom()*500;
	self.avelocity_y = crandom()*500;
	self.avelocity_z = crandom()*500;
	self.touch = ShellHit;
        self.nextthink = time + 5;
	self.think = SUB_Remove;
	self.ltime = time - 1;
	self.deadflag = FALSE;
};

void() SpawnShell=
{
        local entity shell;

	shell = spawn ();
	shell.owner = self;
        shell.small=self.small;
	shell.nextthink = time + 0.4;	     // delay shells until reload
	shell.think = DropShell;
};

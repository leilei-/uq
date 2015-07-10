//====================================================================
//
// SHOTGUN SHELLS			by: Perecli Manole AKA Bort
//		      Shell .mdl & .wav by: Steve Bond
//
//====================================================================
// Aside from this new file, the following are the modifications
// done to id's original source files:
//--------------------------------------------------------------------
// File: Progs.src
// Location: before the "holo.qc" line
// Added: shells.qc
//--------------------------------------------------------------------
// File: Weapons.qc
// Procedure: W_Precache
// Location: last line
// Added: precache_sound ("weapons/shellhit.wav"); // shotgun shells
//--------------------------------------------------------------------
// File: World.qc
// Procedure: worldspawn
// Location: at the end of all precache model definitions
// Added: precache_model ("progs/shell.mdl");
//--------------------------------------------------------------------
// File: Weapons.qc
// Procedure: W_FireShotgun 
// Location: before "FireBullets (6, dir, '0.04 0.04 0');" line
// Added: SpawnShell(); 
//--------------------------------------------------------------------
// File: Weapons.qc
// Procedure: W_FireSuperShotgun
// Location: before "FireBullets (14, dir, '0.14 0.08 0');" line
// Added: SpawnShell(); SpawnShell(); 
//--------------------------------------------------------------------


float () crandom;   // prototype


//--------------------------------------------------------------------
// Plays hit sound when shell hits hard surface if not stuck in loop
//--------------------------------------------------------------------
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
			sound (self, CHAN_WEAPON, "weapons/shellhit.wav", 1, ATTN_NORM);
			self.ltime = time;       // mark the time of the last sound
		}
	}
};


//--------------------------------------------------------------------
// Displays shell and defines its dynamic manifestation
//--------------------------------------------------------------------
void() DropShell = 
{
	self.movetype = MOVETYPE_BOUNCE;
	self.solid = SOLID_BBOX;
        setmodel (self, "progs/shelcase.mdl");
	setsize (self, VEC_ORIGIN, VEC_ORIGIN);   
        makevectors (self.owner.v_angle);
	setorigin (self, self.owner.origin + v_forward * 10 - v_right*10);	
	self.velocity = v_forward*30 + crandom()*v_forward*30 + v_up*220 + crandom()*v_up*10 - v_right*50 + crandom()*v_right*20;
        self.avelocity_x = crandom()*500;
	self.avelocity_y = crandom()*500;
	self.avelocity_z = crandom()*500;
	self.touch = ShellHit;
	self.nextthink = time + 20;
	self.think = SUB_Remove;
	self.ltime = time - 1;
	self.deadflag = FALSE;
};


//--------------------------------------------------------------------
// Spawns new shell entity but doesn't display it until reload time
//--------------------------------------------------------------------
void() SpawnShell=
{
        local entity shell;

	shell = spawn ();
	shell.owner = self;
	shell.nextthink = time + 0.4;	     // delay shells until reload
	shell.think = DropShell;
};

// prototypes
void () W_WeaponFrame;
void() W_SetCurrentAmmo;
void() player_stand1;
void() player_shrink1;
void() player_grow1;
void(entity attacker, float damage) player_spain;
void (vector org) spawn_tfog;
void (vector org, entity death_owner) spawn_tdeath;
void() play_dog_leap1;
// kicking
void() PlayerTouch;

/*
=============================================================================

				LEVEL CHANGING / INTERMISSION

=============================================================================
*/

float	intermission_running;
float	intermission_exittime;

/*QUAKED info_intermission (1 0.5 0.5) (-16 -16 -16) (16 16 16)
This is the camera point for the intermission.
Use mangle instead of angle, so you can set pitch or roll as well as yaw.  'pitch roll yaw'
*/
void() info_intermission =
{
};

/*
void() RestoreMutant =
{
        self.classlabel = "Mutant";
        self.jumphite=parm17;
        self.intel=parm18;
        self.damagetake=parm19;
        self.accuracy=parm20;
        self.hitplus=parm21;
        self.attackspeed=parm22;
        self.speed=parm23;
        self.mass=parm24;
};

void() StoreMutant =
{
 parm17=self.jumphite;
 parm18=self.intel;
 parm19=self.damagetake;
 parm20=self.accuracy;
 parm21=self.hitplus;
 parm22=self.attackspeed;
 parm23=self.speed;
 parm24=self.mass;
};
*/

void() SetChangeParms =
{
// remove items
	self.items = self.items - (self.items & 
	(IT_KEY1 | IT_KEY2 | IT_INVISIBILITY | IT_INVULNERABILITY | IT_SUIT | IT_QUAD) );
// add time to next level for proper mana maintainance
        self.init_mana = self.init_mana - time;
        parm10 = self.init_mana;
        parm11 = self.exp;
// cap super health & boost health if too low
        if (self.health > self.max_health)
                self.health = self.max_health;
        if (self.health < self.max_health/2)
                self.health = self.max_health/2;
	parm1 = self.items;
	parm2 = self.health;
	parm3 = self.armorvalue;
	if (self.ammo_shells < 25)
		parm4 = 25;
	else
		parm4 = self.ammo_shells;
	parm5 = self.ammo_nails;
	parm6 = self.ammo_rockets;
	parm7 = self.ammo_cells;
        parm8 = self.max_health;
	parm9 = self.armortype * 100;
        parm12 = self.waterbreathe*1 +
                 self.fireresist*10 +
                 self.slimeresist*100 +
                 self.magicresist*1000 +
                 self.healthregen*10000 +
                 self.claws*100000 +
                 self.featherfall*1000000 +
                 self.berzerker*10000000 +
                 self.energyabsorb*100000000 +
                 self.anyinvis*1000000000 +
                 self.nospells*10000000000 +
                 self.weakheart*100000000000 +
                 self.weak*1000000000000 +
                 self.wallclimb*10000000000000 +
                 self.heatsee*100000000000000 +
                 self.boltsee*1000000000000000; 
        parm13 = self.skin;
//        parm14 = ;
        parm15 = self.allset*100000 + self.saberset*10000 + self.level*100 + (self.race - 1)*10 + self.class;
//        parm16 = ;
//        if(self.class==6)
//                StoreMutant();
};

void() SetNewParms =
{
        parm1 = IT_SHOTGUN | IT_AXE;// | IT_SNIPERGUN;
        if(deathmatch&&self.max_health>0)
                parm2 = self.max_health;
        else parm2 = 50;
	parm3 = 0;
	parm4 = 25;
	parm5 = 0;
	parm6 = 0;
	parm6 = 0;
        if(deathmatch&&self.max_health>0)
                parm8 = self.max_health;
        else parm8 = 50;
	parm9 = 0;
        parm10 = time;
        if (deathmatch)
                parm11 = 1000;
        else
        parm11 = 0;
        parm12 = 0;
if(self.allset!=TRUE)
{
//        parm14 = FALSE;
        parm15 = 0;
//        parm16 = 0;
        parm13 = 0;
//        parm18 = 0;
//        parm19 = 0;
//        parm20 = 0;
//        parm21 = 0;
//        parm22 = 0;
//        parm23 = 0;
//        parm24 = 0;
}
else
{
        parm13 = self.skin;
//        parm14 = ;
        parm15 = self.allset*100000 + self.saberset*10000 + self.level*100 + (self.race - 1)*10 + self.class;
//        parm16 =;
//        if(self.class==6)
//                StoreMutant();
}
};

void() DecodeLevelParms =
{
/*
	if (serverflags)
	{
		if (world.model == "maps/start.bsp")
			SetNewParms ();		// take away all stuff on starting new episode
	}
*/ 
	self.items = parm1;
	self.health = parm2;
	self.armorvalue = parm3;
	self.ammo_shells = parm4;
	self.ammo_nails = parm5;
	self.ammo_rockets = parm6;
	self.ammo_cells = parm7;
        self.max_health = parm8;
	self.armortype = parm9 * 0.01;
        self.init_mana = parm10;
        if (deathmatch)
                {
                self.exp = 1000000;
                self.init_mana = time - 1000;
                }
        else self.exp = parm11;
        self.attack_finished=self.onfire=self.enchant_axe=self.dog_finished=self.isfeign=self.ducking=self.feigning=self.bloodloss=self.suff=self.levitime=self.firesistime=self.reflecttime=self.protmisstime=self.prottime=self.archtime=self.dog_time=self.alivetime=0;
        self.boltsee=floor(parm12/1000000000000000);
                parm12=parm12-self.boltsee*1000000000000000;
        self.heatsee=floor(parm12/100000000000000);
                parm12=parm12-self.heatsee*100000000000000;
        self.wallclimb=floor(parm12/10000000000000);
                parm12=parm12-self.wallclimb*10000000000000;
        self.weak=floor(parm12/1000000000000);
                parm12=parm12-self.weak*1000000000000;
        self.weakheart=floor(parm12/100000000000);
                parm12=parm12-self.weakheart*100000000000;
        self.nospells=floor(parm12/10000000000);
                parm12=parm12-self.nospells*10000000000;
        self.anyinvis=floor(parm12/1000000000);
                parm12=parm12-self.anyinvis*1000000000;
        self.energyabsorb=floor(parm12/100000000);
                parm12=parm12-self.energyabsorb*100000000;
        self.berzerker=floor(parm12/10000000);
                parm12=parm12-self.berzerker*10000000;
        self.featherfall=floor(parm12/1000000);
                parm12=parm12-self.featherfall*1000000;
        self.claws=floor(parm12/100000);
                parm12=parm12-self.claws*100000;
        self.healthregen=floor(parm12/10000);
                parm12=parm12-self.healthregen*10000;
        self.magicresist=floor(parm12/1000);
                parm12=parm12-self.magicresist*1000;
        self.slimeresist=floor(parm12/100);
                parm12=parm12-self.slimeresist*100;
        self.fireresist=floor(parm12/10);
                parm12=parm12-self.fireresist*10;
        self.waterbreathe=floor(parm12);
                parm12=0;
        self.allset = floor(parm15/100000);
                parm15=parm15-self.allset*100000;
//        if(deathmatch&&self.allset)
//                return;
        self.skin = parm13;
//        if(self.allset)
         self.saberset = floor(parm15/10000);
                parm15=parm15-self.saberset*10000;
        self.level = floor(parm15/100);
                parm15=parm15-self.level*100;
        self.race = floor(parm15/10) + 1;
                parm15=parm15-(self.race - 1)*10;
        self.class = parm15;
                parm15=0;
};

/*
============
FindIntermission

Returns the entity to view from
============
*/
entity() FindIntermission =
{
	local	entity spot;
	local	float cyc;

// look for info_intermission first
	spot = find (world, classname, "info_intermission");
	if (spot)
	{	// pick a random one
		cyc = random() * 4;
		while (cyc > 1)
		{
			spot = find (spot, classname, "info_intermission");
			if (!spot)
				spot = find (spot, classname, "info_intermission");
			cyc = cyc - 1;
		}
		return spot;
	}

// then look for the start position
	spot = find (world, classname, "info_player_start");
	if (spot)
		return spot;
	
// testinfo_player_start is only found in regioned levels
	spot = find (world, classname, "testplayerstart");
	if (spot)
		return spot;
	
	objerror ("FindIntermission: no spot");
};


string nextmap;
void() GotoNextMap =
{
	if (cvar("samelevel"))	// if samelevel is set, stay on same level
		changelevel (mapname);
	else
		changelevel (nextmap);
};


void() ExitIntermission =
{
// skip any text in deathmatch
	if (deathmatch)
	{
		GotoNextMap ();
		return;
	}
	
	intermission_exittime = time + 1;
	intermission_running = intermission_running + 1;

//
// run some text if at the end of an episode
//
	if (intermission_running == 2)
	{
		if (world.model == "maps/e1m7.bsp")
		{
			WriteByte (MSG_ALL, SVC_CDTRACK);
			WriteByte (MSG_ALL, 2);
			WriteByte (MSG_ALL, 3);
			if (!cvar("registered"))
			{
				WriteByte (MSG_ALL, SVC_FINALE);
				WriteString (MSG_ALL, "As the corpse of the monstrous entity\nChthon sinks back into the lava whence\nit rose, you grip the Rune of Earth\nMagic tightly. Now that you have\nconquered the Dimension of the Doomed,\nrealm of Earth Magic, you are ready to\ncomplete your task in the other three\nhaunted lands of Quake. Or are you? If\nyou don't register Quake, you'll never\nknow what awaits you in the Realm of\nBlack Magic, the Netherworld, and the\nElder World!");
			}
			else
			{
				WriteByte (MSG_ALL, SVC_FINALE);
				WriteString (MSG_ALL, "As the corpse of the monstrous entity\nChthon sinks back into the lava whence\nit rose, you grip the Rune of Earth\nMagic tightly. Now that you have\nconquered the Dimension of the Doomed,\nrealm of Earth Magic, you are ready to\ncomplete your task. A Rune of magic\npower lies at the end of each haunted\nland of Quake. Go forth, seek the\ntotality of the four Runes!");
			}
			return;
		}
		else if (world.model == "maps/e2m6.bsp")
		{
			WriteByte (MSG_ALL, SVC_CDTRACK);
			WriteByte (MSG_ALL, 2);
			WriteByte (MSG_ALL, 3);

			WriteByte (MSG_ALL, SVC_FINALE);
			WriteString (MSG_ALL, "The Rune of Black Magic throbs evilly in\nyour hand and whispers dark thoughts\ninto your brain. You learn the inmost\nlore of the Hell-Mother; Shub-Niggurath!\nYou now know that she is behind all the\nterrible plotting which has led to so\nmuch death and horror. But she is not\ninviolate! Armed with this Rune, you\nrealize that once all four Runes are\ncombined, the gate to Shub-Niggurath's\nPit will open, and you can face the\nWitch-Goddess herself in her frightful\notherworld cathedral.");
			return;
		}
		else if (world.model == "maps/e3m6.bsp")
		{
			WriteByte (MSG_ALL, SVC_CDTRACK);
			WriteByte (MSG_ALL, 2);
			WriteByte (MSG_ALL, 3);

			WriteByte (MSG_ALL, SVC_FINALE);
			WriteString (MSG_ALL, "The charred viscera of diabolic horrors\nbubble viscously as you seize the Rune\nof Hell Magic. Its heat scorches your\nhand, and its terrible secrets blight\nyour mind. Gathering the shreds of your\ncourage, you shake the devil's shackles\nfrom your soul, and become ever more\nhard and determined to destroy the\nhideous creatures whose mere existence\nthreatens the souls and psyches of all\nthe population of Earth.");
			return;
		}
		else if (world.model == "maps/e4m7.bsp")
		{
			WriteByte (MSG_ALL, SVC_CDTRACK);
			WriteByte (MSG_ALL, 2);
			WriteByte (MSG_ALL, 3);

			WriteByte (MSG_ALL, SVC_FINALE);
			WriteString (MSG_ALL, "Despite the awful might of the Elder\nWorld, you have achieved the Rune of\nElder Magic, capstone of all types of\narcane wisdom. Beyond good and evil,\nbeyond life and death, the Rune\npulsates, heavy with import. Patient and\npotent, the Elder Being Shub-Niggurath\nweaves her dire plans to clear off all\nlife from the Earth, and bring her own\nfoul offspring to our world! For all the\ndwellers in these nightmare dimensions\nare her descendants! Once all Runes of\nmagic power are united, the energy\nbehind them will blast open the Gateway\nto Shub-Niggurath, and you can travel\nthere to foil the Hell-Mother's plots\nin person.");
			return;
		}

		GotoNextMap();
	}
	
	if (intermission_running == 3)
	{
		if (!cvar("registered"))
		{	// shareware episode has been completed, go to sell screen
			WriteByte (MSG_ALL, SVC_SELLSCREEN);
			return;
		}
		
		if ( (serverflags&15) == 15)
		{
			WriteByte (MSG_ALL, SVC_FINALE);
			WriteString (MSG_ALL, "Now, you have all four Runes. You sense\ntremendous invisible forces moving to\nunseal ancient barriers. Shub-Niggurath\nhad hoped to use the Runes Herself to\nclear off the Earth, but now instead,\nyou will use them to enter her home and\nconfront her as an avatar of avenging\nEarth-life. If you defeat her, you will\nbe remembered forever as the savior of\nthe planet. If she conquers, it will be\nas if you had never been born.");
			return;
		}
		
	}

	GotoNextMap();
};

/*
============
IntermissionThink

When the player presses attack or jump, change to the next level
============
*/
void() IntermissionThink =
{
	if (time < intermission_exittime)
		return;

	if (!self.button0 && !self.button1 && !self.button2)
		return;
	
	ExitIntermission ();
};

void() execute_changelevel =
{
	local entity	pos;

	intermission_running = 1;
	
// enforce a wait time before allowing changelevel
	if (deathmatch)
		intermission_exittime = time + 5;
	else
		intermission_exittime = time + 2;

	WriteByte (MSG_ALL, SVC_CDTRACK);
	WriteByte (MSG_ALL, 3);
	WriteByte (MSG_ALL, 3);
	
	pos = FindIntermission ();

	other = find (world, classname, "player");
	while (other != world)
	{
		other.view_ofs = '0 0 0';
		other.angles = other.v_angle = pos.mangle;
		other.fixangle = TRUE;		// turn this way immediately
		other.nextthink = time + 0.5;
		other.takedamage = DAMAGE_NO;
		other.solid = SOLID_NOT;
		other.movetype = MOVETYPE_NONE;
		other.modelindex = 0;
		setorigin (other, pos.origin);
		other = find (other, classname, "player");
	}	

	WriteByte (MSG_ALL, SVC_INTERMISSION);
};


void() changelevel_touch =
{
	local entity	pos;

	if (other.classname != "player")
		return;

	if (cvar("noexit"))
	{
		T_Damage (other, self, self, 50000);
		return;
	}
	bprint (other.netname);
	bprint (" exited the level\n");

        if(other.saber.running)
                remove(other.saber);
        if(other.sight.running)
                remove(other.sight);
	
	nextmap = self.map;

	SUB_UseTargets ();

	if ( (self.spawnflags & 1) && (deathmatch == 0) )
	{	// NO_INTERMISSION
		GotoNextMap();
		return;
	}
	
	self.touch = SUB_Null;

// we can't move people right now, because touch functions are called
// in the middle of C movement code, so set a think time to do it
	self.think = execute_changelevel;
	self.nextthink = time + 0.1;
};

/*QUAKED trigger_changelevel (0.5 0.5 0.5) ? NO_INTERMISSION
When the player touches this, he gets sent to the map listed in the "map" variable.  Unless the NO_INTERMISSION flag is set, the view will go to the info_intermission spot and display stats.
*/
void() trigger_changelevel =
{
	if (!self.map)
		objerror ("chagnelevel trigger doesn't have map");
	
	InitTrigger ();
	self.touch = changelevel_touch;
};


/*
=============================================================================

				PLAYER GAME EDGE FUNCTIONS

=============================================================================
*/

void() set_suicide_frame;

// called by ClientKill and DeadThink
void() respawn =
{
	if (coop)
	{
		// make a copy of the dead body for appearances sake
                SolidPlayer();
//                CopyToBodyQue (self);
		// get the spawn parms as they were at level start
		setspawnparms (self);
		// respawn		
                PutClientInServer ();
	}
	else if (deathmatch)
	{
		// make a copy of the dead body for appearances sake
                SolidPlayer();
//                CopyToBodyQue (self);
		// set default spawn parms
		SetNewParms ();
		// respawn		
		PutClientInServer ();
	}
	else
	{	// restart the entire server
		localcmd ("restart\n");
	}
};


/*
============
ClientKill

Player entered the suicide command
============
*/
void() ClientKill =
{
	bprint (self.netname);
	bprint (" suicides\n");
	set_suicide_frame ();
	self.modelindex = modelindex_player;
        if(self.health<self.max_health*0.75)
                self.frags = self.frags - 2;
	respawn ();
};

float(vector v) CheckSpawnPoint =
{
	return FALSE;
};

/*
============
SelectSpawnPoint

Returns the entity to spawn at
============
*/
entity() SelectSpawnPoint =
{
	local	entity spot;
	
// testinfo_player_start is only found in regioned levels
	spot = find (world, classname, "testplayerstart");
	if (spot)
		return spot;
		
// choose a info_player_deathmatch point
	if (coop)
	{
		lastspawn = find(lastspawn, classname, "info_player_coop");
		if (lastspawn == world)
			lastspawn = find (lastspawn, classname, "info_player_start");
		if (lastspawn != world)
			return lastspawn;
	}
	else if (deathmatch)
	{
		lastspawn = find(lastspawn, classname, "info_player_deathmatch");
		if (lastspawn == world)
			lastspawn = find (lastspawn, classname, "info_player_deathmatch");
		if (lastspawn != world)
			return lastspawn;
	}

	if (serverflags)
	{	// return with a rune to start
		spot = find (world, classname, "info_player_start2");
		if (spot)
			return spot;
	}
	
	spot = find (world, classname, "info_player_start");
	if (!spot)
		error ("PutClientInServer: no info_player_start on level");
	
	return spot;
};

/*
===========
PutClientInServer

called each time a player is spawned
============
*/
void() DecodeLevelParms;
void() PlayerDie;
void() PutClientInServer =
{
	local	entity spot;

	self.classname = "player";
	self.health = 100;
	self.takedamage = DAMAGE_AIM;
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_WALK;
	self.show_hostile = 0;
	self.max_health = 100;
	self.flags = FL_CLIENT;
	self.air_finished = time + 12;
	self.dmg = 2;   		// initial water damage
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
	self.invisible_finished = 0;
	self.invincible_finished = 0;
	self.effects = 0;
        self.small=FALSE;
        self.shrink_time=0;
      self.weapon=1;
      self.invincible_time = 0;
      self.alive = TRUE;
      self.phase = 1;
	self.climbing=FALSE;
        self.dangle=FALSE;

	DecodeLevelParms ();
	
	W_SetCurrentAmmo ();

        if(self.saber.running||self.saber.follow!=0||self.saber.inpain)
        {
        self.saber.running=FALSE;
        self.saber.follow=0;
        self.saber.inpain=FALSE;
        self.saber.aflag=0;
        remove(self.saber);
        }
        
// Magic stuff
        self.mana = time - self.init_mana;
        self.spell = 24;
        self.splevel = 1;
        self.controller = world;
        self.enemy = world;
        self.active = 2;
	self.attack_finished = time;
	self.th_pain = player_pain;
	self.th_die = PlayerDie;
//        self.mass = 1;
        self.amtaxe=1;
	self.touch = PlayerTouch;
        self.hover=FALSE;

	self.deadflag = DEAD_NO;
// paustime is set by teleporters to keep the player from moving a while
	self.pausetime = 0;
	
	spot = SelectSpawnPoint ();

	self.origin = spot.origin + '0 0 1';
	self.angles = spot.angles;
	self.fixangle = TRUE;		// turn this way immediately
        self.o_angle = self.angles;
// oh, this is a hack!
        setmodel (self, "progs/eyes.mdl");
	modelindex_eyes = self.modelindex;

        setmodel (self, "progs/dog.mdl");
        modelindex_dog = self.modelindex;

        setmodel (self, "progs/player.mdl");
	modelindex_player = self.modelindex;

	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);

        self.view_ofs = '0 0 22';

        if(self.allset)//||temp1!="0")
                {
//                if(temp1!="0")
//                        TempSetAll();
                showrace();
//                if(!self.classset)
                        showclass();
//                if(!self.skinset)
                        showskin();
                }
        else self.race=0;

//        if(self.class==6)
//                RestoreMutant();

	player_stand1 ();
        self.impulse =45;

	if (deathmatch || coop)
	{
		makevectors(self.angles);
		spawn_tfog (self.origin + v_forward*20);
	}
	spawn_tdeath (self.origin, self);
};




/*
=============================================================================

				QUAKED FUNCTIONS

=============================================================================
*/


/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 24)
The normal starting point for a level.
*/
void() info_player_start =
{
};


/*QUAKED info_player_start2 (1 0 0) (-16 -16 -24) (16 16 24)
Only used on start map for the return point from an episode.
*/
void() info_player_start2 =
{
};


/*
saved out by quaked in region mode
*/
void() testplayerstart =
{
};

/*QUAKED info_player_deathmatch (1 0 1) (-16 -16 -24) (16 16 24)
potential spawning position for deathmatch games
*/
void() info_player_deathmatch =
{
};

/*QUAKED info_player_coop (1 0 1) (-16 -16 -24) (16 16 24)
potential spawning position for coop games
*/
void() info_player_coop =
{
};

/*
===============================================================================

RULES

===============================================================================
*/

void(entity c) PrintClientScore =
{
	if (c.frags > -10 && c.frags < 0)
		bprint (" ");
	else if (c.frags >= 0)
	{
		if (c.frags < 100)
			bprint (" ");
		if (c.frags < 10)
			bprint (" ");
	}
	bprint (ftos(c.frags));
	bprint (" ");
	bprint (c.netname);
	bprint ("\n");
};

void() DumpScore =
{
	local entity	e, sort, walk;

	if (world.chain)
		error ("DumpScore: world.chain is set");

// build a sorted lis
	e = find(world, classname, "player");
	sort = world;
	while (e)
	{
		if (!sort)
		{
			sort = e;
			e.chain = world;
		}
		else
		{
			if (e.frags > sort.frags)
			{
				e.chain = sort;
				sort = e;
			}
			else
			{
				walk = sort;
				do
				{
					if (!walk.chain)
					{
						e.chain = world;
						walk.chain = e;
					}
					else if (walk.chain.frags < e.frags)
					{
						e.chain = walk.chain;
						walk.chain = e;
					}
					else
						walk = walk.chain;
				} while (walk.chain != e);
			}
		}
		
		e = find(e, classname, "player");
	}

// print the list
	
	bprint ("\n");	
	while (sort)
	{
		PrintClientScore (sort);
		sort = sort.chain;
	}
	bprint ("\n");
};

/*
go to the next level for deathmatch
*/
void() NextLevel =
{
	local entity o;

// find a trigger changelevel
	o = find(world, classname, "trigger_changelevel");
	if (!o || mapname == "start")
	{	// go back to same map if no trigger_changelevel
		o = spawn();
		o.map = mapname;
	}

	nextmap = o.map;
	
	if (o.nextthink < time)
	{
		o.think = execute_changelevel;
		o.nextthink = time + 0.1;
	}
};

/*
============
CheckRules

Exit deathmatch games upon conditions
============
*/
void() CheckRules =
{
	local	float		timelimit;
	local	float		fraglimit;
	
	if (gameover)	// someone else quit the game already
		return;
		
	timelimit = cvar("timelimit") * 60;
	fraglimit = cvar("fraglimit");
	
	if (timelimit && time >= timelimit)
	{
                NextLevel ();
		return;
	}
	
	if (fraglimit && self.frags >= fraglimit)
	{
                NextLevel ();
		return;
	}	
};

//============================================================================

void() PlayerDeathThink =
{
	local entity	old_self;
	local float		forward;

	if ((self.flags & FL_ONGROUND))
	{
		forward = vlen (self.velocity);
		forward = forward - 20;
		if (forward <= 0)
			self.velocity = '0 0 0';
		else	
			self.velocity = forward * normalize(self.velocity);
	}

// wait for all buttons released
	if (self.deadflag == DEAD_DEAD)
	{
		if (self.button2 || self.button1 || self.button0)
			return;
		self.deadflag = DEAD_RESPAWNABLE;
		return;
	}

// wait for any button down
        if (!self.button2 && !self.button1 && !self.button0)
		return;

	self.button0 = 0;
	self.button1 = 0;
	self.button2 = 0;
        if(self.racename=="Predator"&&self.explosion.active)
                self.explosion.origin = self.origin+'0 0 16';
	respawn();
};

void() Dog_JumpTouch;

void() PlayerJump =
{
        if (self.isfeign)       // experimental
                return;

local vector start, end;
local float jumpdist;

        if (self.levitime > time)
                {
                self.velocity = v_forward*(180/self.mass)+v_up*(60/self.mass);
                return;
                }
        if (self.flags & FL_WATERJUMP)
		return;
	
        if (self.waterlevel >= 2)
	{
                if((self.classlabel=="Jedi"||self.classlabel=="Dark Jedi")&&self.exp>=250000)
                        self.velocity_z = 250/self.mass;
                else if (self.watertype == CONTENT_WATER)
                        if (self.racename=="Bossk")
                                self.velocity_z = self.jumphite*80/self.mass;
                        else self.velocity_z = self.jumphite*24/self.mass;
		else if (self.watertype == CONTENT_SLIME)
                        self.velocity_z = self.jumphite*22/self.mass;
		else
                        self.velocity_z = self.jumphite*20/self.mass;
// play swiming sound
                if (self.swim_flag < time && self.waterlevel >= 2)
		{
			self.swim_flag = time + 1;
			if (random() < 0.5)
				sound (self, CHAN_BODY, "misc/water1.wav", 1, ATTN_NORM);
			else
				sound (self, CHAN_BODY, "misc/water2.wav", 1, ATTN_NORM);
		}

		return;
	}

        if (!(self.flags & FL_ONGROUND))
                {
                if((self.classlabel!="Jedi"&&self.classlabel!="Dark Jedi")||self.exp<250000)
                        return;
                }
        else self.flags = self.flags - FL_ONGROUND;  // don't stairwalk

        if ( !(self.flags & FL_JUMPRELEASED))
                {
                if((self.classlabel!="Jedi"&&self.classlabel!="Dark Jedi")||self.exp<250000)
                        return;         // don't pogo stick
                }
        else self.flags = self.flags - (self.flags & FL_JUMPRELEASED);

	
        self.jumpin = TRUE;

	self.button2 = 0;
// player jumping sound
        if (self.dog_time)
        {
                makevectors (self.angles);
                self.origin_z = self.origin_z + 1;
                self.velocity = v_forward * 800 - '0 0 350';
                self.velocity_z = self.velocity_z * -1;
//                if (self.flags & FL_ONGROUND)
//                        self.flags = self.flags - FL_ONGROUND;
                sound (self, CHAN_BODY, "dog/dsight.wav", 1, ATTN_NORM);
                self.touch = Dog_JumpTouch;
                play_dog_leap1();
        }
        else if (self.levitime < time) 
        {
                if((self.classlabel=="Jedi"||self.classlabel=="Dark Jedi")&&self.exp>=250000)
                        self.velocity_z = 350/self.mass;
                else
                {
                if(self.racename=="TigerMan")
                        sound (self, CHAN_BODY, "tiger/hurt1.wav",self.volume + 1, ATTN_NORM);
#ifdef JAWORSKI
                else if(self.skin==1||self.oldskin==1)
                        {
                        if(self.zap_finished<=time)
                                sound (self, CHAN_BODY, "jaworski/jump.wav", 1, ATTN_NORM);
                        }
#endif
                else if(self.racename!="Predator")
                        if(self.skin==12||self.skin==16||self.oldskin==12||self.oldskin==16)
                        {
                                if(self.skin==12||self.oldskin==12||SolidAbove(200))
                                        sound (self, CHAN_BODY, "xena/femjump.wav",self.volume + 1, ATTN_NORM);
                                else 
                                {
                                        if(random()>0.4)
                                            sound (self, CHAN_BODY, "xena/femjump.wav",self.volume + 1, ATTN_NORM);
                                         else
                                            sound (self, CHAN_BODY, "xena/femyell.wav",self.volume + 1, ATTN_NORM);
                                         self.velocity_z = self.velocity_z + 800/self.mass;
                                         return;
                                }
                        }
                else
                        sound (self, CHAN_BODY, "player/plyrjmp8.wav",self.volume + 1, ATTN_NORM);
                jumpdist=self.jumphite*54/self.mass;
                if(jumpdist<320&&!self.small)
                        jumpdist=320;
                self.velocity_z = self.velocity_z + jumpdist;
                }
        }
};

/*
===========
WaterMove

============
*/
.float	dmgtime;

void() WaterMove =
{
//dprint (ftos(self.waterlevel));
       if((self.skin==24||self.skin==25)&&self.pausetime<=time)
                self.skin = self.oldskin;        
       if (self.movetype == MOVETYPE_NOCLIP)
               return;
       if (self.health < 0)
               return;

    if(self.waterlevel>0&&(self.racename=="T-800"||self.racename=="Borg")&&self.zap_finished<time&&self.radsuit_finished<time)
    {
        sound (self, CHAN_AUTO, "enforcer/enfstop.wav", 1, ATTN_NORM);
        if(self.racename=="Borg")
                {
                T_Damage (self, world, world, 3);
                T_RadiusDamageWater(self, self, 128,self);
                }
        else
                {
                T_Damage (self, world, world, 7);
                T_RadiusDamageWater(self, self, 256,self);
                }
        self.zap_finished = time + 0.5;
    }
    else
    {
        if((self.watertype == CONTENT_WATER||self.watertype==CONTENT_SLIME) && self.waterlevel == 3 && random() < 0.1&&self.air_finished<time+12&&self.suff!=1&&self.racename!="T-800"&&self.racename!="Borg")
	{
                DeathBubbles(1);
	}

       if (self.waterlevel != 3&&self.suff==0&&self.air_finished<time+12)
       {
                if (self.air_finished < time&&self.suff!=1)
                        if(self.skin==12||self.skin==16||self.oldskin==12||self.oldskin==16)
                                sound (self, CHAN_VOICE, "xena/gasp2.wav", 1, ATTN_NORM);
                        else sound (self, CHAN_VOICE, "player/gasp2.wav", 1, ATTN_NORM);
                else if(self.racename!="TigerMan")
                        if(self.air_finished < time + 9&&self.suff!=1)
                               if(self.skin==12||self.skin==16||self.oldskin==12||self.oldskin==16)
                                      sound (self, CHAN_VOICE, "xena/gasp1.wav", 1, ATTN_NORM);
                               else sound (self, CHAN_VOICE, "player/gasp1.wav", 1, ATTN_NORM);
                if (self.waterbreathe||self.racename=="Bossk")
                        self.air_finished = time + 300;
                else if(self.racename=="TigerMan")
                        self.air_finished = time + 6;
                else self.air_finished = time + 12;
                self.dmg = 2;
       }
       if ((self.air_finished < time && self.waterlevel == 3&&self.suff!=1)||self.suff==2||(self.waterlevel!=3&&self.suff==1))
       {       // drown!
               if(self.pain_finished < time)
               {
                       if(self.suff==2)
                               self.dmg=self.dmg + 10;
                       else self.dmg = self.dmg + 2;
                       if (self.dmg > 15&&self.suff!=2&&self.suff!=1)
                               self.dmg = 10;
                       if(self.suff==0)
                               self.deathtype="drown";
                       T_Damage (self, world, world, self.dmg);
                       self.pain_finished = time + 1;
               }
       }
    }
        if(self.small)
//                StaySlow();
                self.velocity = self.velocity - 0.5/self.mass*-2*frametime*self.velocity;
        else if (!(self.flags & FL_WATERJUMP) && self.levitime < time)
                if(self.racename=="Bossk"&&self.waterlevel==3)
                        self.velocity = self.velocity + 2.75*(self.waterlevel - 1)*frametime*self.velocity;
                else self.velocity = self.velocity - 0.8/self.mass*self.waterlevel*frametime*self.velocity;
       else if (self.levitime > time)
                self.velocity = self.velocity + frametime*self.velocity;

        if (!self.waterlevel && self.levitime < time)
	{
		if (self.flags & FL_INWATER)
		{	
			// play leave water sound
			sound (self, CHAN_BODY, "misc/outwater.wav", 1, ATTN_NORM);
			self.flags = self.flags - FL_INWATER;
		}
		return;
	}

        if (self.watertype == CONTENT_LAVA && self.firesistime<time&&self.racename!="Draconian"&&self.fireresist!=1)
	{	// do damage
		if (self.dmgtime < time)
		{
			if (self.radsuit_finished > time)
				self.dmgtime = time + 1;
			else
				self.dmgtime = time + 0.2;
                        if(self.fireresist==-1)
                                T_Damage (self, world, world, 20*self.waterlevel);
                        else T_Damage (self, world, world, 10*self.waterlevel);
		}
	}
        else if (self.watertype == CONTENT_SLIME&&self.suff!=1)
	{	// do damage
                if (self.dmgtime < time && self.radsuit_finished < time&&self.slimeresist!=TRUE)
		{
			self.dmgtime = time + 1;
			T_Damage (self, world, world, 4*self.waterlevel);
		}
	}
	
        if ( !(self.flags & FL_INWATER))
	{	

// player enter water sound

		if (self.watertype == CONTENT_LAVA)
			sound (self, CHAN_BODY, "player/inlava.wav", 1, ATTN_NORM);
		if (self.watertype == CONTENT_WATER)
			sound (self, CHAN_BODY, "player/inh2o.wav", 1, ATTN_NORM);
		if (self.watertype == CONTENT_SLIME)
			sound (self, CHAN_BODY, "player/slimbrn2.wav", 1, ATTN_NORM);
		self.flags = self.flags + FL_INWATER;
		self.dmgtime = 0;
	}
};

void() CheckWaterJump =
{
	local vector start, end;

// check for a jump-out-of-water
	makevectors (self.angles);
	start = self.origin;
	start_z = start_z + 8; 
	v_forward_z = 0;
	normalize(v_forward);
	end = start + v_forward*24;
	traceline (start, end, TRUE, self);
	if (trace_fraction < 1)
	{	// solid at waist
		start_z = start_z + self.maxs_z - 8;
		end = start + v_forward*24;
		self.movedir = trace_plane_normal * -50;
		traceline (start, end, TRUE, self);
		if (trace_fraction == 1)
		{	// open at eye level
			self.flags = self.flags | FL_WATERJUMP;
                        if(self.racename=="Bossk")
                                self.velocity_z = self.velocity_z + self.jumphite*60/self.mass;
                        else self.velocity_z = self.velocity_z + self.jumphite*35/self.mass;
			self.flags = self.flags - (self.flags & FL_JUMPRELEASED);
			self.teleport_time = time + 2;	// safety net
			return;
		}
	}
};

void() Jetfirethink =
{
	if(pointcontents(self.origin)==CONTENT_SLIME||pointcontents(self.origin)==CONTENT_WATER||self.alivetime<=time)
	{
		self.think=SUB_Remove;
		self.nextthink=time;
	}
	else
	{
		self.think=Jetfirethink;
		self.nextthink=time + 0.5;
	}
};

void(float boost) Jetfire =
{
	makevectors(self.angles);
                        local entity jetfire;
                                jetfire = spawn ();
                                jetfire.owner = self;
                                jetfire.movetype = MOVETYPE_FLYMISSILE;
                                jetfire.solid = SOLID_BBOX;
                                jetfire.classname = "fire";
                                jetfire.effects = 8;
                                jetfire.touch = FlameTouch;
                                jetfire.think = Jetfirethink;
					  jetfire.nextthink=time;
                                jetfire.alivetime = time + 0.5;
                                jetfire.angles='180 0 0';
                                jetfire.avelocity='0 0 40';
                                jetfire.velocity_z = random()* boost + boost*2;
                                setmodel (jetfire, "progs/flame2.mdl");
                                setsize (jetfire, '0 0 0', '0 0 0');
					  setorigin(jetfire,self.origin - '0 0 32');
};

/*
================
PlayerPreThink

Called every frame before physics are run
================
*/
void() PlayerPreThink =
{
	local	float	mspeed, aspeed;
	local	float	r;

	if (intermission_running)
	{
		IntermissionThink ();	// otherwise a button could be missed between
		return;					// the think tics
	}

	if (self.view_ofs == '0 0 0')
		return;		// intermission or finale

        if(self.skin==15&&self.allset)
                if(random()<=0.5&&pointcontents(self.origin)!=CONTENT_SOLID)
                        self.solid=SOLID_NOT;
                else self.solid=SOLID_BBOX;
                        
        if(self.weaponmodel=="progs/hand.mdl")
                if(self.attack_finished>=time + 0.8)
                        self.weaponframe=1;
                else if(self.attack_finished>=time + 0.6)
                        self.weaponframe=2;
                else if(self.attack_finished>=time + 0.4)
                        self.weaponframe=3;
                else if(self.attack_finished>=time + 0.2)
                        self.weaponframe=2;
                else if(self.attack_finished>time + 0.0)
                        self.weaponframe=1;
                else
                {
                self.weaponmodel=self.oldweaponmodel;
                self.weaponframe=0;
                }

      if((self.skin>24 && self.health > 0)||(!self.allset))
   	{
                msg_entity = self;
                WriteByte (MSG_ONE, 10);
                WriteAngle (MSG_ONE, self.o_angle_x);
                WriteAngle (MSG_ONE, self.o_angle_y);
                WriteAngle (MSG_ONE, self.o_angle_z);
                if(self.flags&FL_ONGROUND)
                        self.velocity='0 0 0';
                self.button0=0;
                self.button2=0;
   	}
	makevectors (self.v_angle);		// is this still used

	CheckRules ();
	WaterMove ();
        if((self.healthregen||(self.waterlevel==3&&pointcontents(self.origin)==CONTENT_WATER&&self.racename=="Bossk"))&&time>=self.injury_time + 1&&self.health<self.max_health&&self.health>0)
           {
                if(self.racename=="Borg")
                {        
                        if(self.ammo_cells>0)
                        {
                        self.health=self.health + 1;
                        self.ammo_cells=self.ammo_cells - 0.25;
                        }
                }
                else if(self.racename=="Klingon")
                        self.health=self.health + 0.5;
                else self.health=self.health + 1;
                self.injury_time=time;
           }

        if((self.skin==3||self.oldskin==3)&&time>=self.zap_finished + 1&&self.armorvalue<200&&self.health>0&&self.allset)
           {
                self.armorvalue=self.armorvalue + 1;
                if(self.armorvalue>150)
                        self.armortype = 0.8;
                else if(self.armorvalue>100)
                        self.armortype = 0.6;
                else if(self.armorvalue>50)
                        self.armortype = 0.3;
                else self.armortype=0.1;
                self.zap_finished=time;
           }

        if(self.health>=0&&self.weakheart&&random()<0.2&&random()<0.2&&random()<0.2&&random()<0.2&&random()<0.5&&random()<0.5&&random()<0.5&&random()<0.5)
                {
                self.deathtype="heart";
                self.health=0;
                Killed(self,self,self);
                }
if((self.skin==13||self.oldskin==13||self.classlabel=="Jedi"||self.classlabel=="Dark Jedi")&&self.exp>100000&&self.message_time<time)
    {
    local entity head;
    head = findradius(self.origin,500);
    while(head)
          {
          if(head.classname=="lightsaber"&&head.controller==self&&head.inpain)
                {
                if(self.skin!=13&&self.oldskin!=13)
                        {
                        sound (head, CHAN_AUTO, "weapons/saberhup.wav", 1, ATTN_NORM);
                        sprint(self,"Your lightsaber is near...\n");
                        head.effects=head.effects+EF_MUZZLEFLASH;
                        self.message_time=time + 3;
                        }
               }
          else if(head.alive&&head!=self&&!head.isfeign)
                if(head.classlabel=="Jedi"&&self.skin!=13&&self.oldskin!=13)
                        {
                        sprint(self,"You feel the presence of ");
                        sprint(self,head.netname);
                        sprint(self," here...\n");
                        sound (head, CHAN_AUTO, "misc/talk.wav", 1, ATTN_NORM);
                        self.message_time=time + 3;
                        }
                else if(head.classlabel=="Dark Jedi"&&self.skin!=13&&self.oldskin!=13)
                        {
                        sound (head, CHAN_AUTO, "misc/talk.wav", 1, ATTN_NORM);
                        sprint(self,"The power of the Dark Side is strong here in ");
                        sprint(self,head.netname);
                        sprint(self,"...\n");
                        self.message_time=time + 3;
                        }
                else if(head==self.enemy)
                        {
                        sound (head, CHAN_AUTO, "misc/talk.wav", 1, ATTN_NORM);
                        if(head.classname=="player")
                                sprint(self,head.netname);
                        else sprint(self,head.classname);
                        sprint(self," is near...\n");
                        self.message_time=time + 3;
                        }
                head=head.chain;
           }
    }

if(self.racename=="Predator"&&self.weapon==IT_HOME_LAUNCHER&&self.classlabel!="Assassin")
        LaserSight();

        if(self.bloodloss>0)
                {
                self.deathtype="bleed";
                Bleed();
                }
        if(self.racename=="T-800"||self.racename=="Borg")
                self.exp=0;
	if (self.waterlevel == 2)
		CheckWaterJump ();

	if (self.deadflag >= DEAD_DEAD)
	{
		PlayerDeathThink ();
		return;
	}
	
	if (self.deadflag == DEAD_DYING)
		return;	// dying, so do nothing

	if(self.hover)
		{
			self.angles=self.v_angle;
			makevectors(self.v_angle);
                        if(random()<0.2)
                                        Jetfire(-50);
                        else particle (self.origin,v_up* -100, 242, random()*20);
			if(self.velocity_x>-100 && self.velocity_x<100 && (self.velocity_x>20 || self.velocity_x<-20))
				self.velocity_x=self.velocity_x*1.1;
			if(self.velocity_x>200)
				self.velocity_x=200;
			else if(self.velocity_x<-200)
				self.velocity_x= -200;
			if(self.velocity_y>-100&&self.velocity_y<100&&
(self.velocity_y>20 || self.velocity_y<-20))
				self.velocity_y=self.velocity_y*1.1;
			if(self.velocity_y>200)
				self.velocity_y=200;
			else if(self.velocity_y<-200)
				self.velocity_y= -200;
                  if(time - self.hoverstarttime >= 1)
			{
	                  sound (self, CHAN_AUTO, "weapons/jethover.wav", 0.5 , ATTN_NORM);
				self.ammo_cells= self.ammo_cells - (time - self.hoverstarttime);
				if(self.ammo_cells<0)
					self.ammo_cells=0;
				self.hoverstarttime = time;
			}
			if(self.ammo_cells<=0)
				self.hover=FALSE;
		}

	if (self.button2)
	{
              if(self.ghook_extended&&(self.items2&IT_GHOOK))
                if(self.ghook_dropped||!self.ghook_attached)
                        return;// pull enemy or retract ghook
                else if(self.util==IT_GHOOK&&!self.small&&self.ghook_attached&&!self.ghook_dropped)
                {
                        PullMeUp();
                        return;
                }

                if(self.climbing)
                        Climb();
                else if(self.hover)
		    {
                                Jetfire(-100);
                                Jetfire(-100);
                                Jetfire(-100);
				if(self.jetsound_finished)
				{
		                  sound (self, CHAN_AUTO, "weapons/jeton.wav", 1 , ATTN_NORM);
					self.jetsound_finished=FALSE;
				}
				else sound (self, CHAN_AUTO, "weapons/jethover.wav", 1 , ATTN_NORM);
				self.hoverlevel=self.hoverlevel + 10;
				if(self.hoverlevel>60)
					self.hoverlevel=60;
				self.velocity_z = self.velocity_z + 100;
				if(self.velocity_z>3000)
					self.velocity_z = 3000;
		    }
		    else
				PlayerJump();
	}
	else
	{	
//                if(self.items2&IT_GHOOK&&self.ghook_attached&&self.ghook_extended&&(!self.flags&FL_ONGROUND))
                if(self.dangle&&self.ghook_holdon)
                {
                        if(vlen(self.wallspot-self.origin)>100)
                                r=100;
                        else r=10;
//                        self.velocity='0 0 0';
                        self.velocity = (self.velocity+normalize(self.wallspot - self.origin)*r)*0.5;
                }
		if (self.hover&&self.velocity_z<self.hoverlevel)
		{
			self.jetsound_finished=TRUE;
			self.velocity_z = self.hoverlevel;
		}
		self.flags = self.flags | FL_JUMPRELEASED;
	}

// teleporters can force a non-moving pause time	
        if (time < self.pausetime || self.allset==FALSE)
		self.velocity = '0 0 0';
};
	
/*
================
CheckPowerups

Check for turning off powerups
================
*/
void() CheckPowerups =
{
	if (self.health <= 0)
		return;

// TeleEyes or HoloCam
        if (self.aflag == 666)
                if (self.invisible_sound < time)
		{
			sound (self, CHAN_AUTO, "items/inv3.wav", 0.5, ATTN_IDLE);
			self.invisible_sound = time + ((random() * 3) + 1);
                        stuffcmd (self, "bf\n");
                }

// invisibility
        if (self.invisible_finished)
	{
// sound and screen flash when items starts to run out
                if (self.invisible_sound < time)
		{
                        if(self.racename=="Predator")
                        {
                        if(random()<0.5)
                                sound (self, CHAN_AUTO, "predator/invis.wav", 1, ATTN_NORM);
                        else sound (self, CHAN_AUTO, "predator/invis2.wav", 1, ATTN_NORM);
                        self.invisible_sound = time + ((random() * 5) + 5);
                        }
                        else
                        {
			sound (self, CHAN_AUTO, "items/inv3.wav", 0.5, ATTN_IDLE);
			self.invisible_sound = time + ((random() * 3) + 1);
                        }
		}


                if (self.invisible_finished < time + 3)
		{
			if (self.invisible_time == 1)
			{
                                if(self.racename!="Predator")
                                        {
                                        sprint (self, "Ring of Shadows magic is fading\n");
                                        sound (self, CHAN_AUTO, "items/inv1.wav", 1, ATTN_NORM);
//                                        sound (self, CHAN_AUTO, "items/inv2.wav", 1, ATTN_NORM);
                                        }
				stuffcmd (self, "bf\n");
				self.invisible_time = time + 1;
			}
			
			if (self.invisible_time < time)
			{
				self.invisible_time = time + 1;
				stuffcmd (self, "bf\n");
			}
		}

		if (self.invisible_finished < time)
		{	// just stopped
                        if(self.racename=="Predator")
                                sound (self, CHAN_AUTO, "predator/cloak2.wav", 1, ATTN_NORM);
			self.items = self.items - IT_INVISIBILITY;
			self.invisible_finished = 0;
			self.invisible_time = 0;
		}
		
	// use the eyes
if(self.waterlevel!=0&&self.racename=="Predator"&&self.invisible_finished < time + 59&&self.invisible_finished>time)
        {
        if(self.cloakzap>10)
                PredCloakMalFunc();
        else if(random()<0.2)
                if(random()<0.5)
                        {
                        if(self.modelindex==modelindex_eyes)
                                Spritz("off");
                        else if(self.modelindex==modelindex_player)                
                                Spritz("on");
                        }
                 else if(random()<0.2)
                        if(random()<0.2)
                                        PredCloakMalFunc();
        }
        else
        {
		self.frame = 0;
		self.modelindex = modelindex_eyes;
        }
     }
	else
                {
                self.cloakzap = 0;
		self.modelindex = modelindex_player;	// don't use eyes
                }
// Dog Mode
        if (self.dog_finished)
	{
// sound and screen flash when items starts to run out
                if (self.dog_finished < time + 3)
		{
                        if (self.dog_time == 1)
			{
                                sprint (self, "You feel yourself reverting to humanness.\n");
				stuffcmd (self, "bf\n");
				sound (self, CHAN_AUTO, "items/protect2.wav", 1, ATTN_NORM);
                                self.dog_time = time + 1;
			}
			
                        if (self.dog_time < time)
			{
                                self.dog_time = time + 1;
				stuffcmd (self, "bf\n");
			}
		}
		
                if (self.dog_finished < time)
		{	// just stopped
                // FIEND -- Turn into a person
                self.modelindex = modelindex_player;
                sound (self, CHAN_VOICE, "dog/ddeath.wav", 1, ATTN_NORM);
                W_SetCurrentAmmo();
                self.view_ofs = '0 0 22';
                DogChange(self);
                self.dog_time = 0;                
                self.dog_finished = 0;
                self.touch = PlayerTouch;
                }
                self.modelindex = modelindex_dog;
	}
// invincibility
	if (self.invincible_finished)
	{
// sound and screen flash when items starts to run out
		if (self.invincible_finished < time + 3)
		{
			if (self.invincible_time == 1)
			{
				sprint (self, "Protection is almost burned out\n");
				stuffcmd (self, "bf\n");
				sound (self, CHAN_AUTO, "items/protect2.wav", 1, ATTN_NORM);
				self.invincible_time = time + 1;
			}
			
			if (self.invincible_time < time)
			{
				self.invincible_time = time + 1;
				stuffcmd (self, "bf\n");
			}
		}
		
		if (self.invincible_finished < time)
		{	// just stopped
			self.items = self.items - IT_INVULNERABILITY;
			self.invincible_time = 0;
			self.invincible_finished = 0;
		}
		if (self.invincible_finished > time)
			self.effects = self.effects | EF_DIMLIGHT;
		else
			self.effects = self.effects - (self.effects & EF_DIMLIGHT);
	}

// super damage
	if (self.super_damage_finished)
	{

// sound and screen flash when items starts to run out

		if (self.super_damage_finished < time + 3)
		{
			if (self.super_time == 1)
			{
				sprint (self, "Quad Damage is wearing off\n");
				stuffcmd (self, "bf\n");
				sound (self, CHAN_AUTO, "items/damage2.wav", 1, ATTN_NORM);
				self.super_time = time + 1;
			}	  
			
			if (self.super_time < time)
			{
				self.super_time = time + 1;
				stuffcmd (self, "bf\n");
			}
		}

		if (self.super_damage_finished < time)
		{	// just stopped
			self.items = self.items - IT_QUAD;
			self.super_damage_finished = 0;
			self.super_time = 0;
		}
		if (self.super_damage_finished > time)
			self.effects = self.effects | EF_DIMLIGHT;
		else
			self.effects = self.effects - (self.effects & EF_DIMLIGHT);
	}	

// suit	
	if (self.radsuit_finished)
	{
                if (self.racename=="Bossk")
                {
                      if(self.air_finished<time+300)
                             self.air_finished = time + 300;
                }
                else if (self.racename=="TigerMan")
                {
                      if(self.air_finished<time+6)
                             self.air_finished = time + 6;
                }
                else
                      if(self.air_finished<time+12)
                             self.air_finished = time + 12;          // don't drown

// sound and screen flash when items starts to run out
		if (self.radsuit_finished < time + 3)
		{
			if (self.rad_time == 1)
			{
				sprint (self, "Air supply in Biosuit expiring\n");
				stuffcmd (self, "bf\n");
//                                sound (self, CHAN_AUTO, "items/suit2.wav", 1, ATTN_NORM);
                                sound (self, CHAN_AUTO, "items/suit.wav", 1, ATTN_NORM);
				self.rad_time = time + 1;
			}
			
			if (self.rad_time < time)
			{
				self.rad_time = time + 1;
				stuffcmd (self, "bf\n");
			}
		}

		if (self.radsuit_finished < time)
		{	// just stopped
			self.items = self.items - IT_SUIT;
			self.rad_time = 0;
			self.radsuit_finished = 0;
                        self.skin = self.oldskin;
		}
	}	
// Shrink
        if(self.shrink_time>time&&!self.small)
        {
                self.th_pain=SUB_Null;
                DropMelee(self);
                if(self.ducking)
                        Duck();
                self.velocity_z = 200;
                if(self.flags&FL_ONGROUND)
                        self.flags=self.flags-FL_ONGROUND;
                player_shrink1();
                sound (self, CHAN_AUTO, "weapons/shrink.wav", 1, ATTN_NORM);
                self.view_ofs = '0 0 2';//too low?
                self.small=TRUE;
                self.mass=self.mass* 0.1;
                self.jumphite=self.jumphite*0.1;
                if(self.volume==0)
                        self.volume= -0.75;
                self.speed=self.speed*10;
                self.max_health=self.max_health* 0.25;
                self.impulse=0;
                self.th_pain=player_spain;
	}
        else if(self.shrink_time<=time&&self.small)
        {
//                self.modelindex = modelindex_player;
                sound (self, CHAN_AUTO, "weapons/grow.wav", 1, ATTN_NORM);
                player_grow1();
                self.view_ofs = '0 0 22';
                self.small=FALSE;
                self.shrink_time=0;
                self.mass=self.mass*10;
                if(self.volume==-0.75)
                        self.volume= 0;
                self.speed=self.speed*0.1;
                self.jumphite=self.jumphite*10;
                self.max_health=self.max_health*4;
                self.th_pain=player_pain;
        }
};


/*
================
PlayerPostThink

Called every frame after physics are run
================
*/
void() PlayerPostThink =
{
	local	float	mspeed, aspeed;
	local	float	r;

	if (self.view_ofs == '0 0 0')
		return;		// intermission or finale
	if (self.deadflag)
		return;
		
// do weapon stuff

	W_WeaponFrame ();

#ifdef JAWORSKI
        if((self.skin==1||self.oldskin==1)&&self.zap_finished<=time)
                if(random()<0.2&&random()<0.2&&random()<0.2&&random()<0.2&&random()<0.2)
                        {
                        if(random()<0.5)
                                sound (self, CHAN_VOICE, "jaworski/piss.wav", 1, ATTN_NORM);
                        else sound (self, CHAN_VOICE, "jaworski/terlet.wav", 1, ATTN_NORM);
                        self.zap_finished=time+1;
                        }
#endif
// check to see if player landed and play landing sound
if(self.flags & FL_ONGROUND&&self.classlabel!="Jedi"&&self.classlabel!="Dark Jedi")
{
self.jumpin=FALSE;
self.scream=FALSE;
        if (self.jump_flag < -100&&self.health > 9&&self.jump_flag<(0 - self.jumphite*54/self.mass))
	{
                if(self.racename=="T-800"||self.racename=="Borg"||self.skin==16||self.oldskin==16)
                        self.jump_flag=self.jump_flag*0.5;
//                if (self.watertype == CONTENT_WATER)
                if(self.ducking>=time)
                        self.jump_flag=self.jump_flag+(random()*150+100);
                if (self.waterlevel > 2)
			sound (self, CHAN_BODY, "player/h2ojump.wav", 1, ATTN_NORM);
                else if (self.jump_flag<-600&&self.racename!="TigerMan")
		{
                        if(skill>1)
                        {
			self.deathtype = "falling";
                        T_Damage (self, world, world,0-((self.jump_flag/4 + 75)*self.mass)); //do minimum 25 damage, multiplied by your mass
                        }
#ifdef JAWORSKI
                        if(self.skin==1||self.oldskin==1)
                        {
                                if(random()<0.5)
                                        sound (self, CHAN_VOICE, "jaworski/ow-ooo.wav", 1, ATTN_NORM);
                                else sound (self, CHAN_VOICE, "jaworski/oo-uh.wav", 1, ATTN_NORM);
                        }
                        else 
#endif
				if (self.skin==12||self.skin==16||self.oldskin==12||self.oldskin==16)
                                sound (self, CHAN_VOICE, "xena/land2.wav", 1, ATTN_NORM);
                        else sound (self, CHAN_VOICE, "player/land2.wav",self.volume + 1, ATTN_NORM);
                }
                else if (self.jump_flag<-400&&self.racename!="TigerMan")
                        {
                        if(skill>1)
                        {
			self.deathtype = "falling";
                        T_Damage (self, world, world,0-((self.jump_flag/10 + 25)*self.mass)); //do minimum 5 damage, multiplied by your mass
                        }
#ifdef JAWORSKI
                        if(self.skin==1||self.oldskin==1)
                                sound (self, CHAN_VOICE, "jaworski/land.wav", 1, ATTN_NORM);
                        else 
#endif
				if (self.skin==12||self.skin==16||self.oldskin==12||self.oldskin==16)
                                sound (self, CHAN_VOICE, "xena/land.wav", 1, ATTN_NORM);
                        else sound (self, CHAN_VOICE, "player/land.wav",self.volume + 1, ATTN_NORM);
                        }
                else if (self.jump_flag<-150)
                        sound (self, CHAN_BODY, "weapons/stepstop.wav",self.volume + 1, ATTN_NORM);
		self.jump_flag = 0;
	}
}
        if (!(self.flags & FL_ONGROUND) && self.levitime < time&&self.featherfall!=TRUE&&self.climbing==FALSE&&self.dangle==FALSE&&self.hover==FALSE)
        {
                if(LongFall()&&!self.scream&&self.waterlevel==0&&(self.velocity_z<(0 - self.jumphite*54/self.mass))&&skill>=2)
                {
                        self.scream=TRUE;
                        if(self.skin==12||self.oldskin==12||self.skin==16||self.oldskin==16)
                                sound(self,CHAN_VOICE,"xena/femdie.wav",1,ATTN_NONE);
                        else
                                sound(self,CHAN_VOICE,"weapons/scream.wav",1,ATTN_NONE);
                }
                self.velocity_z = self.velocity_z - 3; //simulated gravity
                if (self.velocity_z < -1000)
                        self.velocity_z = -1000; // terminal velocity
                self.jump_flag = self.velocity_z;// damage when hit
                if(self.jump_flag<(0 - self.jumphite*54/self.mass)&&self.ammo_cells>0&&(self.items&IT_JETPACK)&&(!self.hover)&&self.autojet)
                {
                        sound (self, CHAN_AUTO, "weapons/jeton.wav", 1 , ATTN_NORM);
			self.hoverlevel=60;
			self.hover=TRUE;
			self.velocity_z=self.velocity_z + 100;
			self.hoverstarttime=time;
                }
        }
        if(self.climbing==TRUE)
                {
//                Trying to adjust view and angles when on wall or cieling
//                self.angles=self.v_angle=self.v_angle+'90 0 0';
//                self.fixangle=1;
//                self.flags=self.flags+FL_ONGROUND;
                self.velocity='0 0 0';
                self.velocity = normalize(self.wallspot - self.origin)*500;
                }

	CheckPowerups ();
};


/*
===========
ClientConnect

called when a player connects to a server
============
*/
void() ClientConnect =
{
//        sprint(self,"Welcome to Ultimate Quake, version 1.032\n");
//        sprint(self,"Choose your Race and Class...\n");

	bprint (self.netname);
	bprint (" entered the game\n");
	
// a client connecting during an intermission can cause problems
	if (intermission_running)
		ExitIntermission ();
};


/*
===========
ClientDisconnect

called when a player disconnects from a server
============
*/
void() ClientDisconnect =
{
	if (gameover)
		return;
	// if the level end trigger has been activated, just return
	// since they aren't *really* leaving

	// let everyone else know
	bprint (self.netname);
	bprint (" left the game with ");
	bprint (ftos(self.frags));
	bprint (" frags\n");
	sound (self, CHAN_BODY, "player/tornoff2.wav", 1, ATTN_NONE);
	set_suicide_frame ();
};

/*
===========
ClientObituary

called when a player dies
============
*/
void(entity targ, entity attacker) ClientObituary =
{
	local	float rnum;
	local	string deathstring, deathstring2;
        local   entity killer;
	  if (attacker.classname == "player")
        	killer=attacker;
        else if(attacker.charmed)
                killer=attacker.controller;
        else killer=attacker;

	rnum = random();
                if (killer.classname == "teledeath")
		{
			bprint (targ.netname);
			bprint (" was telefragged by ");
                        bprint (killer.owner.netname);
                        bprint ("!\n");

                        killer.owner.frags = killer.owner.frags + 1;
			return;
		}

                if (killer.classname == "teledeath2")
		{
			bprint ("Satan's power deflects ");
			bprint (targ.netname);
                        bprint ("'s telefrag!\n");

			targ.frags = targ.frags - 1;
			return;
		}

                if (killer.classname == "player"||killer.charmed)
                {
                        if (targ == killer)
                        {
                                // killer self
                                  killer.frags = killer.frags - 1;
                                  bprint (targ.netname);
				
                                  if (targ.deathtype=="heart")
                                  {
                                          bprint (" had a heart attack!\n");
                                          return;
                                  }
                                  else if (targ.deathtype=="growsquish")
                                  {
                                          bprint (" got too big for his britches!\n");
                                          return;
                                  }
                                  else if (targ.onfire)
                                  {
                                        bprint (" was burnt to a crisp!\n");
                                        return;
                                  }

                                  if (targ.weapon == 64)
                                  {
                                          if (targ.waterlevel > 1)
                                          {
                                                bprint (" discharges into the water.\n");
                                                return;
                                          }
                                   }
                                   if (targ.weapon > 15 && targ.weapon < 32)
                                        bprint (" tries to put the pin back in!\n");
                                   else if (rnum>0.4)
                                        bprint (" becomes bored with life!\n");
                                   else
                                        bprint (" checks if his weapon is loaded!\n");
                                   return;
                        }
                        else
                        {
                                if(killer.dishonor)
                                       killer.frags = killer.frags - 1;
                                else killer.frags = killer.frags + 1;

                                rnum = killer.weapon;
                                if(targ.small)
                                {
                                        deathstring = " was squished by ";
                                        deathstring2 = " the giant!\n";
                                }
                                else if(targ.deathtype=="charmed")
                                {
                                        deathstring = " was murdered by ";
                                        deathstring2 = "'s monster!\n";
                                }
                                else if(targ.deathtype=="spell")
                                {
                                        deathstring = " was slain by ";
                                        deathstring2 = "'s magic!\n";
                                }
                                else if(targ.deathtype=="sentinel")
                                {
                                        deathstring = " was tracked down by ";
                                        deathstring2 = "'s sentinel!\n";
                                }
                                else if(targ.deathtype=="tripmine")
                                {
                                        deathstring = " tripped up on ";
                                        deathstring2 = "'s tripmine!\n";
                                }
                                else if(targ.deathtype=="betty")
                                {
                                        deathstring = " bounced on ";
                                        deathstring2 = "'s betty!\n";
                                }
                                else if(targ.deathtype=="lightsaber")
                                {
                                        deathstring = " was cut to pieces by ";
                                        deathstring2 = "'s lightsaber!\n";
                                }
                                else if(targ.deathtype=="chakram")
                                {
                                        deathstring = " was whacked by ";
                                        deathstring2 = "'s chakram!\n";
                                }
                                else if(targ.deathtype=="disc")
                                {
                                        deathstring = " was sliced and diced by ";
                                        deathstring2 = "'s disc!\n";
                                }
                                else if(targ.deathtype=="homerocket"||targ.deathtype=="homespread")
                                {
                                        deathstring = " was sought and destroyed by ";
                                        deathstring2 = "'s rocket!\n";
                                }
                                else if(targ.deathtype=="plasmabolt")
                                {
                                        deathstring = " was jacked up by ";
                                        deathstring2 = "'s plasmabolt!\n";
                                }
                                else if(targ.deathtype=="zap")
                                {
                                        deathstring = " was electrocuted by ";
                                        deathstring2 = "!\n";
                                }
                                else if (rnum == IT_AXE)
				{
                                        deathstring = " was hacked to bits by ";
                                        deathstring2 = "!\n";
				}
                                else if (rnum == IT_SHOTGUN)
				{
					deathstring = " chewed on ";
                                        deathstring2 = "'s boomstick!\n";
				}
                                else if (rnum == IT_FLAMETHROWER||rnum == IT_FIREBALLGUN)
				{
                                        deathstring = " was toasted and roasted by ";
                                        deathstring2 = "!\n";
				}
                                else if (rnum == IT_SNIPERGUN)
				{
                                        deathstring = " was sniped by ";
                                        deathstring2 = "!\n";
				}
                                else if (rnum == IT_SUPER_SHOTGUN)
                                {
					deathstring = " ate 2 loads of ";
                                        deathstring2 = "'s buckshot!\n";
				}
                                else if (rnum == IT_NAILGUN)
				{
					deathstring = " was nailed by ";
                                        deathstring2 = "!\n";
				}
                                else if (rnum == IT_SUPER_NAILGUN)
				{
					deathstring = " was punctured by ";
                                        deathstring2 = "!\n";
				}
                                else if (rnum > 15 && rnum < 32)
				{
					deathstring = " eats ";
                                        deathstring2 = "'s pineapple!\n";
					if (targ.health < -40)
					{
						deathstring = " was gibbed by ";
                                                deathstring2 = "'s grenade!\n";
					}
				}
                                else if (rnum > 31 && rnum < 64)
				{
					deathstring = " rides ";
                                        deathstring2 = "'s rocket!\n";
					if (targ.health < -40)
					{
						deathstring = " was gibbed by ";
                                                deathstring2 = "'s rocket!\n" ;
					}
				}
                                else if (rnum == IT_LIGHTNING)
				{
					deathstring = " accepts ";
                                        if (killer.waterlevel > 1)
                                                deathstring2 = "'s discharge!\n";
					else
                                                deathstring2 = "'s shaft!\n";
				}
                                else if (rnum == IT_LASERGUN)
				{
                                        deathstring = " got zapped by ";
                                        deathstring2 = "!\n";
				}

				bprint (targ.netname);
				bprint (deathstring);
                                bprint (killer.netname);
				bprint (deathstring2);
			}
			return;
		}
		else
		{
                        targ.frags = targ.frags - 1;  // killer self
			rnum = targ.watertype;

			bprint (targ.netname);
                        if (rnum == -3||targ.deathtype=="drown")
			{
				if (random() < 0.5)
                                        bprint (" sleeps with the fishes!\n");
				else
                                        bprint (" sucks it down!\n");
				return;
			}
                        else if (rnum == -4&&targ.slimeresist!=TRUE)
			{
				if (random() < 0.5)
                                        bprint (" gulped a load of slime!\n");
				else
                                        bprint (" can't exist on slime alone!\n");
				return;
			}
                        else if (rnum == -5&&targ.firesistime<=time&&targ.fireresist!=1&&targ.racename!="Draconian")
			{
				if (targ.health < -15)
				{
                                        bprint (" burst into flames!\n");
					return;
				}
				if (random() < 0.5)
                                        bprint (" turned into hot slag!\n");
				else
                                        bprint (" visits the Volcano God!\n");
				return;
			}

                        if (killer.flags & FL_MONSTER)
			{
                                if (killer.classname == "Borg")
                                        bprint (" was assimilated by the Borg!\n");
                                if (killer.classname == "grunt")//"monster_army")
                                        bprint (" was shot by a Grunt!\n");
                                if (killer.classname == "fiend")//"monster_demon1")
                                        bprint (" was eviscerated by a Fiend!\n");
                                if (killer.classname == "rottweiler")//"monster_dog")
                                        bprint (" was mauled by a Rottweiler!\n");
                                if (killer.classname == "enforcer")//"monster_enforcer")
                                        bprint (" was blasted by an Enforcer!\n");
                                if (killer.classname == "rotfish")//"monster_fish")
                                        bprint (" was fed to the Rotfish!\n");
                                if (killer.classname == "hell knight")//"monster_hell_knight")
                                        bprint (" was slain by a Death Knight!\n");
                                if (killer.classname == "knight")//"monster_knight")
                                        bprint (" was slashed by a Knight!\n");
                                if (killer.classname == "ogre")//"monster_ogre")
                                        bprint (" was destroyed by an Ogre!\n");
                                if (killer.classname == "monster_oldone")
                                        bprint (" became one with Shub-Niggurath!\n");
                                if (killer.classname == "vore")//"monster_shalrath")
                                        bprint (" was obliterated by a Vore!\n");
                                if (killer.classname == "shambler")//"monster_shambler")
                                        bprint (" was executed by a Shambler!\n");
                                if (killer.classname == "spawn")//"monster_tarbaby")
                                        bprint (" was blown to bits by a Spawn!\n");
//                                if (killer.classname == "vomitus")//"monster_vomit")
//                                        bprint (" was vomited on by a Vomitus\n");
                                if (killer.classname == "scrag")//"monster_wizard")
                                        bprint (" was fragged by a Scrag!\n");
                                if (killer.classname == "zombie")//"monster_zombie")
                                        bprint (" joins the Zombies!\n");

				return;
			}
                        if (killer.classname == "explo_box")
			{
                                bprint (" was blown to smithereens!\n");
				return;
			}
                        if (killer.solid == SOLID_BSP && killer != world)
			{	
                                bprint (" was squished!\n");
				return;
			}
			if (targ.deathtype == "falling")
			{
                                targ.deathtype = "";
                                if(self.skin==12||self.skin==16||self.oldskin==12||self.oldskin==16)
                                        bprint (" fell to her death!\n");
                                else bprint (" fell to his death!\n");
				return;
			}
                        if(targ.deathtype == "bleed")
			{
                                targ.deathtype = "";
                                bprint (" bled to death!\n");
				return;
			}
                        if (killer.classname == "trap_shooter" || killer.classname == "trap_spikeshooter")
			{
                                bprint (" was spiked!\n");
				return;
			}
                        if (killer.classname == "fireball")
			{
                                bprint (" ate a lavaball!\n");
				return;
			}
                        if (killer.classname == "trigger_changelevel")
			{
                                bprint (" tried to leave!\n");
				return;
			}

                        bprint (" died!\n");
		}
};


/*
==============================================================================

PLAYER

==============================================================================
*/

$cd /raid/quake/id1/models/player_4
$origin 0 -6 24
$base base		
$skin skin

//
// running
//
$frame axrun1 axrun2 axrun3 axrun4 axrun5 axrun6

$frame rockrun1 rockrun2 rockrun3 rockrun4 rockrun5 rockrun6

//
// standing
//
$frame stand1 stand2 stand3 stand4 stand5

$frame axstnd1 axstnd2 axstnd3 axstnd4 axstnd5 axstnd6
$frame axstnd7 axstnd8 axstnd9 axstnd10 axstnd11 axstnd12


//
// pain
//
$frame axpain1 axpain2 axpain3 axpain4 axpain5 axpain6

$frame pain1 pain2 pain3 pain4 pain5 pain6


//
// death
//

$frame axdeth1 axdeth2 axdeth3 axdeth4 axdeth5 axdeth6
$frame axdeth7 axdeth8 axdeth9

$frame deatha1 deatha2 deatha3 deatha4 deatha5 deatha6 deatha7 deatha8
$frame deatha9 deatha10 deatha11

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11 deathc12 deathc13 deathc14 deathc15

$frame deathd1 deathd2 deathd3 deathd4 deathd5 deathd6 deathd7
$frame deathd8 deathd9

$frame deathe1 deathe2 deathe3 deathe4 deathe5 deathe6 deathe7
$frame deathe8 deathe9

//
// attacks
//
$frame nailatt1 nailatt2

$frame light1 light2

$frame rockatt1 rockatt2 rockatt3 rockatt4 rockatt5 rockatt6

$frame shotatt1 shotatt2 shotatt3 shotatt4 shotatt5 shotatt6

$frame axatt1 axatt2 axatt3 axatt4 axatt5 axatt6

$frame axattb1 axattb2 axattb3 axattb4 axattb5 axattb6

$frame axattc1 axattc2 axattc3 axattc4 axattc5 axattc6

$frame axattd1 axattd2 axattd3 axattd4 axattd5 axattd6


/*
===============================
DOG PLAYER
===============================
*/
void() dog_bite;

void() PlayerDead =
{
        damage_attacker = self.enemy;
	self.nextthink = -1;
// allow respawn after a certain time
       	self.deadflag = DEAD_DEAD;
};

void() play_dog_atta1        =[      $axrun1,       play_dog_atta2       ] {};
void() play_dog_atta2        =[      $axrun2,       play_dog_atta3       ] {};
void() play_dog_atta3        =[      $axrun3,       play_dog_atta4       ] {};
void() play_dog_atta4        =[      $axrun4,       play_dog_atta5       ] {
sound (self, CHAN_VOICE, "dog/dattack1.wav", 1, ATTN_NORM);
dog_bite();};
void() play_dog_atta5        =[      $axrun5,       play_dog_atta6       ] {};
void() play_dog_atta6        =[      $axrun6,       play_dog_atta7       ] {};
void() play_dog_atta7        =[      $rockrun1,       play_dog_atta8       ] {};
void() play_dog_atta8        =[      $rockrun2,       player_run        ] {};

void() play_dog_leap1        =[      $deatha11,         play_dog_leap2       ] {ai_face();};
void() play_dog_leap2        =[      $deathb1,         play_dog_leap3       ]
{
        if (self.walkframe >= 12)
                self.walkframe = 1;
        self.frame = $axdeth8 + self.walkframe;
        self.walkframe = self.walkframe + 1;

        self.touch = Dog_JumpTouch;
	makevectors (self.angles);
	self.origin_z = self.origin_z + 1;
	self.velocity = v_forward * 300 + '0 0 200';
	if (self.flags & FL_ONGROUND)
		self.flags = self.flags - FL_ONGROUND;
};
void() play_dog_leap3        =[      $deathb2,         play_dog_leap4       ] {};
void() play_dog_leap4        =[      $deathb3,         play_dog_leap5       ] {};
void() play_dog_leap5        =[      $deathb4,         play_dog_leap6       ] {};
void() play_dog_leap6        =[      $deathb5,         play_dog_leap7       ] {};
void() play_dog_leap7        =[      $deathb6,         play_dog_leap8       ] {};
void() play_dog_leap8        =[      $deathb7,         play_dog_leap9       ] {};
void() play_dog_leap9        =[      $deathb8,         play_dog_leap9       ] {};

void()  play_dog_pain =  [       $axpain4, play_dog_pain    ]
{
        sound (self, CHAN_VOICE, "dog/dpain1.wav", 1, ATTN_NORM);
        self.walkframe = 1;
        self.weaponframe = 0;
        self.frame = $axpain4;
};

void()  play_dog_pain1 =  [      $axpain4, play_dog_pain1    ]
{        
        if (self.walkframe >=14)
                player_stand1();
        if (self.walkframe < 6)
                self.frame = $axpain4 + self.walkframe;
        else self.frame = $axpain4 + (14 - self.walkframe);
        self.walkframe = self.walkframe + 1;
};

void() play_dog_die1         =[      $rockrun3,        play_dog_die2        ] {};
void() play_dog_die2         =[      $rockrun4,        play_dog_die3        ] {};
void() play_dog_die3         =[      $rockrun5,        play_dog_die4        ] {};
void() play_dog_die4         =[      $rockrun6,        play_dog_die5        ] {};
void() play_dog_die5         =[      $stand1,        play_dog_die6        ] {};
void() play_dog_die6         =[      $stand2,        play_dog_die7        ] {};
void() play_dog_die7         =[      $stand3,        play_dog_die8        ] {};
void() play_dog_die8         =[      $stand4,        play_dog_die9        ] {};
void() play_dog_die9         =[      $stand5,        play_dog_die9        ] {PlayerDead();};

void() play_dog_dieb1                =[      $axstnd1,       play_dog_dieb2       ] {};
void() play_dog_dieb2                =[      $axstnd2,       play_dog_dieb3       ] {};
void() play_dog_dieb3                =[      $axstnd3,       play_dog_dieb4       ] {};
void() play_dog_dieb4                =[      $axstnd4,       play_dog_dieb5       ] {};
void() play_dog_dieb5                =[      $axstnd5,       play_dog_dieb6       ] {};
void() play_dog_dieb6                =[      $axstnd6,       play_dog_dieb7       ] {};
void() play_dog_dieb7                =[      $axstnd7,       play_dog_dieb8       ] {};
void() play_dog_dieb8                =[      $axstnd8,       play_dog_dieb9       ] {};
void() play_dog_dieb9                =[      $axstnd9,       play_dog_dieb9       ] {PlayerDead();};

/*
==============================================================================
PLAYER
==============================================================================
*/


void() player_run;
void()  player_duck1  =       [       $deathd2,       player_duck2  ] {};
void()  player_duck2  =       [       $deathd3,       player_duck3  ] {};
void()  player_duck3  =       [       $deathd4,       player_duck4  ] {};
void()  player_duck4  =       [       $deathd5,       player_duck5  ] {};
void()  player_duck5  =       [       $deathd6,       player_duck6  ] {};
void()  player_duck6  =       [       $deathd7,       player_duck7  ] {};
void()  player_duck7  =       [       $deatha7,       player_duck8  ] {};
void()  player_duck8  =       [       $deatha8,       player_stand1  ] {};
void()	player_stand1 =[	$axstnd1,	player_stand1	]
{
	self.weaponframe=0;

        if (self.velocity_x || self.velocity_y)
	{
                        self.walkframe=0;
                        player_run();
                        return;
	}
        if (self.dog_time)
        {
        // We are a dog
                self.view_ofs = '0 0 4';
                if (self.walkframe >= 9)
                        self.walkframe = 0;
                self.frame = $deathb9 + self.walkframe;
                if (random() < 0.1)
                        sound (self, CHAN_VOICE, "dog/idle.wav", 1, ATTN_IDLE);
        }
        else if (self.ducking)
                self.frame = $deatha8;
        else if (self.weapon == IT_AXE)
	{
		if (self.walkframe >= 12)
			self.walkframe = 0;
		self.frame = $axstnd1 + self.walkframe;
	}
	else
	{
		if (self.walkframe >= 5)
			self.walkframe = 0;
		self.frame = $stand1 + self.walkframe;
	}
	self.walkframe = self.walkframe + 1;	
};

void()	player_run =[	$rockrun1,	player_run	]
{
local float rstep;

	self.weaponframe=0;

        if (!self.velocity_x && !self.velocity_y)
	{
		self.walkframe=0;
                if (self.stepping && !self.ducking && self.running > 3)
                        if (random() > 0.2)
                                sound (self, CHAN_VOICE, "weapons/stepstop.wav", 1, ATTN_NORM);
                self.stepping == FALSE;
                player_stand1();
		return;
	}

        if(self.dog_time)
        {
                //We are a dog
                self.view_ofs = '0 0 4';
                if (self.walkframe >= 12)
                        self.walkframe = 0;
                self.frame = $axdeth8 + self.walkframe;
                if (random() < 0.1)
                        sound (self, CHAN_VOICE, "dog/dsight.wav", 1, ATTN_IDLE);
        }
        else if (self.ducking)
        {
                if (self.walkframe == 2)
			self.walkframe = 0;
                self.frame = $deatha7 + self.walkframe;
                self.velocity_x = self.velocity_x/3;
                self.velocity_y = self.velocity_y/3;
        }
        else if (self.weapon == IT_AXE)
	{
		if (self.walkframe == 6)
			self.walkframe = 0;
		self.frame = $axrun1 + self.walkframe;
	}
	else
	{
		if (self.walkframe == 6)
			self.walkframe = 0;
		self.frame = self.frame + self.walkframe;

	}
        self.velocity_x = self.velocity_x/self.mass;
        self.velocity_y = self.velocity_y/self.mass;

/*
MOD
Footsteps v0.6
by Brett "Vuh" Wagner and Mike G
brettw@compumedia.com
comments welcome
MOD
*/
        if (self.velocity_y > 60 || self.velocity_y < -60)
                self.running = self.running + 1;
        else self.running = 0;

        if ((self.walkframe == 1 || self.walkframe == 4 ) && (self.ducking == FALSE))
                if (checkbottom(self) == TRUE)
                        if (self.waterlevel == 0)
                        if (self.velocity_x > 60 || self.velocity_x < -60 || self.running)
                        {
                        rstep = random () * 10;
                        if (rstep >= 8)
                              sound (self, CHAN_WEAPON, "weapons/step1.wav", 1, ATTN_NORM);
                        else if (rstep >= 6)
                              sound (self, CHAN_WEAPON, "weapons/step2.wav", 1, ATTN_NORM);
                        else if (rstep >= 4)
                              sound (self, CHAN_WEAPON, "weapons/step3.wav", 1, ATTN_NORM);
                        else if (rstep >= 3)
                              sound (self, CHAN_WEAPON, "weapons/step4.wav", 1, ATTN_NORM);
                        else if (rstep >= 2)
                              sound (self, CHAN_WEAPON, "weapons/step5.wav", 1, ATTN_NORM);
                        else if (rstep >= 1)
                              sound (self, CHAN_WEAPON, "weapons/step6.wav", 1, ATTN_NORM);
                        self.stepping = TRUE;
                        }
/*
END MOD
Footsteps v0.6
END MOD
*/

	self.walkframe = self.walkframe + 1;
};


void()	player_shot1 =	[$shotatt1, player_shot2	] {self.weaponframe=1;
self.effects = self.effects | EF_MUZZLEFLASH;};
void()	player_shot2 =	[$shotatt2, player_shot3	] {self.weaponframe=2;};
void()	player_shot3 =	[$shotatt3, player_shot4	] {self.weaponframe=3;};
void()	player_shot4 =	[$shotatt4, player_shot5	] {self.weaponframe=4;};
void()	player_shot5 =	[$shotatt5, player_shot6	] {self.weaponframe=5;};
void()	player_shot6 =	[$shotatt6, player_run	] {self.weaponframe=6;};

void()	player_axe1 =	[$axatt1, player_axe2	] {self.weaponframe=1;};
void()	player_axe2 =	[$axatt2, player_axe3	] {self.weaponframe=2;};
void()  player_axe3 =   [$axatt3, player_axe4   ] {self.weaponframe=3;if(self.follow)W_FireAxe();};
void()  player_axe4 =   [$axatt4, player_run    ] {self.weaponframe=4;if(!self.follow){W_ThrowAxe();self.weaponframe=6;}};

void()	player_axeb1 =	[$axattb1, player_axeb2	] {self.weaponframe=5;};
void()	player_axeb2 =	[$axattb2, player_axeb3	] {self.weaponframe=6;};
void()  player_axeb3 =  [$axattb3, player_axeb4 ] {self.weaponframe=7;if(self.follow)W_FireAxe();};
void()  player_axeb4 =  [$axattb4, player_run   ] {self.weaponframe=8;if(!self.follow){W_ThrowAxe();self.weaponframe=6;}};

void()	player_axec1 =	[$axattc1, player_axec2	] {self.weaponframe=1;};
void()	player_axec2 =	[$axattc2, player_axec3	] {self.weaponframe=2;};
void()  player_axec3 =  [$axattc3, player_axec4 ] {self.weaponframe=3;if(self.follow)W_FireAxe();};
void()  player_axec4 =  [$axattc4, player_run   ] {self.weaponframe=4;if(!self.follow){W_ThrowAxe();self.weaponframe=6;}};

void()	player_axed1 =	[$axattd1, player_axed2	] {self.weaponframe=5;};
void()	player_axed2 =	[$axattd2, player_axed3	] {self.weaponframe=6;};
void()  player_axed3 =  [$axattd3, player_axed4 ] {self.weaponframe=7;if(self.follow)W_FireAxe();};
void()  player_axed4 =  [$axattd4, player_run   ] {self.weaponframe=8;if(!self.follow){W_ThrowAxe();self.weaponframe=6;}};
 

//============================================================================

void() player_nail1   =[$nailatt1, player_nail2  ] 
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 9)
		self.weaponframe = 1;
//        SuperDamageSound();
	W_FireSpikes (4);
	self.attack_finished = time + 0.2;
};
void() player_nail2   =[$nailatt2, player_nail1  ]
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 9)
		self.weaponframe = 1;
//        SuperDamageSound();
	W_FireSpikes (-4);
	self.attack_finished = time + 0.2;
};

//============================================================================

void() player_light1   =[$light1, player_light2  ] 
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
//        SuperDamageSound();
	W_FireLightning();
	self.attack_finished = time + 0.2;
};
void() player_light2   =[$light2, player_light1  ]
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
//        SuperDamageSound();
	W_FireLightning();
	self.attack_finished = time + 0.2;
};

//============================================================================


void() player_rocket1   =[$rockatt1, player_rocket2  ] {self.weaponframe=1;
self.effects = self.effects | EF_MUZZLEFLASH;};
void() player_rocket2   =[$rockatt2, player_rocket3  ] {self.weaponframe=2;};
void() player_rocket3   =[$rockatt3, player_rocket4  ] {self.weaponframe=3;};
void() player_rocket4   =[$rockatt4, player_rocket5  ] {self.weaponframe=4;};
void() player_rocket5   =[$rockatt5, player_rocket6  ] {self.weaponframe=5;};
void() player_rocket6   =[$rockatt6, player_run  ] {self.weaponframe=6;};
void(float num_bubbles) DeathBubbles;

void() PainSound =
{
local float		rs;

	if (self.health < 0)
		return;

       	if (damage_attacker.classname == "teledeath")
	{
		sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}

// water pain sounds
        if ((self.watertype == CONTENT_WATER && self.waterlevel == 3)||self.suff!=0||(self.waterlevel==3&&self.firesistime>time))
	{
                if (self.suff!=1)
                        DeathBubbles(3);
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/drown1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/drown2.wav", 1, ATTN_NORM);
		return;
	}

// slime pain sounds
	if (self.watertype == CONTENT_SLIME)
	{
// FIX ME	put in some steam here
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/lburn1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/lburn2.wav", 1, ATTN_NORM);
		return;
	}

        if (self.watertype == CONTENT_LAVA && self.firesistime < time)
	{
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/lburn1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/lburn2.wav", 1, ATTN_NORM);
		return;
	}

	if (self.pain_finished > time)
	{
		self.axhitme = 0;
		return;
	}
	self.pain_finished = time + 0.5;

// don't make multiple pain sounds right after each other

// ax pain sound
	if (self.axhitme == 1)
	{
		self.axhitme = 0;
		sound (self, CHAN_VOICE, "player/axhit1.wav", 1, ATTN_NORM);
		return;
	}
	

	rs = rint((random() * 5) + 1);

	self.noise = "";
	if (rs == 1)
		self.noise = "player/pain1.wav";
	else if (rs == 2)
		self.noise = "player/pain2.wav";
	else if (rs == 3)
		self.noise = "player/pain3.wav";
	else if (rs == 4)
		self.noise = "player/pain4.wav";
	else if (rs == 5)
		self.noise = "player/pain5.wav";
	else
		self.noise = "player/pain6.wav";

	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	return;
};
void()	player_pain1 =	[	$pain1,	player_pain2	] {PainSound();self.weaponframe=0;};
void()	player_pain2 =	[	$pain2,	player_pain3	] {};
void()	player_pain3 =	[	$pain3,	player_pain4	] {};
void()	player_pain4 =	[	$pain4,	player_pain5	] {};
void()	player_pain5 =	[	$pain5,	player_pain6	] {};
void()	player_pain6 =	[	$pain6,	player_run	] {};

void()	player_axpain1 =	[	$axpain1,	player_axpain2	] {PainSound();self.weaponframe=0;};
void()	player_axpain2 =	[	$axpain2,	player_axpain3	] {};
void()	player_axpain3 =	[	$axpain3,	player_axpain4	] {};
void()	player_axpain4 =	[	$axpain4,	player_axpain5	] {};
void()	player_axpain5 =	[	$axpain5,	player_axpain6	] {};
void()	player_axpain6 =	[	$axpain6,	player_run	] {};

void() player_pain =
{

        damage_attacker = self.enemy;

	if (self.weaponframe)
		return;

	if (self.invisible_finished > time)
		return;		// eyes don't have pain frames

        if (self.dog_time==1)// && (self.attack_finished < time))
                {
                bprint("yo\n");
                play_dog_pain();
                }

        if (self.isfeign)       // experimental
                return;
        else if (self.weapon == IT_AXE)
		player_axpain1 ();
	else
		player_pain1 ();
};

void() player_dieb1;
void() player_diec1;
void() player_died1;
void() player_diee1;
void() player_die_ax1;

void() DeathBubblesSpawn =
{
local entity	bubble;
        if (self.owner.waterlevel != 3 && self.owner.classname == "player")
		return;
	bubble = spawn();
	setmodel (bubble, "progs/s_bubble.spr");
	setorigin (bubble, self.owner.origin + '0 0 24');
        bubble.movetype = MOVETYPE_FLY;
	bubble.solid = SOLID_NOT;
	bubble.velocity = '0 0 15';
	bubble.nextthink = time + 0.5;
	bubble.think = bubble_bob;
	bubble.classname = "bubble";
        bubble.touch = bubble_remove;
	bubble.frame = 0;
	bubble.cnt = 0;
	setsize (bubble, '-8 -8 -8', '8 8 8');
	self.nextthink = time + 0.1;
	self.think = DeathBubblesSpawn;
	self.air_finished = self.air_finished + 1;
        if (self.air_finished >= self.bubble_count)
		remove(self);
};

void(float num_bubbles) DeathBubbles =
{
local entity	bubble_spawner;
	
	bubble_spawner = spawn();
	setorigin (bubble_spawner, self.origin);
	bubble_spawner.movetype = MOVETYPE_NONE;
	bubble_spawner.solid = SOLID_NOT;
	bubble_spawner.nextthink = time + 0.1;
	bubble_spawner.think = DeathBubblesSpawn;
	bubble_spawner.air_finished = 0;
	bubble_spawner.owner = self;
	bubble_spawner.bubble_count = num_bubbles;
	return;
};


void() DeathSound =
{
local float		rs;

	// water death sounds
	if (self.waterlevel == 3)
	{
		sound (self, CHAN_VOICE, "player/h2odeath.wav", 1, ATTN_NONE);
		return;
	}
	
	rs = rint ((random() * 4) + 1);
	if (rs == 1)
		self.noise = "player/death1.wav";
	if (rs == 2)
		self.noise = "player/death2.wav";
	if (rs == 3)
		self.noise = "player/death3.wav";
	if (rs == 4)
		self.noise = "player/death4.wav";
	if (rs == 5)
		self.noise = "player/death5.wav";

	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NONE);
	return;
};

void() HeadDeath =
{
 ThrowGib ("progs/gib1.mdl", self.health);
 sound (self, CHAN_VOICE, "weapons/slop.wav", 1, ATTN_NORM);
 self.nextthink = time;
 self.think = SUB_Remove;
 self.movetype = MOVETYPE_BOUNCE;
 self.takedamage = DAMAGE_NO;
 self.solid = SOLID_NOT;
 self.th_die = SUB_Null;
 remove(self);
};


void(string gibname, float dm) ThrowHead =
{
	setmodel (self, gibname);
	self.frame = 0;
	self.nextthink = -1;
	self.movetype = MOVETYPE_BOUNCE;
	self.takedamage = DAMAGE_NO;
	self.solid = SOLID_NOT;
	self.view_ofs = '0 0 8';
	setsize (self, '-16 -16 0', '16 16 56');
	self.velocity = VelocityForDamage (dm);
	self.origin_z = self.origin_z - 24;
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.avelocity = crandom() * '0 600 0';
};


void() GibPlayer =
{
	ThrowHead ("progs/h_player.mdl", self.health);
	ThrowGib ("progs/gib1.mdl", self.health);
	ThrowGib ("progs/gib2.mdl", self.health);
	ThrowGib ("progs/gib3.mdl", self.health);

	self.deadflag = DEAD_DEAD;

	if (damage_attacker.classname == "teledeath")
	{
		sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}

	if (damage_attacker.classname == "teledeath2")
	{
		sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}
		
	if (random() < 0.5)
		sound (self, CHAN_VOICE, "player/gib.wav", 1, ATTN_NONE);
	else
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NONE);
};
 
void() PlayerDie =
{
	local	float	i;

        if (self.isfeign)       // experimental
                self.health = -99;

        if (self.aflag == 666)
                HoloCam(self);
        if(self.newholo.active||self.teleeyes.active)
                DetHolo();

	self.items = self.items - (self.items & IT_INVISIBILITY);
	self.invisible_finished = 0;	// don't die as eyes
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
        if (self.modelindex == modelindex_eyes)
                self.modelindex = modelindex_player;    // don't use eyes
        self.alive = FALSE;
	if (deathmatch || coop)
		DropBackpack();
	
	self.weaponmodel="";
	self.view_ofs = '0 0 -8';
	self.deadflag = DEAD_DYING;
	self.solid = SOLID_NOT;
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.movetype = MOVETYPE_TOSS;
	if (self.velocity_z < 10)
		self.velocity_z = self.velocity_z + random()*300;

        DetPipeBombs();
	if (self.health < -40)
	{
                if(self.enemy.classname=="player")
                        if(deathmatch)
                                self.enemy.exp = self.enemy.exp + 100 - self.health;
                        else
                                self.enemy.exp = self.enemy.exp - 100 + self.health;
		GibPlayer ();
		return;
	}
	
	self.angles_x = 0;
	self.angles_z = 0;

        if (self.dog_time)
        {
	sound (self, CHAN_VOICE, "dog/ddeath.wav", 1, ATTN_NORM);
                if(random() < 0.5)
                        play_dog_die1();
                else  play_dog_dieb1();
                return;
        }

	DeathSound();

	if (self.weapon == IT_AXE)
	{
		player_die_ax1 ();
		return;
	}
	
	i = cvar("temp1");
	if (!i)
		i = 1 + floor(random()*6);
	
	if (i == 1)
		player_diea1();
	else if (i == 2)
		player_dieb1();
	else if (i == 3)
		player_diec1();
	else if (i == 4)
		player_died1();
	else
		player_diee1();

};

void() set_suicide_frame =
{       // used by kill command and diconnect command
	if (self.model != "progs/player.mdl")
		return;	// allready gibbed
	self.frame = $deatha11;
        self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_TOSS;
	self.deadflag = DEAD_DEAD;
	self.nextthink = -1;
};

// Holo stuff
void()  holo_upa1    =       [       $deathd9,        holo_upa2    ] {};
void() holo_stand1 = [12, holo_stand2] {};
void()  holo_upa2    =       [       $deathd8,        holo_upa3    ] {};
void()  holo_upa3    =       [       $deathd7,        holo_upa4    ] {};
void()  holo_upa4    =       [       $deathd6,        holo_upa5    ] {};
void()  holo_upa5    =       [       $deathd5,        holo_upa6    ] {};
void()  holo_upa6    =       [       $deathd4,        holo_upa7    ] {};
void()  holo_upa7    =       [       $deathd3,        holo_upa8    ] {};
void()  holo_upa8    =       [       $deathd2,        holo_upa9    ] {};
void()  holo_upa9    =       [       $deathd1,        holo_upa9    ]{if(self.classname=="holo")holo_stand1();else player_stand1();};
void()	player_diea1	=	[	$deatha1,	player_diea2	] {};
void()	player_diea2	=	[	$deatha2,	player_diea3	] {};
void()	player_diea3	=	[	$deatha3,	player_diea4	] {};
void()	player_diea4	=	[	$deatha4,	player_diea5	] {};
void()	player_diea5	=	[	$deatha5,	player_diea6	] {};
void()	player_diea6	=	[	$deatha6,	player_diea7	] {};
void()	player_diea7	=	[	$deatha7,	player_diea8	] {};
void()	player_diea8	=	[	$deatha8,	player_diea9	] {};
void()	player_diea9	=	[	$deatha9,	player_diea10	] {};
void()	player_diea10	=	[	$deatha10,	player_diea11	] {};
void()  player_diea11   =       [       $deatha11,      player_diea11 ] {
if (self.classname == "holo")
{
        self.mana = time - self.init_mana;
        if (self.mana > self.exp)
                self.mana = self.exp;
        self.init_mana = time - self.mana + 0.1;
        self.mana = time - self.init_mana;
        if (self.owner.mana < 0.5)
                RemoveHolo(self); 

        if (!self.isfeign && self.feigning)
        {
        self.feigning = FALSE;
        holo_upa1();
        }
}
else if(!self.isfeign)PlayerDead();
};

void() holo_stand2 = [13, holo_stand3] {};
void() holo_stand3 = [14, holo_stand4] {};
void() holo_stand4 = [15, holo_stand5] {};
void() holo_stand5 = [16, holo_stand1] 
{
        self.owner.mana = time - self.owner.init_mana;
        if (self.owner.mana > self.owner.exp)
                self.owner.mana = self.owner.exp;
        self.owner.init_mana = time - self.owner.mana + 0.5;
        self.owner.mana = time - self.owner.init_mana;
        if (self.owner.mana < 0.5)
                RemoveHolo(self); 

        if (self.isfeign && self.feigning == FALSE)
        {
        player_diea1 ();      
        DeathSound();           
        DropBackpack();         
        self.feigning = TRUE;
        }
};
// end holo stuff

void()	player_dieb1	=	[	$deathb1,	player_dieb2	] {};
void()	player_dieb2	=	[	$deathb2,	player_dieb3	] {};
void()	player_dieb3	=	[	$deathb3,	player_dieb4	] {};
void()	player_dieb4	=	[	$deathb4,	player_dieb5	] {};
void()	player_dieb5	=	[	$deathb5,	player_dieb6	] {};
void()	player_dieb6	=	[	$deathb6,	player_dieb7	] {};
void()	player_dieb7	=	[	$deathb7,	player_dieb8	] {};
void()	player_dieb8	=	[	$deathb8,	player_dieb9	] {};
void()  player_dieb9    =       [       $deathb9,       player_dieb9    ] {PlayerDead();};

void()	player_diec1	=	[	$deathc1,	player_diec2	] {};
void()	player_diec2	=	[	$deathc2,	player_diec3	] {};
void()	player_diec3	=	[	$deathc3,	player_diec4	] {};
void()	player_diec4	=	[	$deathc4,	player_diec5	] {};
void()	player_diec5	=	[	$deathc5,	player_diec6	] {};
void()	player_diec6	=	[	$deathc6,	player_diec7	] {};
void()	player_diec7	=	[	$deathc7,	player_diec8	] {};
void()	player_diec8	=	[	$deathc8,	player_diec9	] {};
void()	player_diec9	=	[	$deathc9,	player_diec10	] {};
void()	player_diec10	=	[	$deathc10,	player_diec11	] {};
void()	player_diec11	=	[	$deathc11,	player_diec12	] {};
void()	player_diec12	=	[	$deathc12,	player_diec13	] {};
void()	player_diec13	=	[	$deathc13,	player_diec14	] {};
void()	player_diec14	=	[	$deathc14,	player_diec15	] {};
void()  player_diec15   =       [       $deathc15,      player_diec15 ] {PlayerDead();};

void()	player_died1	=	[	$deathd1,	player_died2	] {};
void()	player_died2	=	[	$deathd2,	player_died3	] {};
void()	player_died3	=	[	$deathd3,	player_died4	] {};
void()	player_died4	=	[	$deathd4,	player_died5	] {};
void()	player_died5	=	[	$deathd5,	player_died6	] {};
void()	player_died6	=	[	$deathd6,	player_died7	] {};
void()	player_died7	=	[	$deathd7,	player_died8	] {};
void()	player_died8	=	[	$deathd8,	player_died9	] {};
void()  player_died9    =       [       $deathd9,       player_died9    ] {PlayerDead();};

void()  player_diee1    =       [       $deathe1,       player_diee2    ] {};
void()	player_diee2	=	[	$deathe2,	player_diee3	] {};
void()	player_diee3	=	[	$deathe3,	player_diee4	] {};
void()	player_diee4	=	[	$deathe4,	player_diee5	] {};
void()	player_diee5	=	[	$deathe5,	player_diee6	] {};
void()	player_diee6	=	[	$deathe6,	player_diee7	] {};
void()	player_diee7	=	[	$deathe7,	player_diee8	] {};
void()	player_diee8	=	[	$deathe8,	player_diee9	] {};
void()  player_diee9    =       [       $deathe9,       player_diee9    ] {PlayerDead();};

void()	player_die_ax1	=	[	$axdeth1,	player_die_ax2	] {};
void()	player_die_ax2	=	[	$axdeth2,	player_die_ax3	] {};
void()	player_die_ax3	=	[	$axdeth3,	player_die_ax4	] {};
void()	player_die_ax4	=	[	$axdeth4,	player_die_ax5	] {};
void()	player_die_ax5	=	[	$axdeth5,	player_die_ax6	] {};
void()	player_die_ax6	=	[	$axdeth6,	player_die_ax7	] {};
void()	player_die_ax7	=	[	$axdeth7,	player_die_ax8	] {};
void()	player_die_ax8	=	[	$axdeth8,	player_die_ax9	] {};
void()  player_die_ax9  =       [       $axdeth9,       player_die_ax9  ] {PlayerDead();};

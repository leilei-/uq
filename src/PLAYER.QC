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

$frame decap1 decap2 decap3 decap4 decap5 decap6 decap7 decap8
$frame decap9 decap10 decap11

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

//Melee Stuff
$frame mlrun1 mlrun2 mlrun3 mlrun4 mlrun5 mlrun6

$frame mlstnd1 mlstnd2 mlstnd3 mlstnd4 mlstnd5 mlstnd6
$frame mlstnd7 mlstnd8 mlstnd9 mlstnd10 mlstnd11 mlstnd12

$frame mlpain1 mlpain2 mlpain3 mlpain4 mlpain5 mlpain6

//shrink/grow
$frame shrink1 shrink2 shrink3 shrink4 shrink5 shrink6 shrink7 shrink8 shrink9 shrink10

/* SMALL */
//
// running
//
$frame saxrun1 saxrun2 saxrun3 saxrun4 saxrun5 saxrun6

$frame srockrun1 srockrun2 srockrun3 srockrun4 srockrun5 srockrun6

//
// standing
//
$frame sstand1 sstand2 sstand3 sstand4 sstand5

$frame saxstnd1 saxstnd2 saxstnd3 saxstnd4 saxstnd5 saxstnd6
$frame saxstnd7 saxstnd8 saxstnd9 saxstnd10 saxstnd11 saxstnd12


//
// pain
//
$frame saxpain1 saxpain2 saxpain3 saxpain4 saxpain5 saxpain6

$frame spain1 spain2 spain3 spain4 spain5 spain6


//
// attacks
//
$frame snailatt1 snailatt2

$frame slight1 slight2

$frame srockatt1 srockatt2 srockatt3 srockatt4 srockatt5 srockatt6

$frame sshotatt1 sshotatt2 sshotatt3 sshotatt4 sshotatt5 sshotatt6

$frame saxattc1 saxattc2 saxattc3 saxattc4 saxattc5 saxattc6

/*
===============================
DOG PLAYER
===============================
*/
void() dog_bite;

void() PlayerDead =
{
        if(self.ressurect)
                return;
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
                        if(cvar("sv_friction")!=self.friction&&(!deathmatch))
                                SetFriction();
                        self.walkframe=0;
                        player_run();
                        return;
	}

/*
        if(self.enemy.health>0&&self.enemy.skin==1&&self.enemy.classname=="player"&&random()<0.2&&random()<0.2&&random()<0.2&&random()<0.2&&self.enemy.zap_finished<=time)
                        {
                        self.enemy.zap_finished=time+1;
                        sound (self.enemy, CHAN_VOICE, "jaworski/comeon.wav", 1, ATTN_NORM);
                        }
*/
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
        else if(!self.small&&(self.weapon==IT_SWORD||self.weapon == IT_CHAKRAM||self.weapon == IT_SABER||self.weapon == IT_BATLETH||self.weapon == IT_DISC))
	{
                if (self.walkframe == 12)
			self.walkframe = 0;
                self.frame = $mlstnd1 + self.walkframe;
	}
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
        if(self.skin<25)
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
                        if (random() > 0.2&&self.classlabel!="Assassin")
                                sound (self, CHAN_AUTO, "weapons/stepstop.wav", 1, ATTN_NORM);
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
        else if(!self.small&&(self.weapon==IT_SWORD||self.weapon == IT_CHAKRAM||self.weapon == IT_SABER||self.weapon == IT_BATLETH||self.weapon == IT_DISC))
	{
		if (self.walkframe == 6)
			self.walkframe = 0;
                self.frame = $mlrun1 + self.walkframe;
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

        if(self.flags&FL_ONGROUND)
        {
        self.velocity_x = self.velocity_x/self.speed/self.mass;
        self.velocity_y = self.velocity_y/self.speed/self.mass;
        }

        if (self.velocity_y > 60 || self.velocity_y < -60)
                self.running = self.running + 1;
        else self.running = 0;

        if ((self.walkframe == 1 || self.walkframe == 4 ) && (self.ducking == FALSE)&&self.classlabel!="Assassin")
                if (checkbottom(self) == TRUE)
                        if (self.waterlevel == 0)
                        if (self.velocity_x > 60 || self.velocity_x < -60 || self.running)
                        {
//                        rstep = random () * 10;
                        rstep = rint(random () * 3);
                        if (rstep >= 3)
                              sound (self, CHAN_AUTO, "weapons/step1.wav", 1, ATTN_NORM);
//                        else if (rstep >= 6)
//                              sound (self, CHAN_AUTO, "weapons/step2.wav", 1, ATTN_NORM);
//                        else if (rstep >= 4)
//                              sound (self, CHAN_AUTO, "weapons/step3.wav", 1, ATTN_NORM);
//                        else if (rstep >= 3)
//                              sound (self, CHAN_AUTO, "weapons/step4.wav", 1, ATTN_NORM);
                        else if (rstep >= 2)
                              sound (self, CHAN_AUTO, "weapons/step5.wav", 1, ATTN_NORM);
                        else if (rstep >= 1)
                              sound (self, CHAN_AUTO, "weapons/step6.wav", 1, ATTN_NORM);
                        self.stepping = TRUE;
                        }
	self.walkframe = self.walkframe + 1;
};


void()	player_shot1 =	[$shotatt1, player_shot2	] {self.weaponframe=1;
self.effects = self.effects | EF_MUZZLEFLASH;};
void()  player_shot2 =  [$shotatt2, player_shot3        ] {if(self.weapon!=IT_FLAMETHROWER)self.weaponframe=2;};
void()  player_shot3 =  [$shotatt3, player_shot4        ] {if(self.weapon!=IT_FLAMETHROWER)self.weaponframe=3;};
void()  player_shot4 =  [$shotatt4, player_shot5        ] {if(self.weapon!=IT_FLAMETHROWER)self.weaponframe=4;};
void()  player_shot5 =  [$shotatt5, player_shot6        ] {if(self.weapon!=IT_FLAMETHROWER)self.weaponframe=5;};
void()  player_shot6 =  [$shotatt6, player_run  ] {if(self.weapon!=IT_FLAMETHROWER)self.weaponframe=6;};

void()  player_sixl1 =  [$shotatt1, player_sixl2        ] {self.weaponframe=1;
self.effects = self.effects | EF_MUZZLEFLASH;};
void()  player_sixl2 =  [$shotatt3, player_sixl3        ] {self.weaponframe=2;};
void()  player_sixl3 =  [$shotatt6, player_run  ] {self.weaponframe=3;};

void()  player_sixr1 =  [$shotatt1, player_sixr2        ] {self.weaponframe=4;
self.effects = self.effects | EF_MUZZLEFLASH;};
void()  player_sixr2 =  [$shotatt3, player_sixr3        ] {self.weaponframe=5;};
void()  player_sixr3 =  [$shotatt6, player_run  ] {self.weaponframe=6;};

void()  player_reload1 =  [$stand1, player_reload2        ] {self.weaponframe=7;};
void()  player_reload2 =  [$stand2, player_reload3        ] {self.weaponframe=8;};
void()  player_reload3 =  [$stand3, player_reload4        ] {self.weaponframe=9;};
void()  player_reload4 =  [$stand4, player_reload5        ] {self.weaponframe=9;};
void()  player_reload5 =  [$stand5, player_reload6        ] {self.weaponframe=9;};
void()  player_reload6 =  [$stand1, player_reload7        ] {self.weaponframe=9;};
void()  player_reload7 =  [$stand2, player_reload8        ] {self.weaponframe=9;};
void()  player_reload8 =  [$stand3, player_reload9        ] {self.weaponframe=9;};
void()  player_reload9 =  [$stand4, player_reload0        ] {self.weaponframe=8;};
void()  player_reload0 =  [$stand5, player_run  ] {self.weaponframe=7;};

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
        SuperDamageSound();
	self.attempthit=self.attempthit + 1;
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
        SuperDamageSound();
	self.attempthit=self.attempthit + 1;
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
        SuperDamageSound();
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
        SuperDamageSound();
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
if(self.racename!="T-800"&&self.racename!="Borg")
{       
/*
        if(self.skin==1||self.oldskin==1)
                JaworskiHurt(self);
        else */
if(self.skin==12||self.skin==16||self.oldskin==12||self.oldskin==16)
        {
                if(self.waterlevel==3)
                        self.noise="xena/drown2.wav";
                else if(self.watertype==CONTENT_LAVA||self.watertype==CONTENT_SLIME)
                        if(random()<0.5)
                                self.noise="xena/lburn1.wav";
                        else self.noise="xena/lburn2.wav";
                else
                {
                rs = rint((random() * 3) + 1);
                self.noise = "";
                if (rs == 1)
                        self.noise = "xena/femhurt.wav";
                else if (rs == 2)
                        self.noise = "xena/pain6.wav";
                else if (rs == 3)
                        self.noise = "xena/land.wav";
                else
                        self.noise = "xena/lburn1.wav";
                }
                sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
        }
        else if(self.racename=="TigerMan")
        {
        rs = rint((random() * 3) + 1);
	self.noise = "";
	if (rs == 1)
                self.noise = "tiger/hurt1.wav";
	else if (rs == 2)
                self.noise = "tiger/hurt2.wav";
        else if (rs == 3)
                self.noise = "tiger/hurt3.wav";
        else
                self.noise = "tiger/attack.wav";
	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
        }
        else if(self.racename=="Predator")
        {
        if (random() < 0.5)
                self.noise = "predator/pain1.wav";
        else
                self.noise = "predator/pain2.wav";
        sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
        }
        else
        {
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
        if (self.watertype == CONTENT_LAVA && self.firesistime < time&&self.racename!="Draconian")
	{
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/lburn1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/lburn2.wav", 1, ATTN_NORM);
		return;
	}
        }
}
	if (self.pain_finished > time)
	{
		self.axhitme = 0;
		return;
	}
        if(self.racename=="TigerMan"||self.racename=="Predator")
                self.pain_finished = time + 1.5;
        else
                self.pain_finished = time + 0.5;

// don't make multiple pain sounds right after each other

// ax pain sound
	if (self.axhitme == 1)
	{
		self.axhitme = 0;
                if(self.racename!="TigerMan"&&self.racename!="T-800"&&self.racename!="Predator"&&self.skin!=1&&self.skin!=12&&self.skin!=16&&self.racename!="Borg")
		sound (self, CHAN_VOICE, "player/axhit1.wav", 1, ATTN_NORM);
		return;
	}
        if(self.racename=="TigerMan"||self.racename=="T-800"||self.racename=="Predator"||self.skin==1||self.skin==12||self.skin==16||self.oldskin==12||self.oldskin==16||self.oldskin==1||self.racename=="Borg")
                return; 

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

void()  player_mlpain1 =        [       $mlpain1,       player_mlpain2  ] {PainSound();self.weaponframe=0;};
void()  player_mlpain2 =        [       $mlpain2,       player_mlpain3  ] {};
void()  player_mlpain3 =        [       $mlpain3,       player_mlpain4  ] {};
void()  player_mlpain4 =        [       $mlpain4,       player_mlpain5  ] {};
void()  player_mlpain5 =        [       $mlpain5,       player_mlpain6  ] {};
void()  player_mlpain6 =        [       $mlpain6,       player_run      ] {};

void()	player_axpain1 =	[	$axpain1,	player_axpain2	] {PainSound();self.weaponframe=0;};
void()	player_axpain2 =	[	$axpain2,	player_axpain3	] {};
void()	player_axpain3 =	[	$axpain3,	player_axpain4	] {};
void()	player_axpain4 =	[	$axpain4,	player_axpain5	] {};
void()	player_axpain5 =	[	$axpain5,	player_axpain6	] {};
void()	player_axpain6 =	[	$axpain6,	player_run	] {};

void(entity attacker, float damage) player_pain =
{

        damage_attacker = self.enemy;

    if(self.saber.running&&damage>=self.max_health*0.25&&random()<0.5)
                {
                self.saber.velocity_z=self.saber.velocity_z + 300;
                Drop(self.saber);
                }

    if (self.weaponframe||self.skin>24)
		return;

/*
   if(self.racename=="Predator")
        if(self.playpainspecial==FALSE&&damage_attacker.classname=="player")
                {
                self.playpainspecial=TRUE;
                        sound (damage_attacker, CHAN_VOICE, "predator/bleed.wav", 1, ATTN_NORM);
                }
*/
	if (self.invisible_finished > time)
            if(self.racename=="Predator")
                PredCloakMalFunc();
            else return;         // eyes don't have pain frames

        if (self.dog_time==1)// && (self.attack_finished < time))
                play_dog_pain();

        if (self.isfeign)       // experimental
                return;
        else if(!self.small&&(self.weapon==IT_SWORD||self.weapon == IT_CHAKRAM||self.weapon == IT_SABER||self.weapon == IT_BATLETH||self.weapon == IT_DISC))
                player_mlpain1();
        else if (self.weapon == IT_AXE)
		player_axpain1 ();
	else
		player_pain1 ();
        if(self.berzerker&&random()<0.3&&random()<0.2&&self.super_time!=1&&self.health>self.max_health*0.5)
                GoBerzerk();
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
	bubble.velocity = '0 0 30';
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

void() Boom=
{
        if(!self.owner.alive)
                setorigin(self,self.owner.origin+'0 0 16');
        T_RadiusDamage (self, self.owner,500, world);
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
        self.active=FALSE;
        BecomeExplosion();
};

void() startcountdown=
{
        self.explosion = spawn();
        setorigin(self.explosion,self.origin+'0 0 16');
        setmodel(self.explosion,"progs/null.spr");
        self.explosion.active = TRUE;
        self.explosion.owner = self;
        self.effects = 8;
        self.explosion.nextthink = time + 7.5;
        self.explosion.think = Boom;
};

void() DeathSound =
{
local float		rs;

	// water death sounds
        if(self.racename=="T-800")
                return;// sound: I'll be back
        else if(self.racename=="Borg")
                {
                sound(self,CHAN_VOICE,"borg/death.wav",1,ATTN_NONE);
                return;
                }
        else if(self.deathtype=="heart")
        {
                sound (self, CHAN_VOICE, "weapons/heartatt.wav", 1, ATTN_NONE);
                self.deathtype = "";
		return;
        }
        else if(self.racename=="TigerMan")
        {
                sound (self, CHAN_VOICE, "tiger/die.wav", 1, ATTN_NONE);
		return;
        }
/*
        else if(self.skin==1||self.oldskin==1)
        {
                if(self.health<-25||random()<0.2)
                     if(random()<0.5)
                        sound (self, CHAN_VOICE, "jaworski/die1.wav", 1, ATTN_NONE);
                     else sound (self, CHAN_VOICE, "jaworski/keitel.wav", 1, ATTN_NONE);
                else if(random()<0.5&&self.enemy.alive)
                        sound (self, CHAN_VOICE, "jaworski/badguy.wav", 1, ATTN_NONE);
                else sound (self, CHAN_VOICE, "jaworski/fuckthis.wav", 1, ATTN_NONE);
		return;
        }
*/
        else if(self.skin==12||self.skin==16||self.oldskin==12||self.oldskin==16)
        {
                if(self.waterlevel==3)
                        sound (self, CHAN_VOICE, "xena/h2odeath.wav", 1, ATTN_NONE);
                else if(random()<0.5)
                        sound (self, CHAN_VOICE, "xena/femdie.wav", 1, ATTN_NONE);
                else sound (self, CHAN_VOICE, "xena/femdie2.wav", 1, ATTN_NONE);
		return;
        }
        else if(self.racename=="Predator")
        {
                if(random()<0.5)
                {
                sound (self, CHAN_AUTO, "predator/die.wav", 1, ATTN_NONE);
                startcountdown();
                }
                else
                     sound (self, CHAN_VOICE, "predator/die2.wav", 1, ATTN_NONE);
                return;
        }
        else if (self.waterlevel == 3)
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
 if(self.Kick_em&&self.enemy.classname=="player")
         sound(self, CHAN_AUTO, "weapons/bullseye.wav", 1, ATTN_NONE);
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

void() Ressurect=
{
                self.takedamage = DAMAGE_AIM;
                self.solid = SOLID_SLIDEBOX;
                setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
                self.angles=normalize(self.enemy.origin-self.origin);
//              self.angles = vectoyaw(self.enemy.origin - self.origin);
                self.ressurect=FALSE;
                self.view_ofs = '0 0 22';
                self.movetype = MOVETYPE_WALK;
                self.th_pain=player_pain;
                self.flags=FL_CLIENT;
                self.deadflag=DEAD_NO;
                self.health=self.max_health;
                self.effects=EF_MUZZLEFLASH;
//"Hallelujah"                sound(self,CHAN_AUTO,"weapons/hall.wav",1,ATTN_NONE);
	self.effects = 0;
        self.small=FALSE;
        self.shrink_time=0;
        self.alive = TRUE;
	self.climbing=FALSE;
	self.th_pain = player_pain;
	self.th_die = PlayerDie;
	self.touch = PlayerTouch;
        self.hover=FALSE;
	self.pausetime = 0;
	self.fixangle = TRUE;		// turn this way immediately
        self.o_angle = self.angles;
	player_stand1 ();
        makevectors(self.angles);
        spawn_tfog (self.origin + v_forward*20);
	spawn_tdeath (self.origin, self);
};

void() FixGib=
{
        setmodel (self,"progs/player.mdl");
        self.origin_z = self.origin_z + 24;
        self.think=Ressurect;
        self.nextthink=time;
};

void(string gibname, float dm) ThrowHead =
{
	setmodel (self, gibname);
	self.frame = 0;
        if(!self.ressurect)
                self.nextthink = -1;
	self.movetype = MOVETYPE_BOUNCE;

	self.takedamage = DAMAGE_NO;
	self.solid = SOLID_NOT;
	self.view_ofs = '0 0 8';
	setsize (self, '-16 -16 0', '16 16 56');
	self.origin_z = self.origin_z - 24;

	self.velocity = VelocityForDamage (dm);
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.avelocity = crandom() * '0 600 0';
        if(self.ressurect)
        {
                self.think=FixGib;
                self.nextthink=time + 3;
        }
};

void() ReadySolid=
{
        MakeSolidCorpse ("progs/gib1.mdl",self.netname);
};

void()  player_decap1    =       [       $decap1,       player_decap2    ] {SpawnMeatSpray (self.origin + '0 0 24', '0 0 64');};
void()  player_decap2    =       [       $decap2,       player_decap3    ] {makevectors(self.angles);SpawnBlood (self.origin+v_forward*8, '0 0 48', 30,self);sound (self, CHAN_AUTO, "weapons/slop.wav", 1, ATTN_NORM);};
void()  player_decap3    =       [       $decap3,       player_decap4    ] {};
void()  player_decap4    =       [       $decap4,       player_decap5    ] {makevectors(self.angles);SpawnBlood (self.origin+v_forward*16, '0 0 36'+v_forward*16, 20,self);sound (self, CHAN_AUTO, "weapons/slop.wav", 1, ATTN_NORM);};
void()  player_decap5    =       [       $decap5,       player_decap6    ] {};
void()  player_decap6    =       [       $decap6,       player_decap7    ] {makevectors(self.angles);SpawnBlood (self.origin+v_forward*28, '0 0 20'+v_forward*32, 15,self);sound (self, CHAN_AUTO, "weapons/slop.wav", 0.8, ATTN_NORM);};
void()  player_decap7    =       [       $decap7,       player_decap8    ] {};
void()  player_decap8    =       [       $decap8,       player_decap9    ] {};
void()  player_decap9    =       [       $decap9,       player_decap10   ] {makevectors(self.angles);SpawnBlood (self.origin+v_forward*40, '0 0 10'+v_forward*40, 10,self);sound (self, CHAN_AUTO, "weapons/slop.wav", 0.6, ATTN_NORM);};
void()  player_decap10   =       [       $decap10,      player_decap11   ] {};
void()  player_decap11   =       [       $decap11,      ReadySolid ] {
makevectors(self.angles);SpawnBlood (self.origin+v_forward*56, '0 0 -5'+v_forward*40, 5,self);sound (self, CHAN_AUTO, "weapons/slop.wav", 0.4, ATTN_NORM);};

void() DecapPlayer =
{
local entity headless;
        headless=spawn();
        headless.classname="headless";
        headless.decap=TRUE;
        headless.movetype=MOVETYPE_STEP;
        headless.solid=SOLID_SLIDEBOX;
        headless.frame=50;
        headless.skin=self.skin;
        headless.owner=self;
        setmodel(headless,"progs/player.mdl");
        setsize(headless,'-16 -16 -24','16 16 40');
        headless.angles_y=self.angles_y;
        setorigin(headless,self.origin);
        headless.think=player_decap1;
        headless.nextthink=time + 0.25;

        self.health=self.health*4;
        if(self.health>-30)
                self.health=-30;
        else if(self.health<-99)
                self.health=-99;
        if(self.decap==2)
                ThrowHead ("progs/gib1.mdl", self.health);
        else ThrowHead ("progs/h_player.mdl", self.health);
	ThrowGib ("progs/gib1.mdl", self.health);
	ThrowGib ("progs/gib2.mdl", self.health);
	ThrowGib ("progs/gib3.mdl", self.health);

	self.deadflag = DEAD_DEAD;
	if (random() < 0.5)
		sound (self, CHAN_VOICE, "player/gib.wav", 1, ATTN_NONE);
	else
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NONE);
};

void(float wassmall) GibPlayer =
{
        if(wassmall)
                ThrowHead ("progs/s_h_play.mdl", self.health);
        else ThrowHead ("progs/h_player.mdl", self.health);
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
        local   float   i,wassmall;

        if(self.small)
                wassmall=TRUE;
        self.small=FALSE;
        self.shrink_time=0;

        if(self.solid==SOLID_NOT)
                self.solid=SOLID_BBOX;
//        if(self.netname=="clone"&&self.owner.classname=="gplayer")
//                self=self.owner;

        if(self.sight.running)
                remove(self.sight);

        if (self.isfeign)       // experimental
        {
                if (self.enemy.classname == "player")
                        self.enemy.frags = self.enemy.frags - 1;
                else
                        self.frags = self.frags + 1;
                self.health = -99;
        }

        if (self.aflag == 666)
                HoloCam(self);

        if(self.newholo.active||self.teleeyes.active)
                DetHolo();

        if(self.saber.running||self.saber.follow!=0||self.saber.inpain)
                {
                self.saber.velocity_z=self.saber.velocity_z + 300;
                if(deathmatch)
                {
                        self.saber.running=FALSE;
                        self.saber.follow=0;
                        self.saber.inpain=FALSE;
                        self.saber.aflag=0;
                        remove(self.saber);
                }
                else if(self.classlabel=="Jedi"||self.classlabel=="Dark Jedi")
                        Drop(self.saber);
                else if(self.skin==16||self.oldskin==16)
                        chakramDrop();
                else if(self.racename=="Predator")
                        discDrop(self.saber);
                }
        if(self.sword.running||self.batleth.running)
        {
        local entity dropped;
                if(self.sword.running)
                        dropped=self.sword;
                else dropped=self.batleth;
                if(deathmatch)
                {
                        dropped.running=FALSE;
                        dropped.inpain=FALSE;
                        remove(dropped);
                }
                else if(!dropped.inpain)
                {
                        dropped.velocity_z=dropped.velocity_z + 300;
                        Drop(dropped);
                }
        }

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
        if(!self.ressurect)
        {
	self.deadflag = DEAD_DYING;
	self.solid = SOLID_NOT;
	self.flags = self.flags - (self.flags & FL_ONGROUND);
        }
	self.movetype = MOVETYPE_TOSS;
	if (self.velocity_z < 10)
		self.velocity_z = self.velocity_z + random()*300;

        DetPipeBombs();

        if(self.decap)
        {
                if(self.enemy.classname=="player"&&!self.ressurect)
                        if((!deathmatch)||self.enemy.dishonor)
                                self.enemy.exp = self.enemy.exp - 100 - self.health;
                        else
                                self.enemy.exp = self.enemy.exp + 500 + self.health;
                DecapPlayer();
                return;
        }
        else if((self.health < -40&&self.racename!="T-800"&&self.racename!="Borg")||self.deathtype=="telefrag"||wassmall)
	{
                if(self.enemy.classname=="player"&&!self.ressurect)
                        if((!deathmatch)||self.enemy.dishonor)
                                self.enemy.exp = self.enemy.exp - 100 - self.health;
                        else
                                self.enemy.exp = self.enemy.exp + 100 + self.health;
                GibPlayer (TRUE);
		return;
	}

        self.angles_x = 0;//not doing anything?
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

void()  player_shrink1  =       [       $shrink1,       player_shrink2  ] {};
void()  player_shrink2  =       [       $shrink2,       player_shrink3  ] {setsize(self,VEC_HULL_MIN*0.9,VEC_HULL_MAX*0.9);};
void()  player_shrink3  =       [       $shrink3,       player_shrink4  ] {setsize(self,VEC_HULL_MIN*0.8,VEC_HULL_MAX*0.8);};
void()  player_shrink4  =       [       $shrink4,       player_shrink5  ] {setsize(self,VEC_HULL_MIN*0.7,VEC_HULL_MAX*0.7);};
void()  player_shrink5  =       [       $shrink5,       player_shrink6  ] {setsize(self,VEC_HULL_MIN*0.6,VEC_HULL_MAX*0.6);};
void()  player_shrink6  =       [       $shrink6,       player_shrink7  ] {setsize(self,VEC_HULL_MIN*0.5,VEC_HULL_MAX*0.5);};
void()  player_shrink7  =       [       $shrink7,       player_shrink8  ] {setsize(self,VEC_HULL_MIN*0.4,VEC_HULL_MAX*0.4);};
void()  player_shrink8  =       [       $shrink8,       player_shrink9  ] {setsize(self,VEC_HULL_MIN*0.3,VEC_HULL_MAX*0.3);};
void()  player_shrink9  =       [       $shrink9,       player_shrink10  ] {setsize(self,VEC_HULL_MIN*0.2,VEC_HULL_MAX*0.2);};
void()  player_shrink10  =       [       $shrink10,       player_srun  ] {setsize(self,VEC_HULL_MIN*0.1,VEC_HULL_MAX*0.1);
/*self.modelindex = modelindex_small;*/};

void()  player_grow1  =       [       $shrink10,       player_grow2  ] {};
void()  player_grow2  =       [       $shrink9,       player_grow3  ] {setsize(self,VEC_HULL_MIN*0.2,VEC_HULL_MAX*0.2);};
void()  player_grow3  =       [       $shrink8,       player_grow4  ] {setsize(self,VEC_HULL_MIN*0.3,VEC_HULL_MAX*0.3);};
void()  player_grow4  =       [       $shrink7,       player_grow5  ] {setsize(self,VEC_HULL_MIN*0.4,VEC_HULL_MAX*0.4);};
void()  player_grow5  =       [       $shrink6,       player_grow6  ] {setsize(self,VEC_HULL_MIN*0.5,VEC_HULL_MAX*0.5);};
void()  player_grow6  =       [       $shrink5,       player_grow7  ] {setsize(self,VEC_HULL_MIN*0.6,VEC_HULL_MAX*0.6);};
void()  player_grow7  =       [       $shrink4,       player_grow8  ] {setsize(self,VEC_HULL_MIN*0.7,VEC_HULL_MAX*0.7);};
void()  player_grow8  =       [       $shrink3,       player_grow9  ] {setsize(self,VEC_HULL_MIN*0.8,VEC_HULL_MAX*0.8);};
void()  player_grow9  =       [       $shrink2,       player_grow10  ] {setsize(self,VEC_HULL_MIN*0.9,VEC_HULL_MAX*0.9);};
void()  player_grow10  =       [       $shrink1,       player_run  ] {setsize(self,VEC_HULL_MIN,VEC_HULL_MAX);

if(pointcontents(self.origin)==CONTENT_SOLID)
{
        self.deathtype="growsquish";
        T_Damage(self,world,world,50000);
}

};

//===============
// SMALL
//===============

void() StaySlow=
{
        if(self.waterlevel!=0||self.velocity_z<-10)
                self.velocity_z = self.velocity_z*self.mass;
        self.velocity_x = self.velocity_x/self.speed/self.mass/10;
        self.velocity_y = self.velocity_y/self.speed/self.mass/10;
};

void()  player_sstand1 =[        $saxstnd1,       player_sstand1   ]
{
	self.weaponframe=0;

        if (self.velocity_x || self.velocity_y)
	{
                        if(cvar("sv_friction")!=self.friction&&(!deathmatch))
                                SetFriction();
                        self.walkframe=0;
                        player_srun();
                        return;
	}
/*
        if(self.enemy.health>0&&self.enemy.skin==1&&self.enemy.classname=="player"&&random()<0.2&&random()<0.2&&random()<0.2&&random()<0.2&&self.enemy.zap_finished<=time)
                        {
                        self.enemy.zap_finished=time+1;
                        sound (self.enemy, CHAN_VOICE, "jaworski/comeon.wav", 1, ATTN_NORM);
                        }
*/
        if (self.weapon == IT_AXE)
	{
		if (self.walkframe >= 12)
			self.walkframe = 0;
                self.frame = $saxstnd1 + self.walkframe;
	}
	else
	{
		if (self.walkframe >= 5)
			self.walkframe = 0;
                self.frame = $sstand1 + self.walkframe;
	}
        if(self.skin<25)
                self.walkframe = self.walkframe + 1;
};

void()  player_srun =[   $srockrun1,      player_srun      ]
{
local float rstep;

        self.weaponframe=0;

        if (!self.velocity_x && !self.velocity_y)
	{
		self.walkframe=0;
                if (self.stepping && !self.ducking && self.running > 3)
                        if (random() > 0.2&&self.classlabel!="Assassin")
                                sound (self, CHAN_AUTO, "weapons/stepstop.wav", 1, ATTN_NORM);
                self.stepping == FALSE;
                player_sstand1();
		return;
	}

        if (self.weapon == IT_AXE)
	{
		if (self.walkframe == 6)
			self.walkframe = 0;
                self.frame = $saxrun1 + self.walkframe;
	}
	else
	{
		if (self.walkframe == 6)
			self.walkframe = 0;
		self.frame = self.frame + self.walkframe;
	}

        StaySlow();

        if (self.velocity_y > 60 || self.velocity_y < -60)
                self.running = self.running + 1;
        else self.running = 0;

	self.walkframe = self.walkframe + 1;
};


void()  player_sshot1 =  [$sshotatt1, player_sshot2        ] {self.weaponframe=1;
self.effects = self.effects | EF_MUZZLEFLASH;StaySlow();};
void()  player_sshot2 =  [$sshotatt2, player_sshot3        ] {if(self.weapon!=IT_FLAMETHROWER)self.weaponframe=2;StaySlow();};
void()  player_sshot3 =  [$sshotatt3, player_sshot4        ] {if(self.weapon!=IT_FLAMETHROWER)self.weaponframe=3;StaySlow();};
void()  player_sshot4 =  [$sshotatt4, player_sshot5        ] {if(self.weapon!=IT_FLAMETHROWER)self.weaponframe=4;StaySlow();};
void()  player_sshot5 =  [$sshotatt5, player_sshot6        ] {if(self.weapon!=IT_FLAMETHROWER)self.weaponframe=5;StaySlow();};
void()  player_sshot6 =  [$sshotatt6, player_srun  ] {if(self.weapon!=IT_FLAMETHROWER)self.weaponframe=6;StaySlow();};

void()  player_saxec1 =  [$saxattc1, player_saxec2 ] {self.weaponframe=1;StaySlow();};
void()  player_saxec2 =  [$saxattc2, player_saxec3 ] {self.weaponframe=2;StaySlow();};
void()  player_saxec3 =  [$saxattc3, player_saxec4 ] {self.weaponframe=3;if(self.follow)W_FireAxe();StaySlow();};
void()  player_saxec4 =  [$saxattc4, player_srun   ] {self.weaponframe=4;StaySlow();};

//============================================================================

void() player_snail1   =[$snailatt1, player_snail2  ] 
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
                {player_srun ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 9)
		self.weaponframe = 1;
        SuperDamageSound();
	self.attempthit=self.attempthit + 1;
	W_FireSpikes (4);
	self.attack_finished = time + 0.2;
};
void() player_snail2   =[$snailatt2, player_snail1  ]
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
                {player_srun ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 9)
		self.weaponframe = 1;
        SuperDamageSound();
	self.attempthit=self.attempthit + 1;
	W_FireSpikes (-4);
	self.attack_finished = time + 0.2;
};

//============================================================================

void() player_slight1   =[$slight1, player_slight2  ] 
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
                {player_srun ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
        StaySlow();
        SuperDamageSound();
	W_FireLightning();
	self.attack_finished = time + 0.2;
};

void() player_slight2   =[$slight2, player_slight1  ]
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
                {player_srun ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
        StaySlow();
        SuperDamageSound();
	W_FireLightning();
	self.attack_finished = time + 0.2;
};

//============================================================================


void() player_srocket1   =[$srockatt1, player_srocket2  ] {self.weaponframe=1;
self.effects = self.effects | EF_MUZZLEFLASH;StaySlow();};
void() player_srocket2   =[$srockatt2, player_srocket3  ] {self.weaponframe=2;StaySlow();};
void() player_srocket3   =[$srockatt3, player_srocket4  ] {self.weaponframe=3;StaySlow();};
void() player_srocket4   =[$srockatt4, player_srocket5  ] {self.weaponframe=4;StaySlow();};
void() player_srocket5   =[$srockatt5, player_srocket6  ] {self.weaponframe=5;StaySlow();};
void() player_srocket6   =[$srockatt6, player_srun  ] {self.weaponframe=6;StaySlow();};

void()  player_spain1 =  [       $spain1, player_spain2    ] {PainSound();self.weaponframe=0;StaySlow();};
void()  player_spain2 =  [       $spain2, player_spain3    ] {StaySlow();};
void()  player_spain3 =  [       $spain3, player_spain4    ] {StaySlow();};
void()  player_spain4 =  [       $spain4, player_spain5    ] {StaySlow();};
void()  player_spain5 =  [       $spain5, player_spain6    ] {StaySlow();};
void()  player_spain6 =  [       $spain6, player_srun      ] {StaySlow();};

void()  player_saxpain1 =        [       $saxpain1,       player_saxpain2  ] {PainSound();self.weaponframe=0;StaySlow();};
void()  player_saxpain2 =        [       $saxpain2,       player_saxpain3  ] {StaySlow();};
void()  player_saxpain3 =        [       $saxpain3,       player_saxpain4  ] {StaySlow();};
void()  player_saxpain4 =        [       $saxpain4,       player_saxpain5  ] {StaySlow();};
void()  player_saxpain5 =        [       $saxpain5,       player_saxpain6  ] {StaySlow();};
void()  player_saxpain6 =        [       $saxpain6,       player_srun      ] {StaySlow();};

void(entity attacker, float damage) player_spain =
{

        damage_attacker = self.enemy;

    if(self.saber.running&&damage>=self.max_health*0.25&&random()<0.5)
                {
                self.saber.velocity_z=self.saber.velocity_z + 300;
                Drop(self.saber);
                }

    if (self.weaponframe||self.skin>24)
		return;

	if (self.invisible_finished > time)
            if(self.racename=="Predator")
                PredCloakMalFunc();
            else return;         // eyes don't have pain frames

        StaySlow();

        if (self.weapon == IT_AXE)
                player_saxpain1 ();
	else
                player_spain1 ();
};

void()  player_ssixl1 =  [$sshotatt1, player_ssixl2        ] {self.weaponframe=1;
self.effects = self.effects | EF_MUZZLEFLASH;};
void()  player_ssixl2 =  [$sshotatt3, player_ssixl3        ] {self.weaponframe=2;};
void()  player_ssixl3 =  [$sshotatt6, player_srun  ] {self.weaponframe=3;};

void()  player_ssixr1 =  [$sshotatt1, player_ssixr2        ] {self.weaponframe=4;
self.effects = self.effects | EF_MUZZLEFLASH;};
void()  player_ssixr2 =  [$sshotatt3, player_ssixr3        ] {self.weaponframe=5;};
void()  player_ssixr3 =  [$sshotatt6, player_srun  ] {self.weaponframe=6;};

void()  player_sreload1 =  [$sstand1, player_sreload2        ] {self.weaponframe=7;};
void()  player_sreload2 =  [$sstand2, player_sreload3        ] {self.weaponframe=8;};
void()  player_sreload3 =  [$sstand3, player_sreload4        ] {self.weaponframe=9;};
void()  player_sreload4 =  [$sstand4, player_sreload5        ] {self.weaponframe=9;};
void()  player_sreload5 =  [$sstand5, player_sreload6        ] {self.weaponframe=9;};
void()  player_sreload6 =  [$sstand1, player_sreload7        ] {self.weaponframe=9;};
void()  player_sreload7 =  [$sstand2, player_sreload8        ] {self.weaponframe=9;};
void()  player_sreload8 =  [$sstand3, player_sreload9        ] {self.weaponframe=9;};
void()  player_sreload9 =  [$sstand4, player_sreload0        ] {self.weaponframe=8;};
void()  player_sreload0 =  [$sstand5, player_srun  ] {self.weaponframe=7;};

// This is my poor attempt to add something useful 

// Globals

.float isfeign;
.string oldweaponmodel;         // change to local?
.float oldweapon;               // change to local?
.float foolplay;

// Frames
//
//      I had to re-init them all to be able to call them.
// If I had this function in player.qc, this wouldn't be
// necessary, but then it would be less modular.

$cd /raid/quake/id1/models/player_4
$origin 0 -6 24
$base base		
$skin skin

$frame axrun1 axrun2 axrun3 axrun4 axrun5 axrun6
$frame rockrun1 rockrun2 rockrun3 rockrun4 rockrun5 rockrun6
$frame stand1 stand2 stand3 stand4 stand5
$frame axstnd1 axstnd2 axstnd3 axstnd4 axstnd5 axstnd6
$frame axstnd7 axstnd8 axstnd9 axstnd10 axstnd11 axstnd12
$frame axpain1 axpain2 axpain3 axpain4 axpain5 axpain6
$frame pain1 pain2 pain3 pain4 pain5 pain6
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
$frame nailatt1 nailatt2
$frame light1 light2
$frame rockatt1 rockatt2 rockatt3 rockatt4 rockatt5 rockatt6
$frame shotatt1 shotatt2 shotatt3 shotatt4 shotatt5 shotatt6
$frame axatt1 axatt2 axatt3 axatt4 axatt5 axatt6
$frame axattb1 axattb2 axattb3 axattb4 axattb5 axattb6
$frame axattc1 axattc2 axattc3 axattc4 axattc5 axattc6
$frame axattd1 axattd2 axattd3 axattd4 axattd5 axattd6

// Falling down animation.  Any would have done.
/*
void()  player_feigna1    =       [       $deatha1,       player_feigna2    ] {};
void()  player_feigna2    =       [       $deatha2,       player_feigna3    ] {};
void()  player_feigna3    =       [       $deatha3,       player_feigna4    ] {};
void()  player_feigna4    =       [       $deatha4,       player_feigna5    ] {};
void()  player_feigna5    =       [       $deatha5,       player_feigna6    ] {};
void()  player_feigna6    =       [       $deatha6,       player_feigna7    ] {};
void()  player_feigna7    =       [       $deatha7,       player_feigna8    ] {};
void()  player_feigna8    =       [       $deatha8,       player_feigna9    ] {};
void()  player_feigna9    =       [       $deatha9,       player_feigna10   ] {};
void()  player_feigna10   =       [       $deatha10,      player_feigna11   ] {};
void()  player_feigna11   =       [       $deatha11,      player_feigna11   ] {};
*/

// Standing up animation.  This one looks the best.

void()  player_upa1    =       [       $deathd9,        player_upa2    ] {};
void()  player_upa2    =       [       $deathd8,        player_upa3    ] {};
void()  player_upa3    =       [       $deathd7,        player_upa4    ] {};
void()  player_upa4    =       [       $deathd6,        player_upa5    ] {};
void()  player_upa5    =       [       $deathd5,        player_upa6    ] {};
void()  player_upa6    =       [       $deathd4,        player_upa7    ] {};
void()  player_upa7    =       [       $deathd3,        player_upa8    ] {};
void()  player_upa8    =       [       $deathd2,        player_upa9    ] {};
void()  player_upa9    =       [       $deathd1,        player_upa9    ] {player_stand1 ();};


//      I had to make new backpack routines so that you wouldn't give up 
// your ammo, pick it up while you're throwing it, and have a neat message.

void() FakeBackpackTouch =
{
        if (other.classname != "player")        // Monsters won't pick up
		return;
        if (other.health <= 0)                  // Dead people won't pick up
		return;
        if ( (self.owner == other) && ( (self.nextthink - time) > 99 ) )        // The thrower won't pick up
                return;                                                         // unless 20 sec has passed.

        sprint (other, "Hmmmm, empty...\n");
        sound (other, CHAN_ITEM, "weapons/lock4.wav", 1, ATTN_NORM);    // backpack touch sound
        stuffcmd (other, "bf\n");       // flashes the screen
	remove(self);
	
};


void() FakeBackpack =
{
	local entity	item;

	item = spawn();
        item.owner = self;
        item.origin = self.origin - '0 0 24';
	item.velocity_z = 300;
	item.velocity_x = -100 + (random() * 200);
	item.velocity_y = -100 + (random() * 200);
	item.flags = FL_ITEM;
	item.solid = SOLID_TRIGGER;
        item.movetype = MOVETYPE_TOSS;
	setmodel (item, "progs/backpack.mdl");
	setsize (item, '-16 -16 0', '16 16 56');
        item.touch = FakeBackpackTouch;
	item.nextthink = time + 120;	// remove after 2 minutes
	item.think = SUB_Remove;
};

void() feign =
{
        if (!self.isfeign)              // If not already, feign death
        {
                self.foolplay = FALSE;
//                        player_feigna1 ();      // death animation
                        player_diea1 ();      // death animation
                        DeathSound();           // yell like you're dying
                        FakeBackpack();         // throw fake backpack
                self.oldweapon = self.weapon;   
                self.weapon = 0;
                self.oldweaponmodel = self.weaponmodel;
                self.weaponmodel = "";
                setsize (self , '-16 -16 -4' , '16 16 4');      // change bounding bos so you're shorter
                self.view_ofs = '0 0 2';        // put view near ground
                self.movetype = MOVETYPE_TOSS;
                self.isfeign = TRUE;
                if (self.enemy.classname == "player")
                        {
                        self.enemy.frags = self.enemy.frags + 1;
                        self.foolplay = TRUE;
                        }
                else
                        {
                        self.frags = self.frags - 1;
                        self.foolplay = FALSE;   
                        }
        }

        else                    // otherwise, get up

        {
                self.movetype = MOVETYPE_WALK;
                setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
                self.view_ofs = '0 0 22';
                self.isfeign = FALSE;
                player_upa1();
                self.weaponmodel = self.oldweaponmodel;
                self.weapon = self.oldweapon;
                self.oldweapon = 0;
                if (self.foolplay)
                        self.enemy.frags = self.enemy.frags - 1;
                else
                        self.frags = self.frags + 1;
        self.foolplay = FALSE; 
        }
};

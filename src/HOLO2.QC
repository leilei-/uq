void() holo_stand1; // = [12, holo_stand2] {};

void(entity me, entity camera) HoloView =
{
  // Set view point
  msg_entity = me;                         // target of message
  WriteByte (MSG_ONE, SVC_SETVIEWPORT);    // 5 = SVC_SETVIEWPORT;  
  WriteEntity (MSG_ONE, camera);           // view port
  // Also set angles, otherwise it feels strange
  // NezuSetViewAngle(me, camera.angles);
  WriteByte (MSG_ONE, SVC_SETVIEWANGLES);  // 10 = SVC_SETVIEWANGLES
  WriteAngle(MSG_ONE, camera.angles_x);    // tilt 
  WriteAngle(MSG_ONE, camera.angles_y);    // yaw
  WriteAngle(MSG_ONE, camera.angles_z);    // flip
};

void(entity me) HoloCam = 
{
  local entity camera, viewpoint;
  local	vector me_src;
  local vector me_targ;
  local vector me_fire;

  if (me.newholo.active)
        viewpoint = me.newholo;
  else if (me.teleeyes.active)
        viewpoint = me.teleeyes;
  else
        {
        sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
        sprint (self,"Neither Holograph or TeleEyes are Active!\n");
        return;
        }


  if(me.aflag!=0)                // camera is on, set it off
  { 
    camera=me;
    HoloView(me, me);      // restore player position
    sprint(me,"Remote Camera off\n");
    me.aflag=0;                  // camera is ready
    //do not change me.trigger_field  for the NezuCameraCycle
  }
  else                             // camera is off, try to set it on
  {
    HoloView(me, viewpoint);       // Restore player position
    sound (self, CHAN_AUTO, "items/inv3.wav", 0.5, ATTN_IDLE);
    sprint(me,"Remote Camera on!\n");      // Message for player
    me.aflag=666;                       // Camera is on
  }
};

void() DetHolo =
{
	local float	damg;

        if (self.teleeyes.active)
                {
                if (self.aflag == 666)
                        HoloCam (self);
                remove (self.teleeyes);
                sprint (self,"TeleEyes Deactivated\n");
                self.teleeyes.active = FALSE;
                return;
                }

        if (self.newholo.active == FALSE)
                {
                sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                sprint (self,"Neither Holograph nor TeleEyes are Active!\n");
                return;
                }

        if (self.mana < 10)
                {
                sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                sprint (self, "Not enough mana to detonate Holo\n");
                return;
                }

        if (self.aflag == 666)
                HoloCam (self);

	damg = 100 + random()*20;
	
        self.mana = rint(time - self.init_mana);
        if (self.mana > self.exp)
                self.mana = self.exp;
        self.init_mana = time - self.mana + 10;

        T_RadiusDamage (self.newholo, self, 300, self.newholo);

        sound (self.newholo, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
        self.newholo.origin = self.newholo.origin - 8*normalize(self.newholo.velocity);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
        WriteCoord (MSG_BROADCAST, self.newholo.origin_x);
        WriteCoord (MSG_BROADCAST, self.newholo.origin_y);
        WriteCoord (MSG_BROADCAST, self.newholo.origin_z);

        sprint(self,"Holograph Detonated\n");
        self.newholo.active = FALSE;
        remove (self.newholo);
};

//--------------------------------------------------------------------
// When time expires holograph gets deactivated
//--------------------------------------------------------------------
void(entity actor) RemoveHolo =
{
        if (actor.owner.aflag == 666)
                HoloCam (actor.owner);

        if (actor.owner.mana < 0)
                actor.owner.mana = 0;

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_TELEPORT);
        WriteCoord (MSG_BROADCAST, actor.origin_x);
        WriteCoord (MSG_BROADCAST, actor.origin_y);
        WriteCoord (MSG_BROADCAST, actor.origin_z);
        sound (actor, CHAN_BODY, "misc/r_tele1.wav", 1, ATTN_NORM);
        actor.active = FALSE;
        actor.feigning = FALSE;
        actor.isfeign = FALSE;
        sprint(actor.owner,"Holograph Removed\n");
        remove(actor);
};

//--------------------------------------------------------------------
// Frames for holograph self
//--------------------------------------------------------------------

//--------------------------------------------------------------------
// Spawns holograph self
//--------------------------------------------------------------------
void(entity myself) ActivateHolo =
{
local entity hol;
        hol = spawn();
        hol.solid = SOLID_BBOX;
        hol.takedamage = DAMAGE_AIM;
        hol.health = 99999999;
        hol.movetype = MOVETYPE_NOCLIP;
        hol.origin = myself.origin;
        hol.angles = myself.angles;
        setsize (hol, VEC_HULL_MIN, VEC_HULL_MAX);
        hol.colormap = myself.colormap;
        hol.skin = myself.skin;
        setmodel (hol, "progs/player.mdl");
        hol.classname = "holo";
        hol.owner=myself;
        myself.newholo = hol;
        stuffcmd (hol.owner, "bf\n");
        sprint(hol.owner,"Holograph activated\n");
        hol.nextthink = time; 
        hol.think = holo_stand1;    
        hol.active = TRUE;
        hol.th_stand = SUB_Null;
        hol.th_walk = SUB_Null;
        hol.th_run = SUB_Null;
        hol.th_pain = SUB_Null;
        hol.th_melee = SUB_Null;
        hol.th_missile = SUB_Null;
        hol.th_die = GrenadeExplode;
        hol.beendead = TRUE;
};



//--------------------------------------------------------------------
// Checks if holograph should be activated
//--------------------------------------------------------------------
void() CheckHoloCommand = 
{
        if (self.newholo.active == TRUE)
                {
                sprint (self,"Deactivating Holograph\n");
                RemoveHolo(self.newholo);
                return;
                }
        if (self.mana < 10)
	{
                sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                sprint(self,"Mana is too low!\n");
		return;
	}
        if (self.teleeyes.active)
        {
                sound (self, CHAN_WEAPON, "doors/basetry.wav", 1 , ATTN_NORM);
                sprint(self,"Deactivate your Tele-Eyes first!\n");
                return;
        }
	ActivateHolo (self);
}; 

void(entity actor) feign =
{
        if (!actor.isfeign)              // If not already, feign death
        {
                actor.view_ofs = '0 0 2';
                if (self.enemy.classname == "player")
                        self.enemy.frags = self.enemy.frags + 1;
                else
                        self.frags = self.frags - 1;
                actor.isfeign = TRUE;
                if(actor.classname=="holo")
                        sprint (self, "Holograph feigning death...\n");
                else{actor.movetype = MOVETYPE_TOSS;setsize (actor , '-16 -16 -4' , '16 16 4');self.impulse=20;DropBackpack();player_diea1();}
        }
        else                    // otherwise, get up
        {
                setsize (actor, VEC_HULL_MIN, VEC_HULL_MAX);
                actor.view_ofs = '0 0 22';
                if (self.enemy.classname == "player")
                        self.enemy.frags = self.enemy.frags - 1;
                else
                        self.frags = self.frags + 1;
        actor.isfeign = FALSE;
        if(actor.classname=="holo")
                sprint (self, "Holograph has stopped fiegning...\n");
        else{actor.movetype = MOVETYPE_WALK;holo_upa1();}
        }
};

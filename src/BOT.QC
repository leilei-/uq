/*
Multiplayer RoBot and Charmed/Ressurected Player
by Michael Gummelt

ROUTINES:
Stand- Stand and wait.
Walk- Move slowly towards a goal.
Run- Move rapidly towards a goal.
Jump- Jump up.
Swim- Move in water.
Climb- Climb a wall.
Pain- Pain sounds and animation.
Death- Die.
Turn- Turn to look and examine or face enemy.
Hunt- Follow an enemy if visible.
Track- Determine where enemy may have went.
Advance- Move forward towards a goal (even if it's to run from an
        enemy towards a safe area).  Most frequently called function,
        determines how to best get to a specific goal.
Retreat- Move away from a goal (get as far away from a goal as
        possible with no destination in mind).
Wander- Select a random goal.
Find- Determine what spot to advance to.
Hide- Wait in this spot an remain inconspicuous.
Duck- Crouch down/Get up.
Feign- Play Dead.
Wait- Wait until a certain condition is met before taking
        a certain action (not health or ambush related)
Rest- Stay in one spot until health is retored).
Look- Set v_angles.
Aim- Determine line to target, best aim possible.
Attack- Fire a weapon or use any other attack.
SelectWeapon- Determine which weapon is best to use.
Ambush- Hide and Wait until enemy appears close by.
Careful- Watch for ambushes and traps.
Lure- Make enemy follow you.
Peekaboo- Pop in and out of cover.
Strafe- Slide side to side.
Err- Make a mistake as in aiming or weapon selection or panic
        running.
Mercy- Don't take advantage of a clear shot.
SelectSpell- Find a spell to use on enemy.
Cast- Cast a spell.
RememberLoc_Ammo- Remember the location of ammo found.
RememberLoc_Weapon- Remember the location of weapons found (will put
        priority on the better weapons).
RememberLoc_Health- Remember the location of health found.
RememberLoc_Armor- Remember the location of armor found.
RememberLoc_LastSeen- Remember the last place enemy was seen.
RememberLoc_MostWeapon- Remember what weapon your enemy uses most.
RememberLoc_Kill- Remember the last place your enemy was killed.
RememberLoc_Fail- Remember last spot you were killed or majorly
        wounded. (Spots to avoid).
RememberStrategy- Remember the strategies that were most successful
        (i.e.: weapon, location, tactic (ambush, hunt, magic, etc.))
RememberTrap- Remember traps that harmed you (to use in the
        Careful routine).
*/

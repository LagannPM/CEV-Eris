
/*
	apply_damage(a,b,c)
	args
	a:damage - How much damage to take
	b:damage_type - What type of damage to take, brute, burn
	c:def_zone - Where to take the damage if its brute or burn
	Returns
	standard 0 if fail
*/
/mob/living/proc/apply_damage(var/damage = 0,var/damagetype = BRUTE, var/def_zone = null, var/blocked = 0, var/used_weapon = null, var/sharp = 0, var/edge = 0)
	if(!damage || (blocked >= 2))	return 0
	switch(damagetype)
		if(BRUTE)
			adjustBruteLoss(damage/(blocked+1))
		if(BURN)
			if(COLD_RESISTANCE in mutations)	damage = 0
			adjustFireLoss(damage/(blocked+1))
		if(TOX)
			adjustToxLoss(damage/(blocked+1))
		if(OXY)
			adjustOxyLoss(damage/(blocked+1))
		if(CLONE)
			adjustCloneLoss(damage/(blocked+1))
		if(HALLOSS)
			adjustHalLoss(damage/(blocked+1))
	flash_weak_pain()
	updatehealth()
	return 1


/mob/living/proc/apply_damages(var/brute = 0, var/burn = 0, var/tox = 0, var/oxy = 0, var/clone = 0, var/halloss = 0, var/def_zone = null, var/blocked = 0)
	if(blocked >= 2)	return 0
	if(brute)	apply_damage(brute, BRUTE, def_zone, blocked)
	if(burn)	apply_damage(burn, BURN, def_zone, blocked)
	if(tox)		apply_damage(tox, TOX, def_zone, blocked)
	if(oxy)		apply_damage(oxy, OXY, def_zone, blocked)
	if(clone)	apply_damage(clone, CLONE, def_zone, blocked)
	if(halloss) apply_damage(halloss, HALLOSS, def_zone, blocked)
	return 1



/mob/living/proc/apply_effect(var/effect = 0,var/effecttype = STUN, var/blocked = 0, var/check_protection = 1)
	if(!effect || (blocked >= 2))	return 0
	switch(effecttype)
		if(STUN)
			Stun(effect/(blocked+1))
		if(WEAKEN)
			Weaken(effect/(blocked+1))
		if(PARALYZE)
			Paralyse(effect/(blocked+1))
		if(AGONY)
			halloss += effect // Useful for objects that cause "subdual" damage. PAIN!
		if(IRRADIATE)
			var/rad_protection = check_protection ? getarmor(null, "rad")/100 : 0
			radiation += max((1-rad_protection)*effect/(blocked+1),0)//Rads auto check armor
		if(STUTTER)
			if(status_flags & CANSTUN) // stun is usually associated with stutter
				stuttering = max(stuttering,(effect/(blocked+1)))
		if(EYE_BLUR)
			eye_blurry = max(eye_blurry,(effect/(blocked+1)))
		if(DROWSY)
			drowsyness = max(drowsyness,(effect/(blocked+1)))
	updatehealth()
	return 1


/mob/living/proc/apply_effects(var/stun = 0, var/weaken = 0, var/paralyze = 0, var/irradiate = 0, var/stutter = 0, var/eyeblur = 0, var/drowsy = 0, var/agony = 0, var/blocked = 0)
	if(blocked >= 2)	return 0
	if(stun)		apply_effect(stun, STUN, blocked)
	if(weaken)		apply_effect(weaken, WEAKEN, blocked)
	if(paralyze)	apply_effect(paralyze, PARALYZE, blocked)
	if(irradiate)	apply_effect(irradiate, IRRADIATE, blocked)
	if(stutter)		apply_effect(stutter, STUTTER, blocked)
	if(eyeblur)		apply_effect(eyeblur, EYE_BLUR, blocked)
	if(drowsy)		apply_effect(drowsy, DROWSY, blocked)
	if(agony)		apply_effect(agony, AGONY, blocked)
	return 1


// heal ONE external organ, organ gets randomly selected from damaged ones.
/mob/living/proc/heal_organ_damage(var/brute, var/burn, var/additionalyBrutePercent = 0, var/additionalyBurnPercent = 0)
	adjustBruteLoss(-(brute + getBruteLoss()/100 * additionalyBrutePercent))
	adjustFireLoss(-(burn + getFireLoss()/100 * additionalyBurnPercent))
	src.updatehealth()

// damage ONE external organ, organ gets randomly selected from damaged ones.
/mob/living/proc/take_organ_damage(var/brute, var/burn, var/emp=0)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	adjustBruteLoss(brute)
	adjustFireLoss(burn)
	src.updatehealth()

// heal MANY external organs, in random order
/mob/living/proc/heal_overall_damage(var/brute, var/burn)
	adjustBruteLoss(-brute)
	adjustFireLoss(-burn)
	src.updatehealth()

// damage MANY external organs, in random order
/mob/living/take_overall_damage(var/brute, var/burn, var/used_weapon = null)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	adjustBruteLoss(brute)
	adjustFireLoss(burn)
	src.updatehealth()


/mob/living/get_fall_damage(var/turf/from, var/turf/dest)
	var/damage = min(15, maxHealth*0.4)

	//If damage is multiplied by the number of floors you fall simultaneously
	if (from && dest)
		damage *= abs(from.z - dest.z)+1
	return damage

/mob/living/fall_impact(var/turf/from, var/turf/dest)
	var/damage = get_fall_damage(from, dest)
	if (damage > 0)
		take_overall_damage(damage)
		playsound(src, pick(punch_sound), 100, 1, 10)
		Weaken(4)
		updatehealth()
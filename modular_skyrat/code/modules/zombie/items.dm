/obj/item/zombie_hand
	name = "necrotic claw"
	desc = "A black, cancerous growth of a hand. Large knife-like claws jut out from where there used to be fingers, black goo dripping from the rotten and twisted flesh. \
	Can be used to smash down things such as airlocks, gib simple mobs for health, and infect humanoid creatures."
	icon = 'modular_skyrat/icons/obj/items/claw.dmi'
	icon_state = "clawhand_left"
	icon_left = "clawhand_left"
	icon_right = "clawhand_right"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/claws_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/claws_righthand.dmi'

/obj/item/zombie_hand/nightmare
	name = "claw of darkness"
	icon_state = "clawhand_left_NM"
	icon_left = "clawhand_left_NM"
	icon_right = "clawhand_right_NM"
	force = 25

/obj/item/zombie_hand/nightmare/afterattack(atom/movable/AM, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(isopenturf(AM))
		var/turf/open/T = AM
		if(T.light_range && !isspaceturf(T)) //no fairy grass or light tile can escape the fury of the darkness.
			to_chat(user, "<span class='notice'>You scrape away [T] with your [name] and snuff out its lights.</span>")
			T.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	else if(isliving(AM))
		var/mob/living/L = AM
		if(iscyborg(AM))
			var/mob/living/silicon/robot/borg = AM
			if(borg.lamp_intensity)
				borg.update_headlamp(TRUE, INFINITY)
				to_chat(borg, "<span class='danger'>Your headlamp is fried! You'll need a human to help replace it.</span>")
			for(var/obj/item/assembly/flash/cyborg/F in borg.held_items)
				if(!F.crit_fail)
					F.burn_out()
		else
			for(var/obj/item/O in AM)
				if(O.light_range && O.light_power)
					disintegrate(O)
		if(L.pulling && L.pulling.light_range && isitem(L.pulling))
			disintegrate(L.pulling)
	else if(isitem(AM))
		var/obj/item/I = AM
		if(I.light_range && I.light_power)
			disintegrate(I)

/obj/item/zombie_hand/nightmare/proc/disintegrate(obj/item/O)
	if(istype(O, /obj/item/pda))
		var/obj/item/pda/PDA = O
		PDA.set_light(0)
		PDA.fon = FALSE
		PDA.f_lum = 0
		PDA.update_icon()
		visible_message("<span class='danger'>The light in [PDA] shorts out!</span>")
	else if(istype(O, /obj/item/gun))
		var/obj/item/gun/weapon = O
		if(weapon.gun_light)
			var/obj/item/flashlight/seclite/light = weapon.gun_light
			light.forceMove(get_turf(weapon))
			light.burn()
			weapon.gun_light = null
			weapon.update_gunlight()
			QDEL_NULL(weapon.alight)
			visible_message("<span class='danger'>[light] on [O] flickers out and disintegrates!</span>")
	else
		visible_message("<span class='danger'>[O] is disintegrated by [src]!</span>")
		O.burn()
	playsound(src, 'sound/items/welder.ogg', 50, 1)
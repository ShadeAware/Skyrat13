//Base suit and modules
/obj/item/clothing/suit/space/hardsuit
	var/list/startingattachments = list() //list of "modules" installed on initialization
	var/list/currentattachments = list() //list of "modules" currently being used

/obj/item/clothing/suit/space/hardsuit/Initialize()
	. = ..()
	if(startingattachments.len)
		for(var/obj/item/I in startingattachments)
			if(istype(src, I.suit_type))
				var/obj/item/O = new I(src)
				currentattachments += O
				O.on_suit_attach(src)

/obj/item/clothing/suit/space/hardsuit/attackby(obj/item/I, mob/user, params)
	if(!attachitem(I, user))
		if(istype(I, /obj/item/screwdriver))
			if(src == user.get_item_by_slot(SLOT_WEAR_SUIT))
				to_chat(user, "<span class='warning'>You cannot remove [src]'s attachments while it is being worn.</span>")
				return FALSE
			else
				removeallattachments(user)
				return TRUE
	return ..()

/obj/item/clothing/suit/space/hardsuit/proc/attachitem(obj/item/I, mob/user)
	if(I.suit_attachment)
		if(istype(src, I.suit_type)) //i don't think it's possible to get a "base" hardsuit ingame via normal means - this shouldn't cause many problems
			for(var/obj/item/sameitem in currentattachments)
				if(istype(I, sameitem))
					to_chat(user, "<span class='notice'>[src] already has an attachment of the same type! Remove similar attachments before attaching [I].</span>")
					return FALSE
			if(user.transferItemToLoc(I, src))
				currentattachments += I
				I.on_suit_attach(src, user)
				to_chat(user, "<span class='notice'>You successfully install [I] on [src].</span>")
				return TRUE
			else
				to_chat(user, "<span class='notice'>[I] could not be installed on [src].</span>")
				return FALSE
	return FALSE

/obj/item/clothing/suit/space/hardsuit/proc/removeallattachments(mob/user)
	for(var/obj/item/O in currentattachments)
		O.forceMove(drop_location())
		currentattachments -= O
		O.on_suit_unattach(src, user)
		to_chat(user, "<span class='notice'>You successfully remove the [O] from [src].</span>")
	return TRUE

/obj/item/clothing/suit/space/hardsuit/equipped(mob/user, slot)
	..()
	if(slot == SLOT_WEAR_SUIT)
		for(var/obj/item/I in currentattachments)
			for(var/datum/action/A in I.actions)
				A.Grant(user)

/obj/item/clothing/suit/space/hardsuit/dropped(mob/user)
	..()
	for(var/obj/item/I in currentattachments)
		for(var/datum/action/A in I.actions)
			A.Remove(user)
		if(I.loc != src)
			I.forceMove(src)

//Hardsuit "modules"
/obj/item/melee/transforming/armblade
	name = "Hardsuit Blade"
	desc = "A pointy, murdery blade that can be attached to your hardsuit."
	force = 0
	force_on = 20
	sharpness = IS_BLUNT
	var/sharpness_on = IS_SHARP
	throwforce = 0
	throwforce_on = 0
	hitsound_on = 'sound/weapons/bladeslice.ogg'
	armour_penetration = 0
	var/armour_penetration_on = 25
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "armblade0"
	icon_state_on = "armblade1"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi' //PLACEHOLDER!!!!!
	item_state = null
	var/item_state_on = "energy_katana"
	attack_verb_off = list("bopped")
	total_mass_on = 0.6
	actions_types = list(/datum/action/item_action/extendoblade)
	var/extendo = FALSE
	suit_attachment = TRUE

/datum/action/item_action/extendoblade
	name = "Extend Blade"
	desc = "Extend the hardsuit's blade."

/obj/item/melee/transforming/armblade/ui_action_click(mob/user, action)
	var/datum/action/item_action/hightractionaction = action
	if(istype(action, /datum/action/item_action/extendoblade) && istype(loc, /obj/item/clothing/suit/space/hardsuit))
		var/mob/living/carbon/human/H = user
		if(H)
			var/obj/item/arm_item = user.get_active_held_item()
			if(arm_item)
				if(!user.dropItemToGround(arm_item))
					to_chat(user, "<span class='warning'>Your [arm_item] interferes with the activation of [src]!</span>")
					return
				else
					to_chat(user, "<span class='notice'>You drop [arm_item] to activate [src]!</span>")
			user.put_in_r_hand(src)
			ADD_TRAIT(src, TRAIT_NODROP, "hardsuit")
			playsound(get_turf(user), 'sound/mecha/mechmove03.ogg', 50, pick(list(-1,0,1)))
			extendo = !extendo
			if(istype(hightractionaction))
				hightractionaction.desc = "[extendo ? "Retract":"Extend"] the hardsuit's blade."

	else if (istype(action, /datum/action/item_action/extendoblade) && !istype(loc, /obj/item/clothing/suit/space/hardsuit))
		REMOVE_TRAIT(src, TRAIT_NODROP, "hardsuit")
		user.transferItemToLoc(src, user.get_item_by_slot(SLOT_WEAR_SUIT))
		playsound(get_turf(user), 'sound/mecha/mechmove03.ogg', 50, 1)
		extendo = !extendo
		if(istype(hightractionaction))
			hightractionaction.desc = "[extendo ? "Retract":"Extend"] the hardsuit's blade."

/obj/item/melee/transforming/armblade/Initialize()
	..()
	AddComponent(/datum/component/butchering, 50, 100, 0, hitsound_on)

/obj/item/melee/transforming/armblade/transform_weapon(mob/living/user, supress_message_text)
	..()
	if(active)
		sharpness = sharpness_on
		armour_penetration = armour_penetration_on
		item_state = item_state_on
	else
		sharpness = initial(sharpness)
		armour_penetration = initial(armour_penetration)
		item_state = initial(item_state)

/obj/item/melee/transforming/armblade/transform_messages(mob/living/user, supress_message_text)
	playsound(user, active ? 'sound/weapons/batonextend.ogg' : 'sound/items/sheath.ogg', 50, 1)
	if(!supress_message_text)
		to_chat(user, "<span class='notice'>[src] [active ? "has been extended":"has been concealed"].</span>")

/obj/item/melee/transforming/armblade/attack(mob/living/target, mob/living/carbon/human/user)
	var/obj/item/clothing/suit/space/hardsuit/hard = user.get_item_by_slot(SLOT_WEAR_SUIT)
	if(!istype(hard))
		to_chat(user, "<span class='notice'>[src] can only be used while attached to a hardsuit.</span>")
		return FALSE
	else if(!(src in hard.currentattachments))
		to_chat(user, "<span class='notice'>[src] can only be used while attached to a hardsuit.</span>")
		return FALSE
	else
		..()

/obj/item/melee/transforming/armblade/attack_self(mob/living/carbon/user)
	var/obj/item/clothing/suit/space/hardsuit/hard = user.get_item_by_slot(SLOT_WEAR_SUIT)
	if(!istype(hard))
		to_chat(user, "<span class='notice'>[src] can only be used while attached to a hardsuit.</span>")
		return FALSE
	else if(!(src in hard.currentattachments))
		to_chat(user, "<span class='notice'>[src] can only be used while attached to a hardsuit.</span>")
		return FALSE
	else
		..()

/obj/item/tank/jetpack/suit
	suit_attachment = TRUE

///////////////////////// POWER ARMOR MODULES /////////////////////////////
/obj/item/melee/transforming/armblade/powerarmor_blade
	name = "Power Armor armblade"
	desc = "A long, sharp and retractable arm-mounted blade. Made to be attached to a suit of Power Armor."
	icon = 'modular_skyrat/icons/obj/powerarmor_attachments.dmi'
	icon_state = "powerblade0"
	icon_state_on = "powerblade1"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/pwrblade_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/pwrblade_righthand.dmi'
	item_state = "pwrblade-0"
	item_state_on = "pwrblade-1"
	suit_type = /obj/item/clothing/suit/space/hardsuit/powerarmor

/obj/item/holotool/powerarmor_holotool
	name = "Power Armor holotool"
	desc = "An advanced hardlight projection apparatus, tuned to form the shapes of commonly used tools. Made to be attached to a suit of Power Armor."
	suit_attachment = TRUE
	suit_type = /obj/item/clothing/suit/space/hardsuit/powerarmor
	var/extendo = FALSE

/datum/action/item_action/extendotool
	name = "Extend Holotool"
	desc = "Extend the Power Armor's holotool."

/obj/item/holotool/powerarmor_holotool/ui_action_click(mob/user, action)
	var/datum/action/item_action/hightractionaction = action
	if(istype(hightractionaction) && istype(loc, /obj/item/clothing/suit/space/hardsuit/))
		var/mob/living/carbon/human/H = user
		if(H)
			var/obj/item/arm_item = user.get_active_held_item()
			if(arm_item)
				if(!user.dropItemToGround(arm_item))
					to_chat(user, "<span class='warning'>Your [arm_item] interferes with the activation of [src]!</span>")
					return
				else
					to_chat(user, "<span class='notice'>You drop [arm_item] to activate [src]!</span>")
		user.put_in_r_hand(src)
		ADD_TRAIT(src, TRAIT_NODROP, "hardsuit")
		playsound(get_turf(user), 'sound/mecha/mechmove03.ogg', 50, pick(list(-1,0,1)))
		extendo = !extendo
		if(istype(hightractionaction))
			hightractionaction.desc = "Toggle the Power Armor's holotool."
			hightractionaction.desc = "[extendo ? "Retract":"Extend"] the Power Armor's holotool."

	else if (istype(hightractionaction) && !istype(loc, /obj/item/clothing/suit/space/hardsuit))
		REMOVE_TRAIT(src, TRAIT_NODROP, "hardsuit")
		user.transferItemToLoc(src, user.get_item_by_slot(SLOT_WEAR_SUIT))
		playsound(get_turf(user), 'sound/mecha/mechmove03.ogg', 50, 1)
		extendo = !extendo
		if(istype(hightractionaction))
			hightractionaction.desc = "[extendo ? "Retract":"Extend"] the Power Armors holotool."

/obj/item/holotool/powerarmor_holotool/CtrlClick(mob/user)
	var/obj/item/clothing/suit/space/hardsuit/hard = user.get_item_by_slot(SLOT_WEAR_SUIT)
	if(!istype(hard))
		to_chat(user, "<span class='notice'>[src] can only be used while attached to a suit of Power Armor.</span>")
		return FALSE
	else if(!(src in hard.currentattachments))
		to_chat(user, "<span class='notice'>[src] can only be used while attached to a suit of Power Armor.</span>")
		return FALSE
	else
		update_listing()
		var/chosen = show_radial_menu(user, src, radial_modes, custom_check = CALLBACK(src, .proc/check_menu,user))
		if(!check_menu(user))
			return
		if(chosen)
			var/new_tool = LAZYACCESS(mode_names, chosen)
			if(new_tool)
				switch_tool(user, new_tool)


//Power armor
/obj/item/clothing/head/helmet/space/hardsuit/powerarmor
	name = "Power Armor Helmet MK. I"
	desc = "An advanced helmet attached to a powered exoskeleton suit. Protects well against most forms of harm, but struggles against exotic hazards."
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	icon_state = "hardsuit0-powerarmor-1"
	item_state = "hardsuit0-powerarmor-1"
	hardsuit_type = "powerarmor"
	clothing_flags = THICKMATERIAL //Ouchie oofie my bones
	armor = list("melee" = 40, "bullet" = 35, "laser" = 30, "energy" = 20, "bomb" = 40, "bio" = 100, "rad" = 5, "fire" = 75, "acid" = 100)
	resistance_flags = ACID_PROOF
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/Initialize()
	. = ..()
	update_icon()


/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/update_overlays()
	. = ..()
	var/mutable_appearance/glass_overlay = mutable_appearance(icon, "hardsuit0-powerarmor-2")
	if(icon_state == "hardsuit1-powerarmor-1")
		glass_overlay = mutable_appearance(icon, "hardsuit1-powerarmor-2")
		var/mutable_appearance/flight_overlay = mutable_appearance(icon, "hardsuit1-powerarmor-3")
		flight_overlay.appearance_flags = RESET_COLOR
		. += flight_overlay
	glass_overlay.appearance_flags = RESET_COLOR
	. += glass_overlay

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/M1 = mutable_appearance(icon_file, "hardsuit0-powerarmor-2")
		if(icon_state == "hardsuit1-powerarmor-1")
			M1 = mutable_appearance(icon_file, "hardsuit1-powerarmor-2")
			var/mutable_appearance/M2 = mutable_appearance(icon, "hardsuit1-powerarmor-3")
			M2.appearance_flags = RESET_COLOR
			. += M2
		M1.appearance_flags = RESET_COLOR
		. += M1

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == SLOT_HEAD)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		DHUD.add_hud_to(user)

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/dropped(mob/living/carbon/human/user)
	..()
	if (user.head == src)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		DHUD.remove_hud_from(user)

/obj/item/clothing/suit/space/hardsuit/powerarmor
	name = "Power Armor MK. I"
	desc = "A self-powered exoskeleton suit comprised of flexible Plasteel sheets and advanced components, designed to offer excellent protection while still allowing mobility. Does not protect against Space, and struggles against more exotic hazards."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	icon_state = "hardsuit-powerarmor-1"
	item_state = "hardsuit-powerarmor-1"
	slowdown = -0.1
	clothing_flags = THICKMATERIAL //Not spaceproof. No, it isn't Spaceproof in Rimworld either.
	armor = list("melee" = 40, "bullet" = 35, "laser" = 30, "energy" = 20, "bomb" = 40, "bio" = 100, "rad" = 5, "fire" = 75, "acid" = 100) //I was asked to buff this again. Here, fine.
	resistance_flags = ACID_PROOF
	var/explodioprobemp = 1
	var/stamdamageemp = 200
	var/brutedamageemp = 20
	var/rebootdelay
	var/mob/living/carbon/wearer
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/powerarmor
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/space/hardsuit/powerarmor/Initialize()
	. = ..()
	update_icon()

/obj/item/clothing/suit/space/hardsuit/powerarmor/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)

/obj/item/clothing/suit/space/hardsuit/powerarmor/update_overlays()
	. = ..()
	var/mutable_appearance/black_overlay = mutable_appearance(icon, "hardsuit-powerarmor-2")
	black_overlay.appearance_flags = RESET_COLOR
	var/mutable_appearance/bluecore_overlay = mutable_appearance(icon, "hardsuit-powerarmor-3")
	bluecore_overlay.appearance_flags = RESET_COLOR
	. += black_overlay
	. += bluecore_overlay

/obj/item/clothing/suit/space/hardsuit/powerarmor/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/M1 = mutable_appearance(icon_file, "hardsuit-powerarmor-2")
		M1.appearance_flags = RESET_COLOR
		var/mutable_appearance/M2 = mutable_appearance(icon_file, "hardsuit-powerarmor-3")
		M2.appearance_flags = RESET_COLOR
		. += M1
		. += M2

/obj/item/clothing/suit/space/hardsuit/powerarmor/emp_act()
	. = ..()
	var/mob/living/carbon/human/user = src.loc
	playsound(src.loc, 'modular_skyrat/sound/misc/suitmalf.ogg', 60, 1, 10)
	if (ishuman(user) && (user.wear_suit == src))
		to_chat(user, "<span class='danger'>The motors on your armor cease to function, causing the full weight of the suit to weigh on you all at once!</span>")
		user.emote("scream")
		user.adjustStaminaLoss(stamdamageemp)
		user.adjustBruteLoss(brutedamageemp)
	if(prob(explodioprobemp))
		playsound(src.loc, 'sound/effects/fuse.ogg', 60, 1, 10)
		visible_message("<span class ='warning'>The power module on the [src] begins to smoke, glowing with an alarming warmth! Get away from it, now!")
		addtimer(CALLBACK(src, .proc/detonate),50)
	else
		addtimer(CALLBACK(src, .proc/revivemessage), rebootdelay)
		return

/obj/item/clothing/suit/space/hardsuit/powerarmor/proc/revivemessage() //we use this proc to add a timer, so we can have it take a while to boot
	visible_message("<span class ='warning'>The power module on the [src] briefly flickers, before humming to life once more.</span>") //without causing any problems
	return //that sleep() would

/obj/item/clothing/suit/space/hardsuit/powerarmor/proc/detonate()
	visible_message("<span class ='danger'>The power module of the [src] overheats, causing it to destabilize and explode!")
	explosion(src.loc,0,0,3,flame_range = 3)
	qdel(src)
	return

//Security HEV
/obj/item/clothing/head/helmet/space/hardsuit/security/metrocop
	name = "security HEV suit helmet"
	desc = "This helmet seems like something out of this world... It has been designed by Nanotrasen for their security teams to be used during emergency operations in hazardous environments. This one provides more protection from the environment in exchange for the usual combat protection of a regular security suit."
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	icon_state = "hardsuit0-metrocop"
	item_state = "hardsuit0-metrocop"
	hardsuit_type = "metrocop"
	armor = list("melee" = 50, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 60, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF | GOLIATH_RESISTANCE
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/suit/space/hardsuit/security/metrocop
	name = "security HEV suit"
	desc = "This suit seems like something out of this world... It has been designed by Nanotrasen for their security teams to be used during emergency operations in hazardous environments. This one provides more protection from the environment in exchange for the usual combat protection of a regular security suit."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	icon_state = "hardsuit-metrocop"
	item_state = "hardsuit-metrocop"
	hardsuit_type = "metrocop"
	armor = list("melee" = 50, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 60, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 100)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security/metrocop
	resistance_flags = FIRE_PROOF | ACID_PROOF | GOLIATH_RESISTANCE
	mutantrace_variation = STYLE_DIGITIGRADE

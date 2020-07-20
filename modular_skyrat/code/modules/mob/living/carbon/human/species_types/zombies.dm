/datum/species/zombie
	// 3spooky
	name = "High-Functioning Zombie"
	id = "zombie"
	say_mod = "growls"
	
/datum/species/zombie/infectious
	name = "Nanite Horror"
	exotic_blood = /datum/reagent/romerol
	icon_limbs = 'modular_skyrat/icons/mob/zombies/zombie_base.dmi'
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_LIMBATTACHMENT,TRAIT_NOBREATH,TRAIT_NODEATH,TRAIT_NOLIMBDISABLE,TRAIT_UNINTELLIGIBLE_SPEECH,TRAIT_FREESPRINT,TRAIT_TASED_RESISTANCE,TRAIT_STUNIMMUNE)

/datum/species/zombie/infectious/lizard
	icon_limbs = 'modular_skyrat/icons/mob/zombies/zombie_lizard.dmi'
	mutant_bodyparts = list("tail_lizard")
	mutanttail = /obj/item/organ/tail/zombie_lizard
	id = "zombie_lizard"

/datum/species/zombie/infectious/plasma //Plasmamen normally can't be infected, but in the off-chance one of them becomes a zombie (or the admins will it to be), here we have an infected variant.
	sexes = 0
	meat = /obj/item/stack/sheet/mineral/plasma
	icon_limbs = 'modular_skyrat/icons/mob/zombies/zombie_plasmaman.dmi'
	mutantlungs = /obj/item/organ/lungs/plasmaman
	mutanttongue = /obj/item/organ/tongue/bone/plasmaman
	mutantliver = /obj/item/organ/liver/plasmaman
	mutantstomach = /obj/item/organ/stomach/plasmaman
	var/internal_fire = FALSE
	outfit_important_for_life = /datum/outfit/plasmaman
	id = "zombie_plasmaman"

/datum/species/zombie/infectious/plasma/spec_life(mob/living/carbon/human/H)
	var/datum/gas_mixture/environment = H.loc.return_air()
	var/atmos_sealed = FALSE
	if (H.wear_suit && H.head && istype(H.wear_suit, /obj/item/clothing) && istype(H.head, /obj/item/clothing))
		var/obj/item/clothing/CS = H.wear_suit
		var/obj/item/clothing/CH = H.head
		if (CS.clothing_flags & CH.clothing_flags & STOPSPRESSUREDAMAGE)
			atmos_sealed = TRUE
	if((!istype(H.w_uniform, /obj/item/clothing/under/plasmaman) || !istype(H.head, /obj/item/clothing/head/helmet/space/plasmaman)) && !atmos_sealed)
		if(environment)
			if(environment.total_moles())
				if(environment.gases[/datum/gas/oxygen] && (environment.gases[/datum/gas/oxygen]) >= 1) //Same threshhold that extinguishes fire
					H.adjust_fire_stacks(0.5)
					if(!H.on_fire && H.fire_stacks > 0)
						H.visible_message("<span class='danger'>[H]'s body reacts with the atmosphere and bursts into flames!</span>","<span class='userdanger'>Your body reacts with the atmosphere and bursts into flame!</span>")
					H.IgniteMob()
					internal_fire = TRUE
	else
		if(H.fire_stacks)
			var/obj/item/clothing/under/plasmaman/P = H.w_uniform
			if(istype(P))
				P.Extinguish(H)
				internal_fire = FALSE
		else
			internal_fire = FALSE
	H.update_fire()

/datum/species/zombie/infectious/plasma/handle_fire(mob/living/carbon/human/H, no_protection)
	if(internal_fire)
		no_protection = TRUE
	..()

/datum/species/zombie/infectious/insect
	icon_limbs = 'modular_skyrat/icons/mob/zombies/zombie_insect.dmi'
	icon_eyes = 'modular_skyrat/icons/mob/blank_eyes.dmi'
	id = "zombie_insect"

/datum/species/zombie/infectious/moth
	icon_limbs = 'modular_skyrat/icons/mob/zombies/zombie_moth.dmi'
	icon_eyes = 'modular_skyrat/icons/mob/blank_eyes.dmi'
	id = "zombie_moth"

/datum/species/zombie/infectious/mush
	icon_limbs = 'modular_skyrat/icons/mob/zombies/zombie_mushroom.dmi'
	id = "zombie_mush"

/datum/species/zombie/infectious/ipc
	species_traits = list(NOBLOOD,NOZOMBIE,NOTRANSSTING,NOHUSK,ROBOTIC_LIMBS,NO_DNA_COPY)
	icon_limbs = 'modular_skyrat/icons/mob/zombies/zombie_ipc.dmi'
	icon_eyes = 'modular_skyrat/icons/mob/blank_eyes.dmi'
	mutant_brain = /obj/item/organ/brain/ipc_positron
	mutantstomach = /obj/item/organ/stomach/robot_ipc
	mutantears = /obj/item/organ/ears/robot_ipc
	mutanttongue = /obj/item/organ/tongue/robot_ipc
	mutanteyes = /obj/item/organ/eyes/robot_ipc
	mutantlungs = /obj/item/organ/lungs/robot_ipc
	mutant_heart = /obj/item/organ/heart/robot_ipc
	mutantliver = /obj/item/organ/liver/robot_ipc
	id = "zombie_ipc"

/datum/species/zombie/infectious/synthliz
	species_traits = list(NOBLOOD,NOZOMBIE,NOTRANSSTING,NOHUSK,ROBOTIC_LIMBS,NO_DNA_COPY)
	icon_limbs = 'modular_skyrat/icons/mob/zombies/zombie_synthliz.dmi'
	icon_eyes = 'modular_skyrat/icons/mob/blank_eyes.dmi'
	mutant_brain = /obj/item/organ/brain/ipc_positron
	mutantstomach = /obj/item/organ/stomach/robot_ipc
	mutantears = /obj/item/organ/ears/robot_ipc
	mutanttongue = /obj/item/organ/tongue/robot_ipc
	mutanteyes = /obj/item/organ/eyes/robot_ipc
	mutantlungs = /obj/item/organ/lungs/robot_ipc
	mutant_heart = /obj/item/organ/heart/robot_ipc
	mutantliver = /obj/item/organ/liver/robot_ipc
	id = "zombie_synthliz"

/datum/species/zombie/infectious/xeno
	icon_limbs = 'modular_skyrat/icons/mob/zombies/zombie_xeno.dmi'
	icon_eyes = 'modular_skyrat/icons/mob/blank_eyes.dmi'
	mutant_bodyparts = list("tail_lizard")
	mutanttail = /obj/item/organ/tail/zombie_lizard
	id = "zombie_xeno"

/datum/species/zombie/infectious/vox
	icon_limbs = 'modular_skyrat/icons/mob/zombies/zombie_vox.dmi'
	icon_eyes = 'modular_skyrat/icons/mob/blank_eyes.dmi'
	id = "zombie_vox"

/datum/species/zombie/infectious/nightmare //If you see this, you fucked up REALLY hard. Kiss your sorry ass goodbye and say hello to the scariest motherfucker on station.
	icon_limbs = 'modular_skyrat/icons/mob/zombies/zombie_shadow.dmi'
	id = "zombie_nightmare"
	burnmod = 1.5
	mutanteyes = /obj/item/organ/eyes/night_vision/nightmare
	mutant_organs = list(/obj/item/organ/heart/zombie_nightmare)
	mutant_brain =/obj/item/organ/brain/zombie_nightmare
	mutanthands = /obj/item/zombie_hand/nightmare
	species_traits = list(NOBLOOD,NO_UNDERWEAR,NO_DNA_COPY,NOTRANSSTING,NOEYES,NOGENITALS,NOAROUSAL,NOZOMBIE)
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_LIMBATTACHMENT,TRAIT_NOBREATH,TRAIT_NODEATH,TRAIT_NOLIMBDISABLE,TRAIT_UNINTELLIGIBLE_SPEECH,TRAIT_FREESPRINT,TRAIT_TASED_RESISTANCE,TRAIT_STUNIMMUNE,TRAIT_PIERCEIMMUNE,TRAIT_NODISMEMBER,TRAIT_NOHUNGER)

	var/info_text = "You are a <span class='alien'><b>Nanite Horror Nightmare</b></span>. The ability <span class='alien'><b>shadow walk</b></span> allows unlimited, unrestricted movement in the dark while activated. \
					You will automatically dodge gunfire and melee attacks when on a dark tile. The nanites bound to your dark form prevent most forms of death. \
					Your body hungers for darkness... and for flesh. The nanite tumor in your brain wills you to spread their infection with your <span class='alien'><b>zombie claws.</b></span> Your nature as a creature of darkness also allow these to destroy any lights almost instantly. \
					<span class='warning'><b>Feast upon the flesh of the crew, and spread your gift to all those who fall beneath the sharp caress of your daggered fingers.</b></span>"

/datum/species/zombie/infectious/nightmare/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	C.AddElement(/datum/element/photosynthesis, 1, 1, 0, 0, 0, 0, SHADOW_SPECIES_LIGHT_THRESHOLD, SHADOW_SPECIES_LIGHT_THRESHOLD)

/datum/species/shadow/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.RemoveElement(/datum/element/photosynthesis, 1, 1, 0, 0, 0, 0, SHADOW_SPECIES_LIGHT_THRESHOLD, SHADOW_SPECIES_LIGHT_THRESHOLD)

/datum/species/zombie/infectious/nightmare/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	to_chat(C, "[info_text]")

/datum/species/zombie/infectious/nightmare/bullet_act(obj/item/projectile/P, mob/living/carbon/human/H)
	var/turf/T = H.loc
	if(istype(T))
		var/light_amount = T.get_lumcount()
		if(light_amount < SHADOW_SPECIES_LIGHT_THRESHOLD)
			H.visible_message("<span class='danger'>[H] dances in the shadows, evading [P]!</span>")
			playsound(T, "bullet_miss", 75, 1)
			return BULLET_ACT_FORCE_PIERCE
	return ..()

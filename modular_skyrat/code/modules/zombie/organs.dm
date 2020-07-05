/obj/item/organ/zombie_infection
	desc = "A black web of pus and viscera, filled with curious swirling dots."
	icon = 'modular_skyrat/icons/obj/items/nanitetumor.dmi'
	icon_state = "nanitetumor"

/obj/item/organ/zombie_infection/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	else
		owner.adjustFireLoss(10 * severity)
		owner.DefaultCombatKnockdown(50 * severity)

/obj/item/organ/tail/zombie_lizard //Tail code fucking sucks, man. Fuck this.
	name = "infested tail"
	desc = "The severed tail of a Nanite Horror. Constantly leaks a thick black fluid, although it seems inert."
	icon_state = "severedtail"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TAIL
	tail_type = "zombie_lizard"

/obj/item/organ/tail/zombie_xeno
	name = "infested tail"
	desc = "The severed tail of a Nanite Horror. Constantly leaks a thick black fluid, although it seems inert."
	icon_state = "severedtail"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TAIL
	tail_type = "zombie_xeno"

/obj/item/organ/brain/zombie_nightmare //copypasta to avoid funny mindrole fuckups
	name = "leaking tumorous mass"
	desc = "A fleshy growth that was dug out of the skull of a Nightmare. It pulses with an odd blue aura."
	icon = 'modular_skyrat/icons/obj/items/nanitetumor.dmi'
	icon_state = "nanite_nightmare_brain"
	var/obj/effect/proc_holder/spell/targeted/shadowwalk/shadowwalk

/obj/item/organ/brain/zombie_nightmare/Insert(mob/living/carbon/M, special = 0, drop_if_replaced = TRUE)
	..()
	if(M.dna.species.id != "zombie_nightmare")
		M.set_species(/datum/species/zombie/infectious/nightmare)
		visible_message("<span class='warning'>[M] thrashes as [src] takes root in [M.p_their()] body!</span>")
	var/obj/effect/proc_holder/spell/targeted/shadowwalk/SW = new
	M.AddSpell(SW)
	shadowwalk = SW

/obj/item/organ/heart/zombie_nightmare
	name = "twisted mass"
	desc = "An alien organ, constantly leaking some kind of thick, vile black fluid. It writhes and twists in response to light."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "demon_heart-on"
	color = "#1C1C1C"
	decay_factor = 0

/obj/item/organ/heart/zombie_nightmare/Insert(mob/living/carbon/M, special = 0, drop_if_replaced = FALSE)
	..()

/obj/item/organ/heart/nightmare/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/organ/heart/nightmare/Stop()
	return 0

/datum/techweb_node/cyborg_upg_util/New()
	design_ids += "borg_upgrade_xwelding"
	design_ids += "borg_upgrade_shrink"
	//design_ids += "borg_upgrade_plasma"
	. = ..()

/datum/techweb_node/bluespace_portal/New()
	design_ids += "bsrpd"
	design_ids += "borg_upgrade_bsrpd"
	. = ..()

/datum/techweb_node/adv_robotics/New()
	design_ids += "borg_upgrade_premiumka"
	. = ..()

/datum/techweb_node/bs_mining
	id = "bluespace_mining"
	display_name = "Bluespace Mining Technology"
	description = "Harness the power of bluespace to make materials out of nothing. Slowly."
	prereq_ids = list("practical_bluespace", "adv_mining")
	design_ids = list("bluespace_miner")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)

/datum/techweb_node/adv_bluetravel
	id = "advanced_bluetravel"
	display_name = "Advanced Bluespace Travel"
	description = "Using superior knowledge of bluespace, you can develop more finely-controlled teleportation equipment."
	prereq_ids = list("bluespace_warping")
	design_ids = list("telepad", "telesci_console")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 9000)

/datum/techweb_node/ai/New()
	design_ids += "father_module"
	. = ..()

/datum/techweb_node/botany/New()
	design_ids += "prisonerbiogenerator"
	. = ..()

/datum/techweb_node/charge_weaponry
	id = "charge_weaponry"
	display_name = "Advanced Pulse-shot Weapons"
	description = "Utilizing pulse-slung ballistic charge technology, we can produce advanced ballistic weaponry to suit our needs."
	prereq_ids = list("weaponry", "adv_weaponry", "emp_adv", "electronic_weapons")
	design_ids = list("chargepistolammo", "chargesmgammo", "chargerifleammo", "chargeshotammo", "chargeshotammo-nl", "chargepistol", "chargesmg", "chargerifle", "chargeshotgun")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5500)

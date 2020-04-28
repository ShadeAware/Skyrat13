//Credits to Jake Park and RAID: Shadow Legends

/obj/item/crowbar/holotool
	name = "hardlight crowbar"
	desc = "A hardlight projection of a crowbar. Works as well as the real deal."
	icon = 'modular_skyrat/icons/obj/holotool.dmi'
	usesound = 'sound/weapons/sonic_jackhammer.ogg'
	icon_state = "crowbar"
	toolspeed = 0.5

	var/static/radial_crowbar = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "crowbar")
	var/static/radial_screwdriver = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "screwdriver_h")
	var/static/radial_weldingtool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "welder")
	var/static/radial_wirecutters = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "cutters")
	var/static/radial_wrench = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "wrench")
	var/static/radial_mulitool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "multitool")

	// we show the button even if the proc will not work
	var/static/list/radial_options = list(	"crowbar" = radial_crowbar,
											"screwdriver" = radial_screwdriver,
											"weldingtool" = radial_weldingtool,
											"wirecutters" = radial_wirecutters,
											"wrench" = radial_wrench,
											"multitool" = radial_multitool,
											"off" = radial_holotool)

/obj/item/crowbar/holotool/CtrlClick(mob/user)
	var/choice = show_radial_menu(user, src, radial_options, require_near = TRUE)
	if(!choice)
		return
	switch(choice)
		if("crowbar")
			var/obj/item/crowbar/holotool/CW = new /obj/item/crowbar/holotool(drop_location())
			to_chat(user, "You switch to the Crowbar mode.")
			qdel(src)
			user.put_in_active_hand(CW)
		if("screwdriver")
			var/obj/item/screwdriver/holotool/SD = new /obj/item/screwdriver/holotool(drop_location())
			to_chat(user, "You switch to the Screwdriver mode.")
			qdel(src)
			user.put_in_active_hand(SD)
		if("weldingtool")
			var/obj/item/weldingtool/holotool/WT = new /obj/item/weldingtool/holotool(drop_location())
			to_chat(user, "You switch to the Weldingtool mode.")
			qdel(src)
			user.put_in_active_hand(WT)
		if("wirecutters")
			var/obj/item/wirecutters/holotool/WC = new /obj/item/wirecutters/holotool(drop_location())
			to_chat(user, "You switch to the Wirecutter mode.")
			qdel(src)
			user.put_in_active_hand(WC)
		if("wrench")
			var/obj/item/wrench/holotool/WR = new /obj/item/wrench/holotool(drop_location())
			to_chat(user, "You switch to the Wrench mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("multitool")
			var/obj/item/multitool/holotool/WR = new /obj/item/multitool/holotool(drop_location())
			to_chat(user, "You switch to the Wrench mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("off")
			var/obj/item/holotool/WR = new /obj/item/holotool(drop_location())
			to_chat(user, "You turn off the holotool.")
			qdel(src)
			user.put_in_active_hand(WR)

/obj/item/screwdriver/holotool
	name = "hardlight screwdriver"
	desc = "A classy hardlight projection of a screwdriver. Surprisingly sharp."
	icon = 'modular_skyrat/icons/obj/holotool.dmi'
	icon_state = "screwdriver_a"
	item_state = "screwdriver_nuke"
	usesound = 'sound/items/pshoom.ogg'
	toolspeed = 0.5
	random_color = FALSE

	var/static/radial_crowbar = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "crowbar")
	var/static/radial_screwdriver = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "screwdriver_a")
	var/static/radial_weldingtool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "welder")
	var/static/radial_wirecutters = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "cutters")
	var/static/radial_wrench = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "wrench")
	var/static/radial_mulitool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "multitool")

	// we show the button even if the proc will not work
	var/static/list/radial_options = list(	"crowbar" = radial_crowbar,
											"screwdriver" = radial_screwdriver,
											"weldingtool" = radial_weldingtool,
											"wirecutters" = radial_wirecutters,
											"wrench" = radial_wrench,
											"multitool" = radial_multitool,
											"off" = radial_holotool)

/obj/item/screwdriver/holotool/CtrlClick(mob/user)
	var/choice = show_radial_menu(user, src, radial_options, require_near = TRUE)
	if(!choice)
		return
	switch(choice)
		if("crowbar")
			var/obj/item/crowbar/holotool/CW = new /obj/item/crowbar/holotool(drop_location())
			to_chat(user, "You switch to the Crowbar mode.")
			qdel(src)
			user.put_in_active_hand(CW)
		if("screwdriver")
			var/obj/item/screwdriver/holotool/SD = new /obj/item/screwdriver/holotool(drop_location())
			to_chat(user, "You switch to the Screwdriver mode.")
			qdel(src)
			user.put_in_active_hand(SD)
		if("weldingtool")
			var/obj/item/weldingtool/holotool/WT = new /obj/item/weldingtool/holotool(drop_location())
			to_chat(user, "You switch to the Weldingtool mode.")
			qdel(src)
			user.put_in_active_hand(WT)
		if("wirecutters")
			var/obj/item/wirecutters/holotool/WC = new /obj/item/wirecutters/holotool(drop_location())
			to_chat(user, "You switch to the Wirecutter mode.")
			qdel(src)
			user.put_in_active_hand(WC)
		if("wrench")
			var/obj/item/wrench/holotool/WR = new /obj/item/wrench/holotool(drop_location())
			to_chat(user, "You switch to the Wrench mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("multitool")
			var/obj/item/multitool/holotool/WR = new /obj/item/multitool/holotool(drop_location())
			to_chat(user, "You switch to the Multitool mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("off")
			var/obj/item/holotool/WR = new /obj/item/holotool(drop_location())
			to_chat(user, "You turn off the holotool.")
			qdel(src)
			user.put_in_active_hand(WR)

/obj/item/weldingtool/holotool
	name = "hardlight welding tool"
	desc = "A hardlight-constructed welding tool which uses extreme heat and light to function."
	icon = 'modular_skyrat/icons/obj/holotool.dmi'
	icon_state = "welder"
	toolspeed = 0.5
	light_intensity = 0
	change_icons = 0

	var/static/radial_crowbar = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "crowbar")
	var/static/radial_screwdriver = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "screwdriver_a")
	var/static/radial_weldingtool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "welder")
	var/static/radial_wirecutters = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "cutters")
	var/static/radial_wrench = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "wrench")
	var/static/radial_mulitool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "multitool")

	// we show the button even if the proc will not work
	var/static/list/radial_options = list(	"crowbar" = radial_crowbar,
											"screwdriver" = radial_screwdriver,
											"weldingtool" = radial_weldingtool,
											"wirecutters" = radial_wirecutters,
											"wrench" = radial_wrench,
											"multitool" = radial_multitool,
											"off" = radial_holotool)

/obj/item/weldingtool/holotool/CtrlClick(mob/user)
	var/choice = show_radial_menu(user, src, radial_options, require_near = TRUE)
	if(!choice)
		return
	switch(choice)
		if("crowbar")
			var/obj/item/crowbar/holotool/CW = new /obj/item/crowbar/holotool(drop_location())
			to_chat(user, "You switch to the Crowbar mode.")
			qdel(src)
			user.put_in_active_hand(CW)
		if("screwdriver")
			var/obj/item/screwdriver/holotool/SD = new /obj/item/screwdriver/holotool(drop_location())
			to_chat(user, "You switch to the Screwdriver mode.")
			qdel(src)
			user.put_in_active_hand(SD)
		if("weldingtool")
			var/obj/item/weldingtool/holotool/WT = new /obj/item/weldingtool/holotool(drop_location())
			to_chat(user, "You switch to the Weldingtool mode.")
			qdel(src)
			user.put_in_active_hand(WT)
		if("wirecutters")
			var/obj/item/wirecutters/holotool/WC = new /obj/item/wirecutters/holotool(drop_location())
			to_chat(user, "You switch to the Wirecutter mode.")
			qdel(src)
			user.put_in_active_hand(WC)
		if("wrench")
			var/obj/item/wrench/holotool/WR = new /obj/item/wrench/holotool(drop_location())
			to_chat(user, "You switch to the Wrench mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("multitool")
			var/obj/item/multitool/holotool/WR = new /obj/item/multitool/holotool(drop_location())
			to_chat(user, "You switch to the Multitool mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("off")
			var/obj/item/holotool/WR = new /obj/item/holotool(drop_location())
			to_chat(user, "You turn off the holotool.")
			qdel(src)
			user.put_in_active_hand(WR)

/obj/item/weldingtool/holotool/process()
	if(get_fuel() <= max_fuel)
		reagents.add_reagent(/datum/reagent/fuel, 1)
	..()

/obj/item/wirecutters/holotool
	name = "hardlight wirecutters"
	desc = "A pair of hardlight jaws used to cut wires."
	icon = 'modular_skyrat/icons/obj/holotool.dmi'
	icon_state = "cutters"
	toolspeed = 0.5
	random_color = FALSE

	var/static/radial_crowbar = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "crowbar")
	var/static/radial_screwdriver = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "screwdriver_a")
	var/static/radial_weldingtool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "welder")
	var/static/radial_wirecutters = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "cutters")
	var/static/radial_wrench = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "wrench")
	var/static/radial_mulitool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "multitool")

	// we show the button even if the proc will not work
	var/static/list/radial_options = list(	"crowbar" = radial_crowbar,
											"screwdriver" = radial_screwdriver,
											"weldingtool" = radial_weldingtool,
											"wirecutters" = radial_wirecutters,
											"wrench" = radial_wrench,
											"multitool" = radial_multitool,
											"off" = radial_holotool)

/obj/item/wirecutters/holotool/CtrlClick(mob/user)
	var/choice = show_radial_menu(user, src, radial_options, require_near = TRUE)
	if(!choice)
		return
	switch(choice)
		if("crowbar")
			var/obj/item/crowbar/holotool/CW = new /obj/item/crowbar/holotool(drop_location())
			to_chat(user, "You switch to the Crowbar mode.")
			qdel(src)
			user.put_in_active_hand(CW)
		if("screwdriver")
			var/obj/item/screwdriver/holotool/SD = new /obj/item/screwdriver/holotool(drop_location())
			to_chat(user, "You switch to the Screwdriver mode.")
			qdel(src)
			user.put_in_active_hand(SD)
		if("weldingtool")
			var/obj/item/weldingtool/holotool/WT = new /obj/item/weldingtool/holotool(drop_location())
			to_chat(user, "You switch to the Weldingtool mode.")
			qdel(src)
			user.put_in_active_hand(WT)
		if("wirecutters")
			var/obj/item/wirecutters/holotool/WC = new /obj/item/wirecutters/holotool(drop_location())
			to_chat(user, "You switch to the Wirecutter mode.")
			qdel(src)
			user.put_in_active_hand(WC)
		if("wrench")
			var/obj/item/wrench/holotool/WR = new /obj/item/wrench/holotool(drop_location())
			to_chat(user, "You switch to the Wrench mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("multitool")
			var/obj/item/multitool/holotool/WR = new /obj/item/multitool/holotool(drop_location())
			to_chat(user, "You switch to the Multitool mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("off")
			var/obj/item/holotool/WR = new /obj/item/holotool(drop_location())
			to_chat(user, "You turn off the holotool.")
			qdel(src)
			user.put_in_active_hand(WR)

/obj/item/wrench/holotool
	name = "hardlight wrench"
	desc = "A hardlight projection of a wrench. Works as well as the real deal."
	icon = 'modular_skyrat/icons/obj/holotool.dmi'
	icon_state = "wrench"
	usesound = 'sound/effects/empulse.ogg'
	toolspeed = 0.5

	var/static/radial_crowbar = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "crowbar")
	var/static/radial_screwdriver = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "screwdriver_a")
	var/static/radial_weldingtool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "welder")
	var/static/radial_wirecutters = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "cutters")
	var/static/radial_wrench = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "wrench")
	var/static/radial_mulitool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "multitool")

	// we show the button even if the proc will not work
	var/static/list/radial_options = list(	"crowbar" = radial_crowbar,
											"screwdriver" = radial_screwdriver,
											"weldingtool" = radial_weldingtool,
											"wirecutters" = radial_wirecutters,
											"wrench" = radial_wrench,
											"multitool" = radial_multitool,
											"off" = radial_holotool)

/obj/item/wrench/holotool/CtrlClick(mob/user)
	var/choice = show_radial_menu(user, src, radial_options, require_near = TRUE)
	if(!choice)
		return
	switch(choice)
		if("crowbar")
			var/obj/item/crowbar/holotool/CW = new /obj/item/crowbar/holotool(drop_location())
			to_chat(user, "You switch to the Crowbar mode.")
			qdel(src)
			user.put_in_active_hand(CW)
		if("screwdriver")
			var/obj/item/screwdriver/holotool/SD = new /obj/item/screwdriver/holotool(drop_location())
			to_chat(user, "You switch to the Screwdriver mode.")
			qdel(src)
			user.put_in_active_hand(SD)
		if("weldingtool")
			var/obj/item/weldingtool/holotool/WT = new /obj/item/weldingtool/holotool(drop_location())
			to_chat(user, "You switch to the Weldingtool mode.")
			qdel(src)
			user.put_in_active_hand(WT)
		if("wirecutters")
			var/obj/item/wirecutters/holotool/WC = new /obj/item/wirecutters/holotool(drop_location())
			to_chat(user, "You switch to the Wirecutter mode.")
			qdel(src)
			user.put_in_active_hand(WC)
		if("wrench")
			var/obj/item/wrench/holotool/WR = new /obj/item/wrench/holotool(drop_location())
			to_chat(user, "You switch to the Wrench mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("multitool")
			var/obj/item/multitool/holotool/WR = new /obj/item/multitool/holotool(drop_location())
			to_chat(user, "You switch to the Multitool mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("off")
			var/obj/item/holotool/WR = new /obj/item/holotool(drop_location())
			to_chat(user, "You turn off the holotool.")
			qdel(src)
			user.put_in_active_hand(WR)

/obj/item/multitool/holotool
	name = "hardlight multitool"
	desc = "A hardlight multitool. Don't ask how that works."
	icon = 'modular_skyrat/icons/obj/holotool.dmi'
	icon_state = "multitool"
	toolspeed = 0.5

	var/static/radial_crowbar = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "crowbar")
	var/static/radial_screwdriver = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "screwdriver_a")
	var/static/radial_weldingtool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "welder")
	var/static/radial_wirecutters = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "cutters")
	var/static/radial_wrench = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "wrench")
	var/static/radial_mulitool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "multitool")

	// we show the button even if the proc will not work
	var/static/list/radial_options = list(	"crowbar" = radial_crowbar,
											"screwdriver" = radial_screwdriver,
											"weldingtool" = radial_weldingtool,
											"wirecutters" = radial_wirecutters,
											"wrench" = radial_wrench,
											"multitool" = radial_multitool,
											"off" = radial_holotool)

/obj/item/multitool/holotool/CtrlClick(mob/user)
	var/choice = show_radial_menu(user, src, radial_options, require_near = TRUE)
	if(!choice)
		return
	switch(choice)
		if("crowbar")
			var/obj/item/crowbar/holotool/CW = new /obj/item/crowbar/holotool(drop_location())
			to_chat(user, "You switch to the Crowbar mode.")
			qdel(src)
			user.put_in_active_hand(CW)
		if("screwdriver")
			var/obj/item/screwdriver/holotool/SD = new /obj/item/screwdriver/holotool(drop_location())
			to_chat(user, "You switch to the Screwdriver mode.")
			qdel(src)
			user.put_in_active_hand(SD)
		if("weldingtool")
			var/obj/item/weldingtool/holotool/WT = new /obj/item/weldingtool/holotool(drop_location())
			to_chat(user, "You switch to the Weldingtool mode.")
			qdel(src)
			user.put_in_active_hand(WT)
		if("wirecutters")
			var/obj/item/wirecutters/holotool/WC = new /obj/item/wirecutters/holotool(drop_location())
			to_chat(user, "You switch to the Wirecutter mode.")
			qdel(src)
			user.put_in_active_hand(WC)
		if("wrench")
			var/obj/item/wrench/holotool/WR = new /obj/item/wrench/holotool(drop_location())
			to_chat(user, "You switch to the Wrench mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("multitool")
			var/obj/item/multitool/holotool/WR = new /obj/item/multitool/holotool(drop_location())
			to_chat(user, "You switch to the Multitool mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("off")
			var/obj/item/holotool/WR = new /obj/item/holotool(drop_location())
			to_chat(user, "You turn off the holotool.")
			qdel(src)
			user.put_in_active_hand(WR)

/obj/item/holotool
	name = "deactivated holotool"
	desc = "A hardlight toolset device. Constructs various tools from light using an internal design pool and projection apparatus. Must be used with a set of Power Armor."
	icon = 'modular_skyrat/icons/obj/holotool.dmi'
	icon_state = "holotool"

	var/static/radial_crowbar = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "crowbar")
	var/static/radial_screwdriver = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "screwdriver_a")
	var/static/radial_weldingtool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "welder")
	var/static/radial_wirecutters = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "cutters")
	var/static/radial_wrench = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "wrench")
	var/static/radial_mulitool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "multitool")
	var/static/radial_holotool = image(icon = 'modular_skyrat/icons/obj/holotool.dmi', icon_state = "holotool")

	// we show the button even if the proc will not work
	var/static/list/radial_options = list(	"crowbar" = radial_crowbar,
											"screwdriver" = radial_screwdriver,
											"weldingtool" = radial_weldingtool,
											"wirecutters" = radial_wirecutters,
											"wrench" = radial_wrench,
											"multitool" = radial_multitool,
											"off" = radial_holotool)

/obj/item/wrench/holotool/CtrlClick(mob/user)
	var/choice = show_radial_menu(user, src, radial_options, require_near = TRUE)
	if(!choice)
		return
	switch(choice)
		if("crowbar")
			var/obj/item/crowbar/holotool/CW = new /obj/item/crowbar/holotool(drop_location())
			to_chat(user, "You switch to the Crowbar mode.")
			qdel(src)
			user.put_in_active_hand(CW)
		if("screwdriver")
			var/obj/item/screwdriver/holotool/SD = new /obj/item/screwdriver/holotool(drop_location())
			to_chat(user, "You switch to the Screwdriver mode.")
			qdel(src)
			user.put_in_active_hand(SD)
		if("weldingtool")
			var/obj/item/weldingtool/holotool/WT = new /obj/item/weldingtool/holotool(drop_location())
			to_chat(user, "You switch to the Weldingtool mode.")
			qdel(src)
			user.put_in_active_hand(WT)
		if("wirecutters")
			var/obj/item/wirecutters/holotool/WC = new /obj/item/wirecutters/holotool(drop_location())
			to_chat(user, "You switch to the Wirecutter mode.")
			qdel(src)
			user.put_in_active_hand(WC)
		if("wrench")
			var/obj/item/wrench/holotool/WR = new /obj/item/wrench/holotool(drop_location())
			to_chat(user, "You switch to the Wrench mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("multitool")
			var/obj/item/multitool/holotool/WR = new /obj/item/multitool/holotool(drop_location())
			to_chat(user, "You switch to the Multitool mode.")
			qdel(src)
			user.put_in_active_hand(WR)
		if("off")
			var/obj/item/holotool/WR = new /obj/item/holotool(drop_location())
			to_chat(user, "You turn off the holotool.")
			qdel(src)
			user.put_in_active_hand(WR)
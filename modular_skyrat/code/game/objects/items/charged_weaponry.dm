/obj/item/gun/ballistic/charged
	name = "charge weapon"
	desc = "This isn't right at all..."
	icon = 'modular_skyrat/icon/obj/guns/chargeweapons.dmi'
	icon_state = "badstate"
	item_state = "badstate"
	mag_type = /obj/item/ammo_box/magazine/charged
	fire_sound = 'modular_skyrat/sound/weapons/chargegun.ogg'
	can_suppress = FALSE
	lefthand_file = 'modular/skyrat/icons/mob/inhands/weapons/chargeguns_lefthand.dmi'
	righthand_file = 'modular/skyrat/icons/mob/inhands/weapons/chargeguns_righthand.dmi'
	var/alarmed = 0
	var/obj/item/stock_parts/cell/cell
	var/cell_type = /obj/item/stock_parts/cell/magnetic

/obj/item/gun/ballistic/charged/Initialize()
	. = ..()
	if(cell_type)
		cell = new cell_type(src)
	else
		cell = new(src)

/obj/item/gun/ballistic/charged/can_shoot()
	if(QDELETED(cell))
		return 0

	var/obj/item/ammo_casing/charged = chambered
	if(!shot)
		return 0
	if(cell.charge < shot.energy_cost * burst_size)
		return 0
	. = ..()

/obj/item/gun/ballistic/charged/shoot_live_shot()
	var/obj/item/ammo_casing/charged = chambered
	cell.use(shot.energy_cost)
	. = ..()

/obj/item/gun/ballistic/charged/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		cell.use(round(cell.charge / severity))

/obj/item/gun/ballistic/charged/get_cell()
	return cell

/obj/item/gun/ballistic/charged/examine(mob/user)
	. = ..()
	if(cell)
		. += "<span class='notice'>[src]'s cell is [round(cell.charge / cell.maxcharge, 0.1) * 100]% full.</span>"
	else
		. += "<span class='notice'>[src] doesn't seem to have a cell!</span>"

/obj/item/gun/ballistic/automatic/can_shoot()
	return get_ammo()

/obj/item/gun/ballistic/charged/proc/empty_alarm()
	if(!chambered && !get_ammo() && !alarmed)
		playsound(src.loc, 'sound/weapons/smg_empty_alarm.ogg', 40, 1)
		alarmed = 1
	return

/obj/item/gun/ballistic/charged/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(.)
		return
	if(istype(A, /obj/item/ammo_box/magazine))
		var/obj/item/ammo_box/magazine/AM = A
		if(istype(AM, mag_type))
			var/obj/item/ammo_box/magazine/oldmag = magazine
			if(user.transferItemToLoc(AM, src))
				magazine = AM
				if(oldmag)
					to_chat(user, "<span class='notice'>You perform a tactical reload on \the [src], replacing the magazine.</span>")
					oldmag.forceMove(get_turf(src.loc))
					oldmag.update_icon()
				else
					to_chat(user, "<span class='notice'>You insert the magazine into \the [src].</span>")

				playsound(user, 'sound/weapons/autoguninsert.ogg', 60, 1)
				chamber_round()
				A.update_icon()
				update_icon()
				return 1
			else
				to_chat(user, "<span class='warning'>You cannot seem to get \the [src] out of your hands!</span>")

/obj/item/gun/ballistic/charged/chargerifle
	name = "charge rifle"
	desc = "An advanced energy rifle which charges projectiles with unstable energy as they leave the barrel, allowing devastating damage."
	icon_state = "charge_rifle"
	item_state = "charge_rifle"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/charged/chargerifle

/obj/item/gun/ballistic/charged/chargerifle/update_icon()
	..()
	cut_overlays()
	if(magazine)
		add_overlay("charge_rifle-magazine")
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/charged/chargepistol
	name = "charge pistol"
	desc = "An advanced sidearm energy pistol which charges projectiles with unstable energy as they leave the barrel, allowing for devastating damage."
	icon_state = "charge_pistol"
	item_state = "charge_pistol"
	mag_type = /obj/item/ammo_box/magazine/charged/chargepistol

/obj/item/gun/ballistic/charged/chargepistol/update_icon()
	..()
	cut_overlays()
	if(magazine)
		add_overlay("charge_pistol-magazine")
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/charged/chargesmg
	name = "charge SMG"
	desc = "An advanced automatic submachine gun which charges projectiles with unstable energy as they leave the barrel, allowing for devastating damage."
	icon_state = "charge_smg"
	item_state = "charge_smg"
	mag_type = /obj/item/ammo_box/magazine/charged/chargesmg
	burst_size = 3
	burst_shot_delay = 2

/obj/item/gun/ballistic/charged/chargesmg/update_icon()
	..()
	cut_overlays()
	if(magazine)
		add_overlay("charge_pistol-magazine")
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/charged/toychargerifle
	name = "toy charge rifle"
	desc = "Now you too can be a sociopathic space cowboy! Leather hat not included. Ineffective against mechanical beings."
	icon_state = "nerf_charge_rifle"
	item_state = "nerf_charge_rifle"
	mag_type = /obj/item/ammo_box/magazine/charged/toyrifle

/obj/item/gun/ballistic/charged/toychargerifle/update_icon()
	..()
	cut_overlays()
	if(magazine)
		add_overlay("toy_charge_rifle-magazine")
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/shotgun/chargedshotgun //Has to be a snowflake because it works differently compared to the other charge weapons, which work off a mixture of Magrifles/automatic weapons and procs.
	name = "charge shotgun"
	desc = "An advanced shotgun made in traditional style. Uses pulse technology to charge projectiles with unstable energy as they leave the barrel, allowing for devastating damage. "
	icon = 'modular_skyrat/icon/obj/guns/chargeweapons.dmi'
	icon_state = "charge_shotgun"
	item_state = "charge_shotgun"
	mag_type = /obj/item/ammo_box/magazine/internal/charged/chargeshotgun
	fire_delay = 7

///////// PINLESS CHARGE WEAPONS - THESE ARE THE ONES YOU PRINT!!! /////////

/obj/item/gun/ballistic/charged/chargerifle/nopin
	pin = null
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/charged/chargepistol/nopin
	pin = null
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/charged/chargesmg
	pin = null
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/shotgun/chargedshotgun
	pin = null





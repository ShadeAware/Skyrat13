/obj/item
	var/grabtext
	var/grabsound
	var/suit_attachment = FALSE //boolean used by the hardsuit modules system thing. the reason i do it like this instead of creating an attachment subtype or whatever is
	var/suit_type = /obj/item/clothing/suit/space/hardsuit //that this simply allows more freedom with what kind of items we can use and etc

/obj/item/pickup(mob/living/user)
	. = ..()
	if(grabtext)
		var/t = replacetext(grabtext,"user","[user]")
		t = replacetext(t,"src","[src.name]")
		user.visible_message("<span class='danger'>[t]</span>")
	if(grabsound)
		playsound(src,grabsound,50,1)

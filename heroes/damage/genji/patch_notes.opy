#!mainFile "../../../main.opy"



rule "Genji Patch Notes":
    @Event eachPlayer
    @Hero genji

    eventPlayer.hero_description = "We Nerfed Genj- Wait, what do you mean we buffed him?"

    eventPlayer.primary_fire_name = "Shuriken (Primary Fire)"
    eventPlayer.secondary_fire_name = "Shuriken (Secondary Fire)"
    eventPlayer.ability_1_name = "Swift Strike"
    eventPlayer.ability_2_name = "Deflect"
    eventPlayer.ultimate_name = "Dragonblade"
    eventPlayer.passive_name = "Cyber-Agility"
    eventPlayer.patch_notes_buttons[6] = Button.JUMP

    eventPlayer.ability_1_notes = ["Damage received reduced by 50% while using.", "Applies a 25 damage/sec bleed on hit. Lasts 2 seconds."]
    eventPlayer.ability_2_notes = ["Deflected damage heals Genji for 50% of the damage dealt."]
    eventPlayer.ultimate_notes = ["Deflect cooldown while in use removed."]
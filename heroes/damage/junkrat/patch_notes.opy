#!mainFile "../../../main.opy"


rule "Junkrat Patch Notes":
    @Event eachPlayer
    @Hero junkrat

    eventPlayer.hero_description = "Junkrat takes skill, right?"

    eventPlayer.primary_fire_name = ""
    eventPlayer.secondary_fire_name = ""
    eventPlayer.ability_1_name = ""
    eventPlayer.ability_2_name = ""
    eventPlayer.ultimate_name = ""
    eventPlayer.crouch_name = ""
    eventPlayer.passive_name = ""

    eventPlayer.primary_fire_notes = [""]
    eventPlayer.secondary_fire_notes = [""]
    eventPlayer.ability_1_notes = [""]
    eventPlayer.ability_2_notes = [""]
    eventPlayer.crouch_notes = [""]
    eventPlayer.ultimate_notes = [""]
    eventPlayer.passive_notes = [""]
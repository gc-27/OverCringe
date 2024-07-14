#!mainFile "../../../main.opy"


rule "Wrecking Ball Patch Notes":
    @Event eachPlayer
    @Hero hammond

    eventPlayer.hero_description = "People now call him Wrecking Crab."

    eventPlayer.primary_fire_name = "Quad Cannons"
    eventPlayer.secondary_fire_name = "Grappling Claw"
    eventPlayer.ability_1_name = "Roll"
    eventPlayer.ability_2_name = "Adaptive Shield"
    eventPlayer.crouch_name = "Piledriver"
    eventPlayer.ultimate_name = "Minefield"

    eventPlayer.primary_fire_notes = ["No longer requires ammo.", "Damage increased by 25%."]
    eventPlayer.ability_1_notes = ["Move speed in mech form reduced by 50%.", "Mech form grants a 25% damage resistance."]
    eventPlayer.ability_2_notes = ["Jump height while active increased by 75%."]
    eventPlayer.ultimate_notes = ["Mine knockback increased by 300%."]


#!mainFile "../../../main.opy"

rule "D.Va patch notes":
    @Event eachPlayer
    @Hero dva

    eventPlayer.hero_description = "This hopefully addresses the issue of D.Va dealing too much damage."

    eventPlayer.primary_fire_name = "Fusion Cannons"
    eventPlayer.secondary_fire_name = "Defense Matrix"
    eventPlayer.ability_1_name = "Boosters"
    eventPlayer.ability_2_name = "Micro Missiles"
    eventPlayer.ultimate_name = "Self Destruct"

    eventPlayer.secondary_fire_notes = ["Now lasts indefinitely.", "Now has a 10 second cooldown.", "Slowly reduces move speed while in use."]
    eventPlayer.ultimate_notes = ["Eliminating enemies with Self Destruct", " will grant your team 50 overhealth."]
#!mainFile "../../../main.opy"


rule "Sigma Patch Notes":
    @Event eachPlayer
    @Hero sigma

    eventPlayer.hero_description = "Seriously, what is that melody?"

    eventPlayer.primary_fire_name = "Hyperspheres"
    eventPlayer.secondary_fire_name = "Experimental Barrier"
    eventPlayer.ability_1_name = "Kinetic Grasp"
    eventPlayer.ability_2_name= "Accretion"
    eventPlayer.ultimate_name = "Gravitic Flux"

    eventPlayer.hero_general_changes.append(["No longer affected by gravity.", "Control height by using Jump to go up and Crouch to go down."])

    eventPlayer.ability_1_notes = ["Pulls a closeby enemy towards the black hole,", "trapping them and allowing Sigma to move them around."]
    eventPlayer.ability_2_notes = ["Sends hit enemies toward Sigma."]
    eventPlayer.ultimate_notes = ["Enemies bounce upon landing."]


#!mainFile "../../../main.opy"


rule "Reinhardt Patch Notes":
    @Event eachPlayer
    @Hero reinhardt

    eventPlayer.hero_description = "If only he had this armor during the crisis..."
    eventPlayer.hero_general_changes.append(["Move speed increased by 50%."])

    eventPlayer.primary_fire_name = "Rocket Hammer"
    eventPlayer.secondary_fire_name = "Barrier Field"
    eventPlayer.ability_1_name = "Charge"
    eventPlayer.ability_2_name = "Fire Strike"
    eventPlayer.ultimate_name = "Earthshatter"

    eventPlayer.ability_1_notes = ["Move Speed while active reduced to 10%.", "Damage dealt increased by 400%."]
    eventPlayer.ability_2_notes = ["Dealing damage will heal Reinhardt for 100% of the damage."]
    eventPlayer.ultimate_notes = ["Stuns everyone on the ground when it hits.", "I mean, everyone. Literaly everyone."]
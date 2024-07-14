#!mainFile "../../../main.opy"


rule "Cassidy Patch Notes":
    @Event eachPlayer
    @Hero cassidy

    eventPlayer.hero_description = "Realism"

    eventPlayer.primary_fire_name = "Peacekeeper"
    eventPlayer.secondary_fire_name = "Fan the Hammer"
    eventPlayer.ability_1_name = "Combat Roll"
    eventPlayer.ability_2_name = "Flashbang"
    eventPlayer.ultimate_name = "Deadeye"
    eventPlayer.passive_name = "Marksman"

    eventPlayer.secondary_fire_notes = ["Shooting Fan the Hammer knocks Cassidy back slightly."]
    eventPlayer.ability_1_notes = ["Now sends Cassidy in the direction he is facing."]
    eventPlayer.passive_notes = ["Killing an enemy with a headshot grants Cassidy a 25% speed boost for one second."]
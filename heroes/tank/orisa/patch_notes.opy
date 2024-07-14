#!mainFile "../../../main.opy"


rule "Orisa Patch Notes":
    @Event eachPlayer
    @Hero orisa

    eventPlayer.hero_description = "Orisa isn't mobile enough."
    eventPlayer.primary_fire_name = "Augmented Fusion Driver"
    eventPlayer.secondary_fire_name = "Energy Javelin"
    eventPlayer.ability_1_name = "Fortify"
    eventPlayer.ability_2_name = "Javelin Spin"
    eventPlayer.ultimate_name = "Terra Surge"

    eventPlayer.secondary_fire_notes = ["Orisa now throws herself alongside the Javelin."]
    eventPlayer.ability_1_notes = ["Now grants Orisa 500 Overhealth.", "Roots Orisa to the ground while active."]
    eventPlayer.ability_2_notes = ["Pulls enemies towards Orisa while active.", "Grants Orisa forward facing flight while active."]
    eventPlayer.ultimate_notes = ["Grants teammates nearby Orisa Overhealth while charging."]

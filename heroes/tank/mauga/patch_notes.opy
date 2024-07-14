#!mainFile "../../../main.opy"


rule "Mauga Patch Notes":
    @Event eachPlayer
    @Hero mauga

    eventPlayer.hero_description = "He's been struggling recently. He misses Baptiste."
    eventPlayer.primary_fire_name = "Incendiary Chaingun (Gunny)"
    eventPlayer.secondary_fire_name = "Volatile Chaingun (Cha-Cha)"
    eventPlayer.ability_1_name = "Overrun"
    eventPlayer.ability_2_name = "Cardiac Overdrive"
    eventPlayer.ultimate_name = "Cage Fight"
    eventPlayer.passive_name = "Beserker"

    eventPlayer.ability_1_notes = ["Enemies near Mauga during Overrun are set on fire."]
    eventPlayer.ability_2_notes = ["Now gives Mauga a heart attack if he does not deal 200 damage after use.", "Increases Mauga's movespeed by 25% while active."]
    eventPlayer.ultimate_notes = ["Makes Mauga invulnerable.", "Forces Mauga to emote while active."]
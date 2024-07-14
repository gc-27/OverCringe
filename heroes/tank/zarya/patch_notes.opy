#!mainFile "../../../main.opy"


rule "Zarya Patch Notes":
    @Event eachPlayer
    @Hero zarya

    eventPlayer.hero_description = "Fire at... Will? Who's Will?"
    
    eventPlayer.primary_fire_name = "Particle Cannon"
    eventPlayer.secondary_fire_name = "Particle Cannon"
    eventPlayer.ability_1_name = "Particle Barrier"
    eventPlayer.ability_2_name = "Projected Barrier"
    eventPlayer.ultimate_name = "New Ultimate: 'Gravity Bomb'"

    eventPlayer.secondary_fire_notes = ["Knockback doubled."]
    eventPlayer.ability_1_notes = ["Grants a 50 HP Overhealth pool after decaying.", "Grants a 25% speed boost while active.", "Disabled for 2 seconds after use."]
    eventPlayer.ultimate_notes = ["Zarya shoots out a gravity charge that explodes on impact.", "Enemies that are hit with the blast are unable to move, ", "and become weightless for four seconds.", "Effect of Gravity Bomb does not affect players that are Unstoppable.", "(Mauga's Overrun, Orisa's Fortify.)"]

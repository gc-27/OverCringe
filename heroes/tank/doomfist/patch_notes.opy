#!mainFile "../../../main.opy"



rule "Doomfist Patch Notes":
    @Event eachPlayer
    @Hero doomfist
    
    eventPlayer.hero_description = "After years of powerblocking, he finally broke the gauntlet."

    eventPlayer.primary_fire_name = "Hand Cannon"
    eventPlayer.secondary_fire_name = "Rocket Punch"
    eventPlayer.ability_1_name = "Seismic Slam"
    eventPlayer.ability_2_name = "Power Block"
    eventPlayer.ultimate_name = "Meteor Strike"
    eventPlayer.passive_name = "The Best Defense..."

    eventPlayer.primary_fire_notes = ["No longer has an ammo requirement."]
    eventPlayer.secondary_fire_notes = ["Move speed reduced to 10% while punching.", "Deals 200% more knockback.", "Has a small delay before you can move after punching."]
    eventPlayer.ability_1_notes = ["Travel speed increased to 250%."]
    eventPlayer.ability_2_notes = ["Knocks an enemy in front of Doomfist down for one second."]
    eventPlayer.ultimate_notes = ["Knocks enemies in the blast radius down for 2 seconds.", "Knocks enemies in the blast radius away.", "Doomfist can now be seen by all players while using."]
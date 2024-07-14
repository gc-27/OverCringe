#!mainFile "../../../main.opy"


rule "Junker Queen Patch Notes":
    @Event eachPlayer
    @Hero junkerQueen
    
    eventPlayer.hero_description = "Royalty do not have to follow the laws of physics."

    eventPlayer.primary_fire_name = "Scattergun"
    eventPlayer.secondary_fire_name = "Jagged Blade"
    eventPlayer.ability_1_name = "Commanding Shout"
    eventPlayer.ability_2_name = "Carnage"
    eventPlayer.ultimate_name = "Rampage"
    eventPlayer.passive_name = "Adrenaline Rush"

    eventPlayer.secondary_fire_notes = ["Drops out of Junker Queen's hand on use instead of being thrown.", "When pulled, Junker Queen will move towards the knife.", "Junker Queen will phase through walls to get to the knife."]
    eventPlayer.ability_1_notes = ["Now damages nearby enemies for 25% of their current health."]
    eventPlayer.ability_2_notes = ["Cooldown removed.", "Movement speed reduced by 50% while in use.","Missing Carnage will now deal 200 damage to Junker Queen."]
    eventPlayer.ultimate_notes = ["Now drops mines as Junker Queen charges forward."]

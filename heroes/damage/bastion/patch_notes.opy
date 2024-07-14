#!mainFile "../../../main.opy"


rule "Bastion Patch Notes":
    @Event eachPlayer
    @Hero bastion

    eventPlayer.hero_description = "Torbjorn gave him some good upgrades!"
    
    eventPlayer.primary_fire_name = "Configuration: Recon"
    eventPlayer.secondary_fire_name = "A-36 Tactical Grenade"
    eventPlayer.ability_1_name = "Configuration: Assault"
    eventPlayer.ability_2_name = "Self-Repair"
    eventPlayer.ultimate_name = "Configuration: Artillery"
    eventPlayer.passive_name = "Ironclad"

    eventPlayer.primary_fire_notes = ["No longer has falloff."]
    eventPlayer.secondary_fire_notes = ["No longer deals damage to self.", "Knockback scalar increased by 25%."]
    eventPlayer.ability_1_notes = ["Cooldown removed", "No longer able to jump while active.", "Duration still limited to 6 seconds.", "Move speed penalty while active removed.", "Bastion is now stationary while casting", "Sideways movement speed while active reduced by 50%"]
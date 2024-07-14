#!mainFile "../../../main.opy"


rule "Ramattra Patch Notes":
    @Event eachPlayer
    @Hero ramattra

    eventPlayer.hero_description = "Now Ram is truly a dive tank!"

    eventPlayer.primary_fire_name = "Void Accelerator (Omnic Form)"
    eventPlayer.secondary_fire_name = "Void Barrier (Omnic Form)"
    eventPlayer.ability_1_name = "Nemesis Form"
    eventPlayer.ability_2_name = "Ravenous Vortex"
    eventPlayer.ultimate_name = "Annihilation"
    
    eventPlayer.secondary_fire_notes = ["Holding right click to create a barrier will grant Ramattra a 50% speed boost."]
    eventPlayer.ability_1_notes = ["Shield health in Omnic Form is removed while active","Jump Height while in Nemesis Form increased by 200%."]
    eventPlayer.ability_2_notes = ["Now sends enemies upward.", "Enemies are slingshotted up at the end of the vortex."]
    eventPlayer.ultimate_notes = ["Movement speed in Annihilation reduced by 50%.", "Grants Ramattra an additional 250 armor.", "Pummel and Ravenous Vortex are disabled while in use.", "Damage dealt increased by 200%.", "Duration increased to 6 seconds."]

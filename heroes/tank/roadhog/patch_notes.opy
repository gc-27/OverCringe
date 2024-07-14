#!mainFile "../../../main.opy"



rule "Roadhog Patch Notes":
    @Event eachPlayer
    @Hero roadhog

    eventPlayer.hero_description = "Roadhog has been juicing."
    eventPlayer.primary_fire_name = "Scrap Gun"
    eventPlayer.secondary_fire_name = "Take a Breather"
    eventPlayer.ability_1_name = "Chain Hook"
    eventPlayer.ability_2_name = "Pig Pen"
    eventPlayer.ultimate_name = "Whole Hog"
    eventPlayer.passive_name = "New Passive: {} Stank".format(iconString(Icon.POISON))

    eventPlayer.secondary_fire_notes = ["Move speed increased by 25% while in use."]
    eventPlayer.ability_2_notes = ["Replaced with New Ability: {} Belly Flop".format(iconString(Icon.ARROW_DOWN)), "Roadhog jumps and slams on the ground,", "Creating a damaging blast that increases with height", "Stuns enemies Roadhog directly lands on."]
    eventPlayer.ultimate_notes = ["Sends Roadhog Backward while using Whole Hog"]
    eventPlayer.passive_notes = ["Enemies near Roadhog take damage that slowly increases over time."]
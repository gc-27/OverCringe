#!mainFile "../../../main.opy"


rule "Ashe Patch Notes":
    @Event eachPlayer
    @Hero ashe

    eventPlayer.hero_description = "Ashe realized B.O.B couldn't do everything."
    

    eventPlayer.primary_fire_name = "The Viper"
    eventPlayer.secondary_fire_name = "The Viper (ADS)"
    eventPlayer.ability_1_name = "Coach Gun"
    eventPlayer.ability_2_name = "Dynamite"
    eventPlayer.ultimate_name = "B.O.B"
    eventPlayer.passive_name = "New Passive: {} Headhunter".format(iconString(Icon.SKULL))

    eventPlayer.ability_2_notes = ["Players hit by Dynamite are now knocked back slightly."]
    eventPlayer.passive_notes = ["When Ashe earns an elimination,", "Coach Gun's cooldown will be reduced by 2s."]

#!mainFile "../../main.opy"

rule "Junkrat Init":
    @Event eachPlayer
    @Hero junkrat
    
    set_health_pool(eventPlayer, 200, 0, 0)

rule "Junkrat Concussion Mine ":
    @Event playerDealtKnockback
    @Hero junkrat
    @Condition eventAbility == Button.ABILITY_1
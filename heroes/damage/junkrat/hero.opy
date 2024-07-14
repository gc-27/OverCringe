#!mainFile "../../../main.opy"

rule "Junkrat Init":
    @Event eachPlayer
    @Hero junkrat
    
    set_health_pool(eventPlayer, 200, 0, 0)
    startDamageModification(getPlayers(get_enemy_team(eventPlayer)), eventPlayer, 0, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)

rule "Junkrat Knockback":
    @Event playerDealtKnockback
    @Hero junkrat
    
    smallMessage(eventPlayer, eventAbility)




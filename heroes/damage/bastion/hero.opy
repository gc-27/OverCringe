#!mainFile "../../../main.opy"


rule "Bastion Init":
    @Event eachPlayer
    @Hero bastion
    
    set_health_pool(eventPlayer, 150, 125, 0)
    
    startDamageModification(eventPlayer, eventPlayer, 0, DamageReeval.NONE)

rule "Bastion Primary Fire":
    @Event playerDealtDamage
    @Hero bastion
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition not eventPlayer.isUsingAbility1()
    if distance(attacker, victim) > 30:
        damage(victim, attacker, (50 if eventWasCriticalHit else 25) - eventDamage)

rule "Bastion Configuration: Assault":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isUsingAbility1()
    
    eventPlayer.setStatusEffect(null, Status.ROOTED, 1)
    eventPlayer.disallowButton(Button.JUMP)
    wait(1)
    eventPlayer.startForcingThrottle(0, 1, 0, 1, 0, 0.5)
    eventPlayer.moveSpeed += 53.87
    waitUntil(not eventPlayer.isUsingAbility1(), 6)
    eventPlayer.allowButton(Button.JUMP)
    eventPlayer.moveSpeed -= 53.87
    eventPlayer.stopForcingThrottle()
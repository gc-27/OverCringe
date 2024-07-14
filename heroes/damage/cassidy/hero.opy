#!mainFile "../../../main.opy"


rule "Cassidy Init":
    @Event eachPlayer
    @Hero cassidy
    
    set_health_pool(eventPlayer, 175, 50, 0)

rule "Cassidy Fan The Hammer":
    @Event eachPlayer
    @Hero cassidy
    @Condition eventPlayer.isFiringSecondaryFire()

    eventPlayer.applyImpulse(-eventPlayer.getFacingDirection(), 2.5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    wait(0.112)
    if RULE_CONDITION:
        goto RULE_START

rule "Cassidy Combat Roll":
    @Event eachPlayer
    @Hero cassidy
    @Condition eventPlayer.isUsingAbility1()

    eventPlayer.applyImpulse(eventPlayer.getFacingDirection(), 20, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)

rule "Cassidy Marksman":
    @Event playerDealtFinalBlow
    @Hero cassidy
    @Condition eventWasCriticalHit

    eventPlayer.moveSpeed += 25
    wait(2)
    eventPlayer.moveSpeed -= 25
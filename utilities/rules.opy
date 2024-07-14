#!mainFile "../main.opy"

rule "Player Has Silencing Effect - Set canUseAbilities False":
    @Event eachPlayer
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) or eventPlayer.hasStatusEffect(Status.FROZEN) or eventPlayer.hasStatusEffect(Status.HACKED) or eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) or eventPlayer.hasStatusEffect(Status.STUNNED) or eventPlayer.isDead()

    eventPlayer.canUseAbilities = false
    

rule "Player Does Not Have Silencing Effect - Set canUseAbilities True":
    @Event eachPlayer
    @Condition not (eventPlayer.hasStatusEffect(Status.ASLEEP) or eventPlayer.hasStatusEffect(Status.FROZEN) or eventPlayer.hasStatusEffect(Status.HACKED) or eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) or eventPlayer.hasStatusEffect(Status.STUNNED) or eventPlayer.isDead())

    eventPlayer.canUseAbilities = true
    
rule "Update Move Speed":
    @Event eachPlayer
    @Condition eventPlayer.moveSpeed != eventPlayer.prevMoveSpeed

    do:
        eventPlayer.setMoveSpeed(min(eventPlayer.moveSpeed, 200))
        eventPlayer.prevMoveSpeed = eventPlayer.moveSpeed
        wait(0.25)
    while RULE_CONDITION

rule "Update Gravity":
    @Event eachPlayer
    @Condition eventPlayer.gravity != eventPlayer.prevGravity

    do:
        eventPlayer.setGravity(eventPlayer.gravity)
        eventPlayer.prevGravity = eventPlayer.gravity
        wait(0.25)
    while RULE_CONDITION

rule "Health Pack Taken - Remove Burn Status + DoT":
    @Event playerReceivedHealing
    @Condition eventWasHealthPack

    healee.clearStatusEffect(Status.BURNING)
    healee.stopAllDoT()

rule "Hero Changed - Reset player vars and HP":
    @Event eachPlayer
    @Condition eventPlayer.currentHero != eventPlayer.getCurrentHero()


    stopDamageModification(eventPlayer.self_damage_mod)
    eventPlayer.stopAcceleration()
    eventPlayer.stopForcingThrottle()
    eventPlayer.stopThrottleInDirection()
    eventPlayer.stopTransformingThrottle()


    eventPlayer.moveSpeed = 100
    eventPlayer.gravity = 100   
    
    enable_inputs()
    enable_abilities()
    clear_status_effects()

    eventPlayer.enablePlayerCollision()
    eventPlayer.enableEnvironmentCollision()

    eventPlayer.setProjectileSpeed(100)
    eventPlayer.setJumpVerticalSpeed(100)
    
    clear_player_health()
    wait()
    eventPlayer.currentHero = eventPlayer.getCurrentHero()
    if eventPlayer.health:
        check_and_set_hp()

    

#!mainFile "../main.opy"

rule "Update Move Speed":
    @Event eachPlayer
    @Condition eventPlayer.move_speed != eventPlayer.prev_move_speed

    do:
        eventPlayer.setMoveSpeed(min(eventPlayer.move_speed, 200))
        eventPlayer.prev_move_speed = eventPlayer.move_speed
        waitUntil(eventPlayer.move_speed != eventPlayer.prev_move_speed, 0.25)
    while RULE_CONDITION

rule "Update Gravity":
    @Event eachPlayer
    @Condition eventPlayer.gravity != eventPlayer.prev_gravity

    do:
        eventPlayer.setGravity(eventPlayer.gravity)
        eventPlayer.prev_gravity = eventPlayer.gravity
        waitUntil(eventPlayer.gravity != eventPlayer.prev_gravity, 0.25)
    while RULE_CONDITION
   
rule "Health Pack Taken - Remove Burn Status + DoT":
    @Event playerReceivedHealing
    @Condition eventWasHealthPack

    healee.clearStatusEffect(Status.BURNING)
    healee.stopAllDoT()

rule "Hero Changed - Reset player vars and HP":
    @Event eachPlayer
    @Condition eventPlayer.current_hero != eventPlayer.getCurrentHero()


    stopDamageModification(eventPlayer.self_damage_mod)
    eventPlayer.stopAcceleration()
    eventPlayer.stopForcingThrottle()
    eventPlayer.stopThrottleInDirection()
    eventPlayer.stopTransformingThrottle()


    eventPlayer.gravity = 100
    eventPlayer.move_speed = 100
    eventPlayer.cc_immune = false
    
    enable_inputs()
    enable_abilities()
    clear_status_effects()

    eventPlayer.enablePlayerCollision()
    eventPlayer.enableEnvironmentCollision()

    eventPlayer.setProjectileSpeed(100)
    eventPlayer.setJumpVerticalSpeed(100)
    
    clear_player_health()
    if eventPlayer.isDummy():
        wait()
    wait()
    eventPlayer.current_hero = eventPlayer.getCurrentHero()
    if eventPlayer.health:
        check_and_set_hp()

    

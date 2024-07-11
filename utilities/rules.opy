#!mainFile "../main.opy"

rule "Global Init":
    @Event global
    if debug:
        pass
    else:
        #disableInspector()

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

rule "Update Health":
    @Event eachPlayer
    @Condition eventPlayer.healthMax != eventPlayer.prevHealthMax

    do:
        eventPlayer.setMaxHealth(eventPlayer.healthMax)
        eventPlayer.prevHealthMax = eventPlayer.healthMax
        wait(0.25)
    while RULE_CONDITION

rule "Hero Changed - Reset":
    @Event eachPlayer
    @Condition eventPlayer.currentHero != eventPlayer.getCurrentHero()

    enable_inputs()
    enable_abilities()
    clear_status_effects()

    eventPlayer.setMaxHealth(100)

    eventPlayer.enablePlayerCollision()
    eventPlayer.enableEnvironmentCollision()

    eventPlayer.setProjectileSpeed(100)
    eventPlayer.setJumpVerticalSpeed(100)

    eventPlayer.currentHero = eventPlayer.getCurrentHero()
    eventPlayer.patchNotesData = []
    eventPlayer.moveSpeed = 100
    eventPlayer.gravity = 100
    eventPlayer.healthMax = 100
    eventPlayer.health_different = false
    clear_player_health()
    wait(0.1)
    if eventPlayer.health_different:
        check_and_set_hp()
    #eventPlayer.addHealthPool(Health.SHIELDS, 100, true, false)

    

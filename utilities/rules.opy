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

rule "Hero Changed - Reset player vars and HP":
    @Event eachPlayer
    @Condition eventPlayer.currentHero != eventPlayer.getCurrentHero()

    eventPlayer.currentHero = eventPlayer.getCurrentHero()

    eventPlayer.patchNotes = [["not set"], ["not set"], ["not set"], ["not set"], ["not set"], ["not set"], ["not set"], "not set"] 
    eventPlayer.hero_description = "This hero does not have a description!"
    eventPlayer.hero_general_changes = []


    eventPlayer.moveSpeed = 100
    eventPlayer.gravity = 100
    eventPlayer.health_different = false
    eventPlayer.health = 0
    eventPlayer.armor = 0
    eventPlayer.shields = 0
    
    enable_inputs()
    enable_abilities()
    clear_status_effects()

    eventPlayer.enablePlayerCollision()
    eventPlayer.enableEnvironmentCollision()

    eventPlayer.setProjectileSpeed(100)
    eventPlayer.setJumpVerticalSpeed(100)

    clear_player_health()
    wait() #Wait one tick for player to set up
    if eventPlayer.health_different:
        check_and_set_hp()
        eventPlayer.hero_general_changes[0] = "Health pool changed to {} Health{}{}".format(eventPlayer.health, ", {} Armor".format(eventPlayer.armor) if eventPlayer.armor else "", ", {} Shields".format(eventPlayer.shields) if eventPlayer.shields else "")
    
    clear_text_from_screen()
    read_patch_notes_data()

    

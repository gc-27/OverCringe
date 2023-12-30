#!mainFile "../main.opy"

globalvar debug = createWorkshopSetting(bool, "DEVELOPMENT", "DEBUG", false, 0)

playervar moveSpeed = 100
playervar prevMoveSpeed

playervar gravity = 100
playervar prevGravity

playervar currentHero

rule "Spawn Dummy Bots":
    @Event global
    @Condition debug
    @Condition hostPlayer.isHoldingButton(Button.INTERACT)
    
    createDummy(Hero.ANA, getOppositeTeam(hostPlayer.getTeam()), 0, hostPlayer.getPosition(), hostPlayer.getFacingDirection())

rule "Ultimate charge if debug mode":
    @Event eachPlayer
    @Condition debug
    @Condition eventPlayer.getUltCharge() != 100

    do:
        eventPlayer.setUltCharge(100)
        wait(0.25)
    while RULE_CONDITION
    
rule "Update Move Speed":
    @Event eachPlayer
    @Condition eventPlayer.moveSpeed != eventPlayer.prevMoveSpeed

    do:
        eventPlayer.setMoveSpeed(eventPlayer.moveSpeed)
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

rule "Hero Changed - Reset":
    @Event eachPlayer
    @Condition eventPlayer.currentHero != eventPlayer.getCurrentHero()

    eventPlayer.currentHero = eventPlayer.getCurrentHero()
    eventPlayer.patchNotesData = []
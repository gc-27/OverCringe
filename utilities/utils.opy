#!mainFile "../main.opy"


playervar moveSpeed = 100
playervar prevMoveSpeed

playervar gravity = 100
playervar prevGravity

playervar currentHero

playervar effects
playervar var1
playervar var2
playervar var3

#!extension projectiles

def disable_inputs():
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.MELEE)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.disallowButton(Button.JUMP)
    eventPlayer.disallowButton(Button.CROUCH)
    eventPlayer.disallowButton(Button.RELOAD)
    eventPlayer.disallowButton(Button.INTERACT)

def enable_inputs():
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.allowButton(Button.ABILITY_1)
    eventPlayer.allowButton(Button.ABILITY_2)
    eventPlayer.allowButton(Button.MELEE)
    eventPlayer.allowButton(Button.ULTIMATE)
    eventPlayer.allowButton(Button.JUMP)
    eventPlayer.allowButton(Button.CROUCH)
    eventPlayer.allowButton(Button.RELOAD)
    eventPlayer.allowButton(Button.INTERACT)

def disable_abilities():
    eventPlayer.setUltEnabled(false)
    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.setMeleeEnabled(false)
    eventPlayer.setReloadEnabled(false)
    eventPlayer.setCrouchEnabled(false)
    eventPlayer.setJumpEnabled(false)

def enable_abilities():
    eventPlayer.setUltEnabled(true)
    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.setMeleeEnabled(true)
    eventPlayer.setReloadEnabled(true)
    eventPlayer.setCrouchEnabled(true)
    eventPlayer.setJumpEnabled(true)

rule "Spawn Dummy Bots":
    @Event global
    @Condition debug
    @Condition hostPlayer.isHoldingButton(Button.INTERACT)
    
    createDummy(Hero.ANA, getOppositeTeam(hostPlayer.getTeam()), -1, hostPlayer.getPosition(), hostPlayer.getFacingDirection())

rule "Dummy bot died - Delete":
    @Event playerDied
    @Condition debug
    @Condition eventPlayer.isDummy()


    destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())

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

    enable_inputs()
    enable_abilities()

    
    eventPlayer.setProjectileSpeed(100)

    eventPlayer.removeAllHealthPools()
    eventPlayer.addHealthPool(Health.SHIELDS, 100, true, false)

    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.currentHero = eventPlayer.getCurrentHero()
    eventPlayer.patchNotesData = []
    eventPlayer.moveSpeed = 100
    eventPlayer.gravity = 100
    

#!mainFile "../main.opy"

playervar roadhogStankVar 

rule "Roadhog init":
    @Event eachPlayer
    @Hero roadhog

    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.health_different = true
    eventPlayer.health = 450
    eventPlayer.armor = 150


rule "Roadhog Stank":
    @Event eachPlayer
    @Condition teamHasHero(Hero.ROADHOG, getOppositeTeam(eventPlayer.getTeam()))
    @Condition distance(eventPlayer, getPlayersOnHero(Hero.ROADHOG, getOppositeTeam(eventPlayer.getTeam()))) <= 10
    @Condition eventPlayer.getCurrentHero() != Hero.ROADHOG
    @Condition isInLoS(eventPlayer, getPlayersOnHero(Hero.ROADHOG, getOppositeTeam(eventPlayer.getTeam())), BarrierLos.PASS_THROUGH_BARRIERS)
    @Disabled

    eventPlayer.roadhogStankVar += 1
    damage(eventPlayer, getPlayersOnHero(Hero.ROADHOG, getOppositeTeam(eventPlayer.getTeam())), eventPlayer.roadhogStankVar)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START
    eventPlayer.roadhogStankVar = 0

def belly_flop_end():
    eventPlayer.var1 = false
    stopChasingVariable(eventPlayer.var2)
    enable_inputs()
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.gravity -= 200
    eventPlayer.stopCamera()
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.enablePlayerCollision()
    destroyEffect(eventPlayer.effects[0])
    destroyEffect(eventPlayer.effects[1])

rule "Roadhog Belly Flop":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition eventPlayer.canUseAbilities
    @Condition not eventPlayer.isFiringSecondaryFire()
    @Condition not eventPlayer.isUsingAbility1()
    @Condition not eventPlayer.isCommunicatingEmote()
    @Condition not eventPlayer.hasStatusEffect(Status.ROOTED)
    
    eventPlayer.disablePlayerCollision()
    eventPlayer.var1 = true
    eventPlayer.var2 = 0
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 10)
    eventPlayer.startCamera(updateEveryTick(eventPlayer.getEyePosition() + -eventPlayer.getFacingDirection() * 3), updateEveryTick(eventPlayer.getEyePosition()), 0)
    createEffect(getAllPlayers(), Effect.TORBJORN_OVERLOADING, eventPlayer.getTeam(), eventPlayer, 1, EffectReeval.POSITION_AND_RADIUS)
    eventPlayer.effects[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.WINSTON_PRIMAL_RAGE, eventPlayer.getTeam(), eventPlayer, 1, EffectReeval.POSITION_AND_RADIUS)
    eventPlayer.effects[1] = getLastCreatedEntity()
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 250)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 9999)
    eventPlayer.applyImpulse(Vector.UP, 10, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
    disable_inputs()
    wait(0.5)
    chase(eventPlayer.var2, 15, rate=5, ChaseReeval.DESTINATION_AND_RATE)
    eventPlayer.gravity += 200
    waitUntil(eventPlayer.isOnGround() or not eventPlayer.canUseAbilities, 99999)
    if not eventPlayer.canUseAbilities:
        wait(0.5)
        belly_flop_end()
        return
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, eventPlayer.getTeam(), eventPlayer.getPosition(), max(2 * eventPlayer.var2, 5) * 2)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, eventPlayer.getTeam(), eventPlayer.getPosition(), max(eventPlayer.var2, 2.5))
    #playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_METEOR_STRIKE_IMPACT, eventPlayer.getTeam(), eventPlayer.getPosition(), 1)
    playEffect(getAllPlayers(), DynamicEffect.DEBUFF_IMPACT_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 250)
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 250)
    damage(getPlayersInRadius(eventPlayer, max(2 * eventPlayer.var2, 5), getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS), eventPlayer, max(25, 5 * eventPlayer.var2))
    damage(getPlayersInRadius(eventPlayer, max(eventPlayer.var2, 2.5), getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS), eventPlayer, max(25, 5 * eventPlayer.var2))
    getPlayersInRadius(eventPlayer, max(eventPlayer.var2, 5), getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS).applyImpulse(Vector.UP, max(5, eventPlayer.var2), Relativity.TO_PLAYER, Impulse.INCORPORATE_CONTRARY_MOTION)
    getPlayersInRadius(eventPlayer, max(eventPlayer.var2, 2.5), getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS).setStatusEffect(eventPlayer, Status.KNOCKED_DOWN, max(0.5, 0.3 * eventPlayer.var2))
    wait(0.25)
    eventPlayer.startCamera(eventPlayer.getEyePosition() * -eventPlayer.getFacingDirection(), eventPlayer.getEyePosition(), 50)
    wait(0.05)
    belly_flop_end()

rule "Roadhog Take A Breather":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isFiringSecondaryFire()

    eventPlayer.moveSpeed += 25
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 4)
    eventPlayer.moveSpeed -= 25




rule "Roadhog Whole Hog":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    @Condition not eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN)
    @Condition not eventPlayer.hasStatusEffect(Status.ASLEEP)
    @Condition not eventPlayer.hasStatusEffect(Status.FROZEN)
    @Condition not eventPlayer.hasStatusEffect(Status.STUNNED)
    @Condition not eventPlayer.isUsingAbility1()
    @Condition not eventPlayer.isMeleeing()
    @Condition not eventPlayer.isFiringSecondaryFire()
    @Condition not eventPlayer.var1
    
    eventPlayer.applyImpulse(eventPlayer.getFacingDirection() - eventPlayer.getFacingDirection() * 2, 15, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    wait(0.128, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "Roadhog Patch Notes":
    @Event eachPlayer
    @Hero roadhog

    eventPlayer.hero_description = "Roadhog has been juicing."

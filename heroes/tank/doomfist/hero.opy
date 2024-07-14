#!mainFile "../../../main.opy"


rule "Doomfist Init":
    @Event eachPlayer
    @Hero doomfist

    set_health_pool(eventPlayer, 400, 100, 0)


rule "Doomfist Rocket Punch":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isFiringSecondaryFire()

    eventPlayer.move_speed -= 90
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 2)
    wait(0.1)
    eventPlayer.move_speed += 90

rule "Doomfist Seismic Slam":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility1()

    eventPlayer.applyImpulse(eventPlayer.getFacingDirection(), 50, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.gravity += 400
    eventPlayer.move_speed += 150 
    waitUntil(not eventPlayer.isUsingAbility1(), 9999)
    eventPlayer.gravity -= 400
    eventPlayer.move_speed -= 150

rule "Doomfist Power Block Knockdown":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2()

    raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 3, getPlayers(getOppositeTeam(eventPlayer.getTeam())), eventPlayer, false).getPlayerHit().setStatusEffect(eventPlayer, Status.KNOCKED_DOWN, 1)

rule "Doomfist Meteor Strike Usage":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingUltimate()

    createEffect(getAllPlayers(), Effect.RING, eventPlayer.getTeam(), updateEveryTick(eventPlayer.getPosition()), 8, EffectReeval.POSITION_AND_RADIUS)
    eventPlayer.effects[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, eventPlayer.getTeam(), updateEveryTick(eventPlayer.getPosition()), 2, EffectReeval.POSITION_AND_RADIUS)
    eventPlayer.effects[1] = getLastCreatedEntity()

    waitUntil(not eventPlayer.isUsingUltimate(), 4.2)
    destroyEffect(eventPlayer.effects[0])
    destroyEffect(eventPlayer.effects[1])
    eventPlayer.effects = []

rule "Doomfist Meteor Strike Damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.ULTIMATE

    victim.setStatusEffect(attacker, Status.KNOCKED_DOWN, 2)
    victim.applyImpulse(directionTowards(attacker, victim) + Vector.UP, 25, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
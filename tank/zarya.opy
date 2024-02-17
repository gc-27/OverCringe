#!mainFile "../main.opy"

rule "Zarya Init":
    @Event eachPlayer
    @Hero zarya

    eventPlayer.disallowButton(Button.ULTIMATE)

rule "Zarya Particle Barrier":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isUsingAbility1()
    
    eventPlayer.setHealth(eventPlayer.getHealth()/2)

rule "Zarya Graviton Surge":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.getUltCharge() == 100
    @Condition not eventPlayer.hasStatusEffect(Status.ASLEEP)
    @Condition not eventPlayer.hasStatusEffect(Status.HACKED)
    @Condition not eventPlayer.hasStatusEffect(Status.STUNNED)
    @Condition not eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN)
    @Condition not eventPlayer.hasStatusEffect(Status.FROZEN)
    @Condition eventPlayer.isAlive()

    eventPlayer.setUltCharge(0)

    eventPlayer.var1 = 0
    eventPlayer.var2 = (eventPlayer.getEyePosition() + eventPlayer.getPosition()) / 2
    createEffect(getAllPlayers(), Effect.BAD_AURA, Color.BLUE, eventPlayer.var2, eventPlayer.var1, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    eventPlayer.effects[0] = getLastCreatedEntity()
    chase(eventPlayer.var1, 100, duration=10, ChaseReeval.DESTINATION_AND_DURATION)
    while eventPlayer.var1 < 100:
        for eventPlayer.var3 in range (0, len(getAllPlayers())):
            getAllPlayers()[eventPlayer.var3].applyImpulse(directionTowards(getAllPlayers()[eventPlayer.var3], eventPlayer.var2), eventPlayer.var1, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
        kill(getPlayersInRadius(eventPlayer.var2, eventPlayer.var1, Team.ALL, LosCheck.OFF), eventPlayer)
        wait()
    destroyEffect(eventPlayer.effects[0])
    stopChasingVariable(eventPlayer.var1)
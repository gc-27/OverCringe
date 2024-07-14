#!mainFile "../../../main.opy"


rule "Orisa Init":
    @Event eachPlayer
    @Hero orisa

    set_health_pool(eventPlayer, 200, 300, 0)

rule "Orisa Energy Javelin":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isFiringSecondaryFire()
    
    eventPlayer.applyImpulse(eventPlayer.getFacingDirection(), 50, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    wait(1)


rule "Orisa Fortify":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.cc_immune = true
    eventPlayer.addHealthPool(Health.NORMAL, 425, false, true)
    eventPlayer.var1 = getLastCreatedHealthPool()
    eventPlayer.setStatusEffect(null, Status.ROOTED, 5)
    waitUntil(not eventPlayer.isUsingAbility1(), 99999)
    eventPlayer.cc_immune = false
    eventPlayer.clearStatusEffect(Status.ROOTED)
    removeHealthPool(eventPlayer.var1)


rule "Orisa Javelin Spin":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.setEnvironmentalKillCreditor(getPlayersInRadius(eventPlayer, 10, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES))
    if not eventPlayer.isUsingAbility1():
        eventPlayer.applyImpulse(eventPlayer.getFacingDirection(), 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    for eventPlayer.counter in range(len([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(player, eventPlayer) < 15])):
        (([i for i in [player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if not player.cc_immune] if distance(i, eventPlayer) < 15])[eventPlayer.counter]).applyImpulse(directionTowards(([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(player, eventPlayer) < 15])[eventPlayer.counter], eventPlayer), 1, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    wait(0)
    if RULE_CONDITION:
        goto RULE_START



rule "Orisa Terra Surge":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingUltimate() == true
    
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.RING_EXPLOSION, Color.YELLOW, eventPlayer, 15)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer, 15)
    getPlayersInRadius(eventPlayer, 15, eventPlayer.getTeam(), LosCheck.SURFACES).addHealthPool(Health.NORMAL, 50, false, false)
    wait(1)
    if RULE_CONDITION:
        goto RULE_START

